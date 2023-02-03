---
title: Code Style and Quality Guide
bookCollapseSection: false
weight: 19
---

# Apache Flink Code Style and Quality Guide

#### [Preamble]({{< ref "how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< ref "how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Common Coding Guide]({{< ref "how-to-contribute/code-style-and-quality-common" >}})
#### [Java Language Guide]({{< ref "how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Language Guide]({{< ref "how-to-contribute/code-style-and-quality-scala" >}})
#### [Components Guide]({{< ref "how-to-contribute/code-style-and-quality-components" >}})
#### [Formatting Guide]({{< ref "how-to-contribute/code-style-and-quality-formatting" >}})

<hr>

This is an attempt to capture the code and quality standard that we want to maintain.

A code contribution (or any piece of code) can be evaluated in various ways: One set of properties is whether the code is correct and efficient. This requires solving the _logical or algorithmic problem_ correctly and well.

Another set of properties is whether the code follows an intuitive design and architecture, whether it is well structured with right separation of concerns, and whether the code is easily understandable and makes its assumptions explicit. That set of properties requires solving the _software engineering problem_ well. A good solution implies that the code is easily testable, maintainable also by other people than the original authors (because it is harder to accidentally break), and efficient to evolve.

While the first set of properties has rather objective approval criteria, the second set of properties is much harder to assess, but is of high importance for an open source project like Apache Flink. To make the code base inviting to many contributors, to make contributions easy to understand for developers that did not write the original code, and to make the code robust in the face of many contributions, well engineered code is crucial.[^1] For well engineered code, it is easier to keep it correct and fast over time.

This is of course not a full guide on how to write well engineered code. There is a world of big books that try to capture that. This guide is meant as a checklist of best practices, patterns, anti-patterns, and common mistakes that we observed in the context of developing Flink.

A big part of high-quality open source contributions is about helping the reviewer to understand the contribution and double-check the implications, so an important part of this guide is about how to structure a pull request for review.

[^1]: In earlier days, we (the Flink community) did not always pay sufficient attention to this, making some components of Flink harder to evolve and to contribute to.
