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

- Follow the [Code Style and Quality Guide]() of Flink
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




-----

## Coding guidelines (OUTDATED)

*Note: These guidelines are outdated and will be updated soon.*

### Pull requests and commit message
{:.no_toc}

- **Single change per PR**. Please do not combine various unrelated changes in a single pull request. Rather, open multiple individual pull requests where each PR refers to a Jira issue. This ensures that pull requests are *topic related*, can be merged more easily, and typically result in topic-specific merge conflicts only.

- **No WIP pull requests**. We consider pull requests as requests to merge the referenced code *as is* into the current *stable* master branch. Therefore, a pull request should not be "work in progress". Open a pull request if you are confident that it can be merged into the current master branch without problems. If you rather want comments on your code, post a link to your working branch.

- **Commit message**. A pull request must relate to a Jira issue; create an issue if none exists for the change you want to make. The latest commit message should reference that issue. An example commit message would be *[FLINK-633] Fix NullPointerException for empty UDF parameters*. That way, the pull request automatically gives a description of what it does, for example, what bug does it fix in what way.

- **Append review commits**. When you get comments on the pull request asking for changes, append commits for these changes. *Do not rebase and squash them.* It allows people to review the cleanup work independently. Otherwise reviewers have to go through the entire set of diffs again.

- **No merge commits**. Please do not open pull requests containing merge commits. Use `git pull --rebase origin master` if you want to update your changes to the latest master prior to opening a pull request.

### Exceptions and error messages
{:.no_toc}

- **Exception swallowing**. Do not swallow exceptions and print the stacktrace. Instead check how exceptions are handled by similar classes.

- **Meaningful error messages**. Give meaningful exception messages. Try to imagine why an exception could be thrown (what a user did wrong) and give a message that will help a user to resolve the problem.

### Tests
{:.no_toc}

