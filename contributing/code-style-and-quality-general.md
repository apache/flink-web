---
title:  "Apache Flink Code Style and Quality Guide"
---

{% include code-style-navbar.md %}

{% toc %}


## 1. Tools

We recommend to follow the [IDE Setup Guide](https://ci.apache.org/projects/flink/flink-docs-master/flinkDev/ide_setup.html#checkstyle-for-java) to get IDE tooling configured.


### Use inspections in IntelliJ

* Import the inspections settings into the IDE (see IDE setup guide)
    * TODO: Need to agree on a profile and export it (like checkstyle)
* Write the code such that inspection warnings are addressed
    * There are few exceptions where an inspection warning is not meaningful. In that case, suppress the inspection warning.


### Warnings

* We strive for zero warnings
* Even though there are many warnings in existing code, new changes should not add any additional compiler warnings
* If it is not possible to address the warning in a sane way (in some cases when working with generics) add an annotation to suppress the warning
* When deprecating methods, check that this does not introduce additional warnings



## 2. Comments And Code Readability


### Comments

**Golden rule: Comment as much as necessary to support code understanding, but don’t add redundant information.**

Think about

* <span style="text-decoration:underline;">What</span> is the code doing?
* <span style="text-decoration:underline;">How</span> does the code do this?
* <span style="text-decoration:underline;">Why</span> is the code like that?

The code alone should explain as much as possible the “<span style="text-decoration:underline;">what</span>” and the “<span style="text-decoration:underline;">how</span>”

* Use JavaDocs to describe the roles of classes and the contracts of methods, in cases where the contract is not obvious or intuitive from the method name (the “what”).
* The flow of the code should give a good description of the “how”.
Think of variable and method names as part of the code documenting itself.
* It often makes reading the code easier if larger blocks that form a unit are moved into a private method with a descriptive name of what that block is doing

In-code comments help explain the <span style="text-decoration:underline;">“why”</span>

* For example `// this specific code layout helps the JIT to better do this or that`
* Or `// nulling out this field here means future write attempts are fail-fast`
* Or `// for arguments with which this method is actually called, this seemingly naive approach works actually better than any optimized/smart version`

In-code comments should not state redundant information about the “what” and “how” that is already obvious in the code itself. 

JavaDocs should not state meaningless information (just to satisfy the Checkstyle checker).

__Don’t:__

```
/**
 * The symbol expression.
 */
public class CommonSymbolExpression {}
```
__Do:__

```
/**
 * An expression that wraps a single specific symbol.
 * A symbol could be a unit, an alias, a variable, etc.
 */
public class CommonSymbolExpression {}
```


### Branches and Nesting

Avoid deep nesting of scopes, by flipping the if condition and exiting early.

__Don’t:__

```
if (a) {
    if (b) { 
        if (c) {
            the main path
        }
    }
}
```

__Do__

```
if (!a) {
	return ..
}

if (!b) {
	return ...
}

if (!c) {
	return ...
}

the main path
```


## 3. Design and Structure

While it is hard to exactly specify what constitutes a good design, there are some properties that can serve as a _litmus test_ for a good design. If these properties are given, the chances are good that the design is going into a good direction. If these properties cannot be achieved, there is a high probability that the design is flawed.


### Immutability and Eager Initialization

1. Try to use immutable types where possible, especially for APIs, messages, identifiers, properties, configuration, etc.
2. A good general approach is to try and make as many fields of a class `final` as possible.
3. Classes that are used as keys in maps should be strictly immutable and only have `final` fields (except maybe auxiliary fields, like lazy cached hash codes).
4. Eagerly initialize classes. There should be no `init()` or `setup()` methods. Once the constructor completes, the object should be usable.


### Nullability of the Mutable Parts

For nullability, the Flink codebase aims to follow these conventions:

* Fields, parameters, and return types are always non-null, unless indicated otherwise
* All fields, parameters and method types that can be null should be annotated with `@javax.annotation.Nullable`. 
That way, you get warnings from IntelliJ about all sections where you have to reason about potential null values.
* For all mutable (non-final) fields that are not annotated, the assumption is that while the field value changes, there always is a value.
    * This should be double check whether these can in fact not be null throughout the lifetime of the object.

_Note: This means that `@Nonnull` annotations are usually not necessary, but can be used in certain cases to override a previous annotation, or to point non-nullability out in a context where one would expect a nullable value._

`Optional` is a good solution as a return type for method that may or may not have a result, so nullable return types are good candidates to be replaced with `Optional`. 
For fields and parameters, `Optional` is disputed in Java and most parts of the Flink code case don’t use optional for fields.


### Avoid Code Duplication

1. Whenever you are about to copy/paste some code, or reproduce a similar type of functionality in a different place, think about the ways how to refactor/reuse/abstract the changes to avoid the duplication.
2. Common behavior between different specializations should be shared in a common component (or a shared superclass).
3. Always use “private static final” constants instead of duplicating strings or other special values at different locations. Constants should be declared in the top member area of a class.


### Design for Testability

Code that is easily testable typically has good separation of concerns and is structured to be reusable outside the original context (by being easily reusable in tests).

A good summary or problems / symptoms and recommended refactoring is in the PDF linked below. 
Please note that while the examples in the PDF often use a dependency injection framework (Guice), it works in the same way without such a framework.[^1]

[http://misko.hevery.com/attachments/Guide-Writing%20Testable%20Code.pdf](http://misko.hevery.com/attachments/Guide-Writing%20Testable%20Code.pdf)

Here is a compact summary of the most important aspects.


**Inject dependencies**

Reusability becomes easier if constructors don’t create their dependencies (the objects assigned to the fields), but accept them as parameters.

* Effectively, constructors should have no `new` keyword.
* Exceptions are creating a new empty collection (`new ArrayList<>()`) or similar auxiliary fields (objects that have only primitive dependencies).

To make instantiation easy / readable, add factory methods or additional convenience constructors to construct whole object with dependencies.

In no case should it ever be required to use a reflection or a “Whitebox” util to change the fields of an object in a test, or to use PowerMock to intercept a “new” call and supply a mock.


**Avoid “too many collaborators”**

If you have to take a big set of other components into account during testing (“too many collaborators”), consider refactoring.

The component/class you want to test probably depends on another broad component (and its implementation), rather than on the minimal interface (abstraction) required for its work.

In that case, segregate the interfaces (factor out the minimal required interface) and supply a test stub in that case.


* For example, if testing a S3RecoverableMultiPartUploader requires actual S3 access
then the S3 access should be factored out into an interface and test should replace it by a test stub
* This naturally requires to be able to inject dependencies (see above)

⇒ Please note that these steps often require more effort in implementing tests (factoring out interfaces, creating dedicated test stubs), but make the tests more resilient to changes in other components, i.e., you do not need to touch the tests when making unrelated changes.


**Write targeted tests**

* <span style="text-decoration:underline;">Test contracts not implementations</span>: Test that after a sequence of actions, the components are in a certain state, rather than testing that the components followed a sequence of internal state modifications.
    * For example, a typical antipattern is to check whether one specific method was called as part of the test
* A way to enforce this is to try to follow the _Arrange_, _Act_, _Assert_ test structure when writing a unit test ([https://xp123.com/articles/3a-arrange-act-assert/](https://xp123.com/articles/3a-arrange-act-assert/)) 

    This helps to communicate the intention of the test (what is the scenario under test) rather than the mechanics of the tests. The technical bits go to a static methods at the bottom of the test class.
 
    Example of tests in Flink that follow this pattern are:

    * [https://github.com/apache/flink/blob/master/flink-core/src/test/java/org/apache/flink/util/LinkedOptionalMapTest.java](https://github.com/apache/flink/blob/master/flink-core/src/test/java/org/apache/flink/util/LinkedOptionalMapTest.java)
    * [https://github.com/apache/flink/blob/master/flink-filesystems/flink-s3-fs-base/src/test/java/org/apache/flink/fs/s3/common/writer/RecoverableMultiPartUploadImplTest.java](https://github.com/apache/flink/blob/master/flink-filesystems/flink-s3-fs-base/src/test/java/org/apache/flink/fs/s3/common/writer/RecoverableMultiPartUploadImplTest.java)


**Avoid Mockito - Use reusable test implementations**

* Mockito-based tests tend to be costly to maintain in the long run by encouraging duplication of functionality and testing for implementation rather than effect
    * More details: [https://docs.google.com/presentation/d/1fZlTjOJscwmzYadPGl23aui6zopl94Mn5smG-rB0qT8](https://docs.google.com/presentation/d/1fZlTjOJscwmzYadPGl23aui6zopl94Mn5smG-rB0qT8)
* Instead, create reusable test implementations and utilities
    * That way, when some class changes, we only have to update a few test utils or mocks


### Performance Awareness

We can conceptually distinguish between code that “coordinates” and code that “processes data”. Code that coordinates should always favor simplicity and cleanness. Data processing code is highly performance critical and should optimize for performance.

That means still applying the general idea of the sections above, but possibly forgoing some aspects in some place, in order to achieve higher performance.


**Which code paths are Data Processing paths?**

* <span style="text-decoration:underline;">Per-record code paths:</span> Methods and code paths that are called for each record. Found for example in Connectors, Serializers, State Backends, Formats, Tasks, Operators, Metrics, runtime data structures, etc.
* <span style="text-decoration:underline;">I/O methods:</span> Transferring messages or chunks of data in buffers. Examples are in the RPC system, Network Stack, FileSystems, Encoders / Decoders, etc.


**Things that performance critical code may do that we would otherwise avoid**

* Using (and reusing) mutable objects to take pressure off the GC (and sometimes help with cache locality), thus forgoing the strive for immutability.
* Using primitive types, arrays of primitive types, or MemorySegment/ByteBuffer and encoding meaning into the primitive types and byte sequences, rather than encapsulating the behavior in dedicated classes and using objects.
* Structuring the code to amortize expensive work (allocations, lookups, virtual method calls, …) across multiple records, for example by doing the work once per buffer/bundle/batch.
* Code layout optimized for the JIT rather than for readability. Examples are inlining fields from other classes (in cases where it is doubtful whether the JIT would do that optimization at runtime), or structuring code to help the JIT compiler with inlining, loop unrolling, vectorization, etc.



## 4. Concurrency and Threading

**Most code paths should not require any concurrency.** The right internal abstractions should obviate the need for concurrency in almost all cases.

* The Flink core and runtime use concurrency to provide these building blocks.
Examples are in the RPC system, Network Stack, in the Task’s mailbox model, or some predefined Source / Sink utilities.
* We are not fully there, but any new addition that introduces implements its own concurrency should be under scrutiny, unless it falls into the above category of core system building blocks.
* Contributors should reach out to committers if they feel they need to implement concurrent code to see if there is an existing abstraction/building-block, or if one should be added.


**When developing a component think about threading model and synchronization points ahead.**

* For example: single threaded, blocking, non-blocking, synchronous, asynchronous, multi threaded, thread pool, message queues, volatile, synchronized block/methods, mutexes, atomics, callbacks, … 
* Getting those things right and thinking about them ahead is even more important than designing classes interfaces/responsibilities, since it’s much harder to change later on.


**Try to avoid using threads all together if possible in any way.**

* If you feel you have a case for spawning a thread, point this out in the pull request as something to be explicitly reviewed.


**Be aware that using threads is in fact much harder than it initially looks**

* Clean shutdown of threads is very tricky.
* Handling interruptions in a rock solid fashion (avoid both slow shutdown and live locks) requires almost a Java Wizard
* Ensuring clean error propagation out of threads in all cases needs thorough design.
* Complexity of multi-threaded application/component/class grows exponentially, with each additional synchronisation point/block/critical section. Your code initially might be easy enough to understand, but can quickly grow beyond that point.
* Proper testing of multithreaded code is basically impossible, while alternative approaches (like asynchronous code, non-blocking code, actor model with message queues) are quite easy to test.
* Usually multi-threaded code is often even less efficient compared to alternative approaches on modern hardware.


**Be aware of the java.util.concurrent.CompletableFuture**

* Like with other concurrent code, there should rarely be the need to use a CompletableFuture 
* Completing a future would also complete on the calling thread any chained futures that are waiting for the result to be completed, unless a completion executor specified explicitly.
* This can be intentional, if the entire execution should be synchronous / single-threaded, as for example in parts of the Scheduler / ExecutionGraph.
    * Flink even makes use of a “main-thread executor” to allow calling chained handlers in the same thread as a single-threaded RPC endpoint runs
* This can be unexpected, if the thread that completes the future is a sensitive thread.
    * It may be better to use `CompletableFuture.supplyAsync(value, executor)` in that case, instead of `future.complete(value)` when an executor is available
* When blocking on a future awaiting completion, always supply a timeout for a result instead of waiting indefinitely, and handle timeouts explicitly. 
* Use `CompletableFuture.allOf()`/`anyOf()`, `ExecutorCompletionService`, or `org.apache.flink.runtime.concurrent.FutureUtils#waitForAll` if you need to wait for: all the results/any of the results/all the results but handled by (approximate) completion order.




## 5. Dependencies and Modules

* **Keep the dependency footprint small**
    * The more dependencies the harder it gets for the community to manage them as a whole.
    * Dependency management includes dependency conflicts, maintaining licenses and related notices, and handling security vulnerabilities.
    * Discuss whether the dependency should be shaded/relocated to avoid future conflicts.
* **Don’t add a dependency for just one method**
    * Use Java built-in means if possible.
    * If the method is Apache-licensed, you can copy the method into a Flink utility class with proper attribution.
* **Declaration of dependencies**
    * Declare dependencies that you explicitly rely on, whether it provides classes you directly import and use or it's something that provides a service you directly use, like Log4J.
    * Transitive dependencies should only supply dependencies that are needed at runtime but that you don't use yourself.
    * [[source](https://stackoverflow.com/questions/15177661/maven-transitive-dependencies)]
* **Location of classes in the Maven modules**
    * Whenever you create a new class, think about where to put it.
    * A class might be used by multiple modules in the future and might belong into a `common` module in this case. 


## 6. Java Language Features and Libraries


### Preconditions and Log Statements

* Never concatenate strings in the parameters
    * <span style="text-decoration:underline;">Don’t:</span> `Preconditions.checkState(value <= threshold, "value must be below " + threshold)`
    * <span style="text-decoration:underline;">Don’t:</span> `LOG.debug("value is " + value)`
    * <span style="text-decoration:underline;">Do:</span> `Preconditions.checkState(value <= threshold, "value must be below %s", threshold)`
    * <span style="text-decoration:underline;">Do:</span> `LOG.debug("value is {}", value)`


### Generics

* **No raw types:** Do not use raw types, unless strictly necessary (sometimes necessary for signature matches, arrays).
* **Suppress warnings for unchecked conversions:** Add annotations to suppress warnings, if they cannot be avoided (such as “unchecked”, or “serial”). Otherwise warnings about generics flood the build and drown relevant warnings.


### equals() / hashCode()

* **equals() / hashCode() should be added when they are well defined only.**
* They should **not be added to enable a simpler assertion in tests** when they are not well defined. Use hamcrest matchers in that case: [https://github.com/junit-team/junit4/wiki/matchers-and-assertthat](https://github.com/junit-team/junit4/wiki/matchers-and-assertthat)
* A common indicator that the methods are not well defined is when they take a subset of the fields into account (other than fields that are purely auxiliary).
* When the methods take mutable fields into account, you often have a design issue. The `equals()`/`hashCode()` methods suggest to use the type as a key, but the signatures suggest it is safe to keep mutating the type.


### Java Serialization

* **Do not use Java Serialization for anything !!!**
* **Do not use Java Serialization for anything !!! !!!**
* **Do not use Java Serialization for anything !!! !!! !!!**
*  Internal to Flink, Java serialization is used to transport messages and programs through RPC. This is the only case where we use Java serialization. Because of that, some classes need to be serializable (if they are transported via RPC).
* **Serializable classes must define a Serial Version UID:**

  `private static final long serialVersionUID = 1L;`
* **The Serial Version UID for new classes should start at 1** and should generally be bumped on every incompatible change to the class according to the Java serialization compatibility definition (i.e: changing the type of a field, or moving the position of a class in the class hierarchy).


### Java Reflection

**Avoid using Java’s Reflection API**

* Java’s Reflection API can be a very useful tool in certain cases but in all cases it is a hack and one should research for alternatives. The only cases where Flink should use reflection are
    * Dynamically loading implementations from another module (like webUI, additional serializers, pluggable query processors).
    * Extracting types inside the TypeExtractor class. This is fragile enough and should not be done outside the TypeExtractor class.
    * Some cases of cross-JDK version features, where we need to use reflection because we cannot assume a class/method to be present in all versions.
* If you need reflection for accessing methods or fields in tests, it usually indicates some deeper architectural issues, like wrong scoping, bad separation of concerns, or that there is no clean way to provide components / dependencies to the class that is tested


### Collections

* **ArrayList and ArrayDeque are almost always superior to LinkedList**, except when frequently insert and deleting in the middle of the list
* **For Maps, avoid patterns that require multiple lookups**
    * `contains()` before `get()` → `get()` and check null
    * `contains()` before `put()` → `putIfAbsent()` or `computeIfAbsent()`
    * Iterating over keys, getting values → iterate over `entrySet()`


### Lambdas

* Prefer non-capturing lambdas (lambdas that do not contain references to the outer scope). Capturing lambdas need to create a new object instance for every call. Non-capturing lambdas can use the same instance for each invocation. 

  **don’t:**
  ```
  map.computeIfAbsent(key, x -> key.toLowerCase())
  ```

  **do:**
  ```
  map.computeIfAbsent(key, k -> k.toLowerCase());
  ```

* Consider method references instead of inline lambdas

  **don’t**:
  ```
  map.computeIfAbsent(key, k-> Loader.load(k));
  ```
 
  **do:**
  ```
  map.computeIfAbsent(key, Loader::load);
  ```


### Java Streams

* Avoid Java Streams in any performance critical code.
* The main motivation to use Java Streams would be to improve code readability. As such, they can be a good match in parts of the code that are not data-intensive, but deal with coordination..
* Even in the latter case, try to limit the scope to a method, or a few private methods within an internal class.


## 7. Scala Language Features

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


## 8. Component Specific Guidelines

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
* We rely on the newest standard (SQL:2016 or ISO/IEC 9075:2016 when writing this document [[download]](https://standards.iso.org/ittf/PubliclyAvailableStandards/c065143_ISO_IEC_TR_19075-5_2016.zip) ). Not every part is available online but a quick web search might help here.

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

Don’t introduce physical plan changes in minor releases!

* Backwards compatibility for state in streaming SQL relies on the fact that the physical execution plan remains stable. Otherwise the generated Operator Names/IDs change and state cannot be matched and restored.
* Every bug fix that leads to changes in the optimized physical plan of a streaming pipeline hences breaks compatibility.
* As a consequence, changes of the kind that lead to different optimizer plans can only be merged in major releases for now.


#### Scala / Java interoperability (legacy code parts)

Keep Java in mind when designing interfaces.

* Consider whether a class will need to interact with a Java class in the future.
* Use Java collections and Java Optional in interfaces for a smooth integration with Java code.
* Don’t use features of case classes such as .copy() or apply() for construction if a class is subjected to be converted to Java.
* Pure Scala user-facing APIs should use pure Scala collections/iterables/etc. for natural and idiomatic (“scalaesk”) integration with Scala.


## 9. Java Code Formatting Style

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
