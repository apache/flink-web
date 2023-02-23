---
title: Overview
bookCollapseSection: false
weight: 16
---

# How To Contribute

Apache Flink is developed by an open and friendly community. Everybody is cordially welcome to join the community and contribute to Apache Flink. There are several ways to interact with the community and to contribute to Flink including asking questions, filing bug reports, proposing new features, joining discussions on the mailing lists, contributing code or documentation, improving the website, or testing release candidates.


## What do you want to do?
<p>Contributing to Apache Flink goes beyond writing code for the project. Below, we list different opportunities to help the project:</p>


<table class="table table-bordered">
  <thead>
    <tr>
      <th>Area</th>
      <th>Further information</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> Report a Bug</td>
      <td>To report a problem with Flink, open <a href="http://issues.apache.org/jira/browse/FLINK">Flink’s Jira</a>, log in if necessary, and click on the red Create button at the top. <br/>
      Please give detailed information about the problem you encountered and, if possible, add a description that helps to reproduce the problem.</td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-console" aria-hidden="true"></span> Contribute Code</td>
      <td>Read the <a href="{{< relref "how-to-contribute/contribute-code" >}}">Code Contribution Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Help With Code Reviews</td>
      <td>Read the <a href="{{< relref "how-to-contribute/reviewing-prs" >}}">Code Review Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> Help Preparing a Release</td>
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
      <td><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Contribute Documentation</td>
      <td>Read the <a href="{{< relref "how-to-contribute/contribute-documentation" >}}">Documentation Contribution Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Support Flink Users</td>
      <td>
        <ul class="contribute-card-list">
          <li>Reply to questions on the <a href="{{< relref "community" >}}#mailing-lists">user mailing list</a></li>
          <li>Reply to Flink related questions on <a href="https://stackoverflow.com/questions/tagged/apache-flink">Stack Overflow</a> with the <a href="https://stackoverflow.com/questions/tagged/apache-flink"><code style="background-color: #cee0ed; border-color: #cee0ed;">apache-flink</code></a>, <a href="https://stackoverflow.com/questions/tagged/flink-streaming"><code style="background-color: #cee0ed; border-color: #cee0ed;">flink-streaming</code></a> or <a href="https://stackoverflow.com/questions/tagged/flink-sql"><code style="background-color: #cee0ed; border-color: #cee0ed;">flink-sql</code></a> tag</li>
          <li>Check the latest issues in <a href="http://issues.apache.org/jira/browse/FLINK">Jira</a> for tickets which are actually user questions</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-blackboard" aria-hidden="true"></span> Improve The Website</td>
      <td>Read the <a href="{{< relref "how-to-contribute/improve-website" >}}">Website Contribution Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span> Spread the Word About Flink</td>
      <td>
        <ul class="contribute-card-list">
        <li>Organize or attend a <a href="https://www.meetup.com/topics/apache-flink/">Flink Meetup</a></li>
        <li>Contribute to the <a href="{{< relref "posts" >}}">Flink blog</a></li>
        <li>Share your conference, meetup or blog post on the <a href="{{< relref "community" >}}#mailing-lists">community@flink.apache.org mailing list</a>, or tweet about it, tagging the <a href="https://twitter.com/ApacheFlink">@ApacheFlink</a> handle.</li>
      </ul>
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> Any other question? Reach out to the <a href="{{< relref "community" >}}#mailing-lists">dev@flink.apache.org mailing list</a> to get help!
      </td>
    </tr>
  </tbody>
</table>



## Further reading


#### How to become a committer

Committers are community members that have write access to the project's repositories, i.e., they can modify the code, documentation, and website by themselves and also accept other contributions.

There is no strict protocol for becoming a committer or PMC member. Candidates for new committers are typically people that are active contributors and community members.

Candidates for new committers are suggested by current committers or PMC members, and voted upon by the PMC.

If you would like to become a committer, you should engage with the community and start contributing to Apache Flink in any of the above ways. You might also want to talk to other committers and ask for their advice and guidance.

#### What are we looking for in Committers

Being a committer means being recognized as a significant contributor to the project (community or technology), and having the tools to help with the development. Committer candidates are community members who have made good contributions over an extended period of time and want to continue their contributions.

Community contributions include helping to answer user questions on the mailing list, verifying release candidates, giving talks, organizing community events, and other forms of evangelism and community building. The "Apache Way" has a strong focus on the project community, and committers can be recognized for outstanding community contributions even without any code contributions.

Code/technology contributions include contributed pull requests (patches), design discussions, reviews, testing, and other help in identifying and fixing bugs. Especially constructive and high quality design discussions, as well as helping other contributors, are strong indicators.

While the prior points give ways to identify promising candidates, the following are "must haves" for any committer candidate:

- Being community minded: The candidate understands the meritocratic principles of community management. They do not always optimize for as much as possible personal contribution, but will help and empower others where it makes sense.

- We trust that a committer candidate will use their write access to the repositories responsibly, and if in doubt, conservatively. Flink is a big system, and it is important that committers are aware of what they know and what they don't know. In doubt, committers should ask for a second pair of eyes rather than commit to parts that they are not well familiar with. (Even the most seasoned committers follow this practice.)

- They have shown to be respectful towards other community members and constructive in discussions.


#### What are we looking for in PMC members

The PMC is the official controlling body of the project. PMC members "must" be able to perform the official responsibilities of the PMC (verify releases and growth of committers/PMC). We "want" them to be people that have a vision for Flink, technology and community wise.

For the avoidance of doubt, not every PMC member needs to know all details of how exactly Flink's release process works (it is okay to understand the gist and how to find the details). Likewise, not every PMC member needs to be a visionary. We strive to build a PMC that covers all parts well, understanding that each member brings different strengths.

Ideally, we find candidates among active community members that have shown initiative to shape the direction of Flink (technology and community) and have shown willingness to learn the official processes, such as how to create or verify for releases.

A PMC member is also a committer. Candidates are already committers or will automatically become also a committer when joining the PMC. Hence, the "What are we looking for in committers?" also applies to PMC candidates.

A PMC member has a lot of power in a project. A single PMC member can block many decisions and generally stall and harm the project in many ways. We hence must trust the PMC candidates to be level-headed, constructive, supportive, and willing to "disagree and commit" at times.

