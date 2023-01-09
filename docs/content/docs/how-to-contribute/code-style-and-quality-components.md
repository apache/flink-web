---
title: Code Style and Quality Guide — Components Guide
bookCollapseSection: false
bookHidden: true
---

# Code Style and Quality Guide — Components Guide

#### [Preamble]({{< ref "docs/how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< ref "docs/how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Common Coding Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-common" >}})
#### [Java Language Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Language Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-scala" >}})
#### [Components Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-components" >}})
#### [Formatting Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-formatting" >}})

## Component Specific Guidelines

_Additional guidelines about changes in specific components._


### Configuration Changes

Where should the config option go?

* <span style="text-decoration:underline;">‘flink-conf.yaml’:</span> All configuration that pertains to execution behavior that one may want to standardize across jobs. Think of it as parameters someone would set wearing an “ops” hat, or someone that provides a stream processing platform to other teams.

* <span style="text-decoration:underline;">‘ExecutionConfig’</span>: Parameters specific to an individual Flink application, needed by the operators during execution. Typical examples are watermark interval, serializer parameters, object reuse.
* <span style="text-decoration:underline;">ExecutionEnvironment (in code)</span>: Everything that is specific to an individual Flink application and is only needed to build program / dataflow, not needed inside the operators during execution.

How to name config keys:

* Config key names should be hierarchical.
  Think of the configuration as nested objects (JSON style)

  ```
  taskmanager: {
    jvm-exit-on-oom: true,
    network: {
      detailed-metrics: false,
      request-backoff: {
        initial: 100,
        max: 10000
      },
      memory: {
        fraction: 0.1,
        min: 64MB,
        max: 1GB,
        buffers-per-channel: 2,
        floating-buffers-per-gate: 16
      }
    }
  }
  ```

* The resulting config keys should hence be:

  **NOT** `"taskmanager.detailed.network.metrics"`

  **But rather** `"taskmanager.network.detailed-metrics"`


### Connectors

Connectors are historically hard to implement and need to deal with many aspects of threading, concurrency, and checkpointing.

As part of [FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface) we are working on making this much simpler for sources. New sources should not have to deal with any aspect of concurrency/threading and checkpointing any more.

A similar FLIP can be expected for sinks in the near future.


### Examples

Examples should be self-contained and not require systems other than Flink to run. Except for examples that show how to use specific connectors, like the Kafka connector. Sources/sinks that are ok to use are `StreamExecutionEnvironment.socketTextStream`, which should not be used in production but is quite handy for exploring how things work, and file-based sources/sinks. (For streaming, there is the continuous file source)

Examples should also not be pure toy-examples but strike a balance between real-world code and purely abstract examples. The WordCount example is quite long in the tooth by now but it’s a good showcase of simple code that highlights functionality and can do useful things.

Examples should also be heavy in comments. They should describe the general idea of the example in the class-level Javadoc and describe what is happening and what functionality is used throughout the code. The expected input data and output data should also be described.

Examples should include parameter parsing, so that you can run an example (from the Jar that is created for each example using `bin/flink run path/to/myExample.jar --param1 … --param2`.


### Table & SQL API


#### Semantics

**The SQL standard should be the main source of truth.**

* Syntax, semantics, and features should be aligned with SQL!
* We don’t need to reinvent the wheel. Most problems have already been discussed industry-wide and written down in the SQL standard.
* We rely on the newest standard (SQL:2016 or ISO/IEC 9075:2016 when writing this document ([download](https://standards.iso.org/ittf/PubliclyAvailableStandards/c065143_ISO_IEC_TR_19075-5_2016.zip)). Not every part is available online but a quick web search might help here.

Discuss divergence from the standard or vendor-specific interpretations.

* Once a syntax or behavior is defined it cannot be undone easily.
* Contributions that need to extent or interpret the standard need a thorough discussion with the community.
* Please help committers by performing some initial research about how other vendors such as Postgres, Microsoft SQL Server, Oracle, Hive, Calcite, Beam are handling such cases.


Consider the Table API as a bridge between the SQL and Java/Scala programming world.

* The Table API is an Embedded Domain Specific Language for analytical programs following the relational model.
  It is not required to strictly follow the SQL standard in regards of syntax and names, but can be closer to the way a programming language would do/name functions and features, if that helps make it feel more intuitive.
* The Table API might have some non-SQL features (e.g. map(), flatMap(), etc.) but should nevertheless “feel like SQL”. Functions and operations should have equal semantics and naming if possible.


#### Common mistakes

* Support SQL’s type system when adding a feature.
    * A SQL function, connector, or format should natively support most SQL types from the very beginning.
    * Unsupported types lead to confusion, limit the usability, and create overhead by touching the same code paths multiple times.
    * For example, when adding a `SHIFT_LEFT` function, make sure that the contribution is general enough not only for `INT` but also `BIGINT` or `TINYINT`.


#### Testing

Test for nullability.

* SQL natively supports `NULL` for almost every operation and has a 3-valued boolean logic.
* Make sure to test every feature for nullability as well.


Avoid full integration tests

* Spawning a Flink mini-cluster and performing compilation of generated code for a SQL query is expensive.
* Avoid integration tests for planner tests or variations of API calls.
* Instead, use unit tests that validate the optimized plan which comes out of a planner. Or test the behavior of a runtime operator directly.


#### Compatibility

Don’t introduce physical plan changes in patch releases!

* Backwards compatibility for state in streaming SQL relies on the fact that the physical execution plan remains stable. Otherwise the generated Operator Names/IDs change and state cannot be matched and restored.
* Every bug fix that leads to changes in the optimized physical plan of a streaming pipeline hences breaks compatibility.
* As a consequence, changes of the kind that lead to different optimizer plans can only be merged in major releases for now.


#### Scala / Java interoperability (legacy code parts)

Keep Java in mind when designing interfaces.

* Consider whether a class will need to interact with a Java class in the future.
* Use Java collections and Java Optional in interfaces for a smooth integration with Java code.
* Don’t use features of case classes such as .copy() or apply() for construction if a class is subjected to be converted to Java.
* Pure Scala user-facing APIs should use pure Scala collections/iterables/etc. for natural and idiomatic (“scalaesk”) integration with Scala.


