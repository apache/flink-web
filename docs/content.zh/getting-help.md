---
title: 获取帮助
bookCollapseSection: false
weight: 11
menu_weight: 2
---
<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

# 获取帮助

## 有问题吗?

Apache Flink 社区每天都会回答许多用户的问题。你可以从历史存档中搜索答案和建议，也可以联系社区寻求帮助和指导。

### 用户邮件列表

许多 Flink 用户、贡献者和提交者都订阅了 Flink 的用户邮件列表。用户邮件列表是一个寻求帮助的好地方。

在发送邮件到邮件列表之前，你可以搜索以下网站的邮件列表存档，从中找到你关注问题的相关讨论。

- [Apache Pony 邮件存档](https://lists.apache.org/list.html?user@flink.apache.org)

如果你想发送到邮件列表，你需要：

1. 发送电子邮件至 `user-subscribe@flink.apache.org` 来订阅邮件列表
2. 通过回复确认邮件来确认订阅
3. 发送你的电子邮件到 `user@flink.apache.org`.

请注意，如果你没有订阅邮件列表，你将不会收到邮件的回复。

### Slack

你可以通过 [此链接](https://join.slack.com/t/apache-flink/shared_invite/zt-1llkzbgyt-K2nNGGg88rfsDGLkT09Qzg) 加入 Apache Flink 社区专属的 Slack 工作空间。
在成功加入后，不要忘记在 #introductions 频道介绍你自己。
Slack 规定每个邀请链接最多可邀请 100 人，如果遇到上述链接失效的情况，请联系 [Dev 邮件列表]({{< relref "community" >}}#mailing-lists)。 
所有已经加入社区 Slack 空间的成员同样可以邀请新成员加入。

### Stack Overflow

Flink 社区的许多成员都活跃在 [Stack Overflow](https://stackoverflow.com)。你可以在这里搜索问题和答案，或者使用 [\[apache-flink\]](https://stackoverflow.com/questions/tagged/apache-flink) 标签来发布你的问题。

## 发现 Bug?

如果你发现一个意外行为可能是由 Bug 导致的，你可以在 [Flink's JIRA](https://issues.apache.org/jira/browse/FLINK) 中搜索已经上报的 Bug 或者发布该 Bug。

如果你不确定意外行为的发生是否由 Bug 引起的，请发送问题到 [用户邮件列表]({{< relref "community" >}}#user-mailing-list)。

## 收到错误信息?

找到导致错误的原因通常是比较困难的。在下文中，我们列出了最常见的错误消息并解释了如何处理它们。

### 我有一个 NotSerializableException 异常。

Flink 使用 Java 序列化来分发应用程序逻辑（你实现的函数和操作，以及程序配置等）的副本到并行的工作进程。 因此，传递给 API 的所有函数都必须是可序列化的，见 [java.io.Serializable](http://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html) 定义。

如果你使用的函数是匿名内部类，请考虑以下事项：

- 为函数构建独立的类或静态内部类。
- 使用 Java 8 lambda 函数。

如果函数已经是静态类，则在创建该类的实例时会检查该类的字段。其中很可能包含不可序列化类型的字段。

- 在 Java 中，使用 RichFunction 并且在  `open()` 方法中初始化有问题的字段。
- 在 Scala 中，你通常可以简单地使用 “lazy val” 声明来推迟初始化，直到分布式执行发生。这可能是一个较小的性能成本。你当然也可以在 Scala 中使用  `RichFunction`。

### 使用 Scala API，我收到有关隐式值和证据参数的错误。

此错误意味着无法提供类型信息的隐式值。确保在你的代码中存在 `import org.apache.flink.streaming.api.scala._` (DataStream API) 或
`import org.apache.flink.api.scala._` (DataSet API) 语句。

如果在接受泛型参数的函数或类中使用 Flink 操作，则必须为参数提供 TypeInformation 类型参数。 这可以通过使用上下文绑定来实现：

~~~scala
def myFunction[T: TypeInformation](input: DataSet[T]): DataSet[Seq[T]] = {
  input.reduceGroup( i => i.toSeq )
}
~~~

请参阅 [类型提取和序列化]({{< param DocsBaseUrl >}}/dev/types_serialization.html) 深入讨论 Flink 如何处理类型。

### 我看到一个 ClassCastException: X cannot be cast to X.

当你看到 `com.foo.X` cannot be cast to `com.foo.X` ( 或者 cannot be assigned to `com.foo.X`), 样式的异常时，这意味着
`com.foo.X` 类的多个版本已经由不同的类加载器加载，并且尝试相互赋值。

原因可能是:

- 通过 `child-first` 的类加载方式实现类复制。这是一种预期的机制，该机制允许用户使用相同依赖的不同版本。然而，如果这些类的不同副本在 
  Flink 的核心代码和用户应用程序代码之间移动，则可能发生这种异常。为了验证这个原因，请尝试在配置中设置 `classloader.resolve-order: parent-first`。  
  如果这可以使错误消失，请写信到邮件列表以检查是否可能是 Bug。

- 从不同的执行中尝试缓存类，例如使用像 Guava 的 Interners 或 Avro 的 Schema 等通用工具进行缓存操作。尝试不使用 Interners，或减少 interner/cache 的使用范围，以确保每当新任务开始执行时都会创建新的缓存。

### 我有一个 AbstractMethodError 或 NoSuchFieldError 错误。

此类错误通常表示混淆了某些依赖的版本。这意味着在执行期间加载了不同版本的依赖项（库），而不是编译代码的版本。

从 Flink 1.4.0 开始，在默认激活 `child-first` 类加载方式的情况下，相比 Flink core 所使用的依赖或类路径中的其他依赖（例如来自 Hadoop ）而言，应用程序 JAR 文件中的依赖更可能带有不同的版本。

如果你在 Flink 1.4 以上的版本中看到这些问题，则可能是属于以下某种情况：

- 你的程序代码中存在依赖项版本冲突，确保所有依赖项版本都一致。
- 你与一个 Flink 不能支持 `child-first` 类加载的库发生了冲突。目前会产生这种情况的有 Scala 标准库类、Flink 自己的类、日志 API 和所有的 Hadoop 核心类。

### 尽管事件正在持续发送，我的 DataStream 程序还是没有输出。

如果你的 DataStream 程序使用了 事件时间，那么请检查你的 Watermark 是否已经更新。如果没有产生 Watermark， 事件时间窗口可能永远不会触发，程序将不会产生任何结果。

你可以在 Flink 的 Web UI（Watermark 部分）中查看 Watermark 是否正在更新。

### 我看到了一个 “Insufficient number of network buffers” 的异常报告。

如果你用非常高的并行度运行 Flink 程序，则可能需要增加网络缓冲区的大小。

默认情况下，Flink 占用 JVM 堆的 10% 作为网络缓冲区的大小，最小为64MB，最大为1GB。 你可以通过 
`taskmanager.network.memory.fraction`, `taskmanager.network.memory.min` 和
`taskmanager.network.memory.max` 参数调整这些值。

详情请参考 [配置参考](https://nightlies.apache.org/flink/flink-docs-stable/docs/deployment/)。

### 我的 Job 因为 HDFS/Hadoop 代码的各种异常失败了，我该怎么办？

最常见的原因是 Flink 的类路径中的 Hadoop 版本与你要访问的 Hadoop 集群（HDFS / YARN）版本不同。

解决这个问题的最简单方法是选择一个不含 Hadoop 的 Flink 版本，并通过 export 的方式设置 Hadoop 路径和类路径即可。
