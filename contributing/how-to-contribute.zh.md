---
title: "如何参与贡献"
---

<hr />

Apache Flink 社区是一个开放友好的社区。我们诚挚地欢迎每个人加入社区并为 Apache Flink 做出贡献。有许多方式可以参与社区并为 Flink 做出贡献，包括提问、提交错误报告、提出新功能、加入邮件列表上的讨论、贡献代码或文档、改进网站、以及测试候选版本。

{% toc %}

## 问问题!

Apache Flink 社区非常乐意帮助并回答你的问题。我们提供了[用户邮件列表]({{ site.baseurl }}/zh/community.html#mailing-lists)并在 Stack Overflow 网站上创建了 [[apache-flink]](http://stackoverflow.com/questions/tagged/apache-flink) 标签。

-----

## 提交错误报告

如果你在使用 Flink 时遇到了问题，请告知我们并提交错误报告。打开 [Flink Jira](http://issues.apache.org/jira/browse/FLINK)，登录并点击顶部红色的 **Create** 按钮。请提供你遇到的问题的详细信息，如果可能，请添加有助于重现问题的描述。非常感谢。

-----

## 提出改进或新功能

我们的社区一直在寻找反馈来改进 Apache Flink。如果你对如何改进 Flink 有一个想法或者想到了一个新功能，这绝对能帮到 Flink 用户，请在 [Flink Jira](http://issues.apache.org/jira/browse/FLINK) 中提交一个问题。改进或新功能最好能详细描述下，并尽可能地加上支持的范围和需求。详细信息很重要，原因如下：

- 它可确保在实现改进或功能时满足你的需求。
- 它有助于估算工作量并设计满足你需求的解决方案。
- 它允许围绕这个问题展开建设性的讨论。

如果你计划自己贡献改进或功能，也需要提供详细信息。在这种情况下，请阅读[贡献代码]({{ site.base }}/zh/contribute-code.html)指南。

在开始实现之前，我们建议首先与社区就是否需要新功能以及如何实现新功能达成共识。某些功能可能超出了项目的范围，最好尽早发现。

对于从根本上改变 Flink 的非常大的功能，我们有另一个流程：[Flink 改进提案（Flink Improvement Proposals, FLIP）](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals)。如果你有兴趣，可以在那里提出新功能，或者加入现有提案的讨论。

-----

## 帮助他人并加入讨论

Apache Flink 社区中的大多数通信都发生在两个邮件列表中：

- 用户邮件列表  `user@flink.apache.org ` 是 Apache Flink 用户提问和寻求帮助或建议的地方。加入用户列表并帮助其他用户是为Flink社区做出贡献的一种非常好的方式。此外，Stack Overflow 网站上还有 [[apache-flink]](http://stackoverflow.com/questions/tagged/apache-flink) 标签，你可以在那里帮助 Flink 用户（并获得一些积分）。
- 开发邮件列表 `dev@flink.apache.org` 是 Flink 开发人员交流想法、讨论新功能、发布新版本以及开发过程的地方。如果你有兴趣为 Flink 贡献代码，你应该加入此邮件列表。

非常欢迎你[订阅这两个邮件列表]({{ site.baseurl }}/zh/community.html#mailing-lists)。

-----

## 通过审查代码来贡献

Apache Flink 项目以 [Github pull request](https://github.com/apache/flink/pulls) 的形式接收许多代码贡献。为 Flink 社区做出贡献的一个很好的方法是帮助审查 pull request。

**如果你想帮助审查 pull request，请阅读[审查指南]({{ site.baseurl }}/zh/reviewing-prs.html)。**

-----

## 测试一个候选版本

Apache Flink 通过其活跃的社区不断改进。每隔几周，我们都会发布 Apache Flink 的新版本，其中包含了 bug 修复、改进和新特性。发布新版本的过程包括以下步骤:

1. 构建一个新的发布候选版本并开始投票（通常持续72小时）。
2. 测试候选版本并投票（如果没有发现问题，则使用`+1`；如果候选版本有问题，则使用`-1`）。
3. 如果候选发布版有问题，请返回第1步。否则我们发布该版本。

我们的 wiki 包含一个页面，其中总结了[发布的测试过程](https://cwiki.apache.org/confluence/display/FLINK/Releasing)。如果由一小群人完成发布测试工作会很困难，更多人参与则很轻松。Flink 社区鼓励每个人参与测试候选发布版。通过测试候选版本，可以确保下一个 Flink 版本适用于你的环境，并帮助提高版本的质量。

-----

## 贡献代码

Apache Flink 通过志愿者的代码贡献得到维护、改进和扩展。Apache Flink 社区鼓励任何人贡献源代码。为了确保贡献者和评审者有一个愉快的贡献体验并保持高质量的代码库，请遵循我们的[贡献代码]({{ site.base }}/zh/contribute-code.html)指南。该指南还包括有关如何设置开发环境、编码指南和代码样式的说明，并说明如何提交代码贡献。

**在开始贡献代码之前，请阅读[贡献代码]({{ site.base }}/zh/contribute-code.html)指南。**

另请阅读[提交贡献者许可协议]({{ site.baseurl }}/zh/how-to-contribute.html#submit-a-contributor-license-agreement)部分。

### 正在寻找一个可以参与贡献的 issue ？
{:.no_toc}

我们在 [Flink Jira](https://issues.apache.org/jira/browse/FLINK/?selectedTab=com.atlassian.jira.jira-projects-plugin:issues-panel) 中维护了所有已知 bug，改进建议和功能需求的列表。对于新贡献者友好的问题，我们将其打上了特殊的 "starter" 标记。这些任务应该很容易解决，并将帮助你熟悉项目和贡献过程。

如果你正在寻找可以参与贡献的 issue，请查看 [starter issues](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20AND%20labels%20%3D%20starter%20ORDER%20BY%20priority%20DESC) 列表。你当然也可以选择[任何其他问题](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20ORDER%20BY%20priority%20DESC)继续工作。如果你对感兴趣的 issue 有问题的话，也可以随时提问。

-----

## 贡献文档

良好的文档对任何类型的软件都至关重要。对于复杂的软件系统尤其如此，例如 Apache Flink 等分布式数据处理引擎。Apache Flink社区旨在提供简明，精确和完整的文档，并欢迎任何改进 Apache Flink 文档的贡献。

- 如果发现文档缺失、不正确或过时的问题，可以提交一个 [Jira issue](http://issues.apache.org/jira/browse/FLINK) 。
- Flink 文档是用 Markdown 编写的，位于[Flink 源码库]({{ site.baseurl }}/zh/community.html#main-source-repositories)的`docs`文件夹中。有关如何更新和改进文档以及提供贡献的详细说明，请参阅[贡献文档]({{ site.base }}/zh/contribute-documentation.html) 指南。

-----

## 改进网站

[Apache Flink 网站](http://flink.apache.org)展示了 Apache Flink 及其社区。它有几个用途，包括:

- 向访问者介绍 Apache Flink 及其功能。
- 鼓励访问者下载和使用 Flink 。
- 鼓励访客与社区互动。

我们欢迎任何改进我们网站的贡献。

- 如果你认为我们的网站可以改进，请提交一个 [Jira issue](http://issues.apache.org/jira/browse/FLINK) 。
- 如果你想更新和改进网站，请按照[改进网站]({{ site.baseurl }}/zh/improve-website.html)指南进行操作。

-----

## 更多的贡献方式...

还有很多方法可以为 Flink 社区做出贡献。例如，你可以：

- 做一个关于 Flink 的演讲，告诉别人你是如何使用它的。
- 组织本地 Meetup 或用户组。
- 与人们谈论 Flink 。
- ...

-----

## 提交贡献者许可协议

如果你想为 Apache Flink 做出贡献，请向 Apache Software Foundation (ASF)提交贡献者许可协议。以下引用[http://www.apache.org/licenses](http://www.apache.org/licenses/#clas)提供了关于 ICLA 和 CCLA 的更多信息，以及为什么需要它们。

> ASF希望Apache项目的所有思想、代码或文档的贡献者完成、签署并提交(通过邮政邮件、传真或电子邮件)[Individual Contributor License Agreement](http://www.apache.org/licenses/icla.txt) (CLA) [[PDF 表单](http://www.apache.org/licenses/icla.pdf)]。本协议的目的是明确界定向 ASF 提供知识产权的条款，从而使我们能够在未来某个时间就软件发生法律纠纷时为该项目辩护。在个人被授予对 ASF 项目的提交权限之前，需要将签名类存档。
>
> 对于指派员工参与 Apache 项目的企业，可以通过公司提供[企业 CLA](http://www.apache.org/licenses/cla-corporate.txt) (Corporate CLA，CCLA)来贡献知识产权，该知识产权可能是作为雇佣协议的一部分分配的。请注意，企业 CLA 并不免除每个开发人员作为个人签署他们自己的 CLA 的需要，以覆盖那些不属于签署 CCLA 企业的贡献。
>
> ...

-----

## 如何成为一个提交者（Committer）

提交者是具有对项目仓库写权限的社区成员，即他们可以修改代码、文档和网站、也接受其他贡献。

成为提交者没有严格的协议。新提交者的候选人通常是活跃的贡献者和社区成员。

成为活跃的社区成员意味着参与邮件列表讨论、帮助回答问题、验证候选发布版本、尊重他人、以及遵循社区管理的精英原则。由于 “Apache Way” 非常关注项目社区，因此这部分非常重要。

当然，为项目提供代码和文档也很重要。一个好的开端是提供改进、新功能或错误修复。你需要证明你对所贡献的代码负责，添加测试和文档，并帮助维护它。

新提交者的候选人由当前的提交者或 PMC 成员提出，并由 PMC 投票。

如果你想成为提交者，你应该与社区互动并开始以上述任何方式为 Apache Flink 做出贡献。你可能还想与其他提交者交谈并询问他们的建议和指导。