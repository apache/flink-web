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

**Preamble:** This roadmap means to provide user and contributors with a high-level summary of ongoing efforts,
grouped by the major threads to which the efforts belong. With so much that is happening in Flink, we
hope that this helps with understanding the direction of the project.
The roadmap contains both efforts in early stages as well as nearly completed
efforts, so that users may get a better impression of the overall status and direction of those developments.

More details and various smaller changes can be found in the
[FLIPs](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals)

The roadmap is continuously updated. New features and efforts should be added to the roadmap once
there is consensus that they will happen and what they will roughly look like for the user.

**Last Update:** 2021-03-01

<hr />

# Feature Radar

The feature radar is meant to give users guidance regarding feature maturity, as well as which features
are approaching end-of-life. For questions, please contact the developer mailing list:
[dev@flink.apache.org](mailto:dev@flink.apache.org)

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/flink_feature_radar_2.svg" width="700px" />
</div>

## Feature Stages

  - **MVP:** Have a look, consider whether this can help you in the future.
  - **Beta:** You can benefit from this, but you should carefully evaluate the feature.
  - **Ready and Evolving:** Ready to use in production, but be aware you may need to make some adjustments to your application and setup in the future, when you upgrade Flink.
  - **Stable:** Unrestricted use in production
  - **Reaching End-of-Life:** Stable, still feel free to use, but think about alternatives. Not a good match for new long-lived projects.
  - **Deprecated:** Start looking for alternatives now

<hr />

# Unified Analytics: Where Batch and Streaming come Together; SQL and beyond.

Flink is a streaming data system in its core, that executes "batch as a special case of streaming".
Efficient execution of batch jobs is powerful in its own right; but even more so, batch processing
capabilities (efficient processing of bounded streams) open the way for a seamless unification of
batch and streaming applications.

Unified streaming/batch up-levels the streaming data paradigm: It gives users consistent semantics across
their real-time and lag-time applications. Furthermore, streaming applications often need to be complemented
by batch (bounded stream) processing, for example when reprocessing data after bugs or data quality issues,
or when bootstrapping new applications. A unified API and system make this much easier.

## A unified SQL Platform

The community has been building Flink to a powerful basis for a unified (batch and streaming) SQL analytics
platform, and is continuing to do so.

SQL has very strong cross-batch-streaming semantics, allowing users to use the same queries for ad-hoc analytics
and as continuous queries. Flink already contains an efficient unified query engine, and a wide set of
integrations. With user feedback, those are continuously improved.

