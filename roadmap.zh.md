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

**前言：** 这并不是一个权威的路线图，在某种意义上说，这是一个带有特定内容的严格计划时间表。相反，我们，社区，会分享我们对未来的愿景，并提供正在进行和正在受到注意的倡议。此路线图将为用户和贡献者提供并了解项目的发展方向和他们所期望的。

路线图会不断更新。一旦达成共识，新的特性和工作都会添加到路线图中，并且这些特性和工作将对于用户来说大致会知道是什么样子。

# 分析，应用程序，DataStream，DataSet和Table API的角色

Flink将流处理视为[数据处理的统一范例]({{site。baseurl}} / flink-architecture.html)(批处理和实时)和事件驱动的应用程序。API正在演变以此反映这一观点:

  -  **Table API / SQL** 正在以流批统一的方式成为分析用例的主要API。为了以更精简的方式支持分析用例，API通过添加函数([FLIP-29](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=97552739)进行了扩展。

  与SQL一样，Table API是*声明的*，在*逻辑模式*上运行，并且*自动优化* 应用。由于这些属性，该API不能直接访问时间和状态。

  - **DataStream API** 是数据驱动的应用程序和数据管道的主要API。使用*物理数据类型*（Java/Scala类），没有自动重写。
    应用程序可以明确控制* time *和* state *（state，triggers，proc.fun）。  

    从长远来看，DataStream API应该通过*有界数据流*完全包含DataSet API。
    
# 批流统一

Flink在流运行时通过相同的API覆盖批处理和流处理传输。[此博文]（{{site.baseurl}}/news/2019/02/13/ unified-batch-streaming-blink.html）介绍了这种批流统一的方式。

目前的面向用户的最大部分是:

  - Table API重构[FLIP-32]（https://cwiki.apache.org/confluence/display/FLINK/FLIP-32%3A+Restructure+flink-table+for+future+contributions）将Table API与批处理/流处理的特定环境和依赖关系分离。

  - 新的数据源接口[FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)可以跨批处理和流处理传输，使每个连接器都可以看作批处理和流处理数据源。

   - 引入* upsert- *或* changelog- *源[FLINK-8545]（https://issues.apache.org/jira/browse/FLINK-8545）将支持更强大的流输入到Table API。

在运行时级别，流操作符扩展并支持某些批处理操作数据消耗所需的模式（[讨论主题](https://lists.apache.org/thread.html/cb1633d10d17b0c639c3d59b2283e9e01ecda3e54ba860073c124878@%3Cdev.flink.apache.org%3E)).
这也是高效 [旁路输出](https://cwiki.apache.org/confluence/display/FLINK/FLIP-17+Side+Inputs+for+DataStream+API)等功能的基础.

#快速批处理（有界流）

社区的目标是使Flink在有界流（批量使用案例）上的表现与其他批处理引擎竞争。 虽然Flink已被证明是广泛使用的批处理引擎可以更快地处理一些批处理用例，但Flink也正在努力以确保更广泛的被应用：

   - 更快更完整的SQL / Table API：社区正在合并对处理器有所改进的Blin。当前的查询处理器通过添加更丰富的运行时运算符集，优化器规则和代码生成。新的查询处理器将具有完整的TPC-DS支持，并且与当前查询处理器相比，性能提升高达10倍 ([FLINK-11439](https://issues.apache.org/jira/browse/FLINK-11439)).

  - 利用有界流来减少容错范围：当输入有界数据时，它完全可以缓冲在随机播放（内存或磁盘）期间的数据和重播后数据的
     失败。 这使得恢复更精细，因此也更有效([FLINK-10288](https://issues.apache.org/jira/browse/FLINK-10288)).

  - 基于有界数据的应用程序可以调度一个接一个的操作，这取决于操作符使用数据的方式(例如，首先构建哈希表，然后探测哈希表)。关于有界数据，我们将调度策略从执行图中分离出来，以支持不同的策略([FLINK-10429](https://issues.apache.org/jira/browse/FLINK-10429))。

  - 在有界数据集上缓存中间结果，以支持交互式数据探索等用例。缓存通常有助于客户端提交一系列构建的作业的应用程序相互重叠并重复使用彼此的结果。[FLINK-11199](https://issues.apache.org/jira/browse/FLINK-11199)

  - 外部Shuffle服务（主要是有界流）支持从计算并解耦中间结果可以提高Yarn等系统的资源效率。
    [FLIP-31](https://cwiki.apache.org/confluence/display/FLINK/FLIP-31%3A+Pluggable+Shuffle+Manager).

这些增强功能可以从[Blink fork](https://github.com/apache/flink/tree/blink)分支中提供的代码中获取.

要利用上述针对DataStream API中有界流的优化，我们需要断开API的一部分并显式地对有界流建模。

# 流处理案例
  
Flink将获得新的模式来停止正在运行的应用程序，同时确保输出和副作用是一致的，并在关闭前提交。*暂停*提交输出/副作用,但是保持状态，而“终止”则耗尽状态并提交输出和副作用。[FLIP-34](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=103090212)有详细信息。

*新的源接口* ([FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface))旨在为事件时间和源的水印生成提供更简单的开箱即用支持。源可以选择在事件时间内调整他们的消费速度，以减少在流中重新处理大数据量时状态的大小（[FLINK-10887]（https://issues.apache.org/jira/browse/FLINK-10886））。

为了简化流状态的演化，我们计划添加支持Flink应用的Avro state[Protocol Buffers](https://developers.google.com/protocol-buffers/),

# 部署，扩展，安全

为Flink设计一种与动态资源池交互的新方法是一项巨大的工作，并实现自动调整资源的可用性和负载。这在一定程度上变成了一种“反应性”的方式来适应不断变化的资源(比如正在启动或删除的容器/pod) [FLINK-10407](https://issues.apache.org/jira/browse/FLINK-10407)，而其他部分则会导致Flink决定添加“活动”缩放策略或者根据内部指标删除任务管理器。

为了支持Kubernetes中的动态资源管理，我们还添加了Kubernetes资源管理器[FLINK-9953](https://issues.apache.org/jira/browse/FLINK-9953).

Flink Web UI正在移植到更新的框架中并获得其他功能并更好地去跑Job[FLINK-10705](https://issues.apache.org/jira/browse/FLINK-10705).

社区正致力于扩展与身份验证和授权服务的互操作性。而正在讨论并扩展的是[security module abstraction]（http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-security-improvements-td21068.html）以及[Kerberos支持的增强功能]（http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Flink-Kerberos-Improvement-td25983.html）。

# 生态系统

社区正在努力扩展目录，模式注册表和元数据存储，包括API和SQL客户端的支持（[FLINK-11275]（https://issues.apache.org/jira/browse/FLINK-11275））。并且我们正在添加DDL（数据定义语言）支持，以便于添加表和流
catalogs（[FLINK-10232]（https://issues.apache.org/jira/browse/FLINK-10232））。

将Flink与Hive生态系统整合在一起做了大量工作，包括Metastore和Hive UDF支持 [FLINK-10556](https://issues.apache.org/jira/browse/FLINK-10556).

# Connectors & Formats

支持额外的连接器和格式是一个持续的过程。

# 其他项

  - 我们正在在构建并更改默认情况下不捆绑Hadoop，而是将提供预打包的Hadoop与Yarn，HDFS等一起使用的库下载
    [FLINK-11266](https://issues.apache.org/jira/browse/FLINK-11266).

  - Flink代码库正在进行更新以支持Java 9,10和11
    [FLINK-8033](https://issues.apache.org/jira/browse/FLINK-8033),
    [FLINK-10725](https://issues.apache.org/jira/browse/FLINK-10725).

  - 为了减少与不同Scala版本的兼容性问题，我们正在使用Scala，但仅在Scala API中并不在运行时中。 对于所有的Java用户可以删除所有Scala依赖项，使Flink更容易支持不同的Scala版本
    [FLINK-11063](https://issues.apache.org/jira/browse/FLINK-11063).

