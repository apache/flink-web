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


**前言：** 对于具体的严格计划而言，这不是一个权威的时间路线图。 相反，社区共享对我们未来的愿景，并讲述更大的未来
及正在进行并受到关注的举措。 该路线图应给予用户和贡献者了解项目的进展情况以及他们可以预期的结果。

# 分析，应用程序，DataStream，DataSet和Table API

Flink将流处理视为[统一数据处理范例]（{{site.baseurl}} / flink-architecture.html）（批量和实时）和Event Time的应用程序。 API正在不断发展以反映该观点：

  - **Table API / SQL** 正在以统一的方式成为分析用例的主要API跨批处理和流式传输。 以更简化的方式支持分析用例，
    API通过其他功能进行了扩展 ([FLIP-29](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=97552739)).

    与SQL一样，Table API是*声明*，在*逻辑模式*上运行，并应用*自动优化*。
    由于这些属性，该API不能直接访问时间和状态。

  - **DataStream API** 是数据驱动的应用程序和数据管道的主要API。使用*物理数据类型*（Java / Scala类），没有自动重写。
     应用程序可以明确控制* time *和* state *（state，triggers，proc.fun）。

    从长远来看，DataStream API应该通过*有界流*完全包含DataSet API。
    
# 批量和流式统一

Flink的方法是在流式运行时通过相同的API覆盖批处理和流式传输。[此博文]（{{site.baseurl}}/news/2019/02/13/ unified-batch-streaming-blink.html）介绍了这种统一。

目前正在进行的面向用户的最大部分是：

  - Table API重构[FLIP-32]（https://cwiki.apache.org/confluence/display/FLINK/FLIP-32%3A+Restructure+flink-table+for+future+contributions）将Table API与批处理/流特定环境和依赖关系分离。

  - 新的源接口[FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)可以跨批处理和流式传输，使每个连接器都可用作 批次和流数据源。

  - 引入* upsert- *或* changelog- *源[FLINK-8545]（https://issues.apache.org/jira/browse/FLINK-8545）将支持更强大的流输入到Table API。