- **Tests need to pass**. Any pull request where the tests do not pass or which does not compile will not undergo any further review. We recommend to connect your personal GitHub accounts with [Travis CI](http://travis-ci.org/) (like the Flink GitHub repository). Travis will run tests for all tested environments whenever you push something into *your* GitHub repository. Please note the previous [comment about flaky tests]( {{site.base}}/contribute-code.html#verifying-the-compliance-of-your-code).

- **Tests for new features are required**. All new features need to be backed by tests, *strictly*. It is very easy that a later merge accidentally throws out a feature or breaks it. This will not be caught if the feature is not guarded by tests. Anything not covered by a test is considered cosmetic.

- **Use appropriate test mechanisms**. Please use unit tests to test isolated functionality, such as methods. Unit tests should execute in subseconds and should be preferred whenever possible. The names of unit test classes have to end in `*Test`. Use integration tests to implement long-running tests. Flink offers test utilities for end-to-end tests that start a Flink instance and run a job. These tests are pretty heavy and can significantly increase build time. Hence, they should be added with care. The names of end-to-end test classes have to end in `*ITCase`.

### Documentation
{:.no_toc}

- **Documentation Updates**. Many changes in the system will also affect the documentation (both Javadocs and the user documentation in the `docs/` directory). Pull requests and patches are required to update the documentation accordingly; otherwise the change can not be accepted to the source code. See the [Contribute documentation]({{site.base}}/contribute-documentation.html) guide for how to update the documentation.

- **Javadocs for public methods**. All public methods and classes need to have Javadocs. Please write meaningful docs. Good docs are concise and informative. Please do also update Javadocs if you change the signature or behavior of a documented method.

### Code formatting
{:.no_toc}

- **No reformattings**. Please keep reformatting of source files to a minimum. Diffs become unreadable if you (or your IDE automatically) remove or replace whitespaces, reformat code, or comments. Also, other patches that affect the same files become un-mergeable. Please configure your IDE such that code is not automatically reformatted. Pull requests with excessive or unnecessary code reformatting might be rejected.



-----

## Code style


-----

## Best practices

- Travis: Flink is pre-configured for [Travis CI](http://docs.travis-ci.com/), which can be easily enabled for your personal repository fork (it uses GitHub for authentication, so you do not need an additional account). Simply add the *Travis CI* hook to your repository (*Settings --> Integrations & services --> Add service*) and enable tests for the `flink` repository on [Travis](https://travis-ci.org/profile).

-----

--- 



Please note that some tests in Flink's code base are flaky and can fail by chance. The Flink community is working hard on improving these tests but sometimes this is not possible, e.g., when tests include external dependencies. We maintain all tests that are known to be flaky in Jira and attach the **`test-stability`** label. Please check (and extend) this list of [known flaky tests](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20AND%20labels%20%3D%20test-stability%20ORDER%20BY%20priority%20DESC) if you encounter a test failure that seems to be unrelated to your changes.

Please note that we run additional build profiles for different combinations of Java, Scala, and Hadoop versions to validate your contribution. We encourage every contributor to use a *continuous integration* service that will automatically test the code in your repository whenever you push a change. The [Best practices]( {{site.base}}/contribute-code.html#best-practices ) guide shows how to integrate [Travis](https://travis-ci.org/) with your GitHub repository.

In addition to the automated tests, please check the diff of your changes and remove all unrelated changes such as unnecessary reformatting.



## Setup a development environment

### Requirements for developing and building Flink

* Unix-like environment (We use Linux, Mac OS X, and Cygwin)
* git
* Maven (at least version 3.0.4)
* Java 8

### Clone the repository
{:.no_toc}

Apache Flink's source code is stored in a [git](http://git-scm.com/) repository which is mirrored to [GitHub](https://github.com/apache/flink). The common way to exchange code on GitHub is to fork the repository into your personal GitHub account. For that, you need to have a [GitHub](https://github.com) account or create one for free. Forking a repository means that GitHub creates a copy of the forked repository for you. This is done by clicking on the *Fork* button on the upper right of the [repository website](https://github.com/apache/flink). Once you have a fork of Flink's repository in your personal account, you can clone that repository to your local machine.

```
git clone https://github.com/<your-user-name>/flink.git
```

The code is downloaded into a directory called `flink`.


### Proxy Settings

If you are behind a firewall you may need to provide Proxy settings to Maven and your IDE.

For example, the WikipediaEditsSourceTest communicates over IRC and need a [SOCKS proxy server](http://docs.oracle.com/javase/8/docs/technotes/guides/net/proxies.html) to pass.

### Setup an IDE and import the source code
{:.no_toc}

The Flink committers use IntelliJ IDEA and Eclipse IDE to develop the Flink code base.

Minimal requirements for an IDE are:

- Support for Java and Scala (also mixed projects)
- Support for Maven with Java and Scala

#### IntelliJ IDEA

The IntelliJ IDE supports Maven out of the box and offers a plugin for Scala development.

- IntelliJ download: [https://www.jetbrains.com/idea/](https://www.jetbrains.com/idea/)
- IntelliJ Scala Plugin: [http://plugins.jetbrains.com/plugin/?id=1347](http://plugins.jetbrains.com/plugin/?id=1347)

Check out our [Setting up IntelliJ]({{site.docs-stable}}/flinkDev/ide_setup.html#intellij-idea) guide for details.

#### Eclipse Scala IDE

For Eclipse users, we recommend using Scala IDE 3.0.3, based on Eclipse Kepler. While this is a slightly older version,
we found it to be the version that works most robustly for a complex project like Flink.

Further details and a guide to newer Scala IDE versions can be found in the
[How to setup Eclipse]({{site.docs-stable}}/flinkDev/ide_setup.html#eclipse) docs.

**Note:** Before following this setup, make sure to run the build from the command line once
(`mvn clean install -DskipTests`; see below).

1. Download the Scala IDE (preferred) or install the plugin to Eclipse Kepler. See
   [How to setup Eclipse]({{site.docs-stable}}/flinkDev/ide_setup.html#eclipse) for download links and instructions.
2. Add the "macroparadise" compiler plugin to the Scala compiler.
   Open "Window" -> "Preferences" -> "Scala" -> "Compiler" -> "Advanced" and put into the "Xplugin" field the path to
   the *macroparadise* jar file (typically "/home/*-your-user-*/.m2/repository/org/scalamacros/paradise_2.10.4/2.0.1/paradise_2.10.4-2.0.1.jar").
   Note: If you do not have the jar file, you probably did not run the command line build.
3. Import the Flink Maven projects ("File" -> "Import" -> "Maven" -> "Existing Maven Projects")
4. During the import, Eclipse will ask to automatically install additional Maven build helper plugins.
5. Close the "flink-java8" project. Since Eclipse Kepler does not support Java 8, you cannot develop this project.

#### Import the source code

Apache Flink uses Apache Maven as build tool. Most IDEs are capable of importing Maven projects.


### Build the code
{:.no_toc}

To build Flink from source code, open a terminal, navigate to the root directory of the Flink source code, and call:

```
mvn clean package
```

This will build Flink and run all tests. Flink is now installed in `build-target`.

To build Flink without executing the tests you can call:

```
mvn -DskipTests clean package
```


-----


## How to use Git as a committer

Only the infrastructure team of the ASF has administrative access to the GitHub mirror. Therefore, comitters have to push changes to the git repository at the ASF.

### Main source repositories
{:.no_toc}

**ASF writable**: https://gitbox.apache.org/repos/asf/flink.git

**ASF read-only**: https://github.com/apache/flink.git

Note: Flink builds and runs with JDK 8.

If you want to build for Hadoop 1, activate the build profile via `mvn clean package -DskipTests -Dhadoop.profile=1`.
