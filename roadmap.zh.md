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

**前言：** 从具有时间表的严格计划来说，这并不是一个权威的路线图。相反，我们，社区，会分享我们对未来的愿景，并总结了正在进行和正在受到关注的提议。此路线图将为用户和贡献者更好地了解项目的发展方向以及他们可以期待的内容。

路线图会不断更新。一旦达成共识，新的特性和工作都会添加到路线图中。共识是指这些特性和工作将来确定会发生，以及对于用户来说大致是什么样的。

# 分析与应用程序，DataStream、DataSet 和 Table API 的角色

Flink将流处理视为[统一数据处理范式]({{site.baseurl}}/zh/flink-architecture.html)（批与实时）和事件驱动的应用程序。而 API 的不断演进正反映了这一点：

-  **Table API / SQL** 正在以流批统一的方式成为分析型用例的主要 API。为了以更精简的方式支持分析型用例，API 将会扩展很多新的功能（[FLIP-29](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=97552739)）。

与 SQL 一样，Table API 是*声明式的*，在*逻辑 schema*上操作，并且应用了许多*自动优化*。由于这些特性，该 API 不提供直接访问时间和状态的接口。

 - **DataStream API** 是数据驱动应用程序和数据管道的主要API。使用*物理数据类型*（Java/Scala类），没有自动改写和优化。
  应用程序可以显式控制 *时间* 和 *状态*（state，triggers，proc. fun.）。  

从长远来看，DataStream API应该通过*有界数据流*完全包含DataSet API。
    
# 批流统一

Flink 在一个流式运行时之上，通过同样的 API 同时支持了批处理和流处理。[此博文]({{ site.baseurl }}/news/2019/02/13/unified-batch-streaming-blink.html) 介绍了这种批流统一的方式。


目前正在进行的面向用户的最大改动是:

