---
title: Code Style and Quality Guide — Scala
bookCollapseSection: false
bookHidden: true
---

# Code Style and Quality Guide — Scala

#### [Preamble]({{< ref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< ref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Common Coding Guide]({{< ref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java Language Guide]({{< ref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Language Guide]({{< ref "how-to-contribute/code-style-and-quality-scala" >}})
#### [Components Guide]({{< ref "how-to-contribute/code-style-and-quality-components" >}})
#### [Formatting Guide]({{< ref "how-to-contribute/code-style-and-quality-formatting" >}})

## Scala Language Features

### Where to use (and not use) Scala

**We use Scala for Scala APIs or pure Scala Libraries.**

**We do not use Scala in the core APIs and runtime components. We aim to remove existing Scala use (code and dependencies) from those components.**

⇒ This is not because we do not like Scala, it is a consequence of “the right tool for the right job” approach (see below).

For APIs, we develop the foundation in Java, and layer Scala on top.

* This has traditionally given the best interoperability for both Java and Scala
* It does mean dedicated effort to keep the Scala API up to date

Why don’t we use Scala in the core APIs and runtime?

* The past has shown that Scala evolves too quickly with tricky changes in functionality. Each Scala version upgrade was a rather big effort process for the Flink community.
* Scala does not always interact nicely with Java classes, e.g. Scala’s visibility scopes work differently and often expose more to Java consumers than desired
* Scala adds an additional layer of complexity to artifact/dependency management.
    * We may want to keep Scala dependent libraries like Akka in the runtime, but abstract them via an interface and load them in a separate classloader, to keep them shielded and avoid version conflicts.
* Scala makes it very easy for knowledgeable Scala programmers to write code that is very hard to understand for programmers that are less knowledgeable in Scala. That is especially tricky for an open source project with a broad community of diverse experience levels. Working around this means restricting the Scala feature set by a lot, which defeats a good amount of the purpose of using Scala in the first place.


### API Parity

Keep Java API and Scala API in sync in terms of functionality and code quality.

The Scala API should cover all the features of the Java APIs as well.

Scala APIs should have a “completeness test”, like the following example from the DataStream API: [https://github.com/apache/flink/blob/master/flink-streaming-scala/src/test/scala/org/apache/flink/streaming/api/scala/StreamingScalaAPICompletenessTest.scala](https://github.com/apache/flink/blob/master/flink-streaming-scala/src/test/scala/org/apache/flink/streaming/api/scala/StreamingScalaAPICompletenessTest.scala)


### Language Features

* **Avoid Scala implicits.**
    * Scala’s implicits should only be used for user-facing API improvements such as the Table API expressions or type information extraction.
    * Don’t use them for internal “magic”.
* **Add explicit types for class members.**
    * Don’t rely on implicit type inference for class fields and methods return types:

      **Don’t:**
        ```
        var expressions = new java.util.ArrayList[String]()
        ```

      **Do:**
        ```
        var expressions: java.util.List[String] = new java.util.ArrayList[]()
        ```

    * Type inference for local variables on the stack is fine.
* **Use strict visibility.**
    * Avoid Scala’s package private features (such as private[flink]) and use regular private/protected instead.
    * Keep in mind that `private[flink]` and `protected` members are public in Java.
    * Keep in mind that `private[flink]` still exposes all members in Flink provided examples.


### Coding Formatting

**Use line wrapping to structure your code.**

* Scala’s functional nature allows for long transformation chains (`x.map().map().foreach()`).
* In order to force implementers to structure their code, the line length is therefore limited to 100 characters.
* Use one line per transformation for better maintainability.

