---
title: Apache Flink 代码样式和质量指南 — 组件
bookCollapseSection: false
bookHidden: true
---

# Apache Flink 代码样式和质量指南 — 组件

#### [序言]({{< ref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< ref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [常用编码指南]({{< ref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java 语言指南]({{< ref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala 语言指南]({{< ref "how-to-contribute/code-style-and-quality-scala" >}})
#### [组件指南]({{< ref "how-to-contribute/code-style-and-quality-components" >}})
#### [格式指南]({{< ref "how-to-contribute/code-style-and-quality-formatting" >}})

## 组件特定指南

_关于特定组件更改的附加指南。_

### 配置更改

配置选项应该放在哪里？

* <span style="text-decoration:underline;">‘flink-conf.yaml’:</span> 所有属于可能要跨作业标准的执行行为的配置。可以将其想像成 Ops 的工作人员或为其他团队提供流处理平台的工作人员设置的参数。
* <span style="text-decoration:underline;">‘ExecutionConfig’</span>: 执行期间算子需要特定于单个 Flink 应用程序的参数，典型的例子是水印间隔，序列化参数，对象重用。
* <span style="text-decoration:underline;">ExecutionEnvironment (in code)</span>: 所有特定于单个 Flink 应用程序的东西，仅在构建程序/数据流时需要，在算子执行期间不需要。

如何命名配置键：

* 配置键名应该分层级。将配置视为嵌套对象（JSON 样式）

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

* 因此生成的配置键应该：

  **不是** `"taskmanager.detailed.network.metrics"`

  **而是** `"taskmanager.network.detailed-metrics"`


### 连接器

连接器历来很难实现，需要处理多线程、并发和检查点等许多方面。

作为 [FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface) 的一部分，我们正在努力使数据源（source）的实现更简单。新的数据源应该不必处理并发/线程和检查点的任何方面。

预计在不久的将来，会有类似针对数据汇（sink）的 FLIP。

### 示例

示例应该是自包含的，不需要运行 Flink 以外的系统。除了显示如何使用具体的连接器的示例，比如 Kafka 连接器。数据源/数据汇可以使用 `StreamExecutionEnvironment.socketTextStream`，这个不应该在生产中使用，但对于研究示例如何运行是相当方便的，以及基于文件的数据源/数据源。（对于流，Flink 提供了连续的文件数据源读取数据） 示例也不应该是纯粹的玩具示例，而是在现实世界的代码和纯粹的抽象示例之间取得平衡。WordCount 示例到现在已经很久了，但它是一个很好的功能突出并可以做有用事情的简单代码示例。

示例中应该有不少的注释。他们可以在类级 Javadoc 中描述示例的总体思路，并且描述正在发生什么和整个代码里使用了什么功能。还应描述预期的输入数据和输出数据。

示例应该包括参数解析，以便你可以运行一个示例（使用 `bin/flink run path/to/myExample.jar --param1 … --param2` 运行程序）。


### 表和 SQL API

#### 语义

**SQL 标准应该是事实的主要来源。**

* 语法、语义和功能应该和 SQL 保持一致！
* 我们不需要重造轮子。大部分问题都已经在业界广泛讨论过并写在 SQL 标准中了。
* 我们依靠最新的标准（在写这篇文档时使用 SQL:2016 or ISO/IEC 9075:2016 ([[下载]](https://standards.iso.org/ittf/PubliclyAvailableStandards/c065143_ISO_IEC_TR_19075-5_2016.zip))。并不是所有的部分都能在网上找到，但可以通过网络查找确认。

讨论与标准或厂商特定解释的差异。

* 一旦定义了语法或行为就不能轻易撤销。
* 需要扩展或解释标准的贡献需要与社区进行深入的讨论。
* 请通过一些对 Postgres、Microsoft SQL Server、Oracle、Hive、Calcite、Beam 等其他厂商如何处理此类案例进行初步的探讨来帮助提交者。

将 Table API 视为 SQL 和 Java/Scala 编程世界之间的桥梁。

* Table API 是一种嵌入式域特定语言，用于遵循关系模型的分析程序。 在语法和名称方面不需要严格遵循 SQL 标准，但如果这有助于使其感觉更直观，那么可以更接近编程语言的方式/命名函数和功能。
* Table API 可能有一些非 SQL 功能（例如 map()、flatMap() 等），但还是应该“感觉像 SQL”。如果可能，函数和算子应该有相等的语义和命名。

#### 常见错误

* 添加功能时支持 SQL 的类型系统。
    * SQL 函数、连接器或格式化从一开始就应该原生的支持大多数 SQL 类型。
    * 不支持的类型会导致混淆，限制可用性，多次修改相同代码会增加负担。
    * 例如，当添加 `SHIFT_LEFT` 函数时，确保贡献足够通用，不仅适用于 `INT` 也适用于 `BIGINT` 或 `TINYINT`.

#### 测试

测试为空性

* 几乎每个操作，SQL 都原生支持 `NULL`，并具有 3 值布尔逻辑。
* 确保测试每个功能的可空性。

尽量避免集成测试

* 启动一个 Flink 集群并且对 SQL 查询生成的代码进行编译会很耗时。
* 避免对 planner 测试或 API 调用的变更进行集成测试。
* 相反，使用单元测试来验证 planner 产生的优化计划。或者直接测试算子的运行时行为。

#### 兼容性

不要在次要版本中引入物理计划更改！

* 流式 SQL 中状态的向后兼容性依赖于物理执行计划保持稳定的事实。否则，生成的 Operator Names/IDs 将发生变化，并且无法匹配和恢复状态。
* 导致流传输管道的优化物理计划改变的每个 bug 修复均会破坏兼容性。
* 因此，导致不同优化计划的此类更改目前仅可以合并到大版本中。

#### Scala / Java 互操作性（遗留代码部分）

在设计接口时要牢记 Java。

* 考虑一个类将来是否需要与 Java 类交互。
* 在接口中使用 Java 集合和 Java Optional，以便与 Java 代码平滑集成。
* 如果要将类转换为 Java，不要使用 .copy() 或 apply() 等 case class 的功能进行构造。
* 纯 Scala 面向用户的 API 应该使用纯 Scala 集合/迭代/等与 Scala 自然和惯用的（“scalaesk”）集成。


