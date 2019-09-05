---
title: "Apache Flink Roadmap"
---
<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<hr />

{% toc %} 

**Preamble:** This is not an authoritative roadmap in the sense of a strict plan with a specific
timeline. Rather, we — the community — share our vision for the future and give an overview of the bigger
initiatives that are going on and are receiving attention. This roadmap shall give users and
contributors an understanding where the project is going and what they can expect to come.

The roadmap is continuously updated. New features and efforts should be added to the roadmap once
there is consensus that they will happen and what they will roughly look like for the user.

**Last Update:** 2019-09-04

# Analytics, Applications, and the roles of DataStream, DataSet, and Table API

Flink views stream processing as a [unifying paradigm for data processing]({{ site.baseurl }}/flink-architecture.html)
(batch and real-time) and event-driven applications. The APIs are evolving to reflect that view:

  - The **Table API / SQL** is becoming the primary API for analytical use cases, in a unified way
    across batch and streaming. To support analytical use cases in a more streamlined fashion,
    the API is being extended with more convenient multi-row/column operations ([FLIP-29](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=97552739)).

    - Like SQL, the Table API is *declarative*, operates on a *logical schema*, and applies *automatic optimization*.
    Because of these properties, that API does not give direct access to time and state.

    - The Table API is also the foundation for the Machine Learning (ML) efforts inititated in ([FLIP-39](https://cwiki.apache.org/confluence/display/FLINK/FLIP-39+Flink+ML+pipeline+and+ML+libs)), that will allow users to easily build, persist and serve ([FLINK-13167](https://issues.apache.org/jira/browse/FLINK-13167)) ML pipelines/workflows through a set of abstract core interfaces.

  - The **DataStream API** is the primary API for data-driven applications and data pipelines.
    It uses *physical data types* (Java/Scala classes) and there is no automatic rewriting.
    The applications have explicit control over *time* and *state* (state, triggers, proc fun.). 
    In the long run, the DataStream API will fully subsume the DataSet API through *bounded streams*.
    
# Batch and Streaming Unification

Flink's approach is to cover batch and streaming by the same APIs on a streaming runtime.
[This blog post]({{ site.baseurl }}/news/2019/02/13/unified-batch-streaming-blink.html)
gives an introduction to the unification effort.

The biggest user-facing parts currently ongoing are:

  - Table API restructuring ([FLIP-32](https://cwiki.apache.org/confluence/display/FLINK/FLIP-32%3A+Restructure+flink-table+for+future+contributions))
    that decouples the Table API from batch/streaming specific environments and dependencies. Some key parts of the FLIP are completed, such as the modular decoupling of expression parsing and the removal of Scala dependencies, and the next step is to unify the function stack ([FLINK-12710](https://issues.apache.org/jira/browse/FLINK-12710)).

  - The new source interfaces generalize across batch and streaming, making every connector usable as a batch and streaming data source ([FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)).

  - The introduction of *upsert-* or *changelog-* sources will support more powerful streaming inputs to the Table API ([FLINK-8545](https://issues.apache.org/jira/browse/FLINK-8545)).

On the runtime level, the streaming operators were extended in Flink 1.9 to also support the data consumption patterns required for some batch operations — which is groundwork for upcoming features like efficient [side inputs](https://cwiki.apache.org/confluence/display/FLINK/FLIP-17+Side+Inputs+for+DataStream+API).

Once these unification efforts are completed, we can move on to unifying the DataStream API.

# Fast Batch (Bounded Streams)

The community's goal is to make Flink's performance on bounded streams (batch use cases) competitive with that
of dedicated batch processors. While Flink has been shown to handle some batch processing use cases faster than
widely-used batch processors, there are some ongoing efforts to make sure this the case for broader use cases:

  - Faster and more complete SQL/Table API: The community is merging the Blink query processor which improves on
    the current query processor by adding a much richer set of runtime operators, optimizer rules, and code generation.
    The Blink-based query processor has full TPC-H support (with TPC-DS planned for the next release) and up to 10x performance improvement over the pre-1.9 Flink query processor ([FLINK-11439](https://issues.apache.org/jira/browse/FLINK-11439)).

  - An application on bounded data can schedule operations after another, depending on how the operators
    consume data (e.g., first build hash table, then probe hash table).
    We are separating the scheduling strategy from the ExecutionGraph to support different strategies
    on bounded data ([FLINK-10429](https://issues.apache.org/jira/browse/FLINK-10429)).

  - Caching of intermediate results on bounded data, to support use cases like interactive data exploration.
    The caching generally helps with applications where the client submits a series of jobs that build on
    top of one another and reuse each others' results ([FLINK-11199](https://issues.apache.org/jira/browse/FLINK-11199)).

Various of these enhancements can be integrated from the contributed code in the [Blink fork](https://github.com/apache/flink/tree/blink). To exploit these optimizations for bounded streams also in the DataStream API, we first need to break parts of the API and explicitly model bounded streams.

# Stream Processing Use Cases
  
The *new source interface* effort ([FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface))
aims to give simpler out-of-the box support for event time and watermark generation for sources.
Sources will have the option to align their consumption speed in event time, to reduce the
size of in-flight state when re-processing large data volumes in streaming
([FLINK-10887](https://issues.apache.org/jira/browse/FLINK-10886)).

To overcome the current pitfalls of checkpoint performance under backpressure scenarios, the community is introducing the concept of [unaligned checkpoints](https://lists.apache.org/thread.html/fd5b6cceb4bffb635e26e7ec0787a8db454ddd64aadb40a0d08a90a8@%3Cdev.flink.apache.org%3E). This will allow checkpoint barriers to overtake the output/input buffer queue to speed up alignment and snapshot the inflight data as part of checkpoint state.

We also plan to add first class support for
[Protocol Buffers](https://developers.google.com/protocol-buffers/) to make evolution of streaming state simpler, similar to the way
Flink deeply supports Avro state evolution ([FLINK-11333](https://issues.apache.org/jira/browse/FLINK-11333)).

# Deployment, Scaling and Security

To provide downstream projects with a consistent way to programatically control Flink deployment submissions, the Client API is being [refactored](https://lists.apache.org/thread.html/ce99cba4a10b9dc40eb729d39910f315ae41d80ec74f09a356c73938@%3Cdev.flink.apache.org%3E). The goal is to unify the implementation of cluster deployment and job submission in Flink and allow more flexible job and cluster management — independent of cluster setup or deployment mode. [FLIP-52](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=125308637) proposes the deprecation and removal of the legacy Program interface.


The community is working on extending the interoperability with authentication and authorization services.
Under discussion are general extensions to the [security module abstraction](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-security-improvements-td21068.html)
as well as specific [enhancements to the Kerberos support](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-Kerberos-Improvement-td25983.html).

# Resource Management and Configuration

There is a big effort to design a new way for Flink to interact with dynamic resource
pools and automatically adjust to resource availability and load.
Part of this is becoming a *reactive* way of adjusting to changing resources (like
containers/pods being started or removed) ([FLINK-10407](https://issues.apache.org/jira/browse/FLINK-10407)),
while other parts are resulting in *active* scaling policies where Flink decides to add
or remove TaskManagers, based on internal metrics.

  - The current TaskExecutor memory configuration in Flink has some shortcomings that make it hard to reason about or optimize resource utilization, such as: (1) different configuration models for memory footprint for Streaming and Batch; (2) complex and user-dependent configuration of off-heap state backends (typically RocksDB) in Streaming execution; (3) and sub-optimal memory utilization in Batch execution. [FLIP-49](https://cwiki.apache.org/confluence/display/FLINK/FLIP-49%3A+Unified+Memory+Configuration+for+TaskExecutors) proposes to unify managed memory configuration for TaskExecutors to make this process more generic and intuitive for the user.

  - In a similar way, we are introducing changes to Flink's resource management module with [FLIP-53](https://cwiki.apache.org/confluence/display/FLINK/FLIP-53%3A+Fine+Grained+Operator+Resource+Management) to enable fine-grained control over Operator resource utilization according to known (or unknown) resource profiles. Since the requirements of this FLIP conflict with the existing static slot allocation model, this model first needs to be refactored to provide dynamic slot allocation ([FLIP-56](https://cwiki.apache.org/confluence/display/FLINK/FLIP-56%3A+Dynamic+Slot+Allocation)).

  - To support the active resource management also in Kubernetes, we are working on a Kubernetes Resource Manager
([FLINK-9953](https://issues.apache.org/jira/browse/FLINK-9953)).

Spillable Heap State Backend ([FLIP-50](https://cwiki.apache.org/confluence/display/FLINK/FLIP-50%3A+Spill-able+Heap+Keyed+State+Backend)), a new state backend configuration, is being implemented to support spilling cold state data to disk before heap memory is exhausted and so reduce the chance of OOM errors in job execution. This is not meant as a replacement for RocksDB, but more of an enhancement to the existing Heap State Backend.

# Ecosystem

The community is working on extending the support for catalogs, schema registries, and metadata stores, including support in the APIs and the SQL client ([FLINK-11275](https://issues.apache.org/jira/browse/FLINK-11275)).
We have added DDL (Data Definition Language) support in Flink 1.9 to make it easy to add tables to catalogs ([FLINK-10232](https://issues.apache.org/jira/browse/FLINK-10232)), and will extend the support to streaming use cases in the next release.

There is also an ongoing effort to fully integrate Flink with the Hive ecosystem. The latest release made headway in bringing Hive data and metadata interoperability to Flink, along with initial support for Hive UDFs. Moving forward, the community will stabilize and expand on the existing implementation to support Hive DDL syntax and types, as well as other desirable features and capabilities described in [FLINK-10556](https://issues.apache.org/jira/browse/FLINK-10556).

# Non-JVM Languages (Python)

The work initiated in Flink 1.9 to bring full Python support to the Table API ([FLIP-38](https://cwiki.apache.org/confluence/display/FLINK/FLIP-38%3A+Python+Table+API)) will continue in the upcoming releases, also in close collaboration with the Apache Beam community. The next steps include:

  - Adding support for Python UDFs (Scalar Functions (UDF), Tabular Functions (UDTF) and Aggregate Functions (UDAF)). The details of this implementation are defined in [FLIP-58](https://cwiki.apache.org/confluence/display/FLINK/FLIP-58%3A+Flink+Python+User-Defined+Function+for+Table+API) and leverage the [Apache Beam portability framework](https://docs.google.com/document/d/1B9NmaBSKCnMJQp-ibkxvZ_U233Su67c1eYgBhrqWP24/edit#heading=h.khjybycus70) as a basis for UDF execution.

  - Integrating Pandas as the final effort — that is, making functions in Pandas directly usable in the Python Table API.

# Connectors and Formats

Support for additional connectors and formats is a continuous process.

# Miscellaneous

  - The Flink code base has been updated to support Java 9 ([FLINK-8033](https://issues.apache.org/jira/browse/FLINK-8033)) and Java 11 support is underway ([FLINK-10725](https://issues.apache.org/jira/browse/FLINK-10725)).
    
  - To reduce compatibility issues with different Scala versions, we are working using Scala
    only in the Scala APIs, but not in the runtime. That removes any Scala dependency for all
    Java-only users, and makes it easier for Flink to support different Scala versions ([FLINK-11063](https://issues.apache.org/jira/browse/FLINK-11063)).
