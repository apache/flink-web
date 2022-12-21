---
title: 应用
bookCollapseSection: false
weight: 2
---

# Apache Flink 是什么？

Apache Flink 是一个针对无界和有界数据流进行有状态计算的框架。Flink 自底向上在不同的抽象级别提供了多种 API，并且针对常见的使用场景开发了专用的扩展库。

在本章中，我们将介绍 Flink 所提供的这些简单易用、易于表达的 API 和库。

## 流处理应用的基本组件

可以由流处理框架构建和执行的应用程序类型是由框架对 *流*、*状态*、*时间* 的支持程度来决定的。在下文中，我们将对上述这些流处理应用的基本组件逐一进行描述，并对 Flink 处理它们的方法进行细致剖析。

### 流

显而易见，（数据）流是流处理的基本要素。然而，流也拥有着多种特征。这些特征决定了流如何以及何时被处理。Flink 是一个能够处理任何类型数据流的强大处理框架。

* **有界** 和 **无界** 的数据流：流可以是无界的；也可以是有界的，例如固定大小的数据集。Flink 在无界的数据流处理上拥有诸多功能强大的特性，同时也针对有界的数据流开发了专用的高效算子。
* **实时** 和 **历史记录** 的数据流：所有的数据都是以流的方式产生，但用户通常会使用两种截然不同的方法处理数据。或是在数据生成时进行实时的处理；亦或是先将数据流持久化到存储系统中——例如文件系统或对象存储，然后再进行批处理。Flink 的应用能够同时支持处理实时以及历史记录数据流。

### 状态

只有在每一个单独的事件上进行转换操作的应用才不需要状态，换言之，每一个具有一定复杂度的流处理应用都是有状态的。任何运行基本业务逻辑的流处理应用都需要在一定时间内存储所接收的事件或中间结果，以供后续的某个时间点（例如收到下一个事件或者经过一段特定时间）进行访问并进行后续处理。

<div class="row front-graphic">
  {{< img src="/img/function-state.png" width="350px" >}}
</div>

应用状态是 Flink 中的一等公民，Flink 提供了许多状态管理相关的特性支持，其中包括：

