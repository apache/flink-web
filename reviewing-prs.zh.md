---
title:  "如何审核一个 Pull Request"
---

<hr />

本指南适用于希望帮助审核代码的所有提交者和贡献者。感谢您的努力 - 良好的审核是开源项目中最重要也是最关键的部分。本指南应协助社区进行审核，包括以下几个方面:

* 贡献者有很好的贡献经验。
* 我们的审核是有条理的，并且检查贡献的所有重要方面。
* 我们确保在 Flink 中保持高质量的代码。
* 我们避免了贡献者和审核者花费大量时间来完善后来会被拒绝的贡献的情况。

----

{% toc %}

## 审核清单

每次审核都需要检查以下五个方面，我们鼓励按顺序检查这些方面，当是否应实际添加或更改功能尚未达成共识时，避免在代码质量的审核上花费时间。

### 1.贡献是否得到了很好的描述？

检查贡献是否得到充分的描述以支持良好的审核，不重要的更改和修复不需要很长的描述，任何改变功能或行为的 pull request 都需要描述这些改变的重点, 以便知道审核什么内容(并且不必钻研代码来了解更改的作用).

需要更长描述的更改，理想情况下基于邮件列表或 JIRA 中的事先设计讨论，可以简单地链接到那里或从那里复制描述。

**如果在不查看代码的情况下回答以下问题2、3、4，则该贡献得到了很好的描述。**

-----

### 2.是否一致认为这一变更或者功能应该加入到 Flink？

对于错误修复，只有在需要更大的更改或可能破坏现有程序和设置时才需要检查。

理想情况下, 除了错误修复和少量的添加或扩展的情况外，可以直接回答 Jira issue 或在开发人员列表讨论这个问题。在这种情况下,此问题可以立即标记为已解决。对于未事先达成共识而创建的 pull requests，此问题需要作为审核的一部分予以回答。

是否应将变更加入到 Flink 的决定需要考虑以下几个方面：

* 该贡献是否会以某种方式改变功能或组件的行为，从而破坏以前用户的程序和设置？如果是，则需要进行讨论并同意这种变更是可取的。
* 这个贡献在概念上是否适合 Flink ？这是一个特殊情况，它使常见的情况更加复杂或者让抽象概念或 API 更加臃肿？
* 该功能是否适合 Flink 的架构？未来它是否会扩展并保持 Flink 灵活性，或者该功能将来会限制 Flink 的发展吗？
* 该功能是一项重要的新增功能（而不是对现有部件的改进）吗？如果是，Flink 社区是否会承诺维护此功能？
* 该功能是否为 Flink 用户或开发人员带来了额外的价值？或者它是否会在不增加相关用户或开发人员权益的情况下引入回归风险？
* 该贡献可以存在于另一个存储库中，例如 [Apache Bahir](https://bahir.apache.org) 或其他外部存储库吗？

所有这些问题都应该从 Jira 和 pull request 中的描述或讨论中得到回答，而不需要查看代码。

**一旦有一个 committer 接受了某个功能、改进或者错误修复，并且没有其他 committer 不同意（懒惰的共识），那么它就会得到批准。** 

如果意见出现分歧，应将讨论转移到各自的 Jira issue 或开发邮件列表中继续进行，直到达成共识。如果变更是由一位 committer 提出的，那么寻求另一位 committer 的批准是最佳做法。

-----

### 3. 贡献是否需要一些特定的committer的关注，这些 committer 有时间投入吗？

一些更改需要特定的 committer 的注意和批准。例如，对性能非常敏感或对分布式协调和容错有关键影响的部件中的更改，这需要一个对相应组件非常熟悉的 committer 的审核。

根据经验，当 pull request 描述回答模板部分 “Does this pull request potentially affect one of the following parts” 和 “yes” 时，需要特别注意。

这个问题可以参考如下回答

* *Does not need specific attention*
* *Needs specific attention for X (X可以是例如 checkpointing、jobmanager 等)*
* *Has specific attention for X by @commiterA, @contributorB*

**如果 pull request 需要特别注意，则其中一个标记的 committers 或 contributors 应该给出最终批准。**

----

### 4. 实施是否遵循正确的整体方法/架构？

这是实施修复程序或功能的最佳方法，还是其他方法更容易，更强大或更易于维护？
这个问题应该尽可能地从 pull request 描述（或链接的 Jira ）中得到回答。

我们建议您在深入了解更改的各个部分进行评论之前先检查这一点。

----

### 5.整体代码质量是否良好，是否符合我们希望在Flink中维护的标准？

这是对实际变更的详细代码审核，包括：

* 变更是否按照设计文档或 pull request 说明中的描述进行？
* 代码是否遵循正确的软件工程实践？代码是否正确、健壮、可维护、可测试？
* 在更改性能敏感部分时，是否了解性能的变化？
* 测试是否充分涵盖了这些变化？
* 测试是否快速执行，即仅在必要时才使用重量级集成测试？
* 代码格式是否遵循 Flink 的 checkstyle 模式？
* 代码是否避免引入额外的编译器警告？

可以在 [Flink代码样式页面]({{ site.baseurl }}/contribute-code.html#code-style) 中找到一些代码样式指南。

## 使用@flinkbot进行审核

Flink 社区正在使用名为 [@flinkbot]https://github.com/flinkbot) 的服务来帮助审核 pull request。

机器人会自动发布评论，跟踪每个新 pull request 的审核进度：

```
### Review Progress

* [ ] 1. The description looks good.
* [ ] 2. There is consensus that the contribution should go into to Flink.
* [ ] 3. [Does not need specific attention | Needs specific attention for X | Has attention for X by Y]
* [ ] 4. The architectural approach is sound.
* [ ] 5. Overall code quality is good.

Please see the [Pull Request Review Guide](https://flink.apache.org/reviewing-prs.html) if you have questions about the review process.
```

审核人可以指示机器人勾选方框（按顺序）以指示审核的进度。

用于批准贡献的描述，请使用`@flinkbot approve description`提及机器人。这与`consensus`、`architecture`和`quality`类似。

要批准所有方面，请在 pull request 中添加一条带有`@flinkbot approve all`的新评论。

需要注意的语法是`@flinkbot attention @username1 [@username2 ..]`。


