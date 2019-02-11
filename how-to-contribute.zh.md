---
title: "如何参与贡献"
---

<hr />

Apache Flink由一个开放友好的社区开发的。 我们诚挚地欢迎每个人加入社区并为Apache Flink做出贡献。 以下几种方式可以与社区互动并为Flink做出贡献，包括提问，提交错误报告，提出新功能，加入邮件列表上的讨论，贡献代码或文档，改进网站或测试候选版本。

{% toc %}

## 问问题!

Apache Flink社区非常乐意帮助并回答您的问题。 我们提供了 [用户邮件列表]({{ site.baseurl }}/community.html#mailing-lists )并在Stack Overflow网站上创建了 [[apache-flink]](http://stackoverflow.com/questions/tagged/apache-flink)标签。

-----

## 提交错误报告

如果您遇到Flink问题，请告知我们并提交错误报告。打开[Flink的Jira](http://issues.apache.org/jira/browse/FLINK)，在必要时登录并单击顶部的红色**Create**按钮。请提供您遇到的问题的详细信息，如果可能，请添加有助于重现问题的描述。非常感谢。

-----

## 提出改进或新功能

我们的社区一直在寻找反馈来改进Apache Flink。 如果你有一个想法如何改进Flink或有一个新的功能，这将有利于Flink用户，请在[Flink's Jira](http://issues.apache.org/jira/browse/FLINK)中打开一个问题。 应详细描述改进或新功能，并尽可能包括范围及其要求。 详细信息很重要，原因如下：

- 它可确保在实施改进或功能时满足您的要求。
- 它有助于估算工作量并设计满足您需求的解决方案。
- 它允许围绕这个问题进行建设性的讨论。

如果您计划自己提供改进或功能，则还需要提供详细信息。 在这种情况下，请阅读[贡献代码]({{ site.base }}/contribute-code.html)指南。在开始实施之前，我们建议首先与社区就是否需要新功能以及如何实施新功能达成共识。 某些功能可能超出了项目的范围，最好尽早发现。

对于从根本上改变Flink的非常大的功能，我们有另一个流程：[Flink改进建议](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals)。 如果您有兴趣，可以在那里提出新功能或遵循讨论现有提案。

-----

## 帮助他人并加入讨论

Apache Flink社区中的大多数通信都发生在两个邮件列表中：

- 用户邮件列表`user@flink.apache.org `是Apache Flink用户提问和寻求帮助或建议的地方。加入用户列表并帮助其他用户是为Flink社区做出贡献的一种非常好的方式。此外，如果您想帮助Flink用户(并获得一些积分)，Stack Overflow网站上还有[[apache-flink]](http://stackoverflow.com/questions/tagged/apache-flink)标签。
- 开发邮件列表`dev@flink.apache.org`是Flink开发人员交流想法，讨论新功能，即将发布的版本以及开发过程的地方。 如果您有兴趣为Flink贡献代码，您应该加入此邮件列表。

非常欢迎您[订阅这两个邮件列表]({{ site.baseurl }}/community.html#mailing-lists)。

-----

## 通过审查代码来贡献

Apache Flink项目以[Github pull请求](https://github.com/apache/flink/pulls)的形式接收许多代码贡献。为Flink社区做出贡献的一个很好的方法是帮助审查拉取请求。

**如果您想帮助审查拉取请求，请阅读[审查指南]({{ site.baseurl }}/reviewing-prs.html)。**

-----

## 测试一个候选版本

Apache Flink通过其活跃的社区不断改进。每隔几周，我们都会发布Apache Flink的新版本，其中包含了bug修复、改进和新特性。发布新版本的过程包括以下步骤:

1. 构建一个新的发布候选版本并开始投票(通常持续72小时)。
2. 测试候选版本并投票(如果没有发现问题，则使用“+1”;如果候选版本有问题，则使用“-1”)。
3. 如果候选发布版有问题，请返回第1步。 否则我们发布该版本。

我们的wiki包含一个页面，其中总结了[发布的测试过程](https://cwiki.apache.org/confluence/display/FLINK/Releasing)。 如果由一小群人完成发布测试工作则很困难，更多人参与则很轻松。 Flink社区鼓励每个人参与测试候选发布版。 通过测试候选版本，您可以确保下一个Flink版本正常运行，以帮助您进行设置并帮助提高版本质量。

-----

## 贡献代码

Apache Flink通过志愿者的代码贡献得到维护，改进和扩展。 Apache Flink社区鼓励任何人贡献源代码。为了确保贡献者和评审者有一个愉快的贡献体验并保持高质量的代码库，我们遵循我们的[贡献代码]( {{ site.base }}/contribute-code.html)指南。 该指南还包括有关如何设置开发环境，编码指南和代码样式的说明，并说明如何提交代码贡献。

**在开始处理代码贡献之前，请阅读[贡献代码]( {{ site.base }}/contribute-code.html)指南。**

另请阅读[提交贡献者许可协议]({{ site.baseurl }}/how-to-contribute.html#submit-a-contributor-license-agreement)部分。

### 如何寻找可以解决的问题？
{:.no_toc}

我们在[Flink's Jira](https://issues.apache.org/jira/browse/FLINK/?selectedTab=com.atlassian.jira.jira-projects-plugin:issues-panel)中保留了所有已知错误，建议的改进和建议功能的列表。 我们将对于新贡献者有帮助的问题标记为特殊的“starter”标记。 这些任务应该很容易解决，并将帮助您熟悉项目和贡献过程。

请查看[入门问题](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20AND%20labels%20%3D%20starter%20ORDER%20BY%20priority%20DESC)列表，如果您正在寻找可以解决的问题。 您当然也可以选择[任何其他问题](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20ORDER%20BY%20priority%20DESC)继续工作。 您可以随意提出有关您有兴趣处理的问题。

-----

## 贡献文档

良好的文档对任何类型的软件都至关重要。 对于复杂的软件系统尤其如此，例如Apache Flink等分布式数据处理引擎。 Apache Flink社区旨在提供简明，精确和完整的文档，并欢迎任何改进Apache Flink文档的贡献。

- 请将缺失，不正确或过时的文档报告为一个[Jira问题](http://issues.apache.org/jira/browse/FLINK)。
- Flink的文档是用Markdown编写的，位于[Flink的源代码库]({{ site.baseurl }}/community.html#main-source-repositories)的`docs`文件夹中。 有关如何更新和改进文档以及提供更改的详细说明，请参阅[贡献文档]({{ site.base }}/contribute-documentation.html) 指南。

-----

## 改进网站

[Apache Flink网站](http://flink.apache.org)展示了Apache Flink及其社区。它有几个用途，包括:

- 向访问者介绍Apache Flink及其功能。
- 鼓励访问者下载和使用Flink。
- 鼓励访客与社区互动。

我们欢迎任何改进我们网站的贡献。

- 如果您认为我们的网站可以改进，请打开一个[Jira issue](http://issues es.apache.org/jira/browse/flink)。
- 如果您想更新和改进网站，请按照[改进网站]({{ site.baseurl }}/improve-website.html)指南进行操作。

-----

## 更多的贡献方式…

还有很多方法可以为Flink社区做出贡献。 例如，你可以：

- 做一个关于Flink的演讲，告诉别人你是如何使用它的。
- 组织本地Meetup或用户组。
- 与人们谈论Flink。
- …

-----

## 提交贡献者许可协议

如果您想为Apache Flink做出贡献，请向Apache Software Foundation (ASF)提交贡献者许可协议。以下引用[http://www.apache.org/licenses](http://www.apache.org/licenses/#clas)提供了关于ICLA和CCLA的更多信息，以及为什么需要它们。

> ASF希望Apache项目的所有思想、代码或文档的贡献者完成、签署并提交(通过邮政邮件、传真或电子邮件)[Individual Contributor License Agreement](http://www.apache.org/licenses/icla.txt) (CLA) [[PDF表单](http://www.apache.org/licenses/icla.pdf)]。本协议的目的是明确界定向ASF提供知识产权的条款，从而使我们能够在未来某个时间就软件发生法律纠纷时为该项目辩护。在个人被授予对ASF项目的提交权限之前，需要将签名类存档。
>
> 对于分配员工参与Apache项目的公司，可以通过公司提供[Corporate CLA](http://www.apache.org/licenses/cla-corporate.txt) (CCLA)来贡献知识产权，该知识产权可能是作为雇佣协议的一部分分配的。请注意，公司类并不免除每个开发人员作为个人签署他们自己的类的需要，以覆盖他们的贡献，而这些贡献并不属于签署CCLA的公司。
>
> ...

-----

## 如何成为一个提交者

提交者是具有对项目存储库的写访问权的社区成员，即他们可以自己修改代码，文档和网站，也接受其他贡献。

成为提交者没有严格的协议。新提交者的候选人通常是活跃的贡献者和社区成员。

成为活跃的社区成员意味着参与邮件列表讨论，帮助回答问题，验证候选发布者，尊重他人，以及遵循社区管理的精英原则。由于“Apache Way”非常关注项目社区，因此这部分非常重要。

当然，为项目提供代码和文档也很重要。一个好的开始方法是提供改进，新功能或错误修复。您需要证明您对所贡献的代码负责，添加测试和文档，并帮助维护它。

新提交者的候选人由当前的提交者或PMC成员提出，并由PMC投票。

如果您想成为提交者，您应该与社区互动并开始以上述任何方式为Apache Flink做出贡献。您可能还想与其他提交者交谈并询问他们的建议和指导。