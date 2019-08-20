---
title:  "Apache Flink Code Style and Quality Guide  — Components"
---

{% include code-style-navbar.zh.md %}

{% toc %}




## 组件特定指南

_关于特定组件更改的附加指南。_


### 配置更改

配置选项应该放在哪里？

* <span style="text-decoration:underline;">‘flink-conf.yaml’:</span> 所有与可能希望标准化跨作业行为执行相关的配置。把它看作是戴着“ops”帽子，或者为其他团队提供流处理平台的参数。

* <span style="text-decoration:underline;">‘ExecutionConfig’</span>: 执行期间算子需要特定于单个Flink应用程序的参数，典型的例子是水印间隔，序列化参数，对象重用。
* <span style="text-decoration:underline;">ExecutionEnvironment (代码形式)</span>: 所有特定于单个Flink应用程序的东西，只需要构建程序/数据流，在执行期间算子内部不需要。

如何命名配置键：

* 配置键名应该分层级。
  将配置视为嵌套对象（JSON样式）

  ```
  taskmanager: {
    jvm-exit-on-oom: true,
    network: {
      detailed-metrics: false,
      request-backoff: {
        initial: 100,
        max: 10000
      },
      memory: {
        fraction: 0.1,
        min: 64MB,
        max: 1GB,
        buffers-per-channel: 2,
        floating-buffers-per-gate: 16
      }
    }
  }
  ```

* 因此生成的配置键应该是：

  **不是** `"taskmanager.detailed.network.metrics"`

  **而是** `"taskmanager.network.detailed-metrics"`


### 连接器

连接器历来难以实现，需要处理线程、并发和检查点的许多方面。

作为[FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)的一部分，我们正在努力让这些源更加简单。新的源应该不再处理并发/线程和检查点的任何方面。

预计在不久的将来，类似的FLIP可以用于接收器。


### 示例

示例应该是自包含的，不需要运行Flink以外的系统。除了显示如何使用具体的连接器的示例，比如Kafka连接器。可以使用的`StreamExecutionEnvironment.socketTextStream`源/接收器不应该被用于生产，但是非常便于探索事物如何运作，以及基于文件的源/接收器。（对于流，有连续的文件源）

示例也不应该是纯粹的玩具示例，而是在现实世界的代码和纯粹的抽象示例之间取得平衡。WordCount示例到现在已经很久了，但它是一个很好的突出功能并可以做有用的事情的简单代码的展示。

评论中的例子也应该很多。他们应该在类级Javadoc中描述示例的一般概念，并且描述正在发生什么和整个代码使用了什么功能。还应描述预期的输入数据和输出数据。

示例应该包括参数解析，以便你可以运行一个示例（从为每个示例所创建的Jar使用`bin/flink run path/to/myExample.jar --param1 … --param2`。


### 表和SQL API


#### 语义

**SQL标准应该是事实的主要来源。**

* 语法，语义和功能应该和SQL保持一致！
* 我们不需要重造轮子。大部分问题都已经在业界广泛讨论过并写在SQL标准中了。
* 我们依靠最新的标准（SQL:2016 or ISO/IEC 9075:2016 在写这篇文章时[[download]](https://standards.iso.org/ittf/PubliclyAvailableStandards/c065143_ISO_IEC_TR_19075-5_2016.zip)）。并非每个部分都可在线获取，但快速网络搜索可能对此有所帮助。

讨论与标准或厂商特定解释的差异。

* 一旦定义了语法或行为就不能轻易撤销。
* 需要扩展或解释标准的贡献需要与社区进行彻底的讨论。
* 请通过一些对Postgres, Microsoft SQL Server, Oracle, Hive, Calcite, Beam等其他厂商如何处理此类案例进行初步的探讨来帮助提交者。


将Table API视为SQL和Java/Scala编程世界之间的桥梁。

* Table API是一种嵌入式域特定语言，用于遵循关系模型的分析程序。
在语法和名称方面不需要严格遵循SQL标准，但，如果这有助于使其感觉更直观，那么可以更接近编程语言的方式/命名函数和功能。
* Table API可能有一些非SQL功能（例如map()，flatMap()等），但应该还是“感觉像SQL”。如果可能，函数和操作应该有相等的语义和命名。


#### 常见错误

* 添加功能时支持SQL的类型系统。
    * SQL函数，连接器或格式从一开始就应该原生的支持大多数SQL类型。
    * 不支持的类型会导致混淆，限制可用性，并通过多次接触相同代码路径来创建开销。
    * 例如，当添加`SHIFT_LEFT`函数时，确保贡献足够通用，不仅适用于`INT`也适用于`BIGINT`或`TINYINT`。


#### 测试

测试可空性

* 几乎每个操作，SQL都原生支持`NULL`，并具有3值布尔逻辑。
* 也确保测试每个功能的可空性.


避免完全集成测试

* 生成Flink迷你集群并为SQL查询执行生成代码的编译是昂贵的。
* 避免对计划测试或API调用的变更进行集成测试。
* 相反，使用单元测试来验证来自计划器的优化计划。或者直接测试运行时的操作行为。


#### 兼容性

不要在次要版本中引入物理计划更改！

* 流式SQL中状态的向后兼容性依赖于物理执行计划保持稳定的事实。否则，生成的操作名称/IDs将发生变化，并且无法匹配和恢复状态。
* 每个问题修复都会导致流式传输管道的优化物理规划发生变化，从而破坏兼容性。
* 因此，导致不同优化器计划的类型的更改现在只能在主要版本中合并。


#### Scala / Java互操作性（遗留代码部分）

在设计接口时要牢记Java。

* 考虑一个类将来是否需要与Java类交互。
* 在接口中使用Java集合和Java Optional，以便与Java代码平滑集成。
* 如果一个类要被转换为Java，请不要使用.copy()或apply()等案例类的功能。
* 纯Scala面向用户的API应该使用纯Scala集合/迭代/等与scala自然和惯用的（“scalaesk”）集成。

