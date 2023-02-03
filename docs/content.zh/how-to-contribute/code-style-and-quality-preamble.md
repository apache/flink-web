---
title: 代码样式与质量指南
bookCollapseSection: false
weight: 19
---

# Apache Flink Code Style and Quality Guide

#### [序言]({{< ref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< ref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [常用编码指南]({{< ref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java 语言指南]({{< ref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala 语言指南]({{< ref "how-to-contribute/code-style-and-quality-scala" >}})
#### [组件指南]({{< ref "how-to-contribute/code-style-and-quality-components" >}})
#### [格式指南]({{< ref "how-to-contribute/code-style-and-quality-formatting" >}})

<hr>

这是对我们想要维护的代码和质量标准的一种尝试。

一次代码贡献(或者任何代码片段)可以从很多角度进行评价：一组评判标准是代码是否正确和高效。这需要正确且良好的解决逻辑或算法问题。

另一组评判标准是代码是否使用了简洁的设计和架构，是否通过概念分离实现了良好的架构，是否足够简单易懂并且明确假设。该评判标准需要良好的解决软件工程问题。一个好的解决方案需要代码是容易被测试的，可以被除了原作者之外的其他人维护的（因为打破之后再维护是非常困难的），同时还需要能够高效的迭代演进的。

不过第一组标准有相当客观的达成条件，相比之下要达到第二组评判标准更加困难，但是对于 Apache Flink 这样的开源项目来说却非常重要。为了能够吸引更多贡献者，为了的开源贡献能够更容易被开发者理解，同时也为了众多开发者同时开发时代码的健壮性，良好工程化的代码是至关重要的。[^1] 对于良好的工程代码来说，更加容易保证代码的正确性和高效不会随着时间的推移受到影响

当然，本指南并不是一份如何写出良好的工程代码的全方位指导。有相当多的书籍尝试说明如何实现良好的代码。本指南只是作为最佳实践的检查清单，包括我们在开发 Flink 过程中遇到的模式，反模式和常见错误。

高质量的开源代码很大一部分是关于帮助 reviewer 理解和双重检查执行结果。所以，本指南的一个重要目的是关于如何为为 review 构建一个良好的 pull request

[^1]: 在早期，我们（Flink 社区）并没有一直对此给予足够的重视，导致 Flink 的一些组件更难进化和贡献。
