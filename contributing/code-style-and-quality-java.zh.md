---
title:  "Apache Flink 代码风格和质量指南 — Java"
---

{% include code-style-navbar.zh.md %}

{% toc %}


## Java 语言的特点和类库


### 前提条件判断和日志格式

* 不要在参数中拼接字符串
    * <span style="text-decoration:underline;">不要:</span> `Preconditions.checkState(value <= threshold, "value must be below " + threshold)`
    * <span style="text-decoration:underline;">不要:</span> `LOG.debug("value is " + value)`
    * <span style="text-decoration:underline;">可以:</span> `Preconditions.checkState(value <= threshold, "value must be below %s", threshold)`
    * <span style="text-decoration:underline;">可以:</span> `LOG.debug("value is {}", value)`


### 泛型

* **不要使用原始类型:** 除非必要场景（例如在一些方法签名和数组类型情况下），不要使用原始类型。
* **抑制非检转换类警告:** 增加注释来抑制那些无法避免的警告，例如没有进行类型检查或者没有申明`serialVersionUID`。否则的话，这些关于泛型的警告会在编译时大量涌现。

### equals() / hashCode() 方法

* **只有在明确定义的情况下，才实现 equals() / hashCode() 方法.**
* 在没有明确定义的情况下，**只是为了在测试中进行简单判定时，无需实现这些方法**。在这种场景下请使用`hamcrest matchers`: [https://github.com/junit-team/junit4/wiki/matchers-and-assertthat](https://github.com/junit-team/junit4/wiki/matchers-and-assertthat)
* 这些方法没有被明确定义的一个常见指标是，它们只考虑了类字段的部分子集（除了那些纯辅助的字段之外）。
* 当这些方法将可变字段考虑在内时，往往会遇到设计上的问题，因为`equals()`/`hashCode()`方法表明可以将该类作为散列的键，但是签名本身又表明改变类本身是安全的。


### Java 序列化

* **不要使用Java序列化 !!!**
* **不要使用Java序列化 !!! !!!**
* **不要使用Java序列化 !!! !!! !!!**
*  在Flink内部，Java序列化被用于通过RPC传输消息和程序。这是使用Java序列化的唯一情况。 因此，某些使用RPC传输的类需要可序列化。
* **可序列化类必须定义一个Serial Version UID:**

  `private static final long serialVersionUID = 1L;`
* **对于新的类，Serial Version UID应该从1开始** ，而且通常应该根据Java序列化兼容性定义，随着每次类的不兼容改动而修改（例如：更改字段的类型或者在类层次结构中移动类的位置）.


### Java 反射

**尽量避免使用Java的反射API**

* Java的反射功能在某些特定场景下可能是一个非常有用的工具，但无论如何这都是一种很骇客的做法，应该尽量使用其替代方法。Flink只有在如下场景才能使用Java的反射方法：
    * 动态加载其他模块的实现 (例如webUI，额外的序列化器，插件化的查询处理器).
    * 在TypeExtractor类里提取出类型. 因为这个操作往往是很脆弱的，所以不应该在TypeExtractor类外进行操作。
    * 在某些跨JDK版本的功能上，由于无法假定所有版本中都存在此类/方法，因此我们需要使用反射。
* 如果需要使用反射才能访问测试中的方法或者字段，则表明实际上存在一些深层次的体系结构问题，例如错误的作用域，不恰当的关系分离，或者没有干净的方法为测试类提供组件/依赖项。


### 集合类

* **ArrayList和ArrayDeque几乎总是优先于LinkedList使用**, 除非总是在列表中间位置进行频繁地插入和删除时。
* **对于映射, 需要避免多次查询的访问模式**
    * 在`get()`之前调用`contains()` → 直接调用`get()` 然后检查返回结果是否为null
    * 在`put()`之前调用`contains()` → 使用`putIfAbsent()` 或者 `computeIfAbsent()`
    * 遍历键，然后获取对应的值 → 使用`entrySet()`进行遍历。
* **仅在有充分的理由的情况下，才设置集合的初始容量** ，以保持代码的整洁。对于 **映射** 来说，因为负载系数往往会更有效地降低容量，所以其初始容量的设置可以说是具有欺骗性的。


### Java Optional

* **当你不使用Optional时，请对那些可能会是null的变量使用@Nullable注释**
* 如果你能证明`Optional`用法会导致 **在关键代码上的性能退化，可以退到使用 @Nullable**.
* 总是在API/公开方法里 **使用Optional来返回可能是null的值**，除非那些被证明是有性能问题的场景。
* **不要在函数参数中使用Optional**, 而是使用重载方法或者对函数参数使用Builder模式。
     * 注意: 如果您认为Optional参数可以简化代码，则可以在私有方法中使用此参数
     ([例子](https://github.com/apache/flink/blob/master/flink-formats/flink-avro/src/main/java/org/apache/flink/formats/avro/typeutils/AvroFactory.java#L95)).
* **不要对类字段使用Optional**.


### Lambdas

* 首选非捕获型lambda（即不包含对外部作用域的引用）。捕获型lambda需要为每个调用创建一个新的对象实例，而非捕获的lambda可以为每个调用使用相同的实例。

  **不要:**
  ```
  map.computeIfAbsent(key, x -> key.toLowerCase())
  ```

  **可以:**
  ```
  map.computeIfAbsent(key, k -> k.toLowerCase());
  ```

* 考虑优先使用方法引用而不是内联lambda

  **不要**:
  ```
  map.computeIfAbsent(key, k-> Loader.load(k));
  ```

  **可以:**
  ```
  map.computeIfAbsent(key, Loader::load);
  ```


### Java Streams

* 避免在任何性能关键代码中使用Java Streams。
* 使用Java Streams的主要动机是为了提高代码的可读性。它们可以很好地应用在那些不是数据密集型，但是需要协调处理的代码中。
* 即使在后一种情况下，也应尝试将使用范围限制在一个方法或内部类中的一些私有方法中。