- Table API 重构 [FLIP-32](https://cwiki.apache.org/confluence/display/FLINK/FLIP-32%3A+Restructure+flink-table+for+future+contributions) 将 Table API 从特定的流/批环境和依赖中解耦出来。

- 新的数据源接口 [FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface) 进一步推广了跨批处理和流处理传输，使每个连接器都可以作为批处理和流处理的数据源。

- 引入 *upsert-* 或者说 *changelog-* 源 [FLINK-8545](https://issues.apache.org/jira/browse/FLINK-8545) 将支持更强大的流输入到 Table API 中。


在运行时级别，扩展了 streaming operator 以支持某些批处理操作所需的数据消费模式（[讨论主题](https://lists.apache.org/thread.html/cb1633d10d17b0c639c3d59b2283e9e01ecda3e54ba860073c124878@%3Cdev.flink.apache.org%3E)）。

# 快速批处理（有界流）

社区的目标是使 Flink 在有界流（批处理用例）上的性能表现与其他批处理引擎相比具有竞争力。 虽然 Flink 已被证明是在某些批处理应用场景要比广泛使用的批处理引擎更快，不过仍然有许多正在进行的工作使得这些场景能更广泛：

- 更快更完整的 SQL 和 Table API：社区正在合并 Blink 的查询处理器，对当前的查询处理器加了许多的改进，比如提供更丰富的运行时算子、优化规则、代码生成等。新的查询处理器将具有完整的 TPC-DS 支持，并且比当前查询处理器相比具有 10 倍性能提升 ([FLINK-11439](https://issues.apache.org/jira/browse/FLINK-11439)).

- 利用有界流来减少容错范围：当输入数据有界时，它完全可以在 shuffle 期间将数据完整地缓存下来（内存或磁盘），以便在失败后重放这些数据。这也使得作业恢复更加细粒度，也因此更加高效 ([FLINK-10288](https://issues.apache.org/jira/browse/FLINK-10288))。

- 基于有界数据的应用程序可以调度一个接一个的操作，这取决于算子如何消费数据（例如，首先构建哈希表，然后探测哈希表）。关于有界数据，我们将调度策略从执行图中分离出来，以支持不同的策略([FLINK-10429](https://issues.apache.org/jira/browse/FLINK-10429))。

- 在有界数据集上缓存中间结果，以支持交互式数据探索等用例。缓存通常有助于客户端提交一系列构建的作业的应用程序相互重叠并重复使用彼此的结果。[FLINK-11199](https://issues.apache.org/jira/browse/FLINK-11199)

- 外部 Shuffle 服务（主要是有界流）以支持从计算和中间结果中解耦出来，从而获得在 Yarn 等系统上更高的资源利用率。

上文的许多增强和改进都可以从 [Blink fork](https://github.com/apache/flink/tree/blink) 贡献的源码中获得。

要利用上述针对DataStream API中有界流的优化，我们需要断开API的一部分并显式地对有界流建模。

# 流处理案例
  
Flink将获得新的模式来停止正在运行的应用程序，同时确保输出和副作用是一致的，并在关闭前提交。*SUSPEND* 会提交输出和副作用，但是保留状态。而 *TERMINATE* 则清除完状态并提交输出和副作用。[FLIP-34](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=103090212)有详细信息。

*新的源接口* ([FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface))旨在为事件时间和源的水印生成提供更简单的开箱即用支持。源可以选择以事件时间对齐消费速度，以减少在重新处理大数据量时空中（in-flight）状态的大小。（[FLINK-10887](https://issues.apache.org/jira/browse/FLINK-10886)）。

为了简化流状态的升级， 我们计划高优支持 [Protocol Buffers](https://developers.google.com/protocol-buffers/)，支持方式类似于 Flink 深度支持 Avro 状态升级 ([FLINK-11333](https://issues.apache.org/jira/browse/FLINK-11333))。

# 部署，扩展，安全

有一个巨大的工作是设计了一种新的方式使 Flink 与动态资源池交互并能自动调整资源的可用性和负载。其中一部分会变成*响应式（reactive）*方式来适应不断变化的资源（像容器或 pods 被启动和删除）[FLINK-10407](https://issues.apache.org/jira/browse/FLINK-10407)。另一部分会变成*活跃式（active）*扩缩容策略，Flink 会基于内部指标来决定是否添加或删除 TaskManagers。

为了支持Kubernetes中的动态资源管理，我们还添加了Kubernetes资源管理器[FLINK-9953](https://issues.apache.org/jira/browse/FLINK-9953)。

Flink Web UI 正在移植到更新的框架中并获得其他功能并更好地去跑作业 [FLINK-10705](https://issues.apache.org/jira/browse/FLINK-10705).

社区正致力于扩展与身份验证和授权服务的互操作性。正在讨论的是对[安全模块抽象](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-security-improvements-td21068.html)的扩展以及[增强对 Kerberos 的支持](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-Kerberos-Improvement-td25983.html)。


# 生态系统

社区正在努力支持 catalog、schema registries、以及 metadata stores，包括 API 和 SQL 客户端的支持（[FLINK-11275](https://issues.apache.org/jira/browse/FLINK-11275)）。并且我们正在添加 DDL（数据定义语言，Data Definition Language）支持，以便能方便的添加表和流到 catalog 中（[FLINK-10232](https://issues.apache.org/jira/browse/FLINK-10232)）。

还有一个巨大的工作是将 Flink 与 Hive 生态系统集成。包括 Metastore 和 Hive UDF 支持 [FLINK-10556](https://issues.apache.org/jira/browse/FLINK-10556)。

# Connectors & Formats

支持额外的 connectors 和 formats 是一个持续的过程。

# 其他

  - Flink代码库正在进行更新以支持Java 9、10 和 11
    [FLINK-8033](https://issues.apache.org/jira/browse/FLINK-8033),
    [FLINK-10725](https://issues.apache.org/jira/browse/FLINK-10725).

  - 为了减少与不同 Scala 版本的兼容性问题，我们努力只在 Scala API 中使用 Scala，而不是运行时。对于所有的 Java 用户可以删除所有 Scala 依赖项，使 Flink 可以更容易支持不同的 Scala 版本
    [FLINK-11063](https://issues.apache.org/jira/browse/FLINK-11063).

