---
title: 如何参与贡献
bookCollapseSection: false
weight: 16
---

# 如何参与贡献

Apache Flink 是由一个开放友好的社区开发的。我们诚挚地欢迎每个人加入社区并为 Apache Flink 做出贡献。与社区交流和为 Flink 做贡献的方式包括：提问题、报告 bug、提议新特性、参与邮件列表的讨论、贡献代码或文档、改进网站和测试候选发布版本。


## 你想做什么？
<p>为 Apache Flink 做贡献不仅仅包括贡献代码。下面列出来不同的贡献形式：</p>


<table class="table table-bordered">
  <thead>
    <tr>
      <th>可以贡献的领域</th>
      <th>详细说明</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> 报告 Bug</td>
      <td>要报告 Flink 的问题，请登录 <a href="http://issues.apache.org/jira/browse/FLINK">Flink’s Jira</a>，然后点击顶部红色的 Create 按钮。<br/>
      请提供你遇到问题的详细信息，如果可以，请附上能够帮助我们复现问题的描述。</td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-console" aria-hidden="true"></span> 贡献代码</td>
      <td>请阅读 <a href=""{{< relref "how-to-contribute/contribute-code" >}}">代码贡献指南</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 帮助做代码审核</td>
      <td>请阅读 <a href="{{< relref "how-to-contribute/reviewing-prs" >}}">代码审核指南</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> 帮助准备版本发布</td>
      <td>
        发布新版本包括以下步骤：
        <ol>
          <li>建立新的候选版本并且在 dev@flink.apache.org 邮件列表发起投票（投票通常持续72小时）。</li>
          <li>测试候选版本并投票 （如果没发现问题就 +1，发现问题则 -1）。</li>
          <li>如果候选版本有问题就退回到第一步。否则我们发布该版本。</li>
        </ol>
        请阅读 <a href="https://cwiki.apache.org/confluence/display/FLINK/Releasing">版本测试流程</a>。
      </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> 贡献文档</td>
      <td>请阅读 <a href="{{< relref "how-to-contribute/contribute-documentation" >}}">文档贡献指南</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-user" aria-hidden="true"></span> 支持 Flink 用户</td>
      <td>
        <ul class="contribute-card-list">
          <li>回答 <a href="{{< relref "community" >}}#mailing-lists">用户邮件列表</a> 中的问题</li>
          <li>回答 <a href="https://stackoverflow.com/questions/tagged/apache-flink">Stack Overflow</a> 上带有 <a href="https://stackoverflow.com/questions/tagged/apache-flink"><code style="background-color: #cee0ed; border-color: #cee0ed;">apache-flink</code></a>、 <a href="https://stackoverflow.com/questions/tagged/flink-streaming"><code style="background-color: #cee0ed; border-color: #cee0ed;">flink-streaming</code></a> 或 <a href="https://stackoverflow.com/questions/tagged/flink-sql"><code style="background-color: #cee0ed; border-color: #cee0ed;">flink-sql</code></a> 标签的 Flink 相关问题</li>
          <li>检查 <a href="http://issues.apache.org/jira/browse/FLINK">Jira</a> 上近期发布的 issue 中用户提出的问题</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-blackboard" aria-hidden="true"></span> 改进网站</td>
      <td>请阅读 <a href="{{< relref "how-to-contribute/improve-website" >}}">网站贡献指南</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span> 推广 Flink</td>
      <td>
        <ul class="contribute-card-list">
        <li>组织或出席 <a href="https://www.meetup.com/topics/apache-flink/">Flink Meetup</a></li>
        <li>贡献 <a href="https://flink.apache.org/blog/">Flink blog</a></li>
        <li>在 <a href="{{< relref "community" >}}#mailing-lists">community@flink.apache.org 邮件列表</a>分享你的会议、聚会或博客文章，或发 tweet 并 <a href="https://twitter.com/ApacheFlink">@ApacheFlink</a>。</li>
      </ul>
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> 如有其他问题请到 <a href="{{< relref "community" >}}#mailing-lists">dev@flink.apache.org 邮件列表</a> 寻求帮助！
      </td>
    </tr>
  </tbody>
</table>



## 延申阅读

### 成为 Flink Committer 和 PMC 成员

#### 如何成为 committer

Committer 是对项目仓库具有写入权限的社区成员，也就是说，他们可以自己修改代码、文档和网站，也可以接受其他贡献。

成为 committer 或 PMC 成员没有严格的协议。新的 committer 候选人通常是活跃的贡献者和社区成员。

新的 committer 候选人由当前的 committer 或 PMC 成员提名，并由 PMC 投票选举。

如果想成为一名 committer，你应该积极与社区互动，并开始以上述任何方式贡献 Apache Flink。

#### 我们寻找什么样的 committer

作为一名 committer 意味着你被公认为项目（社区或技术）的重要贡献者，并拥有辅助开发的工具。Committer 候选人是社区成员，他们在很长一段时间内做出了优秀的贡献，并且希望继续贡献。


社区贡献包括在邮件列表帮助回答用户的问题、验证候选发布版本、发表演讲、组织社区活动以及通过其他形式推广和建设社区。“Apache 之道”重点关注项目社区，即使从未贡献过一行代码，只要被公认为对社区做出了杰出的贡献，你就可以成为一名 committer。


代码/技术贡献包括贡献 pull request（打补丁）、讨论设计、代码审查、测试以及定位和修复 bug。有建设性和高质量的设计讨论以及帮助其他贡献者是两个尤其重要的指标。

前面几点给出了有望成为候选人的方法，以下是 committer 候选人的“必备条件”：

- 具备社区意识： 候选人要理解社区管理的精英原则。他们并不总是尽可能地提升个人贡献，而是积极帮助和授权他人做出有意义的贡献。

- 我们相信 committer 候选人会负责任地使用他们对代码仓库的写入访问权限，在没有把握的时候他们会保守地使用该权限。Flink 是一个庞大的系统，committer 必须清楚哪些是自己知道的哪些是自己不知道的。如果遇到疑问，committer 应该寻求帮助，而不是提交他们不太熟悉的部分。（即使是经验最丰富的 committer 也要遵循这个约定。）

- 他们表现出对其他社区成员的尊重并建设性地参与话题讨论。


#### 我们寻找什么样的 PMC 成员

PMC 是项目的官方管控机构。PMC 成员“必须”有能力履行 PMC 的官方职责（认证和培养 committer/PMC 成员）。我们“需要”他们成为对 Flink、技术和社区有远见的人。

并非所有 PMC 成员都需要了解 Flink 发布流程的所有细节（理解要点并知道如何找到信息就可以了）。同样，并非每个 PMC 成员都需要有远见卓识。我们努力建立一个涵盖各方面能力的 PMC，我们了解每个成员具有不同的优势。

理想情况下，我们在活跃的社区成员中寻找候选人，他们能够主动塑造 Flink（技术和社区）未来的方向并且愿意学习官方的工作流程，比如如何创建和验证版本。

PMC 成员也是 committer。候选人如果还不是 committer 则会在加入 PMC 时自动成为 committer。 因此，“我们寻找什么样的 committer” 也同样适用于 PMC。

PMC 成员在项目中拥有很大权力。一个 PMC 成员可以干扰许多决策，能够以多种方式阻碍甚至损害项目。因此，我们必须相信 PMC 候选人头脑冷静、具有建设性、可靠，并且有时能够做到“不同意但执行”。

