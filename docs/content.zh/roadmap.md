---
title: Apache Flink 开发计划（Roadmap）
bookCollapseSection: false
weight: 15
menu_weight: 3
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

# Roadmap

**导读：**
此计划路线图旨在对Flink社区当前正在进行的项目进行总结摘要，并对这些项目根据工作内容进行分组。
鉴于Flink每个分组中现在都有非常多的工作正在进行，我们希望此计划书有助于用户和贡献者理解每个项目乃至于整个Flink的未来方向。
这个计划书既涵盖刚起步的项目，也包括接近完成的项目，这样可以使大家更好地了解各项目的发展方向以及当前的进展。

关于各个项目更多的细节讨论和其他较小的改动记录在 [FLIPs](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals)
。

路线图会不断更新。一旦达成共识，新的特性和工作都会添加到路线图中。
这里的共识是指这些特性和工作将来确定会发生，以及这些工作对于用户来说大致是什么样的。

**Last Update:** 2022-11-14

## 功能图谱

功能图谱旨在为用户提供有关功能成熟度方面的引导，包括哪些功能正在积极推进，哪些功能即将寿终正寝。
如有任何疑问，请联系开发人员邮件列表：[dev@flink.apache.org](mailto:dev@flink.apache.org)
。

<div class="row front-graphic">
  {{< img src="/img/flink_feature_radar_3.svg" width="700px" >}}
</div>

#### 功能阶段

- **MVP:** 可以了解一下这个功能，也许在将来对您有所帮助。
- **Beta:** 您可以从中受益，但是您在使用之前应该仔细评估该功能。
- **Ready and Evolving:** 生产可用，但是请注意，将来在升级Flink时，可能需要对您的应用和设置进行一些调整。
- **Stable:** 可以在生产中稳定不受限制地使用。
- **Reaching End-of-Life:** 仍然可以稳定使用，但请考虑替代方法。对于新的长期项目而言，不建议使用。
- **Deprecated:** 不推荐使用，您需要开始寻找替代产品。

### Unified Analytics: Where Batch and Streaming come Together; SQL and beyond.

Flink is a streaming data system in its core, that executes "batch as a special case of streaming".
Efficient execution of batch jobs is powerful in its own right; but even more so, batch processing
capabilities (efficient processing of bounded streams) open the way for a seamless unification of
batch and streaming applications.

Unified streaming/batch up-levels the streaming data paradigm: It gives users consistent semantics across
their real-time and lag-time applications. Furthermore, streaming applications often need to be complemented
by batch (bounded stream) processing, for example when reprocessing data after bugs or data quality issues,
or when bootstrapping new applications. A unified API and system make this much easier.

### A unified SQL Platform

The community has been building Flink to a powerful basis for a unified (batch and streaming) SQL analytics
platform, and is continuing to do so.

SQL has very strong cross-batch-streaming semantics, allowing users to use the same queries for ad-hoc analytics
and as continuous queries. Flink already contains an efficient unified query engine, and a wide set of
integrations. With user feedback, those are continuously improved.

**Going Beyond a SQL Stream/Batch Processing Engine**

