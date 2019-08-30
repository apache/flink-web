---
title:  "贡献代码"
---

Apache Flink 是靠志愿者的代码贡献来得到维护、改进和扩展的项目。我们欢迎给 Flink 做贡献，但由于项目的规模大，为了保持高质量的代码库，我们要求贡献者须遵循本文中的贡献过程说明。

**请随时提出任何问题！** 可以发送邮件到 [dev mailing list]( {{ site.base }}/community.html#mailing-lists )，也可以对正在处理的 Jira issue 发表评论。

**重要提示**: 在开始准备代码贡献之前，请仔细阅读本文档。请遵循如下所述的流程和指南，为 Apache Flink 做贡献并不是从打开 pull request 开始的。我们希望贡献者先和我们联系，共同讨论整体方案。如果没有与 Flink committers 达成共识，那么贡献可能需要大量返工或不予审核通过。



{% toc %}

## 代码贡献步骤

<style>
.contribute-grid {
  margin-bottom: 10px;
  display: flex;
  flex-direction: column;
  margin-left: -2px;
  margin-right: -2px;
}

.contribute-grid .column {
  margin-top: 4px;
  padding: 0 2px;
}

@media only screen and (min-width: 480px) {
  .contribute-grid {
    flex-direction: row;
    flex-wrap: wrap;
  }

  .contribute-grid .column {
    flex: 0 0 50%;
  }

  .contribute-grid .column {
    margin-top: 4px;
  }
}

@media only screen and (min-width: 960px) {
  .contribute-grid {
    flex-wrap: nowrap;
  }

  .contribute-grid .column {
    flex: 0 0 25%;
  }

}

.contribute-grid .panel {
  height: 100%;
  margin: 0;
}

.contribute-grid .panel-body {
  padding: 10px;
}

.contribute-grid h2 {
  margin: 0 0 10px 0;
  padding: 0;
  display: flex;
  align-items: flex-start;
}

.contribute-grid .number {
  margin-right: 0.25em;
  font-size: 1.5em;
  line-height: 0.9;
}
</style>


<div class="alert alert-warning" role="alert">
    <b>注意：</b>最近，代码贡献步骤有改动（2019 年 6 月）。社区<a href="https://lists.apache.org/thread.html/1e2b85d0095331606ad0411ca028f061382af08138776146589914f8@%3Cdev.flink.apache.org%3E">决定</a>将原来的 "backpressure"从 pull request 方式转移到 Jira，要求贡献者在打开 pull request 之前需在 Jira 上达成共识（通过分配到的 ticket 来体现）。
</div>


<div class="contribute-grid">
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">1</span><a href="#consensus">讨论</a></h2>
        <p>在 Jira 上创建投票或邮件列表讨论并达成共识</p>
        <p>商定重要性、相关性、ticket 的范围，讨论实现方案，并找到愿意审查和合并更改的 committer。</p>
        <p><b>只有 committers 才能分配 Jira ticket。</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">2</span><a href="#implement">实现</a></h2>
        <p>根据<a href="{{ site.base }}/contributing/code-style-and-quality.html">代码样式和质量指南</a>，以及 Jira ticket 中商定的方法去实现更改。</p> <br />
        <p><b>只有在达成共识时,才开始去实现(例如你被分配到了 ticket 上)</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">3</span><a href="#review">检查</a></h2>
        <p>打开一个 pull request 并与 reviewer 一起检查。</p>
        <p><b>未被分配 Jira tickets 的 pull request 将不会被社区审查或合并。</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">4</span><a href="#merge">合并</a></h2>
        <p> Flink committer 审查此贡献是否满足需求，并将代码合并到代码库中。</p>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-sm-12">
    <div class="panel panel-default">
      <div class="panel-body">
        注意：诸如拼写错误或语法错误之类的<i>简单</i>热修复可以在打开 pull request 时，使用 [hotfix] 标识，可以不用 Jira ticket。
      </div>
    </div>
  </div>
</div>



<a name="达成共识"></a>

### 1. 创建 Jira Ticket 并达成共识。


向 Apache Flink 做出贡献的第一步是与 Flink 社区达成共识，这意味着需要一起商定更改的范围和实现的方法。

在大多数情况下，讨论应该发生在 [ Flink 的 Bug 跟踪器](https://issues.apache.org/jira/projects/FLINK/summary)中：Jira。

以下类型的更改需要在 dev@flink.apache.org Flink 邮件列表中标识 `[DISCUSS]`:

 - 重大变化（主要新功能、大重构和涉及多个组件）
 - 可能存在争议的变化或问题
 - 采用非常不明确的方法或多种相同方法的变化

 在讨论结束之前,不要为这些类型的更改打开 Jira tickets。
 基于 dev 邮件讨论的 Jira tickets 需要链接到该讨论，并总结结果。



**Jira ticket 获得共识的要求：**

  - 正式要求
     - 描述问题的 *Title* 要简明扼要。
     - 在 *Description* 中要提供了解问题或功能请求所需的所有详细信息。
     - 要设置 *Component* 字段：许多 committers 和贡献者，只专注于 Flink 的某些子系统。设置适当的组件标签对于引起他们的注意很重要。
  - 社区*一致同意*使用 tickets 是有效解决问题的方法，而且这**非常适合** Flink。 
    Flink 社区考虑了以下几个方面：
     - 这种贡献是否会改变特性或组件的性能，从而破坏以前的用户程序和设置？如果是，那么就需要讨论并达成一致意见，证明这种改变是可取的。
     - 这个贡献在概念上是否适合 Flink ？这是一个特殊情况，是因为它使简单问题变复杂，还是使 abstractions 或者 APIs 变得臃肿？
     - 该功能是否适合 Flink 的架构？它是否易扩展并保持 Flink 未来的灵活性，或者该功能将来会限制 Flink 吗？
     - 该特性是一个重要的新增(而不是对现有部分的改进)吗？如果是，Flink 社区会承诺维护这个特性吗？
     - 这个特性是否与 Flink 的路线图以及当前正在进行的工作内容一致？
     - 该特性是否为 Flink 用户或开发人员带来了附加价值？或者它引入了回归的风险而没有给相关的用户或开发人员带来好处？
     - 该贡献是否存在于另一个存储库中，例如 Apache Bahir 或另一个外部存储库？
     - 这仅仅是为了在开源项目中获得提交而做出的贡献吗（仅仅是为了获得贡献而贡献，才去修复拼写错误、改变代码风格）?
  - 在如何解决这个问题上已有**共识**，包括以下需要考虑的因素
    - API 、数据向后兼容性和迁移策略
    - 测试策略
    - 对 Flink 的构建时间的影响
    - 依赖关系及其许可证

如果在 Jira 的讨论中发现改动是一个大的或有争议的变更，则可能需要有 [Flink 改动建议 ( FLIP )](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals) 或在 [ dev 邮件列表]( {{ site.base }}/community.html#mailing-lists) 中讨论以达成一致意见。

贡献者可以在打开 ticket 后的几天内得到来自 committer 的第一回应。如果 ticket 没有得到任何关注，我们建议你联系 [dev 邮件列表]( {{ site.base }}/community.html#mailing-lists)。请注意，Flink 社区有时没有能力接受发来的所有贡献信息。


一旦满足了 ticket 的所有要求，committer 就会将某人*`分配`*给 ticket 的受理人以进行处理。
只有 committer 才有权限分配 ticket 给某人。

**社区不会审查或合并属于未分配的 Jira ticket 的 pull request ！**


<a name="实现"></a>

### 2. 实现你想改动的

一旦你被分配到了 Jira issue，你就可以开始去实现你想改动的内容。

以下是在实现时要注意的一些要点：

- [设置 Flink 的开发环境](https://cwiki.apache.org/confluence/display/FLINK/Setting+up+a+Flink+development+environment)
- 遵循 Flink 的 [代码风格和质量指南]({{ site.base }}/contributing/code-style-and-quality.html)
- 接受来自 Jira issue 或设计文档中的任何讨论和要求。
- 不要将不相关的问题混合到一个贡献中。


<a name="审查"></a>

### 3. 打开一个 Pull Request

在打开 pull request 之前的注意事项：

 - 确保 **`mvn clean verify`** 验证了你的更改，以确保所有检查都通过，代码构建并且所有测试都通过。
 - 执行 [Flink 的端到端测试](https://github.com/apache/flink/tree/master/flink-end-to-end-tests#running-tests)。
 - 确保不包含任何不相关或不必要的格式化更改。
 - 确保你的提交历史符合要求。
 - 确保更改是重新基于你的基本分支中的最新提交。
 - 确保 pull request 引用的是相应的 Jira，并且每个 Jira issue 都分配给了一个 pull request（如果一个 Jira 有多个 pull requests; 首先解决这种情况）

 打开 pull request 之前或之后的注意事项：

 - 确保分支在  [Travis](https://travis-ci.org/) 上已经成功构建。

Flink 中的代码更改将通过 [GitHub pull request](https://help.github.com/en/articles/creating-a-pull-request) 进行审查和接受。

这有关于[如何审查 pull request]({{ site.base }}/contributing/reviewing-prs.html) 的单独指南，包括我们的 pull request 审核流程。 作为代码作者，在你准备 pull request 前，应该满足以上所有要求。







<a name="合并"></a>

### 4. 合并改动

审核完成后，代码将由 Flink 的 committer 合并。Jira ticket 将在合并之后关闭。