在运行时级别，流操作符被扩展为也支持数据消耗某些批处理操作所需的模式（[讨论主题](https://lists.apache.org/thread.html/cb1633d10d17b0c639c3d59b2283e9e01ecda3e54ba860073c124878@%3Cdev.flink.apache.org%3E)).
这也是高效 [side inputs](https://cwiki.apache.org/confluence/display/FLINK/FLIP-17+Side+Inputs+for+DataStream+API)等功能的基础.

# 快速批处理（有界流）

社区的目标是使Flink在有界流（批量使用案例）上的表现与之竞争专用批处理器。 虽然Flink已被证明可以更快地处理一些批处理用例
广泛使用的批处理器，正在进行一些努力以确保更广泛的用例：

  - 更快更完整的SQL / Table API：社区正在合并Blink查询处理器，该处理器有所改进。当前的查询处理器通过添加更丰富的运行时运算符集，优化器规则和代码生成。
    新的查询处理器将具有完整的TPC-DS支持，并且与当前查询处理器相比，性能提升高达10倍 ([FLINK-11439](https://issues.apache.org/jira/browse/FLINK-11439)).

  - 利用有界流来减少容错范围：当输入数据有界时，它就是可以在随机播放（内存或磁盘）期间完全缓冲数据，并在播放后重播该数据
     失败。 这使得恢复更精细，因此更有效([FLINK-10288](https://issues.apache.org/jira/browse/FLINK-10288)).

  - 有界数据的应用程序可以根据运算符的方式调度操作消费数据（例如，第一个构建哈希表，然后是探测哈希表）。我们将调度策略与ExecutionGraph分离，以支持不同的策略有限数据([FLINK-10429](https://issues.apache.org/jira/browse/FLINK-10429)).

  - 在有界数据上缓存中间结果，以支持交互式数据探索等用例。缓存通常有助于客户端提交一系列构建的作业的应用程序相互重叠并重复使用彼此的结果。[FLINK-11199](https://issues.apache.org/jira/browse/FLINK-11199)

  - 外部Shuffle服务（主要是有界流）支持从计算和解耦中间结果可以提高Yarn等系统的资源效率。
    [FLIP-31](https://cwiki.apache.org/confluence/display/FLINK/FLIP-31%3A+Pluggable+Shuffle+Manager).

各种这些增强功能可以从提供的代码中获取[Blink fork](https://github.com/apache/flink/tree/blink).

要在DataStream API中利用上述有界流的优化，我们需要打破API的部分并明确地模拟有界流。

# 流处理用例

Flink将获得新模式以停止正在运行的应用程序，同时确保输出和在关闭之前，副作用是一致的并且已经提交。 * SUSPEND *output/side-effects，但保持状态，而* TERMINATE *排出状态并提交输出和副作用。在
[FLIP-34]（https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=103090212）有详细信息。
  


*新的源界面* ([FLIP-27] (https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface））)旨在为事件时间和源的水印生成提供更简单的开箱即用支持。来源可以选择在事件时间内调整他们的消费速度，以减少在流中重新处理大数据量时的飞行中状态的大小（[FLINK-10887]（https://issues.apache.org/jira/browse/FLINK-10886））。

为了简化流媒体状态的演变，我们计划为其添加一流的支持[Protocol Buffers](https://developers.google.com/protocol-buffers/)，类似的方式
Flink支持Avro状态演变（[FLINK-11333]（https://issues.apache.org/jira/browse/FLINK-11333））。

# 部署，扩展，安全

为Flink设计一种与动态资源交互的新方法资源池并自动调整资源可用性和负载。部分原因正在变成一种适应不断变化的资源的方式（如容器/吊舱正在启动或移除）[FLINK-10407]（https://issues.apache.org/jira/browse/FLINK-10407），而其他部分导致Flink决定添加的* active * scaling策略或根据内部指标删除TaskManagers。

为了支持Kubernetes中的活动资源管理，我们还添加了Kubernetes资源管理器[FLINK-9953](https://issues.apache.org/jira/browse/FLINK-9953).

Flink Web UI正在移植到更新的框架并获得其他功能更好地去跑Job[FLINK-10705](https://issues.apache.org/jira/browse/FLINK-10705).

社区正致力于扩展与身份验证和授权服务的互操作性。正在讨论的是[安全模块抽象]的一般扩展（http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-security-improvements-td21068.html）以及[Kerberos支持的增强功能]（http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-Kerberos-Improvement-td25983.html）。

# 生态系统

社区正在努力扩展对目录，模式注册表和元数据存储，包括API和SQL客户端的支持（[FLINK-11275]（https://issues.apache.org/jira/browse/FLINK-11275））。我们正在添加DDL（数据定义语言）支持，以便于添加表和流
目录（[FLINK-10232]（https://issues.apache.org/jira/browse/FLINK-10232））。

将Flink与Hive生态系统整合在一起做了大量工作，包括Metastore和Hive UDF支持 [FLINK-10556](https://issues.apache.org/jira/browse/FLINK-10556).

# 连接器和格式

支持额外的连接器和格式是一个持续的过程。

# 其他项

  - 我们正在将构建设置更改为默认情况下不捆绑Hadoop，而是提供预打包的Hadoop与Yarn，HDFS等一起使用的库作为便利下载
    [FLINK-11266](https://issues.apache.org/jira/browse/FLINK-11266).

  - Flink代码库正在进行更新以支持Java 9,10和11
    [FLINK-8033](https://issues.apache.org/jira/browse/FLINK-8033),
    [FLINK-10725](https://issues.apache.org/jira/browse/FLINK-10725).
    
  - 为了减少与不同Scala版本的兼容性问题，我们正在使用Scala但仅在Scala API中，不在运行时中。 这将删除所有Scala依赖项。仅限Java的用户，使Flink更容易支持不同的Scala版本
    [FLINK-11063](https://issues.apache.org/jira/browse/FLINK-11063).

