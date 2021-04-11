---
title: "Apache Flink 开发计划（Roadmap）"
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

**导读：**
此计划路线图旨在对Flink社区当前正在进行的项目进行总结摘要，并对这些项目根据工作内容进行分组。
鉴于Flink每个分组中现在都有非常多的工作正在进行，我们希望此计划书有助于用户和贡献者理解每个项目乃至于整个Flink的未来方向。
这个计划书既涵盖刚起步的项目，也包括接近完成的项目，这样可以使大家更好地了解各项目的发展方向以及当前的进展。

关于各个项目更多的细节讨论和其他较小的改动记录在 [FLIPs](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals)
。

路线图会不断更新。一旦达成共识，新的特性和工作都会添加到路线图中。
这里的共识是指这些特性和工作将来确定会发生，以及这些工作对于用户来说大致是什么样的。

**Last Update:** 2021-04-06

<hr />

# 功能图谱

功能图谱旨在为用户提供有关功能成熟度方面的引导，包括哪些功能正在积极推进，哪些功能即将寿终正寝。
如有任何疑问，请联系开发人员邮件列表：[dev@flink.apache.org](mailto:dev@flink.apache.org)
。

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/flink_feature_radar_zh_2.svg" width="700px" />
</div>

## 功能阶段

- **MVP:** 可以了解一下这个功能，也许在将来对您有所帮助。
- **Beta:** 您可以从中受益，但是您在使用之前应该仔细评估该功能。
- **Ready and Evolving:** 生产可用，但是请注意，将来在升级Flink时，可能需要对您的应用和设置进行一些调整。
- **Stable:** 可以在生产中稳定不受限制地使用。
- **Reaching End-of-Life:** 仍然可以稳定使用，但请考虑替代方法。对于新的长期项目而言，不建议使用。
- **Deprecated:** 不推荐使用，您需要开始寻找替代产品。

<hr />


# 一体化分析：流批一体，SQL及其他
Flink的内核是流数据处理系统，Flink将批处理作为流的特例，用流的方式来执行批处理。
Flink作为一个流式引擎，不仅能够高效执行批处理，更重要的是通过高效处理有限流的方式，
打开了无缝流批一体处理之门。

流批一体升级了流数据范例：它可以保证实时和离线应用语义的一致性。
此外，有时流式处理的作业也需要离线（有限流）处理作为补充，例如，
在出现错误或出现数据质量问题时需要重新处理数据，
或者有的情况下启动新的作业但需要历史数据作为引导。统一的API和系统使得此类操作变得很容易。

## 统一的SQL平台

Flink社区一直致力于建设基于Flink的统一的流批一体SQL分析平台，并将持续在这个方向上努力。
SQL具有非常强的跨流批的语义，并允许用户使用相同的SQL语句对即时查询（ad-hoc query）和
连续查询（continuous query）进行分析。Flink拥有高效的统一查询引擎，以及基于此的一系列整合统一。
根据用户反馈，我们会持续改善这些整合统一的使用体验。