**More Connector and Change Data Capture Support**

  - Change-Data-Capture: Capturing a stream of data changes, directly from databases, by attaching to the
    transaction log. The community is adding more CDC intrgrations.
      - External CDC connectors: [https://flink-packages.org/packages/cdc-connectors](https://flink-packages.org/packages/cdc-connectors)
      - Background: [FLIP-105](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=147427289)
        (CDC support for SQL) and [Debezium](https://debezium.io/).

  - Data Lake Connectors: Unified streaming & batch is a powerful value proposition for Data Lakes: supporting
    same APIs, semantics, and engine for streaming real-time processing and batch processing of historic data.
    The community is adding deeper integrations with various Data Lake systems:
    - [Apache Iceberg](https://iceberg.apache.org/): [https://iceberg.apache.org/flink/](https://iceberg.apache.org/flink/)
    - [Apache Hudi](https://hudi.apache.org/): [https://hudi.apache.org/blog/apache-hudi-meets-apache-flink/](https://hudi.apache.org/blog/apache-hudi-meets-apache-flink/)
    - [Apache Pinot](https://pinot.apache.org/): [FLIP-166](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=177045634)

**Platform Infrastructure**

  - To simplify the building of production SQL platforms with Flink, we are improving the SQL client and are
    working on SQL gateway components that interface between client and cluster: [FLIP-163](https://cwiki.apache.org/confluence/display/FLINK/FLIP-163%3A+SQL+Client+Improvements)

**Support for Common Languages, Formats, Catalogs**

  - Hive Query Compatibility: [FLIP-152](https://cwiki.apache.org/confluence/display/FLINK/FLIP-152%3A+Hive+Query+Syntax+Compatibility)

Flink has a broad SQL coverage for batch (full TPC-DS support) and a state-of-the-art set of supported
operations in streaming. There is continuous effort to add more functions and cover more SQL operations.

## Deep Batch / Streaming Unification for the DataStream API

The *DataStream API* is Flink's *physical* API, for use cases where users need very explicit control over data
types, streams, state, and time. This API is evolving to support efficient batch execution on bounded data.

DataStream API executes the same dataflow shape in batch as in streaming, keeping the same operators.
That way users keep the same level of control over the dataflow, and our goal is to mix and switch between
batch/streaming execution in the future to make it a seamless experience.

**Unified Sources and Sinks**

  - The first APIs and implementations of sources were specific to either streaming programs in the DataStream API
    ([SourceFunction](https://github.com/apache/flink/blob/master/flink-streaming-java/src/main/java/org/apache/flink/streaming/api/functions/source/SourceFunction.java)),
    or to batch programs in the DataSet API ([InputFormat](https://github.com/apache/flink/blob/master/flink-core/src/main/java/org/apache/flink/api/common/io/InputFormat.java)).

    In this effort, we are creating sources that work across batch and streaming execution. The aim is to give
    users a consistent experience across both modes, and to allow them to easily switch between streaming and batch
    execution for their unbounded and bounded streaming applications.
    The interface for this New Source API is done and available, and we are working on migrating more source connectors
    to this new model, see [FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface).

  - Similar to the sources, the sinks original sink APIs are also specific to streaming
    ([SinkFunction](https://github.com/apache/flink/blob/master/flink-streaming-java/src/main/java/org/apache/flink/streaming/api/functions/sink/SinkFunction.java))
    and batch ([OutputFormat](https://github.com/apache/flink/blob/master/flink-core/src/main/java/org/apache/flink/api/common/io/OutputFormat.java))
    APIs and execution.

    We have introduced a new API for sinks that consistently handles result writing and committing (*Transactions*)
    across batch and streaming. The first iteration of the API exists, and we are porting sinks and refining the
    API in the process. See [FLIP-143](https://cwiki.apache.org/confluence/display/FLINK/FLIP-143%3A+Unified+Sink+API).

**DataStream Batch Execution**

  - Flink is adding a *batch execution mode* for bounded DataStream programs. This gives users faster and simpler
    execution and recovery of their bounded streaming applications; users do not need to worry about watermarks and
    state sizes in this execution mode: [FLIP-140](https://cwiki.apache.org/confluence/display/FLINK/FLIP-140%3A+Introduce+batch-style+execution+for+bounded+keyed+streams)

    The core batch execution mode is implemented with [great results](https://flink.apache.org/news/2020/12/10/release-1.12.0.html#batch-execution-mode-in-the-datastream-api);
    there are ongoing improvements around aspects like broadcast state and processing-time-timers.
    This mode requires the new unified sources and sinks that are mentioned above, so it is limited
    to the connectors that have been ported to those new APIs.

**Mixing bounded/unbounded streams, and batch/streaming execution**

  - Support checkpointing when some tasks finished & Bounded stream programs shut down with a final
    checkpoint: [FLIP-147](https://cwiki.apache.org/confluence/display/FLINK/FLIP-147%3A+Support+Checkpoints+After+Tasks+Finished)

  - There are initial discussions and designs about jobs with mixed batch/streaming execution, so stay tuned for more
    news in that area.

## Subsuming DataSet with DataStream and Table API

We want to eventually drop the legacy Batch-only DataSet API, have batch-and stream processing unified
throughout the entire system.

Overall Discussion: [FLIP-131](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=158866741)

The _DataStream API_ supports batch-execution to efficiently execute streaming programs on historic data
(see above). Takes over that set of use cases.

The _Table API_ should become the default API for batch-only applications.

  - Add more operations to Table API, so support common data manipulation tasks more
   easily: [FLIP-155](https://cwiki.apache.org/confluence/display/FLINK/FLIP-155%3A+Introduce+a+few+convenient+operations+in+Table+API)
  - Make Source and Sink definitions easier in the Table API.

Improve the _interplay between the Table API and the DataStream API_ to allow switching from Table API to
DataStream API when more control over the data types and operations is necessary.

  - Interoperability between DataStream and Table APIs: [FLIP-136](https://cwiki.apache.org/confluence/display/FLINK/FLIP-136%3A++Improve+interoperability+between+DataStream+and+Table+API)

<hr />

# Applications vs. Clusters; "Flink as a Library"

The goal of these efforts is to make it feel natural to deploy (long running streaming) Flink applications.
Instead of starting a cluster and submitting a job to that cluster, these efforts support deploying a streaming
job as a self contained application.

For example as a simple Kubernetes deployment; deployed and scaled like a regular application without extra workflows.

Deploy Flink jobs as self-contained Applications works for all deployment targets since Flink 1.11.0
([FLIP-85](https://cwiki.apache.org/confluence/display/FLINK/FLIP-85+Flink+Application+Mode)).

  - Reactive Scaling lets Flink applications change their parallelism in response to growing and shrinking
    worker pools, and makes Flink compatibel with standard auto-scalers:
    [FLIP-159](https://cwiki.apache.org/confluence/display/FLINK/FLIP-159%3A+Reactive+Mode)

  - Kubernetes-based HA-services let Flink applications run on Kubernetes without requiring a ZooKeeper dependency:
    [FLIP-144](https://cwiki.apache.org/confluence/display/FLINK/FLIP-144%3A+Native+Kubernetes+HA+for+Flink)

<hr />

# Performance

Continuous work to keep improving performance and recovery speed.

## Faster Checkpoints and Recovery

The community is continuously working on improving checkpointing and recovery speed.
Checkpoints and recovery are stable and have been a reliable workhorse for years. We are still
trying to make it faster, more predictable, and to remove some confusions and inflexibility in some areas.

  - Unaligned Checkpoints, to make checkpoints progress faster when applications cause backpressure:
    [FLIP-76](https://cwiki.apache.org/confluence/display/FLINK/FLIP-76%3A+Unaligned+Checkpoints), available
    since Flink 1.12.2.
  - Log-based checkpoints, for very frequent incremental checkpointing:
    [FLIP-158](https://cwiki.apache.org/confluence/display/FLINK/FLIP-158%3A+Generalized+incremental+checkpoints)

## Large Scale Batch Applications

The community is working on making large scale batch execution (parallelism in the order of 10,000s)
simpler (less configuration tuning required) and more performant.

  - Introduce a more scalable batch shuffle. First parts of this have been merged, and ongoing efforts are
    to make the memory footprint (JVM direct memory) more predictable, see
    [FLIP-148](https://cwiki.apache.org/confluence/display/FLINK/FLIP-148%3A+Introduce+Sort-Merge+Based+Blocking+Shuffle+to+Flink)

      - [FLINK-20740](https://issues.apache.org/jira/browse/FLINK-20740)
      - [FLINK-19938](https://issues.apache.org/jira/browse/FLINK-19938)

  - Make scheduler faster for higher parallelism: [FLINK-21110](https://issues.apache.org/jira/browse/FLINK-21110)

<hr />

# Python APIs

Stateful transformation functions for the Python DataStream API:
[FLIP-153](https://cwiki.apache.org/confluence/display/FLINK/FLIP-153%3A+Support+state+access+in+Python+DataStream+API)

<hr />

# Documentation

There are various dedicated efforts to simplify the maintenance and structure (more intuitive navigation/reading)
of the documentation.

  - Docs Tech Stack: [FLIP-157](https://cwiki.apache.org/confluence/display/FLINK/FLIP-157+Migrate+Flink+Documentation+from+Jekyll+to+Hugo)
  - General Docs Structure: [FLIP-42](https://cwiki.apache.org/confluence/display/FLINK/FLIP-42%3A+Rework+Flink+Documentation)
  - SQL Docs: [FLIP-60](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=127405685)

<hr />

# Miscellaneous Operational Tools

  - Allow switching state backends with savepoints: [FLINK-20976](https://issues.apache.org/jira/browse/FLINK-20976)
  - Support for Savepoints with more properties, like incremental savepoints, etc.:
    [FLIP-47](https://cwiki.apache.org/confluence/display/FLINK/FLIP-47%3A+Checkpoints+vs.+Savepoints)

<hr />

# Stateful Functions

The Stateful Functions subproject has its own roadmap published under [statefun.io](https://statefun.io/).
