---
title: Code Style and Quality Guide — Common Rules
bookCollapseSection: false
bookHidden: true
---

# Code Style and Quality Guide — Common Rules

#### [Preamble]({{< ref "docs/how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< ref "docs/how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Common Coding Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-common" >}})
#### [Java Language Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Language Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-scala" >}})
#### [Components Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-components" >}})
#### [Formatting Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-formatting" >}})

<hr>

## 1. Copyright

Each file must include the Apache license information as a header.

```
/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
```

## 2. Tools

We recommend to follow the {{< docs_link file="flink-docs-stable/docs/flinkdev/ide_setup/" name="IDE Setup Guide">}} to get IDE tooling configured.


<!---
### Use inspections in IntelliJ

* Import the inspections settings into the IDE (see IDE setup guide)
    * TODO: Need to agree on a profile and export it (like checkstyle)
* Write the code such that inspection warnings are addressed
    * There are few exceptions where an inspection warning is not meaningful. In that case, suppress the inspection warning.
-->

### Warnings

* We strive for zero warnings
* Even though there are many warnings in existing code, new changes should not add any additional compiler warnings
* If it is not possible to address the warning in a sane way (in some cases when working with generics) add an annotation to suppress the warning
* When deprecating methods, check that this does not introduce additional warnings



## 3. Comments And Code Readability


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


## 4. Design and Structure

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
See also [usage of Java Optional]({{< ref "docs/how-to-contribute/code-style-and-quality-java" >}}#java-optional).


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



## 5. Concurrency and Threading

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




## 6. Dependencies and Modules

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



## 7. Testing

### Tooling

We are moving our codebase to [JUnit 5](https://junit.org/junit5/docs/current/user-guide/) and [AssertJ](https://assertj.github.io/doc/) as our testing framework and assertions library of choice.

Unless there is a specific reason, make sure you use JUnit 5 and AssertJ when contributing to Flink with new tests and even when modifying existing tests. Don't use Hamcrest, JUnit assertions and `assert` directive.
Make your tests readable and don't duplicate assertions logic provided by AssertJ or by [custom assertions](https://assertj.github.io/doc/#assertj-core-custom-assertions) provided by some flink modules.
For example, avoid:

```java
assert list.size() == 10;
for (String item : list) {
    assertTrue(item.length() < 10);
}
```

And instead use:

```java
assertThat(list)
    .hasSize(10)
    .allMatch(item -> item.length() < 10);
```

### Write targeted tests

* <span style="text-decoration:underline;">Test contracts not implementations</span>: Test that after a sequence of actions, the components are in a certain state, rather than testing that the components followed a sequence of internal state modifications.
    * For example, a typical antipattern is to check whether one specific method was called as part of the test
* A way to enforce this is to try to follow the _Arrange_, _Act_, _Assert_ test structure when writing a unit test ([https://xp123.com/articles/3a-arrange-act-assert/](https://xp123.com/articles/3a-arrange-act-assert/))

  This helps to communicate the intention of the test (what is the scenario under test) rather than the mechanics of the tests. The technical bits go to a static methods at the bottom of the test class.

  Example of tests in Flink that follow this pattern are:

    * [https://github.com/apache/flink/blob/master/flink-core/src/test/java/org/apache/flink/util/LinkedOptionalMapTest.java](https://github.com/apache/flink/blob/master/flink-core/src/test/java/org/apache/flink/util/LinkedOptionalMapTest.java)
    * [https://github.com/apache/flink/blob/master/flink-filesystems/flink-s3-fs-base/src/test/java/org/apache/flink/fs/s3/common/writer/RecoverableMultiPartUploadImplTest.java](https://github.com/apache/flink/blob/master/flink-filesystems/flink-s3-fs-base/src/test/java/org/apache/flink/fs/s3/common/writer/RecoverableMultiPartUploadImplTest.java)


### Avoid Mockito - Use reusable test implementations

* Mockito-based tests tend to be costly to maintain in the long run by encouraging duplication of functionality and testing for implementation rather than effect
    * More details: [https://docs.google.com/presentation/d/1fZlTjOJscwmzYadPGl23aui6zopl94Mn5smG-rB0qT8](https://docs.google.com/presentation/d/1fZlTjOJscwmzYadPGl23aui6zopl94Mn5smG-rB0qT8)
* Instead, create reusable test implementations and utilities
    * That way, when some class changes, we only have to update a few test utils or mocks

### Avoid timeouts in JUnit tests

Generally speaking, we should avoid setting local timeouts in JUnit tests but rather depend on the
global timeout in Azure. The global timeout benefits from taking thread dumps just before timing out
the build, easing debugging.

At the same time, any timeout value that you manually set is arbitrary. If it's set too low, you get
test instabilities. What too low means depends on numerous factors, such as hardware and current
utilization (especially I/O). Moreover, a local timeout is more maintenance-intensive. It's one more
knob where you can tweak a build. If you change the test a bit, you also need to double-check the
timeout. Hence, there have been quite a few commits that just increase timeouts.


[^1]: We are keeping such frameworks out of Flink, to make debugging easier and avoid dependency clashes.
