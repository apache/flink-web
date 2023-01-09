---
title: Review Pull Requests
bookCollapseSection: false
weight: 18
---

# How to Review a Pull Request

This guide is for all committers and contributors that want to help with reviewing code contributions. Thank you for your effort - good reviews are one of the most important and crucial parts of an open source project. This guide should help the community to make reviews such that:

* Contributors have a good contribution experience.
* Our reviews are structured and check all important aspects of a contribution.
* We make sure to keep a high code quality in Flink.
* We avoid situations where contributors and reviewers spend a lot of time refining a contribution that gets rejected later.

## Review Checklist

Every review needs to check the following six aspects. **We encourage to check these aspects in order, to avoid spending time on detailed code quality reviews when formal requirements are not met or there is no consensus in the community to accept the change.**

### 1. Is the Contribution Well-Described?

Check whether the contribution is sufficiently well-described to support a good review. Trivial changes and fixes do not need a long description. If the implementation is exactly [according to a prior discussion on Jira or the development mainling list]({{< ref "docs/how-to-contribute/contribute-code" >}}#consensus), only a short reference to that discussion is needed.
If the implementation is different from the agreed approach in the consensus discussion, a detailed description of the implementation is required for any further review of the contribution.

Any pull request that changes functionality or behavior needs to describe the big picture of these changes, so that reviews know what to look for (and don’t have to dig through the code to hopefully understand what the change does).


**A contribution is well-described if the following questions 2, 3, and 4 can be answered without looking at the code.**

-----

### 2. Is There Consensus that the Change or Feature Should Go into Flink?

This question can be directly answered from the linked Jira issue. For pull requests that are created without prior consensus, a [discussion in Jira to seek consensus]({{< ref "docs/how-to-contribute/contribute-code" >}}) will be needed.


For `[hotfix]` pull requests, consensus needs to be checked in the pull request.


-----

### 3. Does the Contribution Need Attention from some Specific Committers and Is There Time Commitment from These Committers?

Some changes require attention and approval from specific committers. For example, changes in parts that are either very performance sensitive, or have a critical impact on distributed coordination and fault tolerance need input by a committer that is deeply familiar with the component.

As a rule of thumb, special attention is required when the Pull Request description answers one of the questions in the template section “Does this pull request potentially affect one of the following parts” with ‘yes’.

This question can be answered with

* *Does not need specific attention*
* *Needs specific attention for X (X can be for example checkpointing, jobmanager, etc.).*
* *Has specific attention for X by @committerA, @contributorB*

**If the pull request needs specific attention, one of the tagged committers/contributors should give the final approval.**

----

### 4. Does the Implementation Follow the Agreed Upon Overall Approach/Architecture?

In this step, we check if a contribution folllows the agreed upon approach from the previous discussion in Jira or the mailing lists.

This question should be answerable from the Pull Request description (or the linked Jira) as much as possible.

We recommend to check this before diving into the details of commenting on individual parts of the change.

----

### 5. Is the Overall Code Quality Good, Meeting Standard we Want to Maintain in Flink?

This is the detailed code review of the actual changes, covering:

* Are the changes doing what is described in the Jira ticket or design document?
* Does the code follow the right software engineering practices? Is the code correct, robust, maintainable, testable?
* Are the changes performance aware, when changing a performance sensitive part?
* Are the changes sufficiently covered by tests?
* Are the tests executing fast, i.e., are heavy-weight integration tests only used when necessary?
* Does the code format follow Flink’s checkstyle pattern?
* Does the code avoid to introduce additional compiler warnings?
* If dependencies have been changed, were the NOTICE files updated?

Code guidelines can be found in the [Flink Code Style and Quality Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-preamble" >}}).

----

### 6. Are the English and Chinese documentation updated?

If the pull request introduces a new feature, the feature should be documented. The Flink community is maintaining both an English and a Chinese documentation. So both documentations should be updated. If you are not familiar with the Chinese language, please open a Jira assigned to the `chinese-translation` component for Chinese documentation translation and link it with current Jira issue. If you are familiar with Chinese language, you are encouraged to update both sides in one pull request.

See more about how to [contribute documentation]({{< ref "docs/how-to-contribute/contribute-documentation" >}}).