- To extend the capability of a pure stream processor and make Flink ready for future use cases,
  [FLIP-188](https://cwiki.apache.org/confluence/display/FLINK/FLIP-188%3A+Introduce+Built-in+Dynamic+Table+Storage)
  has been announced adding built in dynamic table storage.
- The experience of updating Flink SQL based jobs has been rather cumbersome as it could have
  lead to new job graphs making restoring from savepoints/checkpoints impossible.
  [FLIP-190](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=191336489&src=contextnavpagetreemode)
  that already has been shipped as MVP is targeting this.


**Platform Infrastructure**

- After [FLIP-163](https://cwiki.apache.org/confluence/display/FLINK/FLIP-163%3A+SQL+Client+Improvements)
  the community is working again on a set of SQL Client usability improvements
  ([FLIP-189](https://cwiki.apache.org/confluence/display/FLINK/FLIP-189%3A+SQL+Client+Usability+Improvements))
  which is aiming at improving the user experience, when using the SQL client.

**Support for Common Languages, Formats, Catalogs**

- With [FLIP-216](https://cwiki.apache.org/confluence/display/FLINK/FLIP-216%3A++Introduce+pluggable+dialect+and++decouple+Hive+connector)
  there's now the initiative to introduce pluggable dialects on the example of the Hive connector.
  Including so many dependencies to make dialects work has lead to an overhead for contributors
  and users.

Flink has a broad SQL coverage for batch (full TPC-DS support) and a state-of-the-art set of supported
operations in streaming. There is continuous effort to add more functions and cover more SQL operations.

### Deep Batch / Streaming Unification for the DataStream API

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

- Similar to the sources, the original sink APIs are also specific to streaming
  ([SinkFunction](https://github.com/apache/flink/blob/master/flink-streaming-java/src/main/java/org/apache/flink/streaming/api/functions/sink/SinkFunction.java))
  and batch ([OutputFormat](https://github.com/apache/flink/blob/master/flink-core/src/main/java/org/apache/flink/api/common/io/OutputFormat.java))
  APIs and execution.

  We have introduced a new API for sinks that consistently handles result writing and committing (*Transactions*)
  across batch and streaming. The first iteration of the API exists, and we are porting sinks and refining the
  API in the process. See [FLIP-143](https://cwiki.apache.org/confluence/display/FLINK/FLIP-143%3A+Unified+Sink+API).

### Applications vs. Clusters; "Flink as a Library"

The goal of these efforts is to make it feel natural to deploy (long running streaming) Flink applications.
Instead of starting a cluster and submitting a job to that cluster, these efforts support deploying a streaming
job as a self contained application.

For example as a simple Kubernetes deployment; deployed and scaled like a regular application without extra workflows.

- There is currently a Kubernetes Operator being developed by the community. See
  [FLIP-212](https://cwiki.apache.org/confluence/display/FLINK/FLIP-212%3A+Introduce+Flink+Kubernetes+Operator).

### Performance

Continuous work to keep improving performance and recovery speed.

### Faster Checkpoints and Recovery

The community is continuously working on improving checkpointing and recovery speed.
Checkpoints and recovery are stable and have been a reliable workhorse for years. We are still
trying to make it faster, more predictable, and to remove some confusions and inflexibility in some areas.

- [FLIP-183](https://cwiki.apache.org/confluence/display/FLINK/FLIP-183%3A+Dynamic+buffer+size+adjustment)
  is targeting size of checkpoints by debloating the buffers. A first beta is already available.
- With [FLIP-151](https://cwiki.apache.org/confluence/display/FLINK/FLIP-151%3A+Incremental+snapshots+for+heap-based+state+backend)
  there is an ongoing effort to implement a heap based state backend.

### Apache Flink as part of an ever evolving data ecosystem

There is almost no use case in which Apache Flink is used on its own. It has established itself
as part of many data related reference architectures. In fact you'll find the squirrel logo covering
several aspects.

The community has added a lot of connectors and formats. With the already mentionend
[FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface) and
[FLIP-143](https://cwiki.apache.org/confluence/display/FLINK/FLIP-143%3A+Unified+Sink+API)
a new default for connectors has been established.

- There are efforts to revise the formats API with
  [FLIP-219](https://cwiki.apache.org/confluence/display/FLINK/FLIP-219%3A+Revised+Format+API)
- There is ongoing work on new connectors
  (e.g. [Pinot](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=177045634))
- Connectors will be hosted in an external repository going forward. See the
  [ML thread](https://lists.apache.org/thread/8k1xonqt7hn0xldbky1cxfx3fzh6sj7h)

The Flink community has removed Gelly, it's old graph-processing library.

### Documentation

There are various dedicated efforts to simplify the maintenance and structure (more intuitive navigation/reading)
of the documentation.

- Docs Tech Stack: [FLIP-157](https://cwiki.apache.org/confluence/display/FLINK/FLIP-157+Migrate+Flink+Documentation+from+Jekyll+to+Hugo)
- General Docs Structure: [FLIP-42](https://cwiki.apache.org/confluence/display/FLINK/FLIP-42%3A+Rework+Flink+Documentation)
- SQL Docs: [FLIP-60](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=127405685)

### Flink Kubernetes Operator

Flink Kubernetes Operator 项目拥有自己的[路线图](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-main/docs/development/roadmap/)，您可以在它的说明文档下面看到社区即将开展的工作。

### Flink Table Store

The Flink Table Store subproject has its own roadmap under the [documentation](https://nightlies.apache.org/flink/flink-table-store-docs-master/docs/development/roadmap/).
