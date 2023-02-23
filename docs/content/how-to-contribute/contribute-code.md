---
title: Contribute Code
bookCollapseSection: false
weight: 17
---

# Contributing Code

Apache Flink is maintained, improved, and extended by code contributions of volunteers. We welcome contributions to Flink, but due to the size of the project and to preserve the high quality of the code base, we follow a contribution process that is explained in this document.

**Please feel free to ask questions at any time.** Either send a mail to the [Dev mailing list]({{< relref "community" >}}#mailing-lists) or comment on the Jira issue you are working on.

**IMPORTANT**: Please read this document carefully before starting to work on a code contribution. Follow the process and guidelines explained below. Contributing to Apache Flink does not start with opening a pull request. We expect contributors to reach out to us first to discuss the overall approach together. Without consensus with the Flink committers, contributions might require substantial rework or will not be reviewed.

## Looking for what to contribute

If you have a good idea for the contribution, you can proceed to [the code contribution process](#code-contribution-process).
If you are looking for what you could contribute, you can browse open Jira issues in [Flink's bug tracker](https://issues.apache.org/jira/projects/FLINK/issues),
which are not assigned, and then follow [the code contribution process](#code-contribution-process). If you are very new
to the Flink project and want to learn about it and its contribution process, you can check
[the starter issues](https://issues.apache.org/jira/issues/?filter=12349196), which are annotated with a _starter_ label.

## Code Contribution Process

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
    <b>Note:</b> The code contribution process has changed recently (June 2019). The community <a href="https://lists.apache.org/thread.html/1e2b85d0095331606ad0411ca028f061382af08138776146589914f8@%3Cdev.flink.apache.org%3E">decided</a> to shift the "backpressure" from pull requests to Jira, by requiring contributors to get consensus (indicated by being assigned to the ticket) before opening a pull request.
</div>


<div class="contribute-grid">
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">1</span><a href="#consensus">Discuss</a></h2>
        <p>Create a Jira ticket or mailing list discussion and reach consensus</p>
        <p>Agree on importance, relevance, scope of the ticket, discuss the implementation approach and find a committer willing to review and merge the change.</p>
        <p><b>Only committers can assign a Jira ticket.</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">2</span><a href="#implement">Implement</a></h2>
        <p>Implement the change according to the <a href="{{< relref "how-to-contribute/contribute-code" >}}">Code Style and Quality Guide</a> and the approach agreed upon in the Jira ticket.</p> <br />
        <p><b>Only start working on the implementation if there is consensus on the approach (e.g. you are assigned to the ticket)</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">3</span><a href="#review">Review</a></h2>
        <p>Open a pull request and work with the reviewer.</p>
        <p><b>Pull requests belonging to unassigned Jira tickets or not authored by assignee will not be reviewed or merged by the community.</b></p>
      </div>
    </div>
  </div>
  <div class="column">
    <div class="panel panel-default">
      <div class="panel-body">
        <h2><span class="number">4</span><a href="#merge">Merge</a></h2>
        <p>A committer of Flink checks if the contribution fulfills the requirements and merges the code to the codebase.</p>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-sm-12">
    <div class="panel panel-default">
      <div class="panel-body">
        Note: <i>trivial</i> hot fixes such as typos or syntax errors can be opened as a <code>[hotfix]</code> pull request, without a Jira ticket.
      </div>
    </div>
  </div>
</div>



<a name="consensus"></a>

### 1. Create Jira Ticket and Reach Consensus


The first step for making a contribution to Apache Flink is to reach consensus with the Flink community. This means agreeing on the scope and implementation approach of a change.

In most cases, the discussion should happen in [Flink's bug tracker: Jira](https://issues.apache.org/jira/projects/FLINK/issues).

The following types of changes require a `[DISCUSS]` thread on the [Flink Dev mailing list]({{< relref "community" >}}#mailing-lists):

- big changes (major new feature; big refactorings, involving multiple components)
- potentially controversial changes or issues
- changes with very unclear approaches or multiple equal approaches

Do not open a Jira ticket for these types of changes before the discussion has come to a conclusion.
Jira tickets based on a dev@ discussion need to link to that discussion and should summarize the outcome.



**Requirements for a Jira ticket to get consensus:**

- Formal requirements
    - The *Title* describes the problem concisely.
    - The *Description* gives all the details needed to understand the problem or feature request.
    - The *Component* field is set: Many committers and contributors only focus on certain subsystems of Flink. Setting the appropriate component is important for getting their attention.
- There is **agreement** that the ticket solves a valid problem, and that it is a **good fit** for Flink.
  The Flink community considers the following aspects:
    - Does the contribution alter the behavior of features or components in a way that it may break previous users’ programs and setups? If yes, there needs to be a discussion and agreement that this change is desirable.
    - Does the contribution conceptually fit well into Flink? Is it too much of a special case such that it makes things more complicated for the common case, or bloats the abstractions / APIs?
    - Does the feature fit well into Flink’s architecture? Will it scale and keep Flink flexible for the future, or will the feature restrict Flink in the future?
    - Is the feature a significant new addition (rather than an improvement to an existing part)? If yes, will the Flink community commit to maintaining this feature?
    - Does this feature align well with Flink's roadmap and currently ongoing efforts?
    - Does the feature produce added value for Flink users or developers? Or does it introduce the risk of regression without adding relevant user or developer benefit?
    - Could the contribution live in another repository, e.g., Apache Bahir or another external repository?
    - Is this a contribution just for the sake of getting a commit in an open source project (fixing typos, style changes merely for taste reasons)
- There is **consensus** on how to solve the problem. This includes considerations such as
    - API and data backwards compatibility and migration strategies
    - Testing strategies
    - Impact on Flink's build time
    - Dependencies and their licenses

If a change is identified as a large or controversial change in the discussion on Jira, it might require a [Flink Improvement Proposal (FLIP)](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals) or a discussion on the [Dev mailing list]({{< relref "community" >}}#mailing-lists) to reach agreement and consensus.

Contributors can expect to get a first reaction from a committer within a few days after opening the ticket. If a ticket doesn't get any attention, we recommend reaching out to the [developer mailing list]({{< relref "community" >}}#mailing-lists). Note that the Flink community sometimes does not have the capacity to accept all incoming contributions.


Once all requirements for the ticket are met, a committer will assign somebody to the *`Assignee`* field of the ticket to work on it.
Only committers have the permission to assign somebody.

**Pull requests belonging to unassigned Jira tickets will not be reviewed or merged by the community**.


<a name="implement"></a>

### 2. Implement your change

Once you've been assigned to a Jira issue, you may start to implement the required changes.

Here are some further points to keep in mind while implementing:

- [Set up a Flink development environment](https://cwiki.apache.org/confluence/display/FLINK/Setting+up+a+Flink+development+environment)
- Follow the [Code Style and Quality Guide]({{< relref "how-to-contribute/contribute-code" >}}) of Flink
- Take any discussions and requirements from the Jira issue or design document into account.
- Do not mix unrelated issues into one contribution.


<a name="review"></a>

### 3. Open a Pull Request

Considerations before opening a pull request:

- Make sure that **`mvn clean verify`** is passing on your changes to ensure that all checks pass, the code builds and that all tests pass.
- Execute the [End to End tests of Flink](https://github.com/apache/flink/tree/master/flink-end-to-end-tests#running-tests).
- Make sure no unrelated or unnecessary reformatting changes are included.
- Make sure your commit history adheres to the requirements.
- Make sure your change has been rebased to the latest commits in your base branch.
- Make sure the pull request refers to the respective Jira, and that each Jira issue is assigned to exactly one pull request (in case of multiple pull requests for one Jira; resolve that situation first)

Considerations before or right after opening a pull request:

- Make sure that the branch is building successfully on [Azure DevOps](https://dev.azure.com/apache-flink/apache-flink/_build?definitionId=2).

Code changes in Flink are reviewed and accepted through [GitHub pull requests](https://help.github.com/en/articles/creating-a-pull-request).

There is a separate guide on [how to review a pull request]({{< relref "how-to-contribute/reviewing-prs" >}}), including our pull request review process. As a code author, you should prepare your pull request to meet all requirements.

<a name="merge"></a>

### 4. Merge change

The code will be merged by a committer of Flink once the review is finished. The Jira ticket will be closed afterwards.

