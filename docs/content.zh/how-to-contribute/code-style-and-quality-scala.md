---
title: Code Style and Quality Guide — Scala
bookCollapseSection: false
bookHidden: true
---

# Code Style and Quality Guide — Scala

#### [序言]({{< ref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< ref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [常用编码指南]({{< ref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java 语言指南]({{< ref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala 语言指南]({{< ref "how-to-contribute/code-style-and-quality-scala" >}})
#### [组件指南]({{< ref "how-to-contribute/code-style-and-quality-components" >}})
#### [格式指南]({{< ref "how-to-contribute/code-style-and-quality-formatting" >}})

## Scala 语言特性

### 在哪儿使用（和不使用） Scala

**对于 Scala 的 API 或者纯 Scala libraries，我们会选择使用 Scala。**

**在 core API 和 运行时的组件中，我们不使用 Scala。我们的目标是从这些组件中删除现有的 Scala 使用(代码和依赖项)。**

⇒ 这并不是因为我们不喜欢 Scala，而是考虑到“用正确的工具做正确的事”的结果（见下文）。

对于 API，我们使用 Java 开发基础内容，并在上层使用 Scala。

* 这在传统上为 Java 和 Scala 提供了最佳的互通性
* 这意味着要致力于保持 Scala API 的更新

为什么我们不在 Core API 和 Runtime 中使用 Scala ？

* 过去的经验显示， Scala 在功能上的变化太快了。对于 Flink 社区来说，每次 Scala 版本升级都是一个比较棘手的处理过程。
* Scala 并不总能很好地与 Java 的类交互，例如 Scala 的可见性范围的工作方式不同，而且常常向 Java 消费者公开的内容比预期的要多。
* 由于使用 Scala ，所以 Flink 的 artifact/dependency 管理增加了一层额外的复杂性。
      * 我们希望通过接口抽象，同时也在运行时保留像 Akka 这样依赖 Scala 的库，然后将它们加载到单独的类加载器中，以保护它们并避免版本冲突。
* Scala 让懂 Scala 的程序员很容易编写代码，而对于不太懂 Scala 的程序员来说，这些代码很难理解。对于一个拥有不同经验水平的广大社区的开源项目来说，这尤其棘手。解决这个问题意味着大量限制 Scala 特性集，这首先就违背了使用 Scala 的很多目的。

### API 等价

保持 Java API 和 Scala API 在功能和代码质量方面的同步。

Scala API 也应该涵盖 Java API 的所有特性。

Scala API 应该有一个“完整性测试”，就如下面 DataStream API 的示例中的一样： [https://github.com/apache/flink/blob/master/flink-streaming-scala/src/test/scala/org/apache/flink/streaming/api/scala/StreamingScalaAPICompletenessTest.scala](https://github.com/apache/flink/blob/master/flink-streaming-scala/src/test/scala/org/apache/flink/streaming/api/scala/StreamingScalaAPICompletenessTest.scala)

### 语言特性

* **避免 Scala 隐式转换。**
    * Scala 的隐式转换应该只用于面向用户的 API 改进，例如 Table API 表达式或类型信息提取。
    * 不要把它们用于内部 “magic”。
* **为类成员添加显式类型。**
    * 对于类字段和方法返回类型，不要依赖隐式类型推断:

      **不要这样：**
        ```
        var expressions = new java.util.ArrayList[String]()
        ```

      **要这样：**
        ```
        var expressions: java.util.List[String] = new java.util.ArrayList[]()
        ```

    * 堆栈上局部变量的类型推断是可以的。
* **用严格的可见性。**
    * 避免使用 Scala 的包私有特性(如 private[flink])，而是使用常规 private/protected 替代。
    * 请注意：在 Java 中， `private[flink]` 和 `protected`  的成员是公开的。
    * 请注意：在 Flink 提供的示例中， `private[flink]` 仍然会暴露所有成员。


### 编码格式

**使用换行来构造你的代码。**

* Scala 的函数性质允许长的转换链 (`x.map().map().foreach()`).
* 为了强制让实现者构造其代码，因此将行长度限制为 100 个字符以内。
* 为了更好的可维护性，每次转换使用一行。

