---
title: "貢献するには"
---

<hr />

Apache Flink はオープンでフレンドリーなコミュニティによって開発されています。コミュニティに参加してApache Flinkに貢献することは誰でも歓迎します。質問をする、バグレポートを提出する、新機能を提案する、メーリングリストでの議論に参加する、コードやドキュメントを提供する、ウェブサイトを改善する、リリース候補をテストするなど、コミュニティと交流し、Flink に貢献する方法はいくつかあります。


<h1>何がしたいですか？</h1>
<p>Apache Flink への貢献は、プロジェクトのためにコードを書くだけではありません。以下では、プロジェクトを支援するさまざまな機会をリストアップしています。</p>


<table class="table table-bordered">
  <thead>
    <tr>
      <th>領域</th>
      <th>詳細情報</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> バグを報告する</td>
      <td>To report a problem with Flink, open <a href="http://issues.apache.org/jira/browse/FLINK">Flink’s Jira</a>, log in if necessary, and click on the red Create button at the top. <br/>
      Please give detailed information about the problem you encountered and, if possible, add a description that helps to reproduce the problem.</td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-console" aria-hidden="true"></span> コードを投稿する</td>
      <td>Read the <a href="{{ site.baseurl }}/contributing/contribute-code.html">Code Contribution Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> コードレビューを手助けする</td>
      <td>Read the <a href="{{ site.baseurl }}/contributing/reviewing-prs.html">Code Review Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> リリースの準備を支援する</td>
      <td>
        Releasing a new version consists of the following steps:
        <ol>
          <li>Building a new release candidate and starting a vote (usually for 72 hours) on the dev@flink.apache.org list</li>
          <li>Testing the release candidate and voting (+1 if no issues were found, -1 if the release candidate has issues).</li>
          <li>Going back to step 1 if the release candidate had issues. Otherwise we publish the release.</li>
        </ol>
        Read the <a href="https://cwiki.apache.org/confluence/display/FLINK/Releasing">test procedure for a release</a>.
      </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> 文書に貢献する</td>
      <td>Read the <a href="{{ site.baseurl }}/contributing/contribute-documentation.html">Documentation Contribution Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Support Flink Users</td>
      <td>
        <ul class="contribute-card-list">
          <li>Reply to questions on the <a href="https://flink.apache.org/community.html#mailing-lists">user mailing list</a></li>
          <li>Reply to Flink related questions on <a href="https://stackoverflow.com/questions/tagged/apache-flink">Stack Overflow</a> with the <a href="https://stackoverflow.com/questions/tagged/apache-flink"><code style="background-color: #cee0ed; border-color: #cee0ed;">apache-flink</code></a>, <a href="https://stackoverflow.com/questions/tagged/flink-streaming"><code style="background-color: #cee0ed; border-color: #cee0ed;">flink-streaming</code></a> or <a href="https://stackoverflow.com/questions/tagged/flink-sql"><code style="background-color: #cee0ed; border-color: #cee0ed;">flink-sql</code></a> tag</li>
          <li>Check the latest issues in <a href="https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20ORDER%20BY%20created%20DESC%2C%20priority%20DESC%2C%20updated%20DESC">Jira</a> for tickets which are actually user questions</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-blackboard" aria-hidden="true"></span> Improve The Website</td>
      <td>Read the <a href="{{ site.baseurl }}/contributing/improve-website.html">Website Contribution Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span> Spread the Word About Flink</td>
      <td>
        <ul class="contribute-card-list">
        <li>Organize or attend a <a href="https://www.meetup.com/topics/apache-flink/">Flink Meetup</a></li>
        <li>Contribute to the <a href="https://flink.apache.org/blog/">Flink blog</a></li>
        <li>Share your conference, meetup or blog post on the <a href="https://flink.apache.org/community.html#mailing-lists">community@flink.apache.org mailing list</a>, or tweet about it, tagging the <a href="https://twitter.com/ApacheFlink">@ApacheFlink</a> handle.</li>
      </ul>
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> 他に質問はありますか?
        <a href="https://flink.apache.org/community.html#mailing-lists">dev@flink.apache.org メーリングリスト</a> に連絡して助けを得てください!
      </td>
    </tr>
  </tbody>
</table>



## 読み物


#### コミッターになるには