* **多种状态基础类型**：Flink 为多种不同的数据结构提供了相对应的状态基础类型，例如原子值（value），列表（list）以及映射（map）。开发者可以基于处理函数对状态的访问方式，选择最高效、最适合的状态基础类型。
* **插件化的State Backend**：State Backend 负责管理应用程序状态，并在需要的时候进行 checkpoint。Flink 支持多种 state backend，可以将状态存在内存或者 [RocksDB](https://rocksdb.org/)。RocksDB 是一种高效的嵌入式、持久化键值存储引擎。Flink 也支持插件式的自定义 state backend 进行状态存储。
* **精确一次语义**：Flink 的 checkpoint 和故障恢复算法保证了故障发生后应用状态的一致性。因此，Flink 能够在应用程序发生故障时，对应用程序透明，不造成正确性的影响。
* **超大数据量状态**：Flink 能够利用其异步以及增量式的 checkpoint 算法，存储数 TB 级别的应用状态。
* **可弹性伸缩的应用**：Flink 能够通过在更多或更少的工作节点上对状态进行重新分布，支持有状态应用的分布式的横向伸缩。

### 时间

时间是流处理应用另一个重要的组成部分。因为事件总是在特定时间点发生，所以大多数的事件流都拥有事件本身所固有的时间语义。进一步而言，许多常见的流计算都基于时间语义，例如窗口聚合、会话计算、模式检测和基于时间的 join。流处理的一个重要方面是应用程序如何衡量时间，即区分事件时间（event-time）和处理时间（processing-time）。

Flink 提供了丰富的时间语义支持。

* **事件时间模式**：使用事件时间语义的流处理应用根据事件本身自带的时间戳进行结果的计算。因此，无论处理的是历史记录的事件还是实时的事件，事件时间模式的处理总能保证结果的准确性和一致性。
* **Watermark 支持**：Flink 引入了 watermark 的概念，用以衡量事件时间进展。Watermark 也是一种平衡处理延时和完整性的灵活机制。
* **迟到数据处理**：当以带有 watermark 的事件时间模式处理数据流时，在计算完成之后仍会有相关数据到达。这样的事件被称为迟到事件。Flink 提供了多种处理迟到数据的选项，例如将这些数据重定向到旁路输出（side output）或者更新之前完成计算的结果。
* **处理时间模式**：除了事件时间模式，Flink 还支持处理时间语义。处理时间模式根据处理引擎的机器时钟触发计算，一般适用于有着严格的低延迟需求，并且能够容忍近似结果的流处理应用。

## 分层 API

Flink 根据抽象程度分层，提供了三种不同的 API。每一种 API 在简洁性和表达力上有着不同的侧重，并且针对不同的应用场景。

<div class="row front-graphic">
  {{< img src="/img/api-stack.png" width="500px" >}}
</div>

下文中，我们将简要描述每一种 API 及其应用，并提供相关的代码示例。

### ProcessFunction

{{< docs_link file="flink-docs-stable/dev/stream/operators/process_function.html" name="ProcessFunction">}} 是 Flink 所提供的最具表达力的接口。ProcessFunction 可以处理一或两条输入数据流中的单个事件或者归入一个特定窗口内的多个事件。它提供了对于时间和状态的细粒度控制。开发者可以在其中任意地修改状态，也能够注册定时器用以在未来的某一时刻触发回调函数。因此，你可以利用 ProcessFunction 实现许多[有状态的事件驱动应用]({{< ref "docs/use-cases#eventDrivenApps" >}})所需要的基于单个事件的复杂业务逻辑。

下面的代码示例展示了如何在 `KeyedStream` 上利用 `KeyedProcessFunction` 对标记为 `START` 和 `END` 的事件进行处理。当收到 `START` 事件时，处理函数会记录其时间戳，并且注册一个时长4小时的计时器。如果在计时器结束之前收到 `END` 事件，处理函数会计算其与上一个 `START` 事件的时间间隔，清空状态并将计算结果返回。否则，计时器结束，并清空状态。

{% highlight java %}
/**

* 将相邻的 keyed START 和 END 事件相匹配并计算两者的时间间隔
* 输入数据为 Tuple2<String, String> 类型，第一个字段为 key 值，
* 第二个字段标记 START 和 END 事件。
  */
  public static class StartEndDuration
  extends KeyedProcessFunction<String, Tuple2<String, String>, Tuple2<String, Long>> {

private ValueState<Long> startTime;

@Override
public void open(Configuration conf) {
// obtain state handle
startTime = getRuntimeContext()
.getState(new ValueStateDescriptor<Long>("startTime", Long.class));
}

/** Called for each processed event. */
@Override
public void processElement(
Tuple2<String, String> in,
Context ctx,
Collector<Tuple2<String, Long>> out) throws Exception {

    switch (in.f1) {
      case "START":
        // set the start time if we receive a start event.
        startTime.update(ctx.timestamp());
        // register a timer in four hours from the start event.
        ctx.timerService()
          .registerEventTimeTimer(ctx.timestamp() + 4 * 60 * 60 * 1000);
        break;
      case "END":
        // emit the duration between start and end event
        Long sTime = startTime.value();
        if (sTime != null) {
          out.collect(Tuple2.of(in.f0, ctx.timestamp() - sTime));
          // clear the state
          startTime.clear();
        }
      default:
        // do nothing
    }
}

/** Called when a timer fires. */
@Override
public void onTimer(
long timestamp,
OnTimerContext ctx,
Collector<Tuple2<String, Long>> out) {

    // Timeout interval exceeded. Cleaning up the state.
    startTime.clear();
}
}
{% endhighlight %}

这个例子充分展现了 `KeyedProcessFunction` 强大的表达力，也因此是一个实现相当复杂的接口。

### DataStream API

{{< docs_link file="flink-docs-stable/dev/datastream_api.html" name="DataStream API">}} 为许多通用的流处理操作提供了处理原语。这些操作包括窗口、逐条记录的转换操作，在处理事件时进行外部数据库查询等。DataStream API 支持 Java 和 Scala 语言，预先定义了例如`map()`、`reduce()`、`aggregate()` 等函数。你可以通过扩展实现预定义接口或使用 Java、Scala 的 lambda 表达式实现自定义的函数。

下面的代码示例展示了如何捕获会话时间范围内所有的点击流事件，并对每一次会话的点击量进行计数。

{% highlight java %}
// 网站点击 Click 的数据流
DataStream<Click> clicks = ...

DataStream<Tuple2<String, Long>> result = clicks
// 将网站点击映射为 (userId, 1) 以便计数
.map(
// 实现 MapFunction 接口定义函数
new MapFunction<Click, Tuple2<String, Long>>() {
@Override
public Tuple2<String, Long> map(Click click) {
return Tuple2.of(click.userId, 1L);
}
})
// 以 userId (field 0) 作为 key
.keyBy(0)
// 定义 30 分钟超时的会话窗口
.window(EventTimeSessionWindows.withGap(Time.minutes(30L)))
// 对每个会话窗口的点击进行计数，使用 lambda 表达式定义 reduce 函数
.reduce((a, b) -> Tuple2.of(a.f0, a.f1 + b.f1));
{% endhighlight %}

### SQL &amp; Table API

Flink 支持两种关系型的 API，{{< docs_link file="flink-docs-stable/dev/table/index.html" name="Table API 和 SQL">}}。这两个 API 都是批处理和流处理统一的 API，这意味着在无边界的实时数据流和有边界的历史记录数据流上，关系型 API 会以相同的语义执行查询，并产生相同的结果。Table API 和 SQL 借助了 [Apache Calcite](https://calcite.apache.org) 来进行查询的解析，校验以及优化。它们可以与 DataStream 和 DataSet API 无缝集成，并支持用户自定义的标量函数，聚合函数以及表值函数。

Flink 的关系型 API 旨在简化[数据分析]({{< ref "docs/use-cases#analytics" >}})、[数据流水线和 ETL 应用]({{< ref "docs/use-cases#pipelines" >}})的定义。

下面的代码示例展示了如何使用 SQL 语句查询捕获会话时间范围内所有的点击流事件，并对每一次会话的点击量进行计数。此示例与上述 DataStream API 中的示例有着相同的逻辑。

~~~sql
SELECT userId, COUNT(*)
FROM clicks
GROUP BY SESSION(clicktime, INTERVAL '30' MINUTE), userId
~~~

## 库

Flink 具有数个适用于常见数据处理应用场景的扩展库。这些库通常嵌入在 API 中，且并不完全独立于其它 API。它们也因此可以受益于 API 的所有特性，并与其他库集成。

* **{{< docs_link file="flink-docs-stable/dev/libs/cep.html" name="复杂事件处理(CEP)">}}**：模式检测是事件流处理中的一个非常常见的用例。Flink 的 CEP 库提供了 API，使用户能够以例如正则表达式或状态机的方式指定事件模式。CEP 库与 Flink 的 DataStream API 集成，以便在 DataStream 上评估模式。CEP 库的应用包括网络入侵检测，业务流程监控和欺诈检测。

* **{{< docs_link file="flink-docs-stable/dev/batch/index.html" name="DataSet API">}}**：DataSet API 是 Flink 用于批处理应用程序的核心 API。DataSet API 所提供的基础算子包括*map*、*reduce*、*(outer) join*、*co-group*、*iterate*等。所有算子都有相应的算法和数据结构支持，对内存中的序列化数据进行操作。如果数据大小超过预留内存，则过量数据将存储到磁盘。Flink 的 DataSet API 的数据处理算法借鉴了传统数据库算法的实现，例如混合散列连接（hybrid hash-join）和外部归并排序（external merge-sort）。

* **{{< docs_link file="flink-docs-stable/dev/libs/gelly/index.html" name="Gelly">}}**: Gelly 是一个可扩展的图形处理和分析库。Gelly 是在 DataSet API 之上实现的，并与 DataSet API 集成。因此，它能够受益于其可扩展且健壮的操作符。Gelly 提供了{{< docs_link file="flink-docs-stable/dev/libs/gelly/library_methods.html" name="内置算法">}}，如 label propagation、triangle enumeration 和 page rank 算法，也提供了一个简化自定义图算法实现的 {{< docs_link file="flink-docs-stable/dev/libs/gelly/graph_api.html" name="Graph API">}}。
