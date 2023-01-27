---
author: Stefan Richter
author-twitter: StefanRRichter
categories: features
date: "2017-07-04T09:00:00Z"
excerpt: <p>A primer on stateful stream processing and an in-depth walkthrough of
  rescalable state in Apache Flink.</p>
title: A Deep Dive into Rescalable State in Apache Flink
---
 _Apache Flink 1.2.0, released in February 2017, introduced support for rescalable state. This post provides a detailed overview of stateful stream processing and rescalable state in Flink._
 <br>
 <br>

{% toc %}

## An Intro to Stateful Stream Processing

At a high level, we can consider state in stream processing as memory in operators that remembers information about past input and can be used to influence the processing of future input.

In contrast, operators in _stateless_ stream processing only consider their current inputs, without further context and knowledge about the past. A simple example to illustrate this difference: let us consider a source stream that emits events with schema `e = {event_id:int, event_value:int}`. Our goal is, for each event, to extract and output the `event_value`. We can easily achieve this with a simple source-map-sink pipeline, where the map function extracts the `event_value` from the event and emits it downstream to an outputting sink. This is an instance of stateless stream processing.

But what if we want to modify our job to output the `event_value` only if it is larger than the value from the previous event? In this case, our map function obviously needs some way to remember the `event_value` from a past event — and so this is an instance of stateful stream processing.

This example should demonstrate that state is a fundamental, enabling concept in stream processing that is required for a majority of interesting use cases.

## State in Apache Flink

Apache Flink is a massively parallel distributed system that allows stateful stream processing at large scale. For scalability, a Flink job is logically decomposed into a graph of operators, and the execution of each operator is physically decomposed into multiple parallel operator instances. Conceptually, each parallel operator instance in Flink is an independent task that can be scheduled on its own machine in a network-connected cluster of shared-nothing machines.

For high throughput and low latency in this setting, network communications among tasks must be minimized. In Flink, network communication for stream processing only happens along the logical edges in the job’s operator graph (vertically), so that the stream data can be transferred from upstream to downstream operators.

However, there is no communication between the parallel instances of an operator (horizontally). To avoid such network communication, data locality is a key principle in Flink and strongly affects how state is stored and accessed.

For the sake of data locality, all state data in Flink is always bound to the task that runs the corresponding parallel operator instance and is co-located on the same machine that runs the task.

Through this design, all state data for a task is local, and no network communication between tasks is required for state access. Avoiding this kind of traffic is crucial for the scalability of a massively parallel distributed system like Flink.

