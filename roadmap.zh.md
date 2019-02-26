---
title: "Apache Flink 开发计划"
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
timeline. Rather, we, the community, share our vision for the future and give an overview of the bigger
initiatives that are going on and are receiving attention. This roadmap shall give users and
contributors an understanding where the project is going and what they can expect to come.

The roadmap is continuously updated. New features and efforts should be added to the roadmap once
there is consensus that they will happen and what they will roughly look like for the user.

# Analytics, Applications, an the roles of DataStream, DataSet, and Table API

Flink views stream processing as a [unifying paradigm for data processing]({{ site.baseurl }}/flink-architecture.html)
(batch and real-time) and event-driven applications. The APIs are evolving to reflect that view:

  - The **Table API / SQL** is becoming the primary API for analytical use cases, in a unified way
    across batch and streaming. To support analytical use cases in a more streamlined fashion,
    the API is extended with additional functions ([FLIP-29](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=97552739)).

    Like SQL, the Table API is *declarative*, operates on a *logical schema*, and applies *automatic optimization*.
    Because of these properties, that API does not give direct access to time and state.

  - The **DataStream API** is the primary API for data-driven applications and data pipelines.
    It uses *physical data types* (Java/Scala classes) and there is no automatic rewriting.
    The applications have explicit control over *time* and *state* (state, triggers, proc. fun.).

    In the long run, the DataStream API should fully subsume the DataSet API through *bounded streams*.
    
# Batch and Streaming Unification

Flink's approach is to cover batch and streaming by the same APIs, on a streaming runtime.
[This blog post]({{ site.baseurl }}/news/2019/02/13/unified-batch-streaming-blink.html)
gives an introduction to the unification effort. 

