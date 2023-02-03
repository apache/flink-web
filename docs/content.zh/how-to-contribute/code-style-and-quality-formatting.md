---
title: Code Style and Quality Guide — Formatting Guide
bookCollapseSection: false
bookHidden: true
---

# Code Style and Quality Guide — Formatting Guide

#### [序言]({{< ref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< ref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [常用编码指南]({{< ref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java 语言指南]({{< ref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala 语言指南]({{< ref "how-to-contribute/code-style-and-quality-scala" >}})
#### [组件指南]({{< ref "how-to-contribute/code-style-and-quality-components" >}})
#### [格式指南]({{< ref "how-to-contribute/code-style-and-quality-formatting" >}})

## Java Code Formatting Style

We recommend to set up the IDE to automatically check the code style. Please follow the {{< docs_link file="flink-docs-stable/docs/flinkdev/ide_setup/" name="IDE Setup Guide">}} to set up
{{< docs_link file="flink-docs-stable/docs/flinkdev/ide_setup/#code-formatting" name="spotless">}} and
{{< docs_link file="flink-docs-stable/docs/flinkdev/ide_setup/#checkstyle-for-java" name="checkstyle">}}.

### License

* **Apache license headers.** Make sure you have Apache License headers in your files. The RAT plugin is checking for that when you build the code.

### Imports

* **Empty line before and after package declaration.**
* **No unused imports.**
* **No redundant imports.**
* **No wildcard imports.** They can cause problems when adding to the code and in some cases even during refactoring.
* **Import order.** Imports must be ordered alphabetically, grouped into the following blocks, with each block separated by an empty line:
    * &lt;imports from org.apache.flink.*&gt;
    * &lt;imports from org.apache.flink.shaded.*&gt;
    * &lt;imports from other libraries&gt;
    * &lt;imports from javax.*&gt;
    * &lt;imports from java.*&gt;
    * &lt;imports from scala.*&gt;
    * &lt;static imports&gt;


### Naming

* **Package names must start with a letter, and must not contain upper-case letters or special characters.**
  **Non-private static final fields must be upper-case, with words being separated by underscores.**(`MY_STATIC_VARIABLE`)
* **Non-static fields/methods must be in lower camel case.** (`myNonStaticField`)


### Whitespaces

* **Tabs vs. spaces.** We are using spaces for indentation, not tabs.
* **No trailing whitespace.**
* **Spaces around operators/keywords.** Operators (`+`, `=`, `>`, …) and keywords (`if`, `for`, `catch`, …) must have a space before and after them, provided they are not at the start or end of the line.


### Breaking the lines of too long statements

In general long lines should be avoided for the better readability. Try to use short statements which operate on the same level of abstraction. Break the long statements by creating more local variables, defining helper functions etc.

Two major sources of long lines are:

* **Long list of arguments** in function declaration or call: `void func(type1 arg1, type2 arg2, ...)`
* **Long sequence of chained calls**: `list.stream().map(...).reduce(...).collect(...)...`

Rules about breaking the long lines:

* Break the argument list or chain of calls if the line exceeds limit or earlier if you believe that the breaking would improve the code readability
* If you break the line then each argument/call should have a separate line, including the first one
* Each new line should have one extra indentation (or two for a function declaration) relative to the line of the parent function name or the called entity

Additionally for function arguments:

* The opening parenthesis always stays on the line of the parent function name
* The possible thrown exception list is never broken and stays on the same last line, even if the line length exceeds its limit
* The line of the function argument should end with a comma staying on the same line except the last argument

Example of breaking the list of function arguments:

```
public void func(
    int arg1,
    int arg2,
    ...) throws E1, E2, E3 {

}
```

The dot of a chained call is always on the line of that chained call proceeding the call at the beginning.

Example of breaking the list of chained calls:

```
values
    .stream()
    .map(...)
    .collect(...);
```


### Braces

* **Left curly braces (<code>{</code>) must not be placed on a new line.**
* <strong>Right curly braces (<code>}</code>) must always be placed at the beginning of the line.</strong>
* <strong>Blocks.</strong> All statements after <code>if</code>, <code>for</code>, <code>while</code>, <code>do</code>, … must always be encapsulated in a block with curly braces (even if the block contains one statement).


### Javadocs

* **All public/protected methods and classes must have a Javadoc.**
* **The first sentence of the Javadoc must end with a period.**
* **Paragraphs must be separated with a new line, and started with <p>.**


### Modifiers

* **No redundant modifiers.** For example, public modifiers in interface methods.
* **Follow JLS3 modifier order.** Modifiers must be ordered in the following order: public, protected, private, abstract, static, final, transient, volatile, synchronized, native, strictfp.


### Files

* **All files must end with <code>\n</code>.**
* <strong>File length must not exceed 3000 lines.</strong>


### Misc

* **Arrays must be defined Java-style.** For example, `public String[] array`.
* **Use Flink Preconditions.** To increase homogeneity, consistently use the `org.apache.flink.Preconditions` methods `checkNotNull` and `checkArgument` rather than Apache Commons Validate or Google Guava.



<hr>

[^1]: We are keeping such frameworks out of Flink, to make debugging easier and avoid dependency clashes.
