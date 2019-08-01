---
title:  "Apache Flink Code Style and Quality Guide — Formatting"
---

{% include code-style-navbar.md %}

{% toc %}



## Java Code Formatting Style

We recommend to set up the IDE to automatically check the code style. Please follow the [IDE setup guide](https://ci.apache.org/projects/flink/flink-docs-master/flinkDev/ide_setup.html#checkstyle-for-java) for that.


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

* **Tabs vs. spaces.** We are using tabs for indentation, not spaces.
We are aware that spaces are a bit nicer; it just happened to be that we started with tabs a long time ago (because Eclipse’s default style used tabs then), and we tried to keep the code base homogeneous (not mix tabs and spaces).
* **No trailing whitespace.**
* **Spaces around operators/keywords.** Operators (`+`, `=`, `>`, …) and keywords (`if`, `for`, `catch`, …) must have a space before and after them, provided they are not at the start or end of the line.


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

[^1]:
     We are keeping such frameworks out of Flink, to make debugging easier and avoid dependency clashes.
