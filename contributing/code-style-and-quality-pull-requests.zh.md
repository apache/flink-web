---
title:  "Apache Flink 代码格式和质量指南 — 合并请求 & 改动"
---

{% include code-style-navbar.zh.md %}

{% toc %}

**出发点：** 我们要求贡献者投入一点额外的努力，使得 Pull 请求变得能够更加容易、更加彻底的审查。这在很多方面都能帮助到社区:

* 审查能够更加快速，因此贡献能够更快合并。
* 我们可以通过忽略贡献中较少的问题来确保更高的代码质量。
* Committers 能够在同样时间内审查更多的贡献，这有助于保持 Flink 目前的高贡献率

请理解，没有遵循本指南的贡献将会需要更长的时间来审查，通常社区将会以较低的优先级来处理。这并不是有意的, 这是因为结构混乱的合并请求增加了审查的复杂度。


## 1. JIRA 问题和命名

确保你的 pull 请求能够对应一个 [JIRA 问题]([https://issues.apache.org/jira/projects/FLINK/issues).

****热补丁****可以例外,  比如修复 JavaDocs 或文档文件中的单词拼写错误。
  

表单中的 pull 请求命名 `[FLINK-XXXX][component] Title of the pull request`, `FLINK-XXXX` 应该被实际的问题编号所代替。 组件应该和 JIRA 问题中用到的组件保持一致。

热补丁的命名实例 `[hotfix][docs] Fix typo in event time introduction` 或 `[hotfix][javadocs] Expand JavaDoc for PuncuatedWatermarkGenerator`。


## 2. 描述

请在你的 pull 请求模板中填写你的贡献内容。你描述的内容可以让审查的同学从你的描述中快速的理解问题和解决方案，而不是从你的代码中去理解它们。

一个描述较好的 pull 请求典型事例 [https://github.com/apache/flink/pull/7264](https://github.com/apache/flink/pull/7264)

请确保你解决问题的 PR 中的描述是尽可能详细的。 一个很小的改动是不需要很多文字的。 理想情况下， 一个问题会在 Jira 问题中进行描述，你在 PR 中得描述一般可以从那复制过来。

当你在解决问题的过程中又发现了其他开放的问题，并且你继续选择解决这些问题，请在 pull 请求中的文本描述它们，以便审查的同学能够再次检查你的假设。 示例在 [https://github.com/apache/flink/pull/8290](https://github.com/apache/flink/pull/8290) (“开放架构问题”一节).


## 3. 代码重构、清理、单独的改动分开

****注意：这不是一个优化，这是一个非常关键的要求。****

Pull 请求必须将代码清理、重构、核心的改动分离到不同的提交中。这样，审查的同学才能单独的查看代码的清理、重构，并确保这次改动不会改变其他代码的行为。同时，审查同学也可以单独查看核心代码的改动(没有其他代码改动的影响)，确保这是一次干净并且健壮的改动。

代码改动必须严格分离到不同提交中，实例如下：

* 清理、修复已有代码中的样式和警告
* 包、类、方法重命名
* 移动代码(到其他包或者类)
* 重构代码的结构或者设计模式
* 合并相关的测试或者工具类
* 改变现有测试中的假设 (添加一条提交信息，描述你改动现有假设有什么意义)

不应该有清理提交来修复相同 PR 之前提交中引入的问题。提交本身应该是干净的。

另外，任何较大的贡献都应该将改动分成一组独立的变更，这样这些变更可以被更好的独立评审。

两个很好的将问题分解成单独提交的示例如下：

* [https://github.com/apache/flink/pull/6692](https://github.com/apache/flink/pull/6692) (将清理和重构与主更改分开)
* [https://github.com/apache/flink/pull/7264](https://github.com/apache/flink/pull/7264) (将主要的变更分成独立的可审查的部分)

如果一个 pull 请求依然包含较大的提交 (比如一个提交超过 1000 行的改动)， 那就应该可以考虑将这个提交分解成多个子问题，正如上面的示例所示。


## 4. 提交命名约定

提交消息应该遵循与 pull 请求类似的模式:
`[FLINK-XXXX][component] Commit description`。 
 
在某些情况，这个问题可能是一个子任务，它的组件可能与 Pull 请求的主组件不同。比如，当提交为 runtime 层更改引入端到端测试时，PR 将被标记为 `[runtime]`，但是单个提交将被标记为 `[e2e]`。

提交信息实例:

* `[hotfix] Fix update_branch_version.sh to allow version suffixes`
* `[hotfix] [table] Remove unused geometry dependency`
* `[FLINK-11704][tests] Improve AbstractCheckpointStateOutputStreamTestBase`
* `[FLINK-10569][runtime] Remove Instance usage in ExecutionVertexCancelTest`
* `[FLINK-11702][table-planner-blink] Introduce a new table type system`


## 5. 改变系统的可观察行为
贡献者应该注意他们合并请求中以任何方式改变 Flink 可见行为的修改，因为在许多情况下，这样的改动会破坏现有的设置。
在编写代码或者审查这个问题时，应该使用红色标记来提出问题，例如：

* 修改断言以使得测试在改变行为之后仍然通过。
* 配置设置突然必须被设置一个（非默认）值，以保持现有测试通过，这种情况在新的设置改变默认值之后经常发生。
* 现有脚本或配置必须被调整。
