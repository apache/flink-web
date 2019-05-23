---
title:  "Code Style and Quality Guide (OUTDATED)"
---


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

- **Tests need to pass**. Any pull request where the tests do not pass or which does not compile will not undergo any further review. We recommend to connect your personal GitHub accounts with [Travis CI](http://travis-ci.org/) (like the Flink GitHub repository). Travis will run tests for all tested environments whenever you push something into *your* GitHub repository.

- **Tests for new features are required**. All new features need to be backed by tests, *strictly*. It is very easy that a later merge accidentally throws out a feature or breaks it. This will not be caught if the feature is not guarded by tests. Anything not covered by a test is considered cosmetic.

- **Use appropriate test mechanisms**. Please use unit tests to test isolated functionality, such as methods. Unit tests should execute in subseconds and should be preferred whenever possible. The names of unit test classes have to end in `*Test`. Use integration tests to implement long-running tests. Flink offers test utilities for end-to-end tests that start a Flink instance and run a job. These tests are pretty heavy and can significantly increase build time. Hence, they should be added with care. The names of end-to-end test classes have to end in `*ITCase`.

### Documentation
{:.no_toc}

- **Documentation Updates**. Many changes in the system will also affect the documentation (both Javadocs and the user documentation in the `docs/` directory). Pull requests and patches are required to update the documentation accordingly; otherwise the change can not be accepted to the source code. See the [Contribute documentation]({{site.base}}/contributing/contribute-documentation.html) guide for how to update the documentation.

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

Please note that some tests in Flink's code base are flaky and can fail by chance. The Flink community is working hard on improving these tests but sometimes this is not possible, e.g., when tests include external dependencies. We maintain all tests that are known to be flaky in Jira and attach the **`test-stability`** label. Please check (and extend) this list of [known flaky tests](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20resolution%20%3D%20Unresolved%20AND%20labels%20%3D%20test-stability%20ORDER%20BY%20priority%20DESC) if you encounter a test failure that seems to be unrelated to your changes.

Please note that we run additional build profiles for different combinations of Java, Scala, and Hadoop versions to validate your contribution. We encourage every contributor to use a *continuous integration* service that will automatically test the code in your repository whenever you push a change.

In addition to the automated tests, please check the diff of your changes and remove all unrelated changes such as unnecessary reformatting.


Travis: Flink is pre-configured for [Travis CI](http://docs.travis-ci.com/), which can be easily enabled for your personal repository fork (it uses GitHub for authentication, so you do not need an additional account). Simply add the *Travis CI* hook to your repository (*Settings --> Integrations & services --> Add service*) and enable tests for the `flink` repository on [Travis](https://travis-ci.org/profile).