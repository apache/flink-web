---
title:  "如何审核 Pull Request"
---

<hr />

本指南适用于希望帮助审核代码的所有提交者和贡献者。感谢你的努力 - 良好的审核是开源项目中最重要也是最关键的部分之一。本文旨在协助社区开展代码审核工作，以达到下列目的：

* 让贡献者拥有良好的贡献体验。
* 将审核过程结构化，以涵盖所有需要检查的重要方面。
* 保持 Flink 代码的高质量。
* 避免贡献者和审核者花费大量时间完善代码却最终被拒绝提交的情况。

----

{% toc %}

## 审核清单

每次审核都需要检查以下五个方面。我们建议按照以下顺序进行检查，以避免在还没有就是否添加某项功能或需要改动达成共识之前，就花费时间进行详细的代码质量审核。

### 1.贡献的描述是否清晰？

检查贡献是否有充分的描述以方便审核，不重要的更改和修复不需要很长的描述，任何改变功能或行为的 pull request 都需要描述这些改变的重点, 以便知道审核什么内容(并且不必钻研代码来了解更改的作用)。

需要更长描述的更改，理想情况下基于邮件列表或 JIRA 中的事先设计讨论，可以简单地链接到那里或从那里复制描述。

**如果在不查看代码的情况下能回答以下问题2、3、4，则该贡献得到了很好的描述。**

-----

### 2.是否一致认为这一变更或者功能应该进入 Flink？

对于错误修复，只有在需要相对大量改动或可能破坏现有程序和设置时才需要检查。

理想情况下, 除了错误修复和少量的添加或扩展的情况外，该问题可以从 Jira issue 或开发者邮件列表的讨论中找到答案。在这种情况下，此问题可以立即标记为已解决。对于未事先达成共识而创建的 pull requests，此问题需要作为审核的一部分予以回答。

需从以下几个方面判断是否应将改动引入Flink：

* 贡献中改变特征或组件行为的做法，是否会对先前用户的代码或设置造成影响？如果是，则需要进行讨论并同意这种变更是值得的。
* 这个贡献在概念上是否适合 Flink ？它是否是某种极端特例，反而会将普通场景复杂化或使抽象及 API 变得臃肿？
* 该功能是否适合 Flink 的架构？未来它是否会扩展并保持 Flink 的灵活性，或者该功能将来会限制 Flink 的发展吗？
* 该功能是一项重要的新增功能（而不是对现有部件的改进）吗？如果是，Flink 社区是否会承诺维护此功能？
* 该功能是否为 Flink 用户或开发人员带来了额外的利益？或者它是否会在相关用户或开发人员无法受益的情况下引入回归风险？
* 可以将贡献提交至其他仓库（例如 [Apache Bahir](https://bahir.apache.org)）或外部仓库中吗？

所有这些问题都应在不看代码的前提下从 Jira 和 pull request 中的描述或讨论中得到回答。

**一旦有一个 committer 接受了某个功能、改进或者错误修复，并且没有其他 committer 不同意（lazy consensus 机制），那么就会批准它。** 

如果意见出现分歧，应将讨论转移到各自的 Jira issue 或开发邮件列表中继续进行，直到达成共识。如果变更是由一位 committer 提出的，那么寻求另一位 committer 的批准是最佳做法。

-----

### 3. 贡献是否需要一些特定的 committer 的关注，这些 committer 有时间投入吗？

一些更改需要特定的 committer 的注意和批准。例如，对性能非常敏感或对分布式协调和容错有关键影响的部件中的更改，这需要一个对相应组件非常熟悉的 committer 的审核。

根据经验，当 pull request 描述中对模板里问题 “Does this pull request potentially affect one of the following parts” 的回答为 “yes” 时，需要特别注意。

这个问题可以参考如下回答

* *Does not need specific attention*
* *Needs specific attention for X (X 可以是例如 checkpointing、jobmanager 等)*
* *Has specific attention for X by @commiterA, @contributorB*

**如果 pull request 需要特别关注，则其中一个标记的 committers 或 contributors 应该给出最终批准。**

----

### 4. 实现的整体方案或架构是否正确？

所给出的修复或功能实施方案是最佳吗？还是有其他更容易，更健壮或更易于维护的方案？
这个问题应该尽可能地从 pull request 描述（或链接的 Jira ）中得到回答。

我们建议你在深入了解更改的各个部分进行评论之前先检查这一点。

----

### 5.整体代码质量是否良好，是否符合我们希望在 Flink 中维护的标准？

这是对实际变更的详细代码审核，包括：

* 变更是否按照设计文档或 pull request 说明中的描述进行？
* 代码是否遵循正确的软件工程实践？代码是否正确、健壮、可维护、可测试？
* 在更改性能敏感部分时，是否对性能进行了优化？
* 测试是否覆盖了全部改动？
* 测试执行速度是否够快？（是否仅在必要时才使用重量级集成测试？）
* 代码格式是否遵循 Flink 的 checkstyle 模式？
* 代码是否避免引入额外的编译器警告？

可以在 [Flink代码样式页面]({{ site.baseurl }}/zh/contribute-code.html#code-style) 中找到一些代码样式指南。

## 使用 @flinkbot 进行审核

Flink 社区正在使用名为 [@flinkbot](https://github.com/flinkbot) 的服务来帮助审核 pull request。

针对每个新的 pull request，机器人都会自动发表评论并跟踪审核进度：

```
### Review Progress

* [ ] 1. The description looks good.
* [ ] 2. There is consensus that the contribution should go into to Flink.
* [ ] 3. [Does not need specific attention | Needs specific attention for X | Has attention for X by Y]
* [ ] 4. The architectural approach is sound.
* [ ] 5. Overall code quality is good.

Please see the [Pull Request Review Guide](https://flink.apache.org/reviewing-prs.html) if you have questions about the review process.
```

审核人可以指示机器人（按顺序）勾选方框以指示审核的进度。

用于批准贡献的描述，请使用 `@flinkbot approve description` @机器人。`consensus`、`architecture` 、 `quality` 情况的操作与之类似。

要批准全部方面，请在 pull request 中添加一条带有 `@flinkbot approve all` 的新评论。

提醒他人关注的语法是 `@flinkbot attention @username1 [@username2 ..]`。


