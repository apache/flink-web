---
title: Code Style and Quality Guide — Java
bookCollapseSection: false
bookHidden: true
---

# Code Style and Quality Guide — Java

#### [Preamble]({{< ref "docs/how-to-contribute/code-style-and-quality-preamble" >}})
#### [Pull Requests & Changes]({{< ref "docs/how-to-contribute/code-style-and-quality-pull-requests" >}})
#### [Common Coding Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-common" >}})
#### [Java Language Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-java" >}})
#### [Scala Language Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-scala" >}})
#### [Components Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-components" >}})
#### [Formatting Guide]({{< ref "docs/how-to-contribute/code-style-and-quality-formatting" >}})

## Java Language Features and Libraries


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
* **Set the initial capacity for a collection only if there is a good proven reason** for that, otherwise do not clutter the code. In case of **Maps** it can be even deluding because the Map's load factor effectively reduces the capacity.


### Java Optional

* Use **@Nullable annotation where you do not use Optional** for the nullable values.
* If you can prove that `Optional` usage would lead to a **performance degradation in critical code then fallback to @Nullable**.
* Always use **Optional to return nullable values** in the API/public methods except the case of a proven performance concern.
* **Do not use Optional as a function argument**, instead either overload the method or use the Builder pattern for the set of function arguments.
    * Note: an Optional argument can be allowed in a private helper method if you believe that it simplifies the code
      ([example](https://github.com/apache/flink/blob/master/flink-formats/flink-avro/src/main/java/org/apache/flink/formats/avro/typeutils/AvroFactory.java#L95)).
* **Do not use Optional for class fields**.


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


