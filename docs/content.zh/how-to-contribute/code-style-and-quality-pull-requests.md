---
title: Code Style and Quality Guide — Pull Requests & Changes
bookCollapseSection: false
bookHidden: true
---

# Code Style and Quality Guide — Pull Requests & Changes

#### [序言]({{< relref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< relref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [常用编码指南]({{< relref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java 语言指南]({{< relref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala 语言指南]({{< relref "how-to-contribute/code-style-and-quality-scala" >}})
#### [组件指南]({{< relref "how-to-contribute/code-style-and-quality-components" >}})
#### [格式指南]({{< relref "how-to-contribute/code-style-and-quality-formatting" >}})

<hr>

**Rationale:** We ask contributors to put in a little bit of extra effort to bring pull requests into a state that they can be more easily and more thoroughly reviewed. This helps the community in many ways:

* Reviews are much faster and thus contributions get merged sooner.
* We can ensure higher code quality by overlooking fewer issues in the contributions.
* Committers can review more contributions in the same time, which helps to keep up with the high rate of contributions that Flink is experiencing

Please understand that contributions that do not follow this guide will take longer to review and thus will typically be picked up with lower priority by the community. That is not ill intend, it is due to the added complexity of reviewing unstructured Pull Requests.


## 1. JIRA issue and Naming

Make sure that the pull request corresponds to a [JIRA issue](https://issues.apache.org/jira/projects/FLINK/issues).

Exceptions are ****hotfixes****, like fixing typos in JavaDocs or documentation files.


Name the pull request in the form `[FLINK-XXXX][component] Title of the pull request`, where `FLINK-XXXX` should be replaced by the actual issue number. The components should be the same as used in the JIRA issue.

Hotfixes should be named for example `[hotfix][docs] Fix typo in event time introduction` or `[hotfix][javadocs] Expand JavaDoc for PuncuatedWatermarkGenerator`.


## 2. Description

Please fill out the pull request template to describe the contribution. Please describe it such that the reviewer understands the problem and solution from the description, not only from the code.

A stellar example of a well-described pull request is [https://github.com/apache/flink/pull/7264](https://github.com/apache/flink/pull/7264)

Make sure that the description is adequate for the problem solved by PR. Small changes do not need a wall of text. In ideal cases, the problem was described in the Jira issue and the description be mostly copied from there.

If additional open questions / issues were discovered during the implementation and you made a choice regarding those, describe them in the pull request text so that reviewers can double check the assumptions. And example is in [https://github.com/apache/flink/pull/8290](https://github.com/apache/flink/pull/8290) (Section “Open Architecture Questions”).


## 3. Separate Refactoring, Cleanup and Independent Changes

****NOTE: This is not an optimization, this is a critical requirement.****

Pull Requests must put cleanup, refactoring, and core changes into separate commits. That way, the reviewer can look independently at the cleanup and refactoring and ensure that those changes to not alter the behavior. Then the reviewer can look at the core changes in isolation (without the noise of other changes) and ensure that this is a clean and robust change.

Examples for changes that strictly need to go into a separate commit include

* Cleanup, fixing style and warnings in pre-existing code
* Renaming packages, classes, or methods
* Moving code (to other packages or classes)
* Refactoring structure or changing design patterns
* Consolidating related tests or utilities
* Changing the assumptions in existing tests (add a commit message that describes why the changed assumptions make sense).

There should be no cleanup commits that fix issues that have been introduced in previous commits of the same PR. Commits should be clean in themselves.

In addition, any larger contributions should split the changes into a set of independent changes that can be independently reviewed.

Two great examples of splitting issues into separate commits are:

* [https://github.com/apache/flink/pull/6692](https://github.com/apache/flink/pull/6692) (splits cleanup and refactoring from main changes)
* [https://github.com/apache/flink/pull/7264](https://github.com/apache/flink/pull/7264) (splits also main changes into independently reviewable pieces)

If a pull request does still contain big commits (e.g. a commit with more than 1000 changed lines), it might be worth thinking about how to split the commit into multiple subproblems, as in the example above.


## 4. Commit Naming Conventions

Commit messages should follow a similar pattern as the pull request as a whole:
`[FLINK-XXXX][component] Commit description`.

In some cases, the issue might be a subtask here, and the component may be different from the Pull Request’s main component. For example, when the commit introduces an end-to-end test for a runtime change, the PR would be tagged as `[runtime]`, but the individual commit would be tagged as `[e2e]`.

Examples for commit messages:

* `[hotfix] Fix update_branch_version.sh to allow version suffixes`
* `[hotfix] [table] Remove unused geometry dependency`
* `[FLINK-11704][tests] Improve AbstractCheckpointStateOutputStreamTestBase`
* `[FLINK-10569][runtime] Remove Instance usage in ExecutionVertexCancelTest`
* `[FLINK-11702][table-planner-blink] Introduce a new table type system`


## 5. Changes to the observable behavior of the system

Contributors should be aware of changes in their PRs that break the observable behavior of Flink in any way because in many cases such changes can break existing setups. Red flags that should raise questions while coding or in reviews with respect to this problem are for example:

* Assertions have been changed to make tests pass again with the breaking change.
* Configuration setting that must suddenly be set to (non-default) values to keep existing tests passing. This can happen in particular for new settings with a breaking default.
* Existing scripts or configurations have to be adjusted.