コミッターとは、プロジェクトのリポジトリへの書き込みアクセス権を持つコミュニティメンバーのことで、自分でコードやドキュメント、ウェブサイトを修正したり、他の貢献を受け入れることができます。

コミッターや PMC メンバーになるための厳密なプロトコルはありません。新しいコミッターの候補者は、一般的には積極的な貢献者やコミュニティのメンバーです。

新しいコミッターの候補者は、現在のコミッターまたはPMCのメンバーから提案され、PMCの投票によって決定される。

コミッターになりたいのであれば、コミュニティに参加して、上記の方法で Apache Flink に貢献してください。また、他のコミッターと話をしてアドバイスや指導を求めるのも良いでしょう。

#### コミッターに求めるもの

コミッターになるということは、プロジェクト(コミュニティや技術)に多大な貢献をしていると認められ、開発を支援するツールを持っていることを意味します。コミッター候補者とは、長期間に渡って良い貢献をしてきたコミュニティメンバーであり、その貢献を継続したいと考えている人のことです。

コミュニティへの貢献には、メーリングリストでのユーザからの質問への回答を手伝ったり、 リリース候補の検証をしたり、講演をしたり、コミュニティイベントを企画したり、 その他の形での伝道活動やコミュニティ構築が含まれます。"Apache Way" はプロジェクトのコミュニティに強く焦点を当てており、 コミッターはコードの貢献がなくても優れたコミュニティ貢献をしていると認められることがあります。

コード/技術の貢献には、プルリクエスト(パッチ)、デザインディスカッション、レビュー、テスト、バグの特定と修正のためのその他の支援が含まれます。特に建設的で質の高いデザインディスカッションや、他の貢献者を助けることは、強力な指標となります。

先行するポイントは、有望な候補者を見極める方法を示していますが、以下は、あらゆるコミッター候補者にとっての "マストアイテム "です。

  - Being community minded: 候補者は、コミュニティ運営の実力主義の原則を理解しています。彼らは常に可能な限りの個人的な貢献を最適化するのではなく、理にかなったところで他の人を助け、力を貸します。

  - コミッター候補者が責任を持ってリポジトリへの書き込みアクセスを行い、疑わしい場合は保守的に利用することを信頼しています。Flinkは大きなシステムであり、コミッターが何を知っていて何を知らないのかを認識していることが重要です。疑問がある場合、コミット者は自分がよく知らない部分にコミットするのではなく、第二の目を求めるべきです。(最も経験豊富なコミッターでさえ、この習慣に従っています)。
  
  - 彼らは、他のコミュニティのメンバーに敬意を払い、議論の中で建設的であることを示しています。


#### PMCメンバーに求めるもの

PMCはプロジェクトの公式な管理機関です。PMCのメンバーは、PMCの公式な責任(リリースの確認やコミッターの成長)を果たすことが「できる」人でなければなりません。私たちは彼らにFlinkのビジョンを持ち、技術的にもコミュニティ的にも賢明な人であることを「望んでいます」。

疑念を避けるために、すべてのPMCメンバーがFlinkのリリースプロセスの詳細をすべて知っている必要はありません（要点を理解し、詳細を見つける方法を理解していれば大丈夫です）。同様に、すべてのPMCメンバーが空想家である必要はありません。それぞれのメンバーが異なる強みを持っていることを理解した上で、すべての部分をカバーできるようなPMCを構築することを目指しています。

Flinkの方向性（技術やコミュニティ）を形成するためのイニシアチブを発揮し、リリースに向けての作成方法や検証方法などの公式プロセスを学ぶ意欲のある、活発なコミュニティメンバーの中から候補者を探しています。

PMCメンバーはコミッターでもあります。候補者は既にコミッターであるか、PMCに参加した時点で自動的にコミッターになります。したがって、「コミッターに求めるもの」はPMCの候補者にも適用されます。

PMCメンバーは、プロジェクトにおいて大きな力を持っています。一人のPMCメンバーが多くの決定を妨害したり、一般的にはプロジェクトを様々な形で停滞させたり、害を与えたりすることがあります。したがって、私たちは、PMC候補者が冷静で、建設的で、支持的で、時には「反対してコミットする」ことを厭わないことを信頼しなければなりません。

