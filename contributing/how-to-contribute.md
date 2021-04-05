---
title: "How To Contribute"
---

<hr />

Apache Flink is developed by an open and friendly community. Everybody is cordially welcome to join the community and contribute to Apache Flink. There are several ways to interact with the community and to contribute to Flink including asking questions, filing bug reports, proposing new features, joining discussions on the mailing lists, contributing code or documentation, improving the website, or testing release candidates.


<h1>What do you want to do?</h1>
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
      <td><span class="glyphicon glyphicon-console" aria-hidden="true"></span> Contribute Code</td>
      <td>Read the <a href="{{ site.baseurl }}/contributing/contribute-code.html">Code Contribution Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Help With Code Reviews</td>
      <td>Read the <a href="{{ site.baseurl }}/contributing/reviewing-prs.html">Code Review Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span> Review a Release Candidate</td>
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
      <td>Read the <a href="{{ site.baseurl }}/contributing/contribute-documentation.html">Documentation Contribution Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Support Flink Users</td>
      <td>
        <ul class="contribute-card-list">
          <li>Reply to questions on the <a href="https://flink.apache.org/community.html#mailing-lists">user mailing list</a></li>
          <li>Reply to Flink related questions on <a href="https://stackoverflow.com/questions/tagged/apache-flink">Stack Overflow</a> with  the <a href="https://stackoverflow.com/questions/tagged/apache-flink"><code style="background-color: #cee0ed; border-color: #cee0ed;">apache-flink</code></a> tag</li>
          <li>Check the latest issues in <a href="https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20ORDER%20BY%20created%20DESC%2C%20priority%20DESC%2C%20updated%20DESC">Jira</a> for tickets which are actually user questions</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-blackboard" aria-hidden="true"></span> Contribute To The Website</td>
      <td>Read the <a href="{{ site.baseurl }}/contributing/improve-website.html">Website Contribution Guide</a></td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span> Contribute Evangelism</td>
      <td>
        <ul class="contribute-card-list">
        <li>Organize or attend a <a href="https://www.meetup.com/topics/apache-flink/">Flink Meetup</a></li>
        <li>Contribute to the <a href="https://flink.apache.org/blog/">Flink blog</a></li>
        <li>Submit a talk to conference. <a href="https://flink.apache.org/community.html#mailing-lists">Contact the community@flink.apache.org mailing list</a> to learn about relevant conferences near you.</li>
      </ul>
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> Any other question? Reach out to the <a href="https://flink.apache.org/community.html#mailing-lists">dev@flink.apache.org mailing list</a> to get help!
      </td>
    </tr>
  </tbody>
</table>


-----

## Propose an improvement or a new feature

