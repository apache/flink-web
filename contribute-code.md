---
title:  "Contributing Code"
---

Apache Flink is maintained, improved, and extended by code contributions of volunteers. The Apache Flink community encourages anybody to contribute source code. In order to ensure a pleasant contribution experience for contributors and reviewers and to preserve the high quality of the code base, we follow a contribution process that is explained in this document.

This document contains everything you need to know about contributing code to Apache Flink. It describes the process of preparing, testing, and submitting a contribution, explains coding guidelines and code style of Flink's code base, and gives instructions to setup a development environment.

**IMPORTANT**: Please read this document carefully before starting to work on a code contribution. It is important to follow the process and guidelines explained below. Otherwise, your pull request might not be accepted or might require substantial rework. In particular, before opening a pull request that implements a **new feature**, you need to open a Jira ticket and reach consensus with the community on whether this feature is needed.



{% toc %}

## Code Contribution Process

### Before you start coding…

…please make sure there is a Jira issue that corresponds to your contribution. This is a *general rule* that the Flink community follows for all code contributions, including bug fixes, improvements, or new features, with an exception for *trivial* hot fixes. If you would like to fix a bug that you found or if you would like to add a new feature or improvement to Flink, please follow the [File a bug report]({{ site.baseurl }}/how-to-contribute.html#file-a-bug-report) or [Propose an improvement or a new feature]({{ site.baseurl }}/how-to-contribute.html#propose-an-improvement-or-a-new-feature) guidelines to open an issue in [Flink's Jira](http://issues.apache.org/jira/browse/FLINK) before starting with the implementation.

If the description of a Jira issue indicates that its resolution will touch sensible parts of the code base, be sufficiently complex, or add significant amounts of new code, the Flink community might request a design document. (Most contributions should not require a design document.) The purpose of this document is to ensure that the overall approach to address the issue is sensible and agreed upon by the community. Jira issues that require a design document are tagged with the **`requires-design-doc`** label. The label can be attached by any community member who feels that a design document is necessary. A good description helps to decide whether a Jira issue requires a design document or not. The design document must be added or attached to or linked from the Jira issue and cover the following aspects:

- Overview of the general approach.
- List of API changes (changed interfaces, new and deprecated configuration parameters, changed behavior, …).
- Main components and classes to be touched.
- Known limitations of the proposed approach.

A design document can be added by anybody, including the reporter of the issue or the person working on it.

Contributions for Jira issues that require a design document will not be added to Flink's code base before a design document has been accepted by the community with [lazy consensus](http://www.apache.org/foundation/glossary.html#LazyConsensus). Please check if a design document is required before starting to code.


### While coding…

…please respect the following rules:

- Take any discussion or requirement that is recorded in the Jira issue into account.
- Follow the design document (if a design document is required) as close as possible. Please update the design document and seek consensus, if your implementation deviates too much from the solution proposed by the design document. Minor variations are OK but should be pointed out when the contribution is submitted.
- Closely follow the [coding guidelines]( {{site.base}}/contribute-code.html#coding-guidelines) and the [code style]({{ site.base }}/contribute-code.html#code-style).
- Do not mix unrelated issues into one contribution.

**Please feel free to ask questions at any time.** Either send a mail to the [dev mailing list]( {{ site.base }}/community.html#mailing-lists ) or comment on the Jira issue.

The following instructions will help you to [setup a development environment]( {{ site.base }}/contribute-code.html#setup-a-development-environment).




### Verifying the compliance of your code

It is very important to verify the compliance of changes before submitting your contribution. This includes:

- Making sure the code builds.
- Verifying that all existing and new tests pass.
- Checking that the code style is not violated.
- Making sure no unrelated or unnecessary reformatting changes are included.

You can build the code, run the tests, and check (parts of) the code style by calling:

```
mvn clean verify
```

Please note that some tests in Flink's code base are flaky and can fail by chance. The Flink community is working hard on improving these tests but sometimes this is not possible, e.g., when tests include external dependencies. We maintain all tests that are known to be flaky in Jira and attach the **`test-stability`** label. Please check (and extend) this list of [known flaky tests](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20AND%20labels%20%3D%20test-stability%20ORDER%20BY%20priority%20DESC) if you encounter a test failure that seems to be unrelated to your changes.

Please note that we run additional build profiles for different combinations of Java, Scala, and Hadoop versions to validate your contribution. We encourage every contributor to use a *continuous integration* service that will automatically test the code in your repository whenever you push a change. The [Best practices]( {{site.base}}/contribute-code.html#best-practices ) guide shows how to integrate [Travis](https://travis-ci.org/) with your GitHub repository.

In addition to the automated tests, please check the diff of your changes and remove all unrelated changes such as unnecessary reformatting.




### Preparing and submitting your contribution

To make the changes easily mergeable, please rebase them to the latest version of the main repository's master branch. Please also respect the [commit message guidelines]( {{ site.base }}/contribute-code.html#coding-guidelines ), clean up your commit history, and squash your commits to an appropriate set. Please verify your contribution one more time after rebasing and commit squashing as described above.

The Flink project accepts code contributions through the [GitHub Mirror](https://github.com/apache/flink), in the form of [Pull Requests](https://help.github.com/articles/using-pull-requests). Pull requests are a simple way to offer a patch, by providing a pointer to a code branch that contains the change.

To open a pull request, push your contribution back into your fork of the Flink repository.

```
git push origin myBranch
```

Go to the website of your repository fork (`https://github.com/<your-user-name>/flink`) and use the *"Create Pull Request"* button to start creating a pull request. Make sure that the base fork is `apache/flink master` and the head fork selects the branch with your changes. Give the pull request a meaningful description and send it.

It is also possible to attach a patch to a [Jira]({{site.FLINK_ISSUES_URL}}) issue.

-----

## Coding guidelines

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

### License
- **Apache license headers.** Make sure you have Apache License headers in your files. The RAT plugin is checking for that when you build the code.

### Imports
- **Empty line before and after package declaration.**
- **No unused imports.**
- **No redundant imports.**
- **No wildcard imports.** They can cause problems when adding to the code and in some cases even during refactoring.
- **Import order.** Imports must be ordered alphabetically, grouped into the following blocks, with each block separated by an empty line:
	- &lt;imports from org.apache.flink.*&gt;
	- &lt;imports from org.apache.flink.shaded.*&gt;
	- &lt;imports from other libraries&gt;
	- &lt;imports from javax.*&gt;
	- &lt;imports from java.*&gt;
	- &lt;imports from scala.*&gt;
	- &lt;static imports&gt;

### Naming
- **Package names must start with a letter, and must not contain upper-case letters or special characters.**
- **Non-private static final fields must be upper-case, with words being separated by underscores.** (`MY_STATIC_VARIABLE`)
- **Non-static fields/methods must be in lower camel case.** (`myNonStaticField`)

### Whitespace
- **Tabs vs. spaces.** We are using tabs for indentation, not spaces. We are not religious there; it just happened to be that we started with tabs, and it is important to not mix them (merge/diff conflicts).
- **No trailing whitespace.**
- **Spaces around operators/keywords.** Operators (`+`, `=`, `>`, …) and keywords (`if`, `for`, `catch`, …) must have a space before and after them, provided they are not at the start or end of the line.

### Braces
- **Left curly braces (`{`) must not be placed on a new line.**
- **Right curly braces (`}`) must always be placed at the beginning of the line.**
- **Blocks.** All statements after `if`, `for`, `while`, `do`, … must always be encapsulated in a block with curly braces (even if the block contains one statement).

  ```java
for (…) {
 …
}
```

	If you are wondering why, recall the famous [*goto bug*](https://www.imperialviolet.org/2014/02/22/applebug.html) in Apple's SSL library.

### Javadocs
- **All public/protected methods and classes must have a Javadoc.**
- **The first sentence of the Javadoc must end with a period.**
- **Paragraphs must be separated with a new line, and started with &lt;p&gt;.**

### Modifiers
- **No redundant modifiers.** For example, public modifiers in interface methods.
- **Follow JLS3 modifier order.** Modifiers must be ordered in the following order: public, protected, private, abstract, static, final, transient, volatile, synchronized, native, strictfp.

### Files
- **All files must end with `\n`.**
- **File length must not exceed 3000 lines.**

### Misc
- **Arrays must be defined Java-style.** For example, `public String[] array`.
- **Use Flink Preconditions.** To increase homogeneity, consistently use the `org.apache.flink.Preconditions` methods `checkNotNull` and `checkArgument` rather than Apache Commons Validate or Google Guava.
- **No raw generic types.** Do not use raw generic types, unless strictly necessary (sometime necessary for signature matches, arrays).
- **Suppress warnings.** Add annotations to suppress warnings, if they cannot be avoided (such as "unchecked", or "serial").
- **Comments.** Add comments to your code. What is it doing? Add Javadocs or inherit them by not adding any comments to the methods. Do not automatically generate comments, and avoid unnecessary comments like:

  ```java
i++; // increment by one
```

-----

## Best practices

- Travis: Flink is pre-configured for [Travis CI](http://docs.travis-ci.com/), which can be easily enabled for your personal repository fork (it uses GitHub for authentication, so you do not need an additional account). Simply add the *Travis CI* hook to your repository (*Settings --> Integrations & services --> Add service*) and enable tests for the `flink` repository on [Travis](https://travis-ci.org/profile).

-----

## Setup a development environment

### Requirements for developing and building Flink

* Unix-like environment (We use Linux, Mac OS X, and Cygwin)
* git
* Maven (at least version 3.0.4)
* Java 7 or 8

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

Check out our [Setting up IntelliJ](https://github.com/apache/flink/blob/master/docs/internals/ide_setup.md#intellij-idea) guide for details.

#### Eclipse Scala IDE

For Eclipse users, we recommend using Scala IDE 3.0.3, based on Eclipse Kepler. While this is a slightly older version,
we found it to be the version that works most robustly for a complex project like Flink.

Further details and a guide to newer Scala IDE versions can be found in the
[How to setup Eclipse](https://github.com/apache/flink/blob/master/docs/internals/ide_setup.md#eclipse) docs.

**Note:** Before following this setup, make sure to run the build from the command line once
(`mvn clean install -DskipTests`; see below).

1. Download the Scala IDE (preferred) or install the plugin to Eclipse Kepler. See
   [How to setup Eclipse](https://github.com/apache/flink/blob/master/docs/internals/ide_setup.md#eclipse) for download links and instructions.
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

**ASF writable**: https://git-wip-us.apache.org/repos/asf/flink.git

**ASF read-only**: git://git.apache.org/repos/asf/flink.git

**ASF read-only**: https://github.com/apache/flink.git

Note: Flink does not build with Oracle JDK 6. It runs with Oracle JDK 6.

If you want to build for Hadoop 1, activate the build profile via `mvn clean package -DskipTests -Dhadoop.profile=1`.

-----

## Snapshots (Nightly Builds)

Apache Flink `{{ site.FLINK_VERSION_LATEST }}` is our latest development version.

You can download a packaged version of our nightly builds, which include
the most recent development code. You can use them if you need a feature
before its release. Only builds that pass all tests are published here.

- **Hadoop 2 and YARN**: <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_LATEST }}" class="ga-track" id="download-hadoop2-nightly">{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_LATEST | split:'/' | last }}</a>

Add the **Apache Snapshot repository** to your Maven `pom.xml`:

```xml
<repositories>
  <repository>
    <id>apache.snapshots</id>
    <name>Apache Development Snapshot Repository</name>
    <url>https://repository.apache.org/content/repositories/snapshots/</url>
    <releases><enabled>false</enabled></releases>
    <snapshots><enabled>true</enabled></snapshots>
  </repository>
</repositories>
```

You can now include Apache Flink as a Maven dependency (see above) with version `{{ site.FLINK_VERSION_LATEST }}` (or `{{ site.FLINK_VERSION_HADOOP_1_LATEST }}` for compatibility with old Hadoop 1.x versions).