**CDC & Connectors**

  - CDC（Change-Data-Capture）: 通过直接连接到数据库的日志来捕获数据变更。Flink社区会加强和CDC的整合
      - CDC connectors: 
        [https://flink-packages.org/packages/cdc-connectors](https://flink-packages.org/packages/cdc-connectors)
      - 背景: [FLIP-105](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=147427289)
        (CDC对SQL的支持) & [Debezium](https://debezium.io/)

  - 数据湖Connectors: 流批一体对数据湖有很大价值，包括支持流（处理当前数据）和批（处理历史数据）的相同API，相同语义，以及相同引擎。
	目前，Flink社区正在和各种数据湖系统进行深度融合，包括：
      - [Apache Iceberg](https://iceberg.apache.org/): 
        [https://iceberg.apache.org/flink/](https://iceberg.apache.org/flink/)
      - [Apache Hudi](https://hudi.apache.org/): 
        [https://hudi.apache.org/blog/apache-hudi-meets-apache-flink/](https://hudi.apache.org/blog/apache-hudi-meets-apache-flink/)
      - [Apache Pinot](https://pinot.apache.org/): 
        [FLIP-166](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=177045634)

**SQL 平台基建**

  - 为了简化Flink SQL的生产实践，我们正在改进SQL客户端以及SQL Gateway中客户端和群集之间与交互相关的组件：
    [FLIP-163](https://cwiki.apache.org/confluence/display/FLINK/FLIP-163%3A+SQL+Client+Improvements)

**通用语言，格式（Formats），目录（Catalogs）**

  - Hive Query兼容性支持: [FLIP-152](https://cwiki.apache.org/confluence/display/FLINK/FLIP-152%3A+Hive+Query+Syntax+Compatibility)

Flink SQL具备广泛的批处理覆盖（全面的TPC-DS支持）和最先进的流处理支持。我们也一直会努力增添更多的SQL功能和算子。


## DataStream API 流批一体深度融合

*DataStream API* 是 Flink 的*物理层* API, 针对需要明确地控制数据类型，数据流，状态以及时间的应用。
DataStream API 也在不断丰富演化以支持在有限数据上的高效地批处理。
DataStream API 使用和流式一样的 dataflow 来执行批处理，并使用一样的算子。
这样一来，用户使用 DataStream API 表达流和批可以保持相同级别的控制。
我们对DataStream API融合的最终目标是可以混合并自由切换流批执行，提供流批间无缝切换体验。

**统一 Sources & Sinks**

  - 第一代 source 的 API 和实现要么只能用于 DataStream API 里面的流处理
    ([SourceFunction](https://github.com/apache/flink/blob/master/flink-streaming-java/src/main/java/org/apache/flink/streaming/api/functions/source/SourceFunction.java))
    ；要么只能用于 DataSet API 里面的批处理 
    ([InputFormat](https://github.com/apache/flink/blob/master/flink-core/src/main/java/org/apache/flink/api/common/io/InputFormat.java)) 。
    
    因此，我们致力于构造对流和批都适用的 sources，能让用户在这两种模式下有一致的使用体验，
    并可以很容易地在流处理和批处理之间切换，执行无限流和有限流作业。
    新的 Source API 的接口已经可以使用。我们会将更多的 source connectors 迁移到这个新的模型，详见
	[FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface).

  - 和 source 类似，原先的 sink 及其 API 也是分别针对流
    ([SinkFunction](https://github.com/apache/flink/blob/master/flink-streaming-java/src/main/java/org/apache/flink/streaming/api/functions/sink/SinkFunction.java))
    和批 ([OutputFormat](https://github.com/apache/flink/blob/master/flink-core/src/main/java/org/apache/flink/api/common/io/OutputFormat.java))
    设计的。

    为此，我们引入了新的 sink API，可以流批一致的解决结果输出和提交 (*Transactions*) 的问题。
	新的 sink API 的第一版已经出炉，并在不断改进中，详见 
	[FLIP-143](https://cwiki.apache.org/confluence/display/FLINK/FLIP-143%3A+Unified+Sink+API) 。
    
**DataStream 的批处理执行模式**

  - Flink 在 DataStream 上为有限流新增加了*批执行模式*，这可以使得用户更简单快速的执行和恢复有限流作业。 
    在有限流的批执行模式下，用户无需担心 watermarks 和状态大小的问题：
    [FLIP-140](https://cwiki.apache.org/confluence/display/FLINK/FLIP-140%3A+Introduce+batch-style+execution+for+bounded+keyed+streams) 。
	
    批执行模式的核心实现已有 [很好的结果](https://flink.apache.org/news/2020/12/10/release-1.12.0.html#batch-execution-mode-in-the-datastream-api);
    其他部分也在持续改进中，包括 broadcast state 和 processing-time-timers。
    值得注意的是，此模式的实现基于上面提到的新的的 source 和 sink，因此它只能支持已经使用新 API 的 connectors。

**混合 有限流/无限流 & 批执行/流执行**

  - 支持在部分 task 结束后还可以做 checkpoint & 支持有限流作业在结束的时候做最后一次 checkpoint ：
    [FLIP-147](https://cwiki.apache.org/confluence/display/FLINK/FLIP-147%3A+Support+Checkpoints+After+Tasks+Finished)

  - 对于混合/切换流和批的执行，我们有一些初步的设计和讨论，敬请关注。

## 使用 DataStream & Table API 取代 DataSet

我们希望最终能弃用只支持批式处理的 DataSet API，从而使用统一的流批处理贯穿整个系统。
整体的讨论在这里: [FLIP-131](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=158866741) 。

_DataStream API_ 可以高效的用批的方式来执行需要处理历史数据的流作业（如上所述）。

_Table API_ 应该是所有单批作业所使用的默认的 API 。

- Table API 增加更多操作，以方便支持常见的数据操作任务
	[FLIP-155](https://cwiki.apache.org/confluence/display/FLINK/FLIP-155%3A+Introduce+a+few+convenient+operations+in+Table+API)

- 在 Table API 中，使 Source 和 Sink 更容易定义使用                                                  

- DataStream API & Table API 互通性: 
	[FLIP-136](https://cwiki.apache.org/confluence/display/FLINK/FLIP-136%3A++Improve+interoperability+between+DataStream+and+Table+API)
	
	提升 Table API 和 DataStream API 之间互通的能力。当需要更多对数据类型和操作控制的时候，允许从 Table API 切换到 DataStream API 。
   
<hr />

# Applications vs. Clusters; "Flink as a Library"

这个部分的工作主要是为了使部署（长时间运行的流式）Flink 作业变得更为自然简单。
我们希望部署一个流式作业就像启动一个独立的应用（Applications）一样简单：
不需要首先启动集群（Clusters），再向该集群提交作业。

例如，我们期望 Flink 作业可以作为简单的Kubernetes部署，能像普通应用程序一样可以进行常规部署和扩展，而无需额外的工作流程。
从 Flink 1.11.0 开始，Flink 支持将 Flink 作业部署为独立的应用程序
([FLIP-85](https://cwiki.apache.org/confluence/display/FLINK/FLIP-85+Flink+Application+Mode)) 。

  - 响应式缩放功能（Reactive Scaling）可以使 Flink 作业根据资源池的增长和收缩情况更改并行度。 
    这样可以自然地使 Flink 与标准自动缩放（atuo Scaler）兼容。
	[FLIP-159](https://cwiki.apache.org/confluence/display/FLINK/FLIP-159%3A+Reactive+Mode)

  - 基于 Kubernetes 的高可用性（HA）服务使 Flink 作业在 Kubernetes 上运行时无需依赖ZooKeeper：
    [FLIP-144](https://cwiki.apache.org/confluence/display/FLINK/FLIP-144%3A+Native+Kubernetes+HA+for+Flink)

<hr />

# 性能

我们会持续不断的提高性能和容错恢复速度。

## Faster Checkpoints and Recovery

Flink 社区正在致力于提升做检查点（checkpointing）和容错恢复（recovery）的速度。
Flink的容错机制多年来运行非常稳定，但是我们还是想让整个容错过程更快并且更可预测，提升易用性。

- Unaligned Checkpoints，解决反压情况下 Checkpoint 做不出来的问题，从 Flink 1.12.2 版本开始可用：
    [FLIP-76](https://cwiki.apache.org/confluence/display/FLINK/FLIP-76%3A+Unaligned+Checkpoints)
  
- Log-based Checkpoints, 可以做高频增量 Checkpoints，加快 checkpoint：
	[FLIP-158](https://cwiki.apache.org/confluence/display/FLINK/FLIP-158%3A+Generalized+incremental+checkpoints)

## 大规模批作业

Flink 社区也在致力于简化大规模批作业（并行度量级在10,000左右）的部署运行，所需的配置调整更少并使之有更好的性能。

- 为批处理引入更具扩展性的 batch shuffle。Batch shuffle 的第一部分已经合并入社区代码，
	剩下的部分可以使内存占用量（JVM直接内存）更可预测，请参阅
	[FLIP-148](https://cwiki.apache.org/confluence/display/FLINK/FLIP-148%3A+Introduce+Sort-Merge+Based+Blocking+Shuffle+to+Flink)
	
    - [FLINK-20740](https://issues.apache.org/jira/browse/FLINK-20740)
    - [FLINK-19938](https://issues.apache.org/jira/browse/FLINK-19938)

- 更快调度高并发作业：[FLINK-21110](https://issues.apache.org/jira/browse/FLINK-21110)

<hr />

# Python APIs

Python DataStream API 对状态访问的支持：
[FLIP-153](https://cwiki.apache.org/confluence/display/FLINK/FLIP-153%3A+Support+state+access+in+Python+DataStream+API)

<hr />

# 文档

我们也正在简化文档结构，以方便更直观的导航和阅读

- Flink 文档迁移（Jekyll to Hugo）:
	[FLIP-157](https://cwiki.apache.org/confluence/display/FLINK/FLIP-157+Migrate+Flink+Documentation+from+Jekyll+to+Hugo)
- 文档重构: [FLIP-42](https://cwiki.apache.org/confluence/display/FLINK/FLIP-42%3A+Rework+Flink+Documentation)
- SQL 文档: [FLIP-60](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=127405685)

<hr />

# 操作工具

- 允许使用 savepoint 来切换后端状态存储（state backends）: [FLINK-20976](https://issues.apache.org/jira/browse/FLINK-20976)
- 支持 savepoint 的其他的一些属性，例如增量 savepoint 等:
	[FLIP-47](https://cwiki.apache.org/confluence/display/FLINK/FLIP-47%3A+Checkpoints+vs.+Savepoints)

<hr />

# Stateful Functions

Stateful Functions 子项目有其单独的规划路线图，请参考 [statefun.io](https://statefun.io/) 。