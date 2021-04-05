---
title:  "Contributing Code"
---

Apache Flink is maintained, improved, and extended by code contributions of volunteers. We welcome contributions to Flink, but due to the size of the project and to preserve the high quality of the code base, we follow a contribution process that is explained in this document.

**Please feel free to ask questions at any time.** Either send a mail to the [dev mailing list]( {{ site.base }}/community.html#mailing-lists ) or comment on the Jira issue you are working on.

**IMPORTANT**: Please read this document carefully before starting to work on a code contribution. Follow the process and guidelines explained below. Otherwise, your pull request might not be accepted or might require substantial rework. In particular, before opening a pull request that implements a **new feature**, you need to open a Jira ticket and reach consensus with the community on whether this feature is needed.



{% toc %}

## Code Contribution Process

<style>
.process-box {
	border: 1px solid #dee2e6!important;
    border-radius: .5rem!important;
    margin: 2px;
    margin-bottom: 5px;
    padding: 10px;
    width: 24%;
    height: 300px;
}
</style>

<div class="row">
	<div class="col-sm-3 process-box">
	  <h2><a href="#consensus">1. JIRA Ticket: Get Consensus</a></h2>
	  Agree on importance, relevance, scope of the ticket, discuss the implementation approach and find a committer willing to review and merge the change.<br>
	  <b>Only committers can assign a Jira ticket</b>.
	</div>
	<div class="col-sm-3 process-box">
	  <h2><a href="#implement">2. Implement</a></h2>
	  Implement the change according to the <a href="">Code Style and Quality Guide</a> and the approach agreed upon in the JIRA ticket.
	</div>
	<div class="col-sm-3 process-box">
	  <h2><a href="#review">3. Review</a></h2>
	  Open a pull request and work with the reviewer. <br /><br />
	  <b>Pull requests belonging to unassigned Jira tickets will not be reviewed or merged by the community</b> 
	</div>
	<div class="col-sm-3 process-box">
	  <h2><a href="#merge">4. Merge</a></h2>
	  A committer of Flink checks if the contribution fulfills the requirements and merges the code to the codebase.
	</div>
</div>
<div class="row">
	<div class="col-sm-12 process-box" style="height:inherit; width:inherit;">
		Note: <i>trivial</i> hot fixes such as typos or syntax errors can be opened as a <code>[hotfix]</code> pull request, without a JIRA ticket.
	</div>
</div>


<div class="alert alert-warning" role="alert">
    <b>Note:</b> The code contribution process has changed recently (May 2019). The community <a href="https://lists.apache.org/thread.html/1e2b85d0095331606ad0411ca028f061382af08138776146589914f8@%3Cdev.flink.apache.org%3E">decided</a> to shift the "backpressure" from pull requests to Jira, by requiring contributors to get consensus (indicated by being assigned to the ticket) before opening a pull request.
</div>


<a name="consensus"></a>

### 1. Jira Ticket: Get Consensus


The first step for making a contribution to Apache Flink is to reach consensus in [Flink's bug tracker: Jira](https://issues.apache.org/jira/projects/FLINK/summary).
This means agreeing on the scope and implementation approach of a change.

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
    - testing strategies
    - impact on Flink's build time
    - dependencies and their licenses

Large changes might require a [Flink Improvement Proposal (FLIP)](https://cwiki.apache.org/confluence/display/FLINK/Flink+Improvement+Proposals) or a discussion on the [dev mailing list]( {{ site.base }}/community.html#mailing-lists ) to reach agreement or consensus.

Once all requirements for the ticket are met, a committer will assign somebody to the *`Assignee`* field of the ticket to work on it.
Only committers have the permission to assign somebody.

**Pull requests belonging to unassigned Jira tickets will not be reviewed or merged by the community**.


<a name="implement"></a>

### 2. Implement your change

- [Set up a Flink development environment](https://cwiki.apache.org/confluence/display/FLINK/Setting+up+a+Flink+development+environment)
- Follow the [Code Style and Quality Guide]({{ site.base }}/contributing/code-style-and-quality.html) of Flink
- Take any discussions and requirements from the Jira issue or design document into account.
- Do not mix unrelated issues into one contribution.


<a name="review"></a>

### 3. Open a Pull Request

Code changes in Flink are reviewed and accepted through [GitHub pull requests](https://help.github.com/en/articles/creating-a-pull-request).

There is a separate guide on [how to review a pull request]({{ site.base }}/contributing/reviewing-prs.html), including our pull request review process. As a code author, you should prepare your pull request to meet all requirements.

Considerations before opening a pull request:

 - Make sure that **`mvn clean verify`** is passing on your changes to ensure that all checks pass, the code builds and that all tests pass.
 - Execute the [End to End tests of Flink](https://github.com/apache/flink/tree/master/flink-end-to-end-tests#running-tests).
 - Make sure no unrelated or unnecessary reformatting changes are included.
 - Make sure your commit history adheres to the requirements.
 - Make sure your change has been rebased to the latest commits in your base branch.


Considerations before or right after opening a pull request:

 - Make sure that the branch is building successfully on [Travis](https://travis-ci.org/).



<a name="merge"></a>

### 4. Merge change

The code will be merged by a committer of Flink once the review is finished. The Jira ticket will be closed afterwards.

