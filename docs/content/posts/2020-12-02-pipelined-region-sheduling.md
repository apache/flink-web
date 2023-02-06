---
authors:
- Andrey: null
  name: Andrey Zagrebin
date: "2020-12-02T08:00:00Z"
excerpt: In this blogpost, we’ll take a closer look at how far the community has come
  in improving task scheduling for batch workloads, why this matters and what you
  can expect in Flink 1.12 with the new pipelined region scheduler.
title: Improvements in task scheduling for batch workloads in Apache Flink 1.12
---

The Flink community has been working for some time on making Flink a
[truly unified batch and stream processing system](https://flink.apache.org/news/2019/02/13/unified-batch-streaming-blink.html).
Achieving this involves touching a lot of different components of the Flink stack, from the user-facing APIs all the way
to low-level operator processes such as task scheduling. In this blogpost, we’ll take a closer look at how far
the community has come in improving scheduling for batch workloads, why this matters and what you can expect in the
Flink 1.12 release with the new _pipelined region scheduler_.

{% toc %}

# Towards unified scheduling

Flink has an internal [scheduler](#what-is-scheduling) to distribute work to all available cluster nodes, taking resource utilization, state locality and recovery into account.
How do you write a scheduler for a unified batch and streaming system? To answer this question,
let's first have a look into the high-level differences between batch and streaming scheduling requirements.

#### Streaming

_Streaming_ jobs usually require that all _[operator subtasks](#executiongraph)_ are running in parallel at the same time, for an indefinite time.
Therefore, all the required resources to run these jobs have to be provided upfront, and all _operator subtasks_ must be deployed at once.

<center>
<img src="/img/blog/2020-12-02-pipelined-region-sheduling/streaming-job-example.png" width="400px" alt="Streaming job example:high"/>
<br/>
<i><small>Flink: Streaming job example</small></i>
</center>
<br/>

Because there are no finite intermediate results, a _streaming job_ always has to be restarted fully from a checkpoint or a savepoint in case of failure.

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
A _streaming job_ may generally consist of multiple disjoint pipelines which can be restarted independently.
Hence, the full job restart is not required in this case but you can think of each disjoint pipeline as if it were a separate job.
</div>

#### Batch

In contrast to _streaming_ jobs, _batch_ jobs usually consist of one or more stages that can have dependencies between them.
Each stage will only run for a finite amount of time and produce some finite output (i.e. at some point, the batch job will be _finished_).
Independent stages can run in parallel to improve execution time, but for cases where there are dependencies between stages,
a stage may have to wait for upstream results to be produced before it can run.
These are called _[blocking results](#intermediate-results)_, and in this case stages cannot run in parallel.

<center>
<img src="/img/blog/2020-12-02-pipelined-region-sheduling/batch-job-example.png" width="600px" alt="Batch job example:high"/>
<br/>
<i><small>Flink: Batch job example</small></i>
</center>
<br/>

As an example, in the figure above **Stage 0** and **Stage 1** can run simultaneously, as there is no dependency between them.
**Stage 3**, on the other hand, can only be scheduled once both its inputs are available. There are a few implications from this:

* **(a)** You can use available resources more efficiently by only scheduling stages that have data to perform work;

* **(b)** You can use this mechanism also for failover: if a stage fails, it can be restarted individually, without recomputing the results of other stages.

### Scheduling Strategies in Flink before 1.12

Given these differences, a unified scheduler would have to be good at resource management for each individual stage,
be it finite (_batch_) or infinite (_streaming_), and also across multiple stages.
The existing [scheduling strategies](#scheduling-strategy) in older Flink versions up to 1.11 have been largely designed to address these concerns separately.

**“All at once (Eager)”**

This strategy is the simplest: Flink just tries to allocate resources and deploy all _subtasks_ at once.
Up to Flink 1.11, this is the scheduling strategy used for all _streaming_ jobs.
For _batch_ jobs, using “all at once” scheduling would lead to suboptimal resource utilization,
since it’s unlikely that such jobs would require all resources upfront, and any resources allocated to subtasks
that could not run at a given moment would be idle and therefore wasted.

**“Lazy from sources”**

To account for _blocking results_ and make sure that no consumer is deployed before their respective producers are finished,
Flink provides a different scheduling strategy for _batch_ workloads.
“Lazy from sources” scheduling deploys subtasks only once all their inputs are ready.
This strategy operates on each _subtask_ individually; it does not identify all _subtasks_ which can (or have to) run at the same time.

### A practical example

Let’s take a closer look at the specific case of _batch_ jobs, using as motivation a simple SQL query:

```SQL
CREATE TABLE customers (
    customerId int,
    name varchar(255)
);

CREATE TABLE orders (
    orderId int,
    orderCustomerId int
);

--fill tables with data

SELECT customerId, name
FROM customers, orders
WHERE customerId = orderCustomerId
```

Assume that two tables were created in some database: the `customers` table is relatively small and fits into the local memory (or also on disk). The `orders` table is bigger, as it contains all orders created by customers, and doesn’t fit in memory. To enrich the orders with the customer name, you have to join these two tables. There are basically two stages in this _batch_ job:

1. Load the complete `customers` table into a local map: `(customerId, name)`; because this table is smaller,
2. Process the `orders` table record by record, enriching it with the `name` value from the map.

#### Executing the job

The batch job described above will have three operators. For simplicity, each operator is represented with a parallelism of 1,
so the resulting _[ExecutionGraph](#executiongraph)_ will consist of three _subtasks_: A, B and C.

* **A**: load full `customers` table
* **B**: load `orders` table record by record in a _streaming_ (pipelined) fashion
* **C**: join order table records with the loaded customer table

This translates into **A** and **C** being connected with a _blocking_ data exchange,
because the `customers` table needs to be loaded locally (**A**) before we start processing the order table (**B**).
**B** and **C** are connected with a _[pipelined](#intermediate-results)_ data exchange,
because the consumer (**C**) can run as soon as the first result records from **B** have been produced.
You can think of **B->C** as a _finite streaming_ job. It’s then possible to identify two separate stages within the _ExecutionGraph_: **A** and **B->C**.

<center>
<img src="/img/blog/2020-12-02-pipelined-region-sheduling/sql-join-job-example.png" width="450px" alt="SQL Join job example:high"/>
<br/>
<i><small>Flink: SQL Join job example</small></i>
</center>
<br/>

#### Scheduling Limitations

Imagine that the cluster this job will run in has only one _[slot](#slots-and-resources)_ and can therefore only execute one _subtask_.
If Flink deploys **B** _[chained](#slots-and-resources)_ with **C** first into this one _slot_ (as **B** and **C** are connected with a _[pipelined](#intermediate-results)_ edge),
**C** cannot run because A has not produced its _blocking result_ yet. Flink will try to deploy **A** and the job will fail, because there are no more _slots_.
If there were two _slots_ available, Flink would be able to deploy **A** and the job would eventually succeed.
Nonetheless, the resources of the first _slot_ occupied by **B** and **C** would be wasted while **A** was running.

Both scheduling strategies available as of Flink 1.11 (_“all at once”_ and _“lazy from source”_) would be affected by these limitations.
What would be the optimal approach? In this case, if **A** was deployed first, then **B** and **C** could also complete afterwards using the same _slot_.
The job would succeed even if only a single _slot_ was available.

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
If we could load the `orders` table into local memory (making B -> C blocking), then the previous strategy would also succeed with one slot.
Nonetheless, we would have to allocate a lot of resources to accommodate the table locally, which may not be required.
</div>

Last but not least, let’s consider what happens in the case of _failover_: if the processing of the `orders` table fails (**B->C**),
then we do not have to reload the customer table (**A**); we only need to restart **B->C**. This did not work prior to Flink 1.9.

To satisfy the scheduling requirements for _batch_ and _streaming_ and overcome these limitations,
the Flink community has worked on a new unified scheduling and failover strategy that is suitable for both types of workloads: _pipelined region scheduling_.

# The new pipelined region scheduling

As you read in the previous introductory sections, an optimal [scheduler](#what-is-scheduling) should efficiently allocate resources
for the sub-stages of the pipeline, finite or infinite, running in a _streaming_ fashion. Those stages are called _pipelined regions_ in Flink.
In this section, we will take a deeper dive into _pipelined region scheduling and failover_.

## Pipelined regions

The new scheduling strategy analyses the _[ExecutionGraph](#executiongraph)_ before starting the _subtask_ deployment in order to identify its _pipelined regions_.
A _pipelined region_ is a subset of _subtasks_ in the _ExecutionGraph_ connected by _[pipelined](#intermediate-results)_ data exchanges.
_Subtasks_ from different _pipelined regions_ are connected only by _[blocking](#intermediate-results)_ data exchanges.
The depicted example of an _ExecutionGraph_ has four _pipelined regions_ and _subtasks_, A to H:

<center>
<img src="/img/blog/2020-12-02-pipelined-region-sheduling/pipelined-regions.png" width="250px" alt="Pipelined regions:high"/>
<br/>
<i><small>Flink: Pipelined regions</small></i>
</center>
<br/>

Why do we need the _pipelined region_? Within the _pipelined region_ all consumers have to constantly consume the produced results
to not block the producers and avoid backpressure. Hence, all _subtasks_ of a _pipelined region_ have to be scheduled, restarted in case of failure and run at the same time.

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note (out of scope)</span>
In certain cases the _subtasks_ can be connected by _[blocking](#intermediate-results)_ data exchanges within one region.
Check [FLINK-17330](https://issues.apache.org/jira/browse/FLINK-17330) for details.
</div>

## Pipelined region scheduling strategy

Once the _pipelined regions_ are identified, each region is scheduled only when all the regions it depends on (i.e. its inputs),
have produced their _[blocking](#intermediate-results)_ results (for the depicted graph: R2 and R3 after R1; R4 after R2 and R3).
If the _JobManager_ has enough resources available, it will try to run as many schedulable _pipelined regions_ in parallel as possible.
The _subtasks_ of a _pipelined region_ are either successfully deployed all at once or none at all.
The job fails if there are not enough resources to run any of its _pipelined regions_.
You can read more about this effort in the original [FLIP-119 proposal](https://cwiki.apache.org/confluence/display/FLINK/FLIP-119+Pipelined+Region+Scheduling#FLIP119PipelinedRegionScheduling-BulkSlotAllocation).

## Failover strategy

As mentioned before, only certain regions are running at the same time. Others have already produced their _[blocking](#intermediate-results)_ results.
The results are stored locally in _TaskManagers_ where the corresponding _subtasks_ run.
If a currently running region fails, it gets restarted to consume its inputs again.
If some input results got lost (e.g. the hosting _TaskManager_ failed as well), Flink will rerun their producing regions.
You can read more about this effort in the [user documentation]({{< param DocsBaseUrl >}}flink-docs-release-1.11/dev/task_failure_recovery.html#failover-strategies)
and the original [FLIP-1 proposal](https://cwiki.apache.org/confluence/display/FLINK/FLIP-1+%3A+Fine+Grained+Recovery+from+Task+Failures).

## Benefits

**Run any batch job, possibly with limited resources**

The _subtasks_ of a _pipelined region_ are deployed only when all necessary conditions for their success are fulfilled:
inputs are ready and all needed resources are allocated. Hence, the _batch_ job never gets stuck without notifying the user.
The job either eventually finishes or fails after a timeout.

Depending on how the _subtasks_ are allowed to [share slots]({{< param DocsBaseUrl >}}flink-docs-release-1.11/dev/stream/operators/#task-chaining-and-resource-groups),
it is often the case that the whole _pipelined region_ can run within one _slot_,
making it generally possible to run the whole _batch_ job with only a single _slot_.
At the same time, if the cluster provides more resources, Flink will run as many regions as possible in parallel to improve the overall job performance.

**No resource waste**

As mentioned in the definition of _pipelined region_, all its _subtasks_ have to run simultaneously.
The _subtasks_ of other regions either cannot or do not have to run at the same time.
This means that a _pipelined region_ is the minimum subgraph of a _batch_ job’s _ExecutionGraph_ that has to be scheduled at once.
There is no way to run the job with fewer resources than needed to run the largest region, and so there can be no resource waste.

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note (out of scope)</span>
The amount of resources required to run a region can be further optimized separately.
It depends on _co-location constraints_ and _slot sharing groups_ of the region’s _subtasks_.
Check [FLINK-18689](https://issues.apache.org/jira/browse/FLINK-18689) for details.
</div>

# Conclusion

Scheduling is a fundamental component of the Flink stack. In this blogpost, we recapped how scheduling affects resource utilization and failover as a part of the user experience.
We described the limitations of Flink’s old scheduler and introduced a new approach to tackle them: the  _pipelined region scheduler_, which ships with Flink 1.12.
The blogpost also explained how _pipelined region failover_ (introduced in Flink 1.11) works.

Stay tuned for more improvements to scheduling in upcoming releases. If you have any suggestions or questions for the community,
we encourage you to sign up to the Apache Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) and become part of the discussion.

# Appendix

## What is scheduling?

### ExecutionGraph

A Flink _job_ is a pipeline of connected _operators_ to process data.
Together, the operators form a _[JobGraph]({{< param DocsBaseUrl >}}flink-docs-release-1.11/internals/job_scheduling.html#jobmanager-data-structures)_.
Each _operator_ has a certain number of _subtasks_ executed in parallel. The _subtask_ is the actual execution unit in Flink.
Each subtask can consume user records from other subtasks (inputs), process them and produce records for further consumption by other _subtasks_ (outputs) down the stream.
There are _source subtasks_ without inputs and _sink subtasks_ without outputs. Hence, the _subtasks_ form the nodes of the
_[ExecutionGraph]({{< param DocsBaseUrl >}}flink-docs-release-1.11/internals/job_scheduling.html#jobmanager-data-structures)_.


### Intermediate results

There are also two major data-exchange types to produce and consume results by _operators_ and their _subtasks_: _pipelined_ and _blocking_.
They are basically types of edges in the _ExecutionGraph_.

A _pipelined_ result can be consumed record by record. This means that the consumer can already run once the first result records have been produced.
A _pipelined_ result can be a never ending output of records, e.g. in case of a _streaming job_.

A _blocking_ result can be consumed only when its _production_ is done. Hence, the _blocking_ result is always finite
and the consumer of the _blocking_ result can run only when the producer has finished its execution.

### Slots and resources

A _[TaskManager]({{< param DocsBaseUrl >}}flink-docs-release-1.11/concepts/flink-architecture.html#anatomy-of-a-flink-cluster)_
instance has a certain number of virtual _[slots]({{< param DocsBaseUrl >}}flink-docs-release-1.11/concepts/flink-architecture.html#task-slots-and-resources)_.
Each _slot_ represents a certain part of the _TaskManager’s physical resources_ to run the operator _subtasks_, and each _subtask_ is deployed into a _slot_ of the _TaskManager_.
A _slot_ can run multiple _[subtasks]({{< param DocsBaseUrl >}}flink-docs-release-1.11/internals/job_scheduling.html#scheduling)_ from different _operators_ at the same time, usually [chained]({{< param DocsBaseUrl >}}flink-docs-release-1.11/concepts/flink-architecture.html#tasks-and-operator-chains) together.

### Scheduling strategy

_[Scheduling]({{< param DocsBaseUrl >}}flink-docs-release-1.11/internals/job_scheduling.html#scheduling)_
in Flink is a process of searching for and allocating appropriate resources (_slots_) from the _TaskManagers_ to run the _subtasks_ and produce results.
The _scheduling strategy_ reacts on scheduling events (like start job, _subtask_ failed or finished etc) to decide which _subtask_ to deploy next.

For instance, it does not make sense to schedule _subtasks_ whose inputs are not ready to consume yet to avoid wasting resources.
Another example is to schedule _subtasks_ which are connected with _pipelined_ edges together, to avoid deadlocks caused by backpressure.
