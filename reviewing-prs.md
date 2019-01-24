---
title:  "How to Review a Pull Request"
---

<hr />

This guide is for all committers and contributors that want to help with reviewing code contributions. Thank you for your effort - good reviews are one the most important and crucial parts of an open source project. This guide should help the community to make reviews such that:

* Contributors have a good contribution experience.
* Our reviews are structured and check all important aspects of a contribution.
* We make sure to keep a high code quality in Flink.
* We avoid situations where contributors and reviewers spend a lot of time refining a contribution that gets rejected later.

----

{% toc %}

## Review Checklist

Every review needs to check the following five aspects. We encourage to check these aspects in order, to avoid spending time on detailed code quality reviews when there is no consensus yet whether a feature or change should actually be added.

### 1. Is the Contribution Well-Described?

Check whether the contribution is sufficiently well-described to support a good review. Trivial changes and fixes do not need a long description. Any pull request that changes functionality or behavior needs to describe the big picture of these changes, so that reviews know what to look for (and don’t have to dig through the code to hopefully understand what the change does).

Changes that require longer descriptions are ideally based on a prior design discussion in the mailing list or in Jira and can simply link to there or copy the description from there. 

**A contribution is well-described if the following questions 2, 3, and 4 can be answered without looking at the code.**

-----

### 2. Is There Consensus that the Change or Feature Should Go into Flink?

For bug fixes, this needs to be checked only in case it requires bigger changes or might break existing programs and setups.

Ideally, this question can be directly answered from a Jira issue or a dev-list discussion, except in cases of bug fixes and small lightweight additions/extensions. In that case, this question can be immediately marked as resolved. For pull requests that are created without prior consensus, this question needs to be answered as part of the review.

The decision whether the change should go into Flink needs to take the following aspects into consideration:

* Does the contribution alter the behavior of features or components in a way that it may break previous users’ programs and setups? If yes, there needs to be a discussion and agreement that this change is desirable.
* Does the contribution conceptually fit well into Flink? Is it too much of a special case such that it makes things more complicated for the common case, or bloats the abstractions / APIs?
* Does the feature fit well into Flink's architecture? Will it scale and keep Flink flexible for the future, or will the feature restrict Flink in the future?
* Is the feature a significant new addition (rather than an improvement to an existing part)? If yes, will the Flink community commit to maintaining this feature?
* Does the feature produce added value for Flink users or developers? Or does it introduce the risk of regression without adding relevant user or developer benefit?
* Could the contribution live in another repository, e.g., [Apache Bahir](https://bahir.apache.org) or another external repository?

All of these questions should be answerable from the description/discussion in Jira and Pull Request, without looking at the code.

**A feature, improvement, or bug fix is approved once one committer accepts it and no committer disagrees (lazy consensus).** 

In case of diverging opinions, the discussion should be moved to the respective Jira issue or to the dev mailing list and continued until consensus is reached. If the change is proposed by a committer, it is best-practice to seek the approval of another committer. 

-----

### 3. Does the Contribution Need Attention from some Specific Committers and Is There Time Commitment from These Committers?

Some changes require attention and approval from specific committers. For example, changes in parts that are either very performance sensitive, or have a critical impact on distributed coordination and fault tolerance need input by a committer that is deeply familiar with the component.

As a rule of thumb, special attention is required when the Pull Request description answers one of the questions in the template section “Does this pull request potentially affect one of the following parts” with ‘yes’.

This question can be answered with

* *Does not need specific attention*
* *Needs specific attention for X (X can be for example checkpointing, jobmanager, etc.).*
* *Has specific attention for X by @commiterA, @contributorB*

**If the pull request needs specific attention, one of the tagged committers/contributors should give the final approval.**

----

### 4. Does the Implementation Follow the Right Overall Approach/Architecture?

Is this the best approach to implement the fix or feature, or are there other approaches that would be easier, more robust, or more maintainable?
This question should be answerable from the Pull Request description (or the linked Jira) as much as possible.

We recommend to check this before diving into the details of commenting on individual parts of the change.

----

### 5. Is the Overall Code Quality Good, Meeting Standard we Want to Maintain in Flink?

This is the detailed code review of the actual changes, covering:

* Are the changes doing what is described in the design document or PR description?
* Does the code follow the right software engineering practices? Is the code correct, robust, maintainable, testable?
* Are the changes performance aware, when changing a performance sensitive part?
* Are the changes sufficiently covered by tests?
* Are the tests executing fast, i.e., are heavy-weight integration tests only used when necessary?
* Does the code format follow Flink’s checkstyle pattern?
* Does the code avoid to introduce additional compiler warnings?

Some code style guidelines can be found in the [Flink Code Style Page]({{ site.baseurl }}/contribute-code.html#code-style)

## Review with the @flinkbot

The Flink community is using a service called [@flinkbot](https://github.com/flinkbot) to help with the review of the pull requests.

The bot automatically posts a comment tracking the review progress for each new pull request:

```
### Review Progress <!-- NOTE: DO NOT REMOVE THIS SECTION! -->

* [ ] 1. The contribution is well-described.
* [ ] 2. There is consensus that the contribution should go into to Flink.
* [ ] 3. [Does not need specific attention | Needs specific attention for X | Has attention for X by Y]
* [ ] 4. The architectural approach is sound.
* [ ] 5. Overall code quality is good.

Please see the [Pull Request Review Guide](https://flink.apache.org/reviewing-prs.html) if you have questions about the review process.
```

Reviewers can instruct the bot to tick off the boxes (in order) to indicate the progress of the review.

For approving the description of the contribution, mention the bot with `@flinkbot approve contribution`. This works similarly with `consensus`, `architecture` and `quality`.

For approving all aspects, put a new comment with `@flinkbot approve all` into the pull request.

The syntax for requiring attention is `@flinkbot attention @username1 [@username2 ..]`.