Our community is constantly looking for feedback to improve Apache Flink. If you have an idea how to improve Flink or have a new feature in mind that would be beneficial for Flink users, please open an issue in [Flink's Jira](http://issues.apache.org/jira/browse/FLINK). The improvement or new feature should be described in appropriate detail and include the scope and its requirements if possible. Detailed information is important for a few reasons:

- It ensures your requirements are met when the improvement or feature is implemented.
- It helps to estimate the effort and to design a solution that addresses your needs.
- It allow for constructive discussions that might arise around this issue.

Detailed information is also required, if you plan to contribute the improvement or feature you proposed yourself. Please read the [Contribute code]({{ site.base }}/contributing/contribute-code.html) guide in this case as well.


We recommend to first reach consensus with the community on whether a new feature is required and how to implement a new feature, before starting with the implementation. Some features might be out of scope of the project, and it's best to discover this early.

For very big features that change Flink in a fundamental way we have another process in place:
[Flink Improvement Proposals](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals). If you are interested you can propose a new feature there or follow the
discussions on existing proposals.


-----

## Submit a Contributor License Agreement

Please submit a contributor license agreement to the Apache Software Foundation (ASF) if you are contributing a lot of code to Apache Flink. The following quote from [http://www.apache.org/licenses](http://www.apache.org/licenses/#clas) gives more information about the ICLA and CCLA and why they are necessary.

> The ASF desires that all contributors of ideas, code, or documentation to the Apache projects complete, sign, and submit (via postal mail, fax or email) an [Individual Contributor License Agreement](http://www.apache.org/licenses/icla.txt) (CLA) [ [PDF form](http://www.apache.org/licenses/icla.pdf) ]. The purpose of this agreement is to clearly define the terms under which intellectual property has been contributed to the ASF and thereby allow us to defend the project should there be a legal dispute regarding the software at some future time. A signed CLA is required to be on file before an individual is given commit rights to an ASF project.
>
> For a corporation that has assigned employees to work on an Apache project, a [Corporate CLA](http://www.apache.org/licenses/cla-corporate.txt) (CCLA) is available for contributing intellectual property via the corporation, that may have been assigned as part of an employment agreement. Note that a Corporate CLA does not remove the need for every developer to sign their own CLA as an individual, to cover any of their contributions which are not owned by the corporation signing the CCLA.
>
>  ...

-----

## Becoming a Flink Committer and PMC member

### How to become a committer

Committers are community members that have write access to the project's repositories, i.e., they can modify the code, documentation, and website by themselves and also accept other contributions.

There is no strict protocol for becoming a committer or PMC member. Candidates for new committers are typically people that are active contributors and community members.

Candidates for new committers are suggested by current committers or PMC members, and voted upon by the PMC.

If you would like to become a committer, you should engage with the community and start contributing to Apache Flink in any of the above ways. You might also want to talk to other committers and ask for their advice and guidance.

### What are we looking for in Committers

Being a committer means being recognized as a significant contributor to the project (community or technology), and having the tools to help with the development. Committer candidates are community members who have made good contributions over an extended period of time and want to continue their contributions.

Community contributions include helping to answer user questions on the mailing list, verifying release candidates, giving talks, organizing community events, and other forms of evangelism and community building. The "Apache Way" has a strong focus on the project community, and committers can be recognized for outstanding community contributions even without any code contributions.

Code/technology contributions include contributed pull requests (patches), design discussions, reviews, testing, and other help in identifying and fixing bugs. Especially constructive and high quality design discussions, as well as helping other contributors, are strong indicators.

While the prior points give ways to identify promising candidates, the following are "must haves" for any committer candidate:

  - Being community minded: The candidate understands the meritocratic principles of community management. They do not always optimize for as much as possible personal contribution, but will help and empower others where it makes sense.

  - We trust that a committer candidate will use their write access to the repositories responsibly, an if in doubt, conservatively. Flink is a big system, and it is important that committers are aware of what they know and what they don't know. In doubt, committers should ask for a second pair of eyes rather than commit to parts that they are not well familiar with. (Even the most seasoned committers follow this practice.)
  
  - They have shown to be respectful towards other community members and constructive in discussions.


### What are we looking for in PMC members

The PMC is the official controlling body of the project. PMC members "must" be able to perform the official responsibilities of the PMC (verify releases and growth of committers/PMC). We "want" them to be people that have a vision for Flink, technology and community wise.

For the avoidance of doubt, not every PMC member needs to know all details of how exactly Flink's release process works (it is okay to understand the gist and how to find the details). Likewise, not every PMC member needs to be a visionary. We strive to build a PMC that covers all parts well, understanding that each member brings different strengths.

Ideally, we find candidates among active community members that have shown initiative to shape the direction of Flink (technology and community) and have shown willingness to learn the official processes, such as how to create or verify for releases.

A PMC member is also a committer. Candidates are already committers or will automatically become also a committer when joining the PMC. Hence, the "What are we looking for in committers?" also applies to PMC candidates.

A PMC member has a lot of power in a project. A single PMC member can block many decisions and generally stall and harm the project in many ways. We hence must trust the PMC candidates to be level-headed, constructive, supportive, and willing to "disagree and commit" at times.