For Flink’s stateful stream processing, we differentiate between two different types of state: operator state and keyed state. Operator state is scoped per parallel instance of an operator (sub-task), and keyed state can be thought of as [“operator state that has been partitioned, or sharded, with exactly one state-partition per key”]({{< param DocsBaseUrl >}}flink-docs-release-1.3/dev/stream/state.html#keyed-state). We could have easily implemented our previous example as operator state: all events that are routed through the operator instance can influence its value.

## Rescaling Stateful Stream Processing Jobs

Changing the parallelism (that is, changing the number of parallel subtasks that perform work for an operator) in stateless streaming is very easy. It requires only starting or stopping parallel instances of stateless operators and dis-/connecting them to/from their upstream and downstream operators as shown in **Figure 1A**.

On the other hand, changing the parallelism of stateful operators is much more involved because we must also (i) redistribute the previous operator state in a (ii) consistent, (iii) meaningful way. Remember that in Flink’s shared-nothing architecture, all state is local to the task that runs the owning parallel operator instance, and there is no communication between parallel operator instances at job runtime.

However, there is already one mechanism in Flink that allows the exchange of operator state between tasks, in a consistent way, with exactly-once guarantees — Flink’s checkpointing!

You can see detail about Flink’s checkpoints in [the documentation]({{< param DocsBaseUrl >}}flink-docs-release-1.3/internals/stream_checkpointing.html). In a nutshell, a checkpoint is triggered when a checkpoint coordinator injects a special event (a so-called checkpoint barrier) into a stream.

Checkpoint barriers flow downstream with the event stream from sources to sinks, and whenever an operator instance receives a barrier, the operator instance immediately snapshots its current state to a distributed storage system, e.g. HDFS.

On restore, the new tasks for the job (which potentially run on different machines now) can again pick up the state data from the distributed storage system.

<br><center><i>Figure 1</i></center>
<center>
<img src="{{ site.baseurl }}/img/blog/stateless-stateful-streaming.svg" style="width:70%;margin:10px">
</center>
<br>

We can piggyback rescaling of stateful jobs on checkpointing, as shown in **Figure 1B**. First, a checkpoint is triggered and sent to a distributed storage system. Next, the job is restarted with a changed parallelism and can access a consistent snapshot of all previous state from the distributed storage. While this solves (i) redistribution of a (ii) consistent state across machines there is still one problem: without a clear 1:1 relationship between previous state and new parallel operator instances, how can we assign the state in a (iii) meaningful way?

We could again assign the state from previous `map_1` and `map_2` to the new `map_1` and `map_2`. But this would leave `map_3` with empty state. Depending on the type of state and concrete semantics of the job, this naive approach could lead to anything from inefficiency to incorrect results.

In the following section, we’ll explain how we solved the problem of efficient, meaningful state reassignment in Flink. Each of Flink state’s two flavours, operator state and keyed state, requires a different approach to state assignment.

## Reassigning Operator State When Rescaling

First, we’ll discuss how state reassignment in rescaling works for operator state. A common real-world use-case of operator state in Flink is to maintain the current offsets for Kafka partitions in Kafka sources. Each Kafka source instance would maintain `<PartitionID, Offset>` pairs – one pair for each Kafka partition that the source is reading–as operator state. How would we redistribute this operator state in case of rescaling? Ideally, we would like to reassign all `<PartitionID, Offset>` pairs from the checkpoint in round robin across all parallel operator instances after the rescaling.

As a user, we are aware of the “meaning” of Kafka partition offsets, and we know that we can treat them as independent, redistributable units of state. The problem of how we can we share this domain-specific knowledge with Flink remains.

**Figure 2A** illustrates the previous interface for checkpointing operator state in Flink. On snapshot, each operator instance returned an object that represented its complete state. In the case of a Kafka source, this object was a list of partition offsets.

This snapshot object was then written to the distributed store. On restore, the object was read from distributed storage and passed to the operator instance as a parameter to the restore function.

This approach was problematic for rescaling: how could Flink decompose the operator state into meaningful, redistributable partitions? Even though the Kafka source was actually always a list of partition offsets, the previously-returned state object was a black box to Flink and therefore could not be redistributed.

As a generalized approach to solve this black box problem, we slightly modified the checkpointing interface, called `ListCheckpointed`. **Figure 2B** shows the new checkpointing interface, which returns and receives a list of state partitions. Introducing a list instead of a single object makes the meaningful partitioning of state explicit: each item in the list still remains a black box to Flink, but is considered an atomic, independently re-distributable part of the operator state.


<br><center><i>Figure 2</i></center>
<center>
<img src="{{ site.baseurl }}/img/blog/list-checkpointed.svg" style="width:70%;margin:10px">
</center><br>


Our approach provides a simple API with which implementing operators can encode domain-specific knowledge about how to partition and merge units of state. With our new checkpointing interface, the Kafka source makes individual partition offsets explicit, and state reassignment becomes as easy as splitting and merging lists.

```java
public class FlinkKafkaConsumer<T> extends RichParallelSourceFunction<T> implements CheckpointedFunction {
	 // ...

   private transient ListState<Tuple2<KafkaTopicPartition, Long>> offsetsOperatorState;

   @Override
   public void initializeState(FunctionInitializationContext context) throws Exception {

      OperatorStateStore stateStore = context.getOperatorStateStore();
      // register the state with the backend
      this.offsetsOperatorState = stateStore.getSerializableListState("kafka-offsets");

      // if the job was restarted, we set the restored offsets
      if (context.isRestored()) {
         for (Tuple2<KafkaTopicPartition, Long> kafkaOffset : offsetsOperatorState.get()) {
            // ... restore logic
         }
      }
   }

   @Override
   public void snapshotState(FunctionSnapshotContext context) throws Exception {

      this.offsetsOperatorState.clear();

      // write the partition offsets to the list of operator states
      for (Map.Entry<KafkaTopicPartition, Long> partition : this.subscribedPartitionOffsets.entrySet()) {
         this.offsetsOperatorState.add(Tuple2.of(partition.getKey(), partition.getValue()));
      }
   }

   // ...

}
```

## Reassigning Keyed State When Rescaling
The second flavour of state in Flink is keyed state. In contrast to operator state, keyed state is scoped by key, where the key is extracted from each stream event.

To illustrate how keyed state differs from operator state, let’s use the following example. Assume we have a stream of events, where each event has the schema `{customer_id:int, value:int}`. We have already learned that we can use operator state to compute and emit the running sum of values for all customers.

Now assume we want to slightly modify our goal and compute a running sum of values for each individual `customer_id`. This is a use case from keyed state, as one aggregated state must be maintained for each unique key in the stream.

Note that keyed state is only available for keyed streams, which are created through the `keyBy()` operation in Flink. The `keyBy()` operation (i) specifies how to extract a key from each event and (ii) ensures that all events with the same key are always processed by the same parallel operator instance. As a result, all keyed state is transitively also bound to one parallel operator instance, because for each key, exactly one operator instance is responsible. This mapping from key to operator is deterministically computed through hash partitioning on the key.

We can see that keyed state has one clear advantage over operator state when it comes to rescaling: we can easily figure out how to correctly split and redistribute the state across parallel operator instances. State reassignment simply follows the partitioning of the keyed stream. After rescaling, the state for each key must be assigned to the operator instance that is now responsible for that key, as determined by the hash partitioning of the keyed stream.

While this automatically solves the problem of logically remapping the state to sub-tasks after rescaling, there is one more practical problem left to solve: how can we efficiently transfer the state to the subtasks’ local backends?

When we’re not rescaling, each subtask can simply read the whole state as written to the checkpoint by a previous instance in one sequential read.

When rescaling, however, this is no longer possible – the state for each subtask is now potentially scattered across the files written by all subtasks (think about what happens if you change the parallelism in `hash(key) mod parallelism`). We have illustrated this problem in **Figure 3A**. In this example, we show how keys are shuffled when rescaling from parallelism 3 to 4 for a key space of 0, 20, using identity as hash function to keep it easy to follow.

A naive approach might be to read all the previous subtask state from the checkpoint in all sub-tasks and filter out the matching keys for each sub-task. While this approach can benefit from a sequential read pattern, each subtask potentially reads a large fraction of irrelevant state data, and the distributed file system receives a huge number of parallel read requests.

Another approach could be to build an index that tracks the location of the state for each key in the checkpoint. With this approach, all sub-tasks could locate and read the matching keys very selectively. This approach would avoid reading irrelevant data, but it has two major downsides. A materialized index for all keys, i.e. a key-to-read-offset mapping, can potentially grow very large. Furthermore, this approach can also introduce a huge amount of random I/O (when seeking to the data for individual keys, see **Figure 3A**, which typically entails very bad performance in distributed file systems.

Flink’s approach sits in between those two extremes by introducing key-groups as the atomic unit of state assignment. How does this work? The number of key-groups must be determined before the job is started and (currently) cannot be changed after the fact. As key-groups are the atomic unit of state assignment, this also means that the number of key-groups is the upper limit for parallelism. In a nutshell, key-groups give us a way to trade between flexibility in rescaling (by setting an upper limit for parallelism) and the maximum overhead involved in indexing and restoring the state.

We assign key-groups to subtasks as ranges. This makes the reads on restore not only sequential within each key-group, but often also across multiple key-groups. An additional benefit: this also keeps the metadata of key-group-to-subtask assignments very small. We do not maintain explicit lists of key-groups because it is sufficient to track the range boundaries.

We have illustrated rescaling from parallelism 3 to 4 with 10 key-groups in **Figure 3B**. As we can see, introducing key-groups and assigning them as ranges greatly improves the access pattern over the naive approach. Equation 2 and 3 in **Figure 3B** also details how we compute key-groups and the range assignment.

<br><center><i>Figure 2</i></center>
<center>
<img src="{{ site.baseurl }}/img/blog/key-groups.svg" style="width:70%;margin:10px">
</center><br>

## Wrapping Up

Thanks for staying with us, and we hope you now have a clear idea of how rescalable state works in Apache Flink and how to make use of rescaling in real-world scenarios.

Flink 1.3.0, which was released earlier this month, adds more tooling for state management and fault tolerance in Flink, including incremental checkpoints. And the community is exploring features such as…

• State replication<br>
• State that isn’t bound to the lifecycle of a Flink job<br>
• Automatic rescaling (with no savepoints required)

…for Flink 1.4.0 and beyond.

If you’d like to learn more, we recommend starting with the Apache Flink [documentation]({{< param DocsBaseUrl >}}flink-docs-release-1.3/dev/stream/state.html).

_This is an excerpt from a post that originally appeared on the data Artisans blog. If you'd like to read the original post in its entirety, you can find it <a href="https://data-artisans.com/blog/apache-flink-at-mediamath-rescaling-stateful-applications" target="_blank">here</a> (external link)._
