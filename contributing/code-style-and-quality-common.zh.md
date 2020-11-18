---
title:  "Apache Flink 代码样式和质量指南  — 通用规则"
---

{% include code-style-navbar.zh.md %}

{% toc %}

<a name="copyright"></a>

## 1. 版权

每个文件的头部必须包含 Apache 许可信息。

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

<a name="tools"></a>

## 2. 工具

我们建议你按照 [IDE 设置指南](https://ci.apache.org/projects/flink/flink-docs-master/flinkDev/ide_setup.html#checkstyle-for-java) 配置 IDE 工具。


<!---
### 在 IntelliJ 中使用检查

* 将检查设置导入到 IDE (参阅 IDE 设置指南)
    * TODO: 需要同意导出配置文件 (如 checkstyle)
* 编码解决检查警告
    * 当出现没有意义的检查警告时，应该禁止该警告，虽然这种情况很少。
-->

### 警告

* 我们争取实现零警告
* 尽管现有的代码中存在许多警告，但新的修改不应该有任何编译器警告
* 如果不能用合理的方式处理警告（某些情况下使用泛型时）也应该添加注释以压制警告
* 弃用方法时，检查是否会引入其他的警告



<a name="comments-and-code-readability"></a>

## 3. 注释和代码可读性


### 注释

**黄金法则: 尽可能多的注释以支持代码的理解，但不要添加多余的信息。**

思考

* <span style="text-decoration:underline;">What</span> 代码在做什么？
* <span style="text-decoration:underline;">How</span> 代码怎么做到的？
* <span style="text-decoration:underline;">Why</span> 代码为什么是这样的？

代码本身应该尽可能的解释 “<span style="text-decoration:underline;">what</span>” 和 “<span style="text-decoration:underline;">how</span>”

* 使用 JavaDocs 来描述类的作用和方法的协议，以防止不能从方法名看出协议（“what”）。
* 代码流程应该能够很好的描述 “how”。
将变量和方法名看作是代码文档的一部分。
* 如果将组成单元较大块的代码移动到 private 方法中，并且该方法具有描述性的名称，那么代码的可读性就会更强。

代码内部的注释有助于解释 <span style="text-decoration:underline;">“why”</span>

* 例如 `// 这种特定的代码布局可以让 JIT 更好的进行工作`
* 或 `// 此字段为空将会导致写入尝试 fail-fast`
* 或 `// 用于实际调用该方法的参数，这种看似简单的方式实际上比任何优化/智能版本更好`

在代码注释中，不应该有关于 “what” 和 “how” 这么明显的冗余信息。

JavaDocs 不应该说明无意义的信息 （这么做只是为了满足 Checkstyle 的检查）。

__反例：__

```
/**
 * 符号表达式。
 */
public class CommonSymbolExpression {}
```
__正例：__

```
/**
 * 包含单个特定符号的表达式。
 * 符号可以是 Unit、Alias、Variable 等等。
 */
public class CommonSymbolExpression {}
```


### 分支和嵌套

通过对 if 条件取反并提前退出，避免超出嵌套深度的范围。

__反例：__

```
if (a) {
    if (b) { 
        if (c) {
            the main path
        }
    }
}
```

__正例：__

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


<a name="design-and-structure"></a>

## 4. 设计和结构

虽然很难确切地指定一个好的设计是由什么构成的，但是有一些属性可以作为好的设计的试金石。如果设计上拥有这些属性，那么就有可能得到好的发展。否则，设计就很有可能存在缺陷。


### 不变性（Immutability）和急切初始化（Eager Initialization）

1. 尽可能尝试使用不可变类型，尤其是 API、消息、标识符、属性、配置等等。
2. 一个好的通用方法是尽可能地将类中的字段设置为 `final`。
3. 在 map 中作为 key 的类应该是严格不可变的，并且只有 final 字段（可能除了辅助的字段，如延迟缓存的 hash code）。
4. 急切初始化类。不应该有 `init()` 或 `setup()` 方法。构造函数完成后，对象应该就可用。


### 可变部件（Mutable Parts）的可空性（Nullability）

Flink 代码库对于可空性旨在遵循以下约定:

* 除非有特殊说明，否则字段、参数和返回类型始终都是非 null。
* 所有可以为 null 的字段、参数和方法类型都要使用 `@javax.annotation.Nullable` 注解（Annotated）。 
这样 IntelliJ 就能够对可能出现的 null 值进行警告.
* 对于那些没有添加注解的可变（not-final）字段，就无法确定字段值是否为 null。
    * 此时应该仔细的检查这些值在对象的整个生命周期中是否可以不为 null。

_注意: 大部分情况下是不需要 `@Nonnull` 注解的，但有些时候可以用来覆盖之前的注解，或者在不可以为 null 的上下文（Context）中，还想要得到 null 值。_

对于不确定是否有结果返回的方法，`Optional` 作为方法的返回类型是个很好的解决方案，可以用 `Optional` 来代替所有可以为 null 的返回类型。
参考 [Java Optional 的用法](code-style-and-quality-java.zh.md#java-optional).


### 避免重复的代码

1. 当你准备复制/粘贴一些代码，或者在不同的地方实现类似的功能时，就要考虑怎么去重构、复用、抽象来避免重复的代码。
2. 不同模块之间的相同特性应该抽象到公共组件（或父类）中。
3. 常量应该声明在类顶部的成员区域中，并且是使用“private static final”修饰，而不是在不同的地方复制。


### 可测性设计（Design for Testability）

容易进行测试的代码通常能够很好的使关注点分离，并且可以在其他地方重复使用（测试的时候很容易重复使用）。

下面的 PDF 链接中有对问题的总结和重构的建议。需要注意的是，虽然 PDF 中的示例使用 Guice 作为依赖注入框架，但是如果没有使用这个框架，它也能达到相同的效果。[^1]

[http://misko.hevery.com/attachments/Guide-Writing%20Testable%20Code.pdf](http://misko.hevery.com/attachments/Guide-Writing%20Testable%20Code.pdf)

下面是重点方面的简要总结


**依赖关系的注入**

如果构造对象时不创建依赖项（分配给字段的对象），而是通过接受参数的方式，那么可重用性（Reusability）的实现就会变得更容易。

* 实际上，构造函数应该没有 `new` 关键字。
* 不建议创建一个新的空集合（`new ArrayList<>()`）或类似的辅助字段（对象有且仅有原始的依赖）。

为了让对象更容易的实例化和易读，可以添加工厂方法或者其他简便的构造函数来对其依赖关系进行构造。

在任何情况下，都不应该使用反射或者“白盒”工具来修改测试过程中对象的字段，或者使用 PowerMock 拦截“新”的调用并进行模拟。


**避免 “过多的协作者”**

如果在测试过程中需要大量的其他组件（“过多的协作者”），那么就要考虑重构了。

有时候需要测试的组件/类可能依赖于另外的公共组件（及其实现），而不是其工作所需的最小接口（抽象）。

在这种情况下，隔离接口（将所需的最小接口抽取出来）并在这种情况下提供测试存根。

* 例如，假设测试的 S3RecoverableMultiPartUploader 需要实际的 S3 进行访问，那么应该将 S3 的访问抽取成一个接口，测试时使用测试存根来代替它。
* 这当然需要能够注入依赖项（参见上文）。

⇒ 需要注意的是，实现测试的这些步骤（抽取接口、创建专用测试存根）通常需要更多工作，但是这对于其他组件的修改更具有弹性，也就是说没有修改的组件不需要进行测试。


**编写针对性测试**

* <span style="text-decoration:underline;">契约测试而不是实现</span>： 经过一系列的测试操作之后，组件处于某种状态，而不是测试组件遵循一系列内部状态的修改。
    * 例如，经典的反面模式是检查一个特定的方法是否作为测试的一部分被调用。
* 实现这一点的方法是在编写单元测试时尽量的遵循 Arrange、Act、Assert 测试结构([https://xp123.com/articles/3a-arrange-act-assert/](https://xp123.com/articles/3a-arrange-act-assert/)) 

    这有助于传递测试的意图（测试的场景是什么），而不是测试的机制。技术部分进入到测试类底部的静态方法。
 
    Flink 中遵循此模式的测试示例如下:

    * [https://github.com/apache/flink/blob/master/flink-core/src/test/java/org/apache/flink/util/LinkedOptionalMapTest.java](https://github.com/apache/flink/blob/master/flink-core/src/test/java/org/apache/flink/util/LinkedOptionalMapTest.java)
    * [https://github.com/apache/flink/blob/master/flink-filesystems/flink-s3-fs-base/src/test/java/org/apache/flink/fs/s3/common/writer/RecoverableMultiPartUploadImplTest.java](https://github.com/apache/flink/blob/master/flink-filesystems/flink-s3-fs-base/src/test/java/org/apache/flink/fs/s3/common/writer/RecoverableMultiPartUploadImplTest.java)


**避免 Mockito - 使用可重用的测试实现**

* 从长远来看，基于 Mockito 的测试维护成本往往很高，因为它更倾向于功能的重复测试和实现测试，而不是效果测试。
    * 更多的细节： [https://docs.google.com/presentation/d/1fZlTjOJscwmzYadPGl23aui6zopl94Mn5smG-rB0qT8](https://docs.google.com/presentation/d/1fZlTjOJscwmzYadPGl23aui6zopl94Mn5smG-rB0qT8)
* 相反的，应该创建可重用的测试实现和实用程序。
    * 这样，当某些类修改时，只需要更新一些测试工具或 mock。


### 性能意识

我们可以从概念上区分“协调”代码和“数据处理”代码。协调代码应该始终保持简单和干净，而数据处理代码的性能至关重要，应该对性能进行优化。

这说明应用上面各部分的基本思想，但是为了获得更高的性能，可能会在某些地方放弃掉某一些方面。


**哪些代码是数据处理代码？**

* <span style="text-decoration:underline;">每行代码的记录：</span> 记录每行代码的调用的方法和路径。例如在连接器、序列化器、状态后端、格式、任务、操作符、度量、运行时的数据结构等等。
* <span style="text-decoration:underline;">I/O 方法：</span> 在缓冲区中传输消息或数据块。例如在 RPC 系统、网络堆栈、文件系统、编码器/解码器等等。


**有些代码的性能问题是可以避免的**

* 使用（和重用）可变对象来减轻 GC 的压力（有时候还能帮助缓存局部性），从而放弃不可变性。
* 使用基本类型、基本类型数组或 MemorySegment/ByteBuffer 或将含义编码为基本类型和字节序列，而不是将行为封装在专用类中并使用对象。
* 通过跨多个记录来分摊构造代码的昂贵工作（分配、查找、虚拟方法的调用...），例如，通过对缓冲区/绑定/批处理执行一次工作。
* 针对 JIT 优化而不是可读性的代码布局。例如，来自其他类的内联字段（不确定 JIT 是否会在运行时进行优化的情况下），或者通过构造代码来帮助 JIT 编译器进行内联、循环展开、向量化等等。



## 5. 线程和并发性

**大多数的代码不需要任何的并发** 正确的内部抽象应该是所有情况下都不需要考虑并发性的问题。

* Flink 的core 和runtime 构建块都是通过并发来实现的。例如 RPC 系统、网络堆栈、任务的邮箱模型或者一些预定于的 Source/Sink 实用程序。
* 虽然现在还没有完全做到这一点，但是所有自身实现了并发性的新添加模块都应该仔细的检查，除非它属于上述的系统核心构建块。
* 如果贡献者（Contributors）查看现有的抽象/构建块不能实现并发代码，需要添加并发代码或者抽象/构建块，那么贡献者应该与提交者（Committers）联系。

**在开发组件时，请提前考虑线程模型和同步点**

* 例如：单线程、阻塞、非阻塞、同步、异步、多线程、线程池、消息队列、可见性（Volatile）、同步代码块/方法、互斥、原子、回调等等。
* 提前把这些事情都考虑好甚至比设计类接口/职责更重要，因为后面想要修改的话就难了。


**尽可能的避免以任何方式共享线程**

* 如果有产生线程的情况，需要在 pull 请求中指出这一点，作为要显式检查的内容。


**要知道使用线程实际上比初始化要难的多**

* 清除关闭线程非常棘手。
* 以绝对可靠的方式处理中断（避免缓慢关闭和活动锁）差不多需要一个 Java Wizard。
* 在所有情况下，确保线程清除的错误进行传播都需要深入的设计。
* 多线程应用程序/组件/类的复杂度随着每个额外的同步点/块/临界部分呈指数级增长。可能你的代码最开始很容易理解，但是很快就不是了。
* 想要正确的测试多线程代码基本上是不可能的，而替代的方法（如异步代码、非阻塞代码、带有消息队列的actor 模型）却能很容易的测试。
* 通常情况下多线程代码的效率比现代硬件上的替代方法更低。


**注意 java.util.concurrent.CompletableFuture**

* 和其他并发代码一样，很少需要用到 CompletableFuture。
* 除非有明确地指定完成的执行程序，否则在调用线程上完成的 future 将等待所有的链式 futures 完成。
* 如果整个执行都是同步/单线程的，那么很有可能是故意的，例如在 Scheduler/ExecutionGraph 的某些部分中。
    * Flink 甚至允许使用“main-thread-executor”来运行单线程的 RPC 端点中的相同的线程中调用链式处理程序。
* 如果完成 future 的线程是敏感线程（Thread-Sensitive），那么这可能是没有向导的。
    * 这种情况下，最好使用 `CompletableFuture.supplyAsync(value, executor)` 而不是在 executor 可用时使用 `future.complete(value)`。
* 当阻塞等待 future 完成时，始终提供超时的结果，而不是无限期地等待，并且显式地处理超时。
* 如果需要等待：所有的结果/任意的结果/由（差不多）完成顺序处理的所有结果，请使用 `CompletableFuture.allOf()`/`anyOf()`， `ExecutorCompletionService`，或 `org.apache.flink.runtime.concurrent.FutureUtils#waitForAll`。




## 6. 模块和依赖

* **保持较小的依赖**
    * 依赖的越多，社区就越难以将它们作为一个整体来进行管理。
    * 依赖管理包括依赖冲突、维护许可和相关通知以及处理安全漏洞。
    * 讨论是否应该对依赖项进行隐藏/迁移以避免将来发生冲突。
* **不要只为了一个方法添加依赖项**
    * 如果可以的话使用 Java 内置的方法。
    * 如果该方法是 Apache 授权的，则可以将该方法复制到合适的 Flink 应用程序类中。
* **依赖声明**
    * 声明你显式依赖的依赖项，无论是为了提供直接导入和使用的类，还是直接使用的服务，如 Log4J。
    * 传递依赖项应该只提供 runtime 所需，但你不会使用的依赖项。
    * [[来源](https://stackoverflow.com/questions/15177661/maven-transitive-dependencies)]
* **Maven 模块中类的位置**
    * 每当你创建一个新类时，都要考虑它放在哪。
    * 一个类将来可能会被多个模块使用，这种情况下可能属于 `common` 模块。 





<hr>

[^1]:
     我们将这些框架放在 Flink 之外，以简化调试并避免依赖冲突。
