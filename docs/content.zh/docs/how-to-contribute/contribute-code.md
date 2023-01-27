---
title: 贡献代码
bookCollapseSection: false
weight: 17
---

# 贡献代码

Apache Flink 是一个通过志愿者贡献的代码来维护、改进和扩展的项目。我们欢迎给 Flink 做贡献，但由于项目的规模大，以及为了保持高质量的代码库，我们要求贡献者遵循本文所阐述的贡献流程。

**请随时提出任何问题！** 可以发送邮件到 [dev mailing list]( {{< siteurl >}}/zh/community.html#mailing-lists )，也可以对正在处理的 Jira issue 发表评论。

**重要提示**：在开始准备代码贡献之前，请仔细阅读本文档。请遵循如下所述的流程和指南，为 Apache Flink 做贡献并不是从创建 pull request 开始的。我们希望贡献者先和我们联系，共同讨论整体方案。如果没有与 Flink committers 达成共识，那么贡献可能需要大量返工或不予审核通过。



{% toc %}

## 寻找可贡献的内容

如果你已经有好的想法可以贡献，可以直接参考下面的 "代码贡献步骤"。
如果你在寻找可贡献的内容，可以通过 [Flink 的问题跟踪列表](https://issues.apache.org/jira/projects/FLINK/issues) 浏览处于 open 状态且未被分配的 Jira 工单，然后根据 "代码贡献步骤" 中的描述来参与贡献。
如果你是一个刚刚加入到 Flink 项目中的新人，并希望了解 Flink 及其贡献步骤，可以浏览 [适合新手的工单列表](https://issues.apache.org/jira/issues/?filter=12349196) 。
这个列表中的工单都带有 _starter_ 标记，适合新手参与。

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
    <b>注意：</b>最近（2019 年 6 月），代码贡献步骤有改动。社区<a href="https://lists.apache.org/thread.html/1e2b85d0095331606ad0411ca028f061382af08138776146589914f8@%3Cdev.flink.apache.org%3E">决定</a>将原来直接提交 pull request 的方式转移到 Jira 上，要求贡献者在创建 pull request 之前需在 Jira 上达成共识（通过分配到的工单来体现），以减轻 PR review 的压力。
</div>


<div class="contribute-grid">
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">1</span><a href="#consensus">讨论</a></h2>
        <p>在 Jira 上创建工单或邮件列表讨论并达成共识</p>
        <p>商定重要性、相关性、工单的范围，讨论实现方案，并找到愿意审查和合并更改的 committer。</p>
        <p><b>只有 committers 才能分配 Jira 工单。</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">2</span><a href="#implement">实现</a></h2>
        <p>根据<a href="{{< siteurl >}}/zh/contributing/code-style-and-quality-preamble.html">代码样式和质量指南</a>，以及 Jira 工单中商定的方法去实现更改。</p> <br />
        <p><b>只有在达成共识时,才开始去实现(例如已经有工单分配给你了)</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">3</span><a href="#review">审查</a></h2>
        <p>创建一个 pull request 并与 reviewer 一起审查。</p>
        <p><b>未被分配 Jira 工单的 pull request 将不会被社区审查或合并。</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">4</span><a href="#merge">合并</a></h2>
        <p>Flink committer 审查此贡献是否满足需求，并将代码合并到代码库中。</p>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-sm-12">
    <div class="panel panel-default">
      <div class="panel-body">
        注意：诸如拼写错误或语法错误之类的<i>简单</i>热修复可以不用创建 Jira 工单，直接提交 [hotfix] pull request 即可。
      </div>
    </div>
  </div>
</div>



<a name="consensus"></a>

### 1. 创建 Jira 工单并达成共识。


向 Apache Flink 做出贡献的第一步是与 Flink 社区达成共识，这意味着需要一起商定更改的范围和实现的方法。

在大多数情况下，我们应该在 [Flink 的 Bug 追踪器：Jira](https://issues.apache.org/jira/projects/FLINK/summary) 中进行讨论。

以下类型的更改需要向 Flink 的 dev@flink.apache.org 邮件列表发一封以 `[DISCUSS]` 开头的邮件:

- 重大变化（主要新功能、大重构和涉及多个组件）
- 可能存在争议的改动或问题
- 采用非常不明确的方法或有多种实现方法

在讨论未达成一致之前,不要为这些类型的更改创建 Jira 工单。
基于 dev 邮件讨论的 Jira 工单需要链接到该讨论，并总结结果。



**Jira 工单获得共识的要求：**

- 正式要求
  - 描述问题的 *Title* 要简明扼要。
  - 在 *Description* 中要提供了解问题或功能请求所需的所有详细信息。
  - 要设置 *Component* 字段：许多 committers 和贡献者，只专注于 Flink 的某些子系统。设置适当的组件标签对于引起他们的注意很重要。
- 社区*一致同意*使用工单是有效解决问题的方法，而且这**非常适合** Flink。
  Flink 社区考虑了以下几个方面：
  - 这种贡献是否会改变特性或组件的性能，从而破坏以前的用户程序和设置？如果是，那么就需要讨论并达成一致意见，证明这种改变是可取的。
  - 这个贡献在概念上是否适合 Flink ？这是否是一种特殊场景？支持这种场景后会导致通用的场景变得更复杂，还是使整理抽象或者 APIs 变得更臃肿？
  - 该功能是否适合 Flink 的架构？它是否易扩展并保持 Flink 未来的灵活性，或者该功能将来会限制 Flink 吗？
  - 该特性是一个重要的新增内容(而不是对现有内容的改进)吗？如果是，Flink 社区会承诺维护这个特性吗？
  - 这个特性是否与 Flink 的路线图以及当前正在进行的工作内容一致？
  - 该特性是否为 Flink 用户或开发人员带来了附加价值？或者它引入了回归的风险而没有给相关的用户或开发人员带来好处？
  - 该贡献是否存在于其他仓库中，例如 Apache Bahir 或者其他第三方库？
  - 这仅仅是为了在开源项目中获得提交而做出的贡献吗（仅仅是为了获得贡献而贡献，才去修复拼写错误、改变代码风格）?
- 在如何解决这个问题上已有**共识**，包括以下需要考虑的因素
  - API、数据向后兼容性和迁移策略
  - 测试策略
  - 对 Flink 构建时间的影响
  - 依赖关系及其许可证

如果在 Jira 的讨论中发现改动是一个大的或有争议的变更，则可能需要起草 [Flink 改动建议(FLIP)](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals) 或在 [ dev 邮件列表]( {{< siteurl >}}/zh/community.html#mailing-lists) 中讨论以达成一致的意见。

一般 Committer 会在几天内对工单进行回应。如果工单没有得到任何关注，我们建议你联系 [dev 邮件列表]( {{< siteurl >}}/zh/community.html#mailing-lists)。请注意，Flink 社区有时无法处理发来的所有贡献信息。


一旦满足了工单的所有条件后，Committer 就会将工单*`分配`*给某个人，然后被分配到工单的人就可以继续后续的工作了。
只有 Committer 才能分配工单（包括分配给他自己和其他人）。

**社区不会审查或合并未关联 Jira 工单的 pull request！**


<a name="implement"></a>

### 2. 实现你的改动

你一旦被分配到了 Jira issue，那么你就可以开始去实现所需的改动了。

以下是在实现时要注意的一些要点：

- [设置 Flink 的开发环境](https://cwiki.apache.org/confluence/display/FLINK/Setting+up+a+Flink+development+environment)
- 遵循 Flink 的[代码风格和质量指南]({{< siteurl >}}/zh/contributing/code-style-and-quality-preamble.html)
- 接受来自 Jira issue 或设计文档中的任何讨论和要求。
- 不要将不相关的问题混合到一个贡献中。


<a name="review"></a>

### 3. 创建 Pull Request

在创建 pull request 之前的注意事项：

- 确保 **`mvn clean verify`** 成功执行，以保证所有检查都通过、代码成功构建和所有测试用例都成功执行。
- 执行 [Flink 的端到端测试](https://github.com/apache/flink/tree/master/flink-end-to-end-tests#running-tests)。
- 确保不包含任何不相关或不必要的格式化更改。
- 确保你的提交历史符合要求。
- 确保你的改动是基于最新的 base 分支提交的。
- 确保 pull request 引用的是相应的 Jira，并且每个 Jira issue 都对应一个 pull request（如果一个 Jira 有多个 pull requests，首先解决这种情况）

创建 pull request 之前或之后的注意事项：

- 确保分支在 [Travis](https://travis-ci.org/) 上已经成功构建。

Flink 中的代码更改将通过 [GitHub pull request](https://help.github.com/en/articles/creating-a-pull-request) 进行审查和合并。

这里有关于[如何审查 pull request]({{< siteurl >}}/zh/contributing/reviewing-prs.html) 的单独指南，包括我们的 pull request 审核流程。作为代码作者，在你准备 pull request 前，应该满足以上所有要求。

<a name="merge"></a>

### 4. 合并改动

审核完成后，代码将由 Flink 的 committer 合并。Jira 工单将在合并之后关闭。


