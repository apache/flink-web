---
title: 开发计划
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

**Last Update:** 2023-08-XX

## 功能图谱

功能图谱旨在为用户提供有关功能成熟度方面的引导，包括哪些功能正在积极推进，哪些功能即将寿终正寝。
如有任何疑问，请联系开发人员邮件列表：[dev@flink.apache.org](mailto:dev@flink.apache.org)
。

<div class="row front-graphic">
  {{< img src="/img/flink_feature_radar_zh_4.svg" width="700px" >}}
</div>

#### 功能阶段

- **MVP:** 可以了解一下这个功能，也许在将来对您有所帮助。
- **Beta:** 您可以从中受益，但是您在使用之前应该仔细评估该功能。
- **Ready and Evolving:** 生产可用，但是请注意，将来在升级Flink时，可能需要对您的应用和设置进行一些调整。
- **Stable:** 可以在生产中稳定不受限制地使用。
- **Approaching End-of-Life:** 仍然可以稳定使用，但请考虑替代方法。对于新的长期项目而言，不建议使用。
- **Deprecated:** 不推荐使用，您需要开始寻找替代产品。


## Scenarios We Focus On

### Batch / Streaming Unification and Mixing

Flink is a streaming data system in its core, that executes “batch as a special case of streaming”. Efficient execution of batch jobs is powerful in its own right; but even more so, batch processing capabilities (efficient processing of bounded streams) open the way for a seamless unification of batch and streaming applications.
Unified streaming/batch up-levels the streaming data paradigm: It gives users consistent semantics across their real-time and lag-time applications. Furthermore, streaming applications often need to be complemented by batch (bounded stream) processing, for example when reprocessing data after bugs or data quality issues, or when bootstrapping new applications. A unified API and system make this much easier.

