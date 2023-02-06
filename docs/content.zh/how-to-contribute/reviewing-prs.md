---
title: 审核 Pull Request
bookCollapseSection: false
weight: 18
---

# 如何审核 Pull Request

本指南适用于希望帮助审核代码的所有提交者和贡献者。感谢你的努力 - 良好的审核是开源项目中最重要也是最关键的部分之一。本文旨在协助社区开展代码审核工作，以达到下列目的：

* 让贡献者拥有良好的贡献体验。
* 将审核过程结构化，以涵盖所有需要检查的重要方面。
* 保持 Flink 代码的高质量。
* 避免贡献者和审核者花费大量时间完善代码却最终被拒绝提交的情况。

## 审核清单

每次审核都需要检查以下六个方面。 **我们建议按照以下顺序进行检查，以避免在还没有就是否添加某项功能或需要改动达成共识之前或没有满足一些正式条件前，就花费时间进行详细的代码质量审核。**

### 1. 贡献的描述是否清晰？

检查贡献是否有充分的描述以方便审核，不重要的更改和修复不需要很长的描述。如果实现方案完全是[按照之前在 Jira 或 dev 邮件列表上讨论结论]({{< relref "how-to-contribute/contribute-code" >}}#consensus)进行的话，只需要一个对讨论的简短的引用即可。 如果实现方案与之前达成一致的方案不同的话，关于实现的详细描述是需要的，以便 review 贡献时更深入地讨论。

任何改变功能或行为的 pull request 都需要描述这些改变的重点, 以便知道审核什么内容(并且不必钻研代码来了解更改的作用)。

**如果在不查看代码的情况下能回答以下问题2、3、4，则该贡献得到了很好的描述。**

-----

### 2. 是否一致认为这一变更或者功能应该进入 Flink？

这个问题要直接在关联的 Jira issue 中回答。对于在达成一致前创建的 pull request 来说，需要[先在 Jira 中寻求一致的意见]({{< relref "how-to-contribute/contribute-code" >}})。

对于 `[hotfix]` 类型的的 pull request，可以在 pull request 中寻求意见一致。

-----

### 3. 贡献是否需要一些特定的 committer 的关注，这些 committer 有时间投入吗？

一些更改需要特定的 committer 的注意和批准。例如，对性能非常敏感或对分布式协调和容错有关键影响的部件中的更改，这需要一个对相应组件非常熟悉的 committer 的审核。

根据经验，当 pull request 描述中对模板里问题 “Does this pull request potentially affect one of the following parts” 的回答为 “yes” 时，需要特别注意。

这个问题可以参考如下回答

* *Does not need specific attention*
* *Needs specific attention for X (X 可以是例如 checkpointing、jobmanager 等)*
* *Has specific attention for X by @committerA, @contributorB*

**如果 pull request 需要特别关注，则其中一个标记的 committers 或 contributors 应该给出最终批准。**

----

### 4. 实现方案是否遵循了商定的整体方案/架构？

在这一步中，我们会检查一个贡献的实现是否遵循了在 Jira 或邮件列表中商定的方案。 这个问题应该尽可能地从 pull request 描述（或链接的 Jira ）中得到回答。

我们建议你在深入了解更改的各个部分进行评论之前先检查这一点。

----

### 5. 整体代码质量是否良好，是否符合我们希望在 Flink 中维护的标准？

这是对实际变更的详细代码审核，包括：

* 变更是否按照 Jira issue 或 pull request 说明中的描述进行？
* 代码是否遵循正确的软件工程实践？代码是否正确、健壮、可维护、可测试？
* 在更改性能敏感部分时，是否对性能进行了优化？
* 测试是否覆盖了全部改动？
* 测试执行速度是否够快？（是否仅在必要时才使用重量级集成测试？）
* 代码格式是否遵循 Flink 的 checkstyle 模式？
* 代码是否避免引入额外的编译器警告？
* 如果依赖更新了，NOTICE 文件是否也更新了？

可以在 [Flink代码样式和质量指南]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}}) 中找到编码的规范和指南。

----

### 6. 英文和中文文档是否都更新了？

如果这个 pull request 引入了一个新功能，该功能应该被文档化。Flink 社区正在同时维护英文和中文文档。所以如果你想要更新或扩展文档，英文和中文文档都需要更新。如果你不熟悉中文，请创建一个用于中文文档翻译的 JIRA 并附上 `chinese-translation` 的组件名，并与当前 JIRA 关联起来。如果你熟悉中文，我们鼓励在一个 pull request 中同时更新两边的文档。

阅读[如何贡献文档]({{< relref "how-to-contribute/contribute-documentation" >}})了解更多。