The biggest user-facing parts currently ongoing are:

  - Table API restructuring [FLIP-32](https://cwiki.apache.org/confluence/display/FLINK/FLIP-32%3A+Restructure+flink-table+for+future+contributions)
    that decouples the Table API from batch/streaming specific environments and dependencies.

  - The new source interfaces [FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)
    generalize across batch and streaming, making every connector usable as a batch and
    streaming data source.

  - The introduction of *upsert-* or *changelog-* sources [FLINK-8545](https://issues.apache.org/jira/browse/FLINK-8545)
    will support more powerful streaming inputs to the Table API.

On the runtime level, the streaming operators are extended to also support the data consumption
patterns required for some batch operations ([discussion thread](https://lists.apache.org/thread.html/cb1633d10d17b0c639c3d59b2283e9e01ecda3e54ba860073c124878@%3Cdev.flink.apache.org%3E)).
This is also groundwork for features like efficient [side inputs](https://cwiki.apache.org/confluence/display/FLINK/FLIP-17+Side+Inputs+for+DataStream+API).

# Fast Batch (Bounded Streams)

The community's goal is to make Flink's performance on bounded streams (batch use cases) competitive with that
of dedicated batch processors. While Flink has been shown to handle some batch processing use cases faster than
widely-used batch processors, there are some ongoing efforts to make sure this the case for broader use cases:

  - Faster and more complete SQL/Table API: The community is merging the Blink query processor which improves on
    the current query processor by adding a much richer set of runtime operators, optimizer rules, and code generation.
    The new query processor will have full TPC-DS support and up to 10x performance improvement over the current
    query processor ([FLINK-11439](https://issues.apache.org/jira/browse/FLINK-11439)).

  - Exploiting bounded streams to reduce the scope of fault tolerance: When input data is bounded, it is
    possible to completely buffer data during shuffles (memory or disk) and replay that data after a
    failure. This makes recovery more fine grained and thus much more efficient
    ([FLINK-10288](https://issues.apache.org/jira/browse/FLINK-10288)).

  - An application on bounded data can schedule operations after another, depending on how the operators
    consume data (e.g., first build hash table, then probe hash table).
    We are separating the scheduling strategy from the ExecutionGraph to support different strategies
    on bounded data ([FLINK-10429](https://issues.apache.org/jira/browse/FLINK-10429)).

  - Caching of intermediate results on bounded data, to support use cases like interactive data exploration.
    The caching generally helps with applications where the client submits a series of jobs that build on
    top of one another and reuse each others' results.
    [FLINK-11199](https://issues.apache.org/jira/browse/FLINK-11199)

  - External Shuffle Services (mainly bounded streams) to support decoupling from computation and
    intermediate results for better resource efficiency on systems like Yarn.
    [FLIP-31](https://cwiki.apache.org/confluence/display/FLINK/FLIP-31%3A+Pluggable+Shuffle+Manager).

Various of these enhancements can be taken form the contributed code from the
[Blink fork](https://github.com/apache/flink/tree/blink).

To exploit the above optimizations for bounded streams in the DataStream API, we need
break parts of the API and explicitly model bounded streams.

# Stream Processing Use Cases

Flink will get the new modes to stop a running application while ensuring that output and
side-effects are consistent and committed prior to shutdown. *SUSPEND* commit output/side-effects,
but keep state, while *TERMINATE* drains state and commits the outputs and side effects.
[FLIP-34](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=103090212) has the details.
  
The *new source interface* effort ([FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface))
aims to give simpler out-of-the box support for event time and watermark generation for sources.
Sources will have the option to align their consumption speed in event time, to reduce the
size of in-flight state when re-processing large data volumes in streaming
([FLINK-10887](https://issues.apache.org/jira/browse/FLINK-10886)).

To make evolution of streaming state simpler, we plan to add first class support for
[Protocol Buffers](https://developers.google.com/protocol-buffers/), similar to the way
Flink deeply supports Avro state evolution ([FLINK-11333](https://issues.apache.org/jira/browse/FLINK-11333)).

# Deployment, Scaling, Security

There is a big effort to design a new way for Flink to interact with dynamic resource
pools and automatically adjust to resource availability and load.
Part of this is  becoming a *reactive* way of adjusting to changing resources (like
containers/pods being started or removed) [FLINK-10407](https://issues.apache.org/jira/browse/FLINK-10407),
while other parts are resulting in *active* scaling policies where Flink decides to add
or remove TaskManagers, based on internal metrics.

To support the active resource management also in Kubernetes, we are adding a Kubernetes Resource Manager
[FLINK-9953](https://issues.apache.org/jira/browse/FLINK-9953).

The Flink Web UI is being ported to a newer framework and getting additional features for
better introspection of running jobs [FLINK-10705](https://issues.apache.org/jira/browse/FLINK-10705).

The community is working on extending the interoperability with authentication and authorization services.
Under discussion are general extensions to the [security module abstraction](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-security-improvements-td21068.html)
as well as specific [enhancements to the Kerberos support](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-Kerberos-Improvement-td25983.html).

# Ecosystem

The community is working on extending the support for catalogs, schema registries, and
metadata stores, including support in the APIs and the SQL client ([FLINK-11275](https://issues.apache.org/jira/browse/FLINK-11275)).
We are adding DDL (Data Definition Language) support to make it easy to add tables and streams to
the catalogs ([FLINK-10232](https://issues.apache.org/jira/browse/FLINK-10232)).

There is a broad effort to integrate Flink with the Hive Ecosystem, including
metastore and Hive UDF support [FLINK-10556](https://issues.apache.org/jira/browse/FLINK-10556).

# Connectors & Formats

Support for additional connectors and formats is a continuous process.

# Miscellaneous

  - We are changing the build setup to not bundle Hadoop by default, but rather offer pre-packaged Hadoop
    libraries for the use with Yarn, HDFS, etc. as convenience downloads
    [FLINK-11266](https://issues.apache.org/jira/browse/FLINK-11266).

  - The Flink code base is being updates to support Java 9, 10, and 11
    [FLINK-8033](https://issues.apache.org/jira/browse/FLINK-8033),
    [FLINK-10725](https://issues.apache.org/jira/browse/FLINK-10725).
    
  - To reduce compatibility issues with different Scala versions, we are working using Scala
    only in the Scala APIs, but not in the runtime. That removes any Scala dependency for all
    Java-only users, and makes it easier for Flink to support different Scala versions
    [FLINK-11063](https://issues.apache.org/jira/browse/FLINK-11063).