Both DataStream API and SQL provide unified API to execute the same application in different modes of batch and streaming. There have been some efforts to make the unification much more seamless, such as unified Source API ([FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)) and SinkV2 API ([FLIP-191](https://cwiki.apache.org/confluence/display/FLINK/FLIP-191%3A+Extend+unified+Sink+interface+to+support+small+file+compaction)). Beyond unification, we want to go one step further. Our goal is to mix and switch between batch/streaming execution in the future to make it a seamless experience. We have supported checkpointing when some tasks are finished & bounded stream programs shut down with a final checkpoint ([FLIP-147](https://cwiki.apache.org/confluence/display/FLINK/FLIP-147%3A+Support+Checkpoints+After+Tasks+Finished)). There are initial discussions and designs about jobs with mixed batch/streaming execution, so stay tuned for more news in that area. 

- Dynamic checkpoint interval for processing bounded stream of historical data and unbounded stream of incremental data ([FLIP-309](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=255069517)).
- Event notification mechanism for the boundary of bounded part and unbounded part in a stream. This can unlock many exciting features and improvements, such as [FLINK-19830](https://issues.apache.org/jira/browse/FLINK-19830).
- Bootstrap states using a batch job (bounded stream program) with a final checkpoint, and continue processing with a streaming job (unbounded stream program) from the checkpoint and state. 

### Unified SQL Platform 

The community has been building Flink to a powerful basis for a unified (batch and streaming) SQL analytics platform and is continuing to do so.


SQL has very strong cross-batch-streaming semantics, allowing users to use the same queries for ad-hoc analytics and as continuous queries. Flink already contains an efficient unified query engine and a wide set of integrations. With user feedback, those are continuously improved.

#### Going Beyond a SQL Stream/Batch Processing Engine

- The experience of updating Flink SQL based jobs has been rather cumbersome as it could have led to new job graphs making restoring from savepoints/checkpoints impossible. [FLIP-190](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=191336489) which already has been shipped as MVP is targeting this.
- To extend the capability of a stream-batch processing engine and make Flink ready for the unified SQL platform, there is an ongoing effort to allow Flink better manage data and metadata, including [DELETE/UPDATE](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=235838061), [Call Procedures](https://cwiki.apache.org/confluence/display/FLINK/FLIP-311%3A+Support+Call+Stored+Procedure), [rich DDLs](https://cwiki.apache.org/confluence/display/FLINK/FLIP-305%3A+Support+atomic+for+CREATE+TABLE+AS+SELECT%28CTAS%29+statement), [Time Travel](https://cwiki.apache.org/confluence/display/FLINK/FLIP-308%3A+Support+Time+Travel), and so on. This is especially useful for building a lakehouse with Flink and Paimon/Iceberg/Hudi. 
- There are some initial discussions to support JSON data type for Flink SQL. This can enable Flink SQL to better analyze semi-structured data and better adapt to NoSQL databases. 

#### Platform Infrastructure

- After [FLIP-163](https://cwiki.apache.org/confluence/display/FLINK/FLIP-163%3A+SQL+Client+Improvements) the community is working again on a set of SQL Client usability improvements ([FLIP-189](https://cwiki.apache.org/confluence/display/FLINK/FLIP-189%3A+SQL+Client+Usability+Improvements), [FLIP-222](https://cwiki.apache.org/confluence/display/FLINK/FLIP-222%3A+Support+full+job+lifecycle+statements+in+SQL+client)) which is aiming at improving the user experience when using the SQL client.
- To simplify the building of production SQL platforms with Flink, we are improving the [SQL Gateway](https://nightlies.apache.org/flink/flink-docs-master/docs/dev/table/sql-gateway/overview/) component as the service of the Flink SQL platform. There are many ongoing exciting features around it, including supporting application mode ([FLIP-316](https://cwiki.apache.org/confluence/display/FLINK/FLIP-316%3A+Introduce+SQL+Driver)), JDBC driver client ([FLIP-293](https://cwiki.apache.org/confluence/display/FLINK/FLIP-293%3A+Introduce+Flink+Jdbc+Driver+For+Sql+Gateway)), persisted catalog registration ([FLIP-295](https://cwiki.apache.org/confluence/display/FLINK/FLIP-295%3A+Support+lazy+initialization+of+catalogs+and+persistence+of+catalog+configurations#FLIP295:Supportlazyinitializationofcatalogsandpersistenceofcatalogconfigurations-Motivation)), authentication, and high availability. 

#### Support for Common Languages

- Hive syntax compatibility can help users migrate existing Hive SQL tasks to Flink seamlessly, and it is convenient for users who are familiar with Hive syntax to use Hive syntax to write SQL to query tables registered in Flink. Until now, the Hive syntax compatibility has reached 94.1% which is measured using the Hive qtest suite. Flink community is continuously improving the compatibility and execution performance ([FLINK-29717](https://issues.apache.org/jira/browse/FLINK-29717)). 
- With [FLIP-216](https://cwiki.apache.org/confluence/display/FLINK/FLIP-216%3A++Introduce+pluggable+dialect+and+plan+for+migrating+Hive+dialect) there’s now the initiative to introduce pluggable SQL dialects on the example of the Hive syntax. It makes Flink easier to support other SQL dialects in the future, for example, Spark SQL and PostgreSQL. 

### Towards Streaming Warehouses

Flink has become the leading technology and factual standard for stream processing. The concept of unifying streaming and batch data processing is gaining recognition and is being successfully implemented in more and more companies. To further unify streaming-batch analytics, Flink has proposed the concept of Streaming Warehouse. This new concept aims to unify not only computation but also storage, ensuring that data flows and is processed in real time. As a result, the data in the warehouse is always up-to-date, and any analytics or insights generated from it reflect the current state of the business. This combines the advantages of traditional data warehouses with real-time insights.

The Apache Flink community initiated the Flink Table Store subproject ([FLIP-188](https://cwiki.apache.org/confluence/display/FLINK/FLIP-188%3A+Introduce+Built-in+Dynamic+Table+Storage)) with the vision of streaming-batch unified storage. With the project growing rapidly, Flink Table Store [joined the Apache incubator](https://lists.apache.org/thread/pz5f9cvpyk4q9vltd7z088q5368v412t) as an independent project called [Apache Paimon](https://github.com/apache/incubator-paimon/). Apache Paimon has its own roadmap under the [documentation](https://paimon.apache.org/docs/master/project/roadmap/). The unified storage opens the way for Flink to improve the performance and experience of streaming-batch unified applications.

OLAP is an important scenario after Flink streaming-batch data processing, users need an OLAP engine to analyze data in the streaming warehouse. Flink could execute “OLAP as a special case of batch” and the community is trying to explore the possibility of improvement for short-lived jobs without affecting streaming and batch processing. It is a nice-to-have feature and it will bring great value for users in Flink becoming a unified streaming-batch-OLAP data processing system.

In order to build an efficient streaming warehouse, there are a lot of things that need to be improved in Flink, for example:
- Support rich warehouse APIs to manage data and metadata, such as: CTAS/RTAS ([FLIP-303](https://cwiki.apache.org/confluence/display/FLINK/FLIP-303%3A+Support+REPLACE+TABLE+AS+SELECT+statement)), CALL ([FLIP-311](https://cwiki.apache.org/confluence/display/FLINK/FLIP-311%3A+Support+Call+Stored+Procedure)), TRUNCATE ([FLIP-302](https://cwiki.apache.org/confluence/display/FLINK/FLIP-302%3A+Support+TRUNCATE+TABLE+statement+in+batch+mode)), and so on. 
- CBO (cost-based optimizations) with statistics in streaming lakehouses for streaming queries. 
- Make full use of the layout and indexes on streaming lakehouse to reduce data reading and processing for streaming queries.
- Improvements for short-lived jobs to support OLAP queries with low latency and concurrent execution. 


## Engine Evolution

### Disaggregated State Management

One major advantage of Flink is its efficient and easy-to-use state management mechanism. However, this mechanism has evolved a little since it was born and is not suitable in the cloud-native era. In the past several releases, we’ve made significant efforts to improve the procedure of state snapshotting (FLIP-76 [unaligned checkpoint](https://flink.apache.org/2020/10/15/from-aligned-to-unaligned-checkpoints-part-1-checkpoints-alignment-and-backpressure/), FLIP-158 [generic incremental checkpoint](https://flink.apache.org/2022/05/30/improving-speed-and-stability-of-checkpointing-with-generic-log-based-incremental-checkpoints/)) and [state repartitioning](https://flink.apache.org/2022/10/28/announcing-the-release-of-apache-flink-1.16/#rocksdb-rescaling-improvement--rescaling-benchmark). In doing so, we gradually find that a lot of problems (slow state snapshotting and state recovery for example) are root-caused by computation and state management bounded together, especially for large jobs with large states. Hence, starting from Flink 2.0, we aim at disaggregating Flink computation and state management and we believe that is more suitable for a modern cloud-native architecture.

In the new design, DFS is played as primary storage. Checkpoints are shareable between operators so we do not need to compute and store multiple copies of the same state table. Queryable state APIs can be provided based on these checkpoints. Compaction and clean-up of state files are not bounded to the same Task manager anymore so we can do better load-balancing and avoid burst CPU and network peaks.

### Evolution of Flink APIs

With Flink 2.0 approaching, the community is planning to evolve the APIs of Apache Flink.
- We are planning to remove some long deprecated APIs in Flink 2.0, to make Flink move faster, including:
  - The DataSet API, all Scala APIs, the legacy SinkV1 API, the legacy TableSource/TableSink API
  - Deprecated methods / fields / classes in the DataStream API, Table API and REST API
  - Deprecated configuration options and metrics
- We are also planning to retire the legacy SourceFunction / SinkFunction APIs, and Queryable State API in the long term. This may not happen shortly, as the prerequisites for users to migrate from these APIs are not fully met at the moment.
- We are aware of some problems of the current DataStream API, such as the exposing of and dependencies on the Flink internal implementations, which requires significant changes to fix. To provide a smooth migration experience, the community is designing a new ProcessFunction API, which aims to gradually replace the DataStream API in the long term.

### Flink as an Application

The goal of these efforts is to make it feel natural to deploy (long-running streaming) Flink applications. Instead of starting a cluster and submitting a job to that cluster, these efforts support deploying a streaming job as a self-contained application.

For example as a simple Kubernetes deployment; deployed and scaled like a regular application without extra workflows.
- There is currently a Flink Kubernetes Operator subproject being developed by the community and has its own roadmap under the [documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-main/docs/development/roadmap/).
- Streaming query as an application. Make SQL Client/Gateway supports submitting SQL jobs in the application mode ([FLIP-316](https://cwiki.apache.org/confluence/display/FLINK/FLIP-316%3A+Introduce+SQL+Driver#FLIP316:IntroduceSQLDriver-Motivation)). 


### Performance

Continuous work to keep improving the performance of both Flink streaming and batch processing.

#### Large-Scale Streaming Jobs

- Streaming Join is a headache for Flink users because of its large-scale state. The community is putting lots of effort into further improving the performance of streaming join, such as minibatch join, multi-way join, and reducing duplicated states.
- The community is also continuously improving and working on some other joins, such as unordered async lookup join and processing-time temporal join ([FLIP-326](https://cwiki.apache.org/confluence/display/FLINK/FLIP-326%3A+Enhance+Watermark+to+Support+Processing-Time+Temporal+Join)). They can be very efficient alternatives for streaming joins.
- Change data capture and processing with Flink SQL is widely used, and the community is improving cost and performance in this case, e.g. reducing normalize and materialize state.

#### Faster Batch Queries

The community's goal is to make Flink's performance on bounded streams (batch use cases) competitive with that of dedicated batch processors. While Flink has been shown to handle some batch processing use cases faster than widely-used batch processors, there are some ongoing efforts to make sure this is the case for broader use cases:
The community has introduced Dynamic Partition Pruning ([DPP](https://cwiki.apache.org/confluence/display/FLINK/FLIP-248%3A+Introduce+dynamic+partition+pruning)) which aims to minimize I/O costs of the data read from the data sources. There are some ongoing efforts to further reduce the I/O and shuffle costs, such as Runtime Filter ([FLIP-324](https://cwiki.apache.org/confluence/display/FLINK/FLIP-324%3A+Introduce+Runtime+Filter+for+Flink+Batch+Jobs)).
Operator Fusion CodeGen ([FLIP-315](https://cwiki.apache.org/confluence/display/FLINK/FLIP-315+Support+Operator+Fusion+Codegen+for+Flink+SQL)) improves the execution performance of a query by fusing an operator DAG into a single optimized operator that eliminates virtual function calls and leverages CPU registers for intermediate data.
The community has supported some adaptive batch execution and scheduling ([FLIP-187](https://cwiki.apache.org/confluence/display/FLINK/FLIP-187%3A+Adaptive+Batch+Scheduler)). We are trying to support broader adaptive cases, such as Adaptive Query Execution that makes use of runtime statistics to choose the most efficient query execution plan. 
The community has started improving scheduler and execution performance ([FLINK-25318](https://issues.apache.org/jira/browse/FLINK-25318)) for short-lived jobs to support OLAP. Flink executes “OLAP as a special case of batch”, we are trying to extend Flink to execute low-latency and currency queries in Session Cluster and users can perform streaming, batch, and OLAP data processing on the unified Flink engine.

### Stability

The community is keeping improving the stability of jobs, by better tolerating failures, and speeding up the recovery process.

The instability of the environment is unavoidable. It can lead to a crash of JobManager and TaskManager nodes, or slow data processing. The community has introduced speculative execution ([FLIP-168](https://cwiki.apache.org/confluence/display/FLINK/FLIP-168%3A+Speculative+Execution+for+Batch+Job), [FLIP-245](https://cwiki.apache.org/confluence/display/FLINK/FLIP-245%3A+Source+Supports+Speculative+Execution+For+Batch+Job), [FLIP-281](https://cwiki.apache.org/confluence/display/FLINK/FLIP-281+Sink+Supports+Speculative+Execution+For+Batch+Job)) for batch jobs to reduce the impact of problematic machines which slows down data processing.

JobManager node crash is usually unacceptable for a batch job because the job has to be re-run from the very beginning. Therefore, the community is planning to improve the JobManager recovery process to avoid re-run finished stages. Another planned improvement is to retain running tasks when the JobManager node goes down unexpectedly, to further reduce the impact of the JobManager crash. This can also benefit streaming jobs even if they have periodical checkpointing, to avoid interruption or regression of data processing in this case.

### Usability

Now and then we hear people say that, while Flink is powerful in functionality, it is not that easy to master. Such voices are heard. The community is working on several efforts to improve the usability of Flink.

We are working on reducing the number of configuration options that users need to specify, as well as making them easier to understand and tune. This includes:
Removing options that require in-depth knowledge of Flink internals to understand and use.
Making Flink automatically and dynamically decide the proper behavior where possible.
Improving the default values of the options so that users need not to touch them in most cases.
Improving the definition and description of the options so that they are easier to understand and work with when it’s necessary.

We have already made some progress along this direction. Flink 1.17 requires less than 10 configurations to achieve well enough performance on TPC-DS. Hybrid shuffle supports dynamically switching between different shuffle modes and decouples its memory footprint from the parallelism of the job.


## Developer Experience

### Ecosystem
There is almost no use case in which Apache Flink is used on its own. It has established itself as part of many data related reference architectures. In fact you’ll find the squirrel logo covering several aspects.

All connectors will be hosted in an external repository going forward and many of them have been successfully externalized. See the [mailing list thread](https://lists.apache.org/thread/8k1xonqt7hn0xldbky1cxfx3fzh6sj7h). 
Catalog as a first-class citizen. Flink catalog lets users issue batch and streaming queries connecting to external systems without registering DDLs/schemas manually. It is recommended to support Catalog in the highest priority for connectors. The community is working on supporting more catalogs for connectors (e.g. [GlueCatalog](https://cwiki.apache.org/confluence/display/FLINK/FLIP-277%3A+Native+GlueCatalog+Support+in+Flink), [SchemaRegistryCatalog](https://cwiki.apache.org/confluence/display/FLINK/FLIP-125%3A+Confluent+Schema+Registry+Catalog)). 
There is ongoing work on introducing more new connectors (e.g. [Pinot](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=177045634), [Redshift](https://cwiki.apache.org/confluence/display/FLINK/FLIP-307%3A++Flink+Connector+Redshift), [ClickHouse](https://cwiki.apache.org/confluence/display/FLINK/FLIP-202%3A+Introduce+ClickHouse+Connector))


### Documentation

There are various dedicated efforts to simplify the maintenance and structure (more intuitive navigation/reading) of the documentation.

- Docs Tech Stack: [FLIP-157](https://cwiki.apache.org/confluence/display/FLINK/FLIP-157+Migrate+Flink+Documentation+from+Jekyll+to+Hugo)
- General Docs Structure: [FLIP-42](https://cwiki.apache.org/confluence/display/FLINK/FLIP-42%3A+Rework+Flink+Documentation)
- SQL Docs: [FLIP-60](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=127405685)


