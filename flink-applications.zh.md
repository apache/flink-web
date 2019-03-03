---
title: "Apache Flink 是什么？"
---

<hr/>
<div class="row">
  <div class="col-sm-12" style="background-color: #f8f8f8;">
    <h2>
      <a href="{{ site.baseurl }}/zh/flink-architecture.html">架构</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      应用 &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/zh/flink-operations.html">操作</a>
    </h2>
  </div>
</div>
<hr/>

Apache Flink是一个用于对无界和有界数据流进行有状态计算的框架。 Flink在不同的抽象级别提供多种API，并为常见用例提供专用库。

本小节，我们将介绍Flink框架中易于使用和富有表现力的API和函数库。

## 构建流应用程序的基石

流处理框架如何管理*流*，*状态*和*时间*定义了这类基于流处理框架构建和执行的应用程序。在下文中，我们将描述构建流处理应用程序的基石，并阐述Flink处理它们的方法。

### 流

显然，流是流处理最为基础组成。 但是，流可以具有不同的特征，这些特征会影响流的处理方式。 Flink是一个多功能的处理框架，可以处理任何类型的流。

* **有界的**和**无界的**流：流可以是无界的，或有界的（即固定大小的数据集）。 Flink具有处理无界流的复杂机制，但也有专门的操作符来有效地处理有界流。
* **实时的** 和 **录制的** 流: 所有数据都以流的形式生成。 有两种方法可以用来处理数据：在数据生成时进行实时处理；或将流持久化保存到存储系统（例如文件系统或对象存储器等），然后在以后处理它们。 Flink应用程序可以处理录制流或实时流。

### 状态

每个复杂一点的流应用程序都是有状态的，即，除了只处理单个事件的应用程序不需要状态。 任何运行基本业务逻辑的应用程序都需要（在过程中）记录事件或中间结果，以便在未来的某个时间点（例如在收到下一个事件时或在特定一段时间之后）重新访问它们。

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/function-state.png" width="350px" />
</div>

应用程序的状态是Flink中的“一等公民”。 您可以通过Flink提供的各种状态处理功能体会到。

* **多状态原语**: Flink为不同的数据结构提供状态原语，例如原子值，列表或映射。 开发人员可以根据函数的访问模式来选择最有效的状态原语。
* **可插拔的状态后端**: 应用程序状态由可插拔的状态后端进行管理和检查。 Flink具有不同的状态后端，可以将状态存在内存或[RocksDB][1]，后者是一种高效的嵌入式磁盘数据存储引擎。 另外，自定义状态后端可以嵌入Flink中。
* **Exactly-once状态一致性**: Flink的检查点和恢复算法可以保证在发生故障时应用程序状态的一致性。 因此，故障是透明处理的，不会影响应用程序的正确性。
* **大规模状态**: 由于其异步和增量检查点算法，Flink能够维护几兆字节的应用程序状态
* **可扩展应用程序**: Flink通过将状态重新分配给更多或更少的计算节点实现有状态应用程序的扩展。

### 时间

时间是流应用程序的另一个重要组成部分。大多数事件流都具有固有的时间语义，因为每个事件都是在特定时间点生成的。 此外，许多常见的流计算（例如时间窗口内聚合, sessionization，模式检测和基于时间的连接等）是基于时间的。 流处理的一个重要方面是应用程序如何处理时间，即如何处理事件时间和处理时间的差异。

Flink提供了一系列时间处理相关的特性。

* **事件时间模式**: 应用程序基于事件的时间戳处理具有事件时间语义的流数据。 因此，无论是处理录制的事件还是实时的事件，通过事件时间模式处理都能够得到准确和一致的结果
* **水印支持**: Flink采用水印来推断事件时间应用中的时间。 水印同时也是一种灵活的机制用以权衡结果的延迟和完整性。
* **延迟数据处理**:当使用水印在事件时间模式下处理流时，可能会发生在所有相关事件到达之前就完成计算。 这类事件被称为延迟事件。 Flink有多种方式来处理延迟事件，例如通过额外输出实现重新路由这些事件，以及更新之前完成的结果
* **处理事件模型**:除了事件时间模式之外，Flink还支持处理时间语义，该处理时间语义的执行由处理机器的时钟触发。 处理时间模式适用于具有严格的低延迟要求的某些应用，这些要求可以容忍近似的结果。

## 分层的API

每个层次的API在简洁性和表达性之间取得不同的权衡，用于不同的情况。

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/api-stack.png" width="500px" />
</div>

我们将简要地介绍每个层次的API，讨论其应用，并提供示例代码。

### ProcessFunctions介绍

[ProcessFunctions][2]是Flink提供的最具表现力的功能接口。 Flink提供ProcessFunction来处理来自窗口中分组的一个或两个输入数据流或事件。 ProcessFunction提供了对时间和状态的细粒度控制。 一个ProcessFunction可以任意修改其状态，并注册定时器用以触发回调函数。 因此，ProcessFunction可以实现许多[有状态事件驱动的应用程序]({{ site.baseurl }}/usecases.html#eventDrivenApps)所需的复杂事件业务逻辑。

接下来的例子展示了一个`KeyedProcessFunction`，它对`KeyedStream`进行操作，并匹配`START`和`END`事件。 当收到`START`事件时，该函数会记录其状态时间戳并注册了一个四小时的计时器。 如果在定时器触发之前收到`END`事件，该函数则计算`END`和`START`事件之间的持续时间，清除状态，并返回该值；否则，计时器会触发并清除状态。

{% highlight java %}
/\*\*
 * Matches keyed START and END events and computes the difference between 
 * both elements' timestamps. The first String field is the key attribute, 
 * the second String attribute marks START and END events.
 \*/
public static class StartEndDuration
	extends KeyedProcessFunction<String, Tuple2<String, String>, Tuple2<String, Long>> {

  private ValueState<Long> startTime;

  @Override
  public void open(Configuration conf) {
	// obtain state handle
	startTime = getRuntimeContext()
	  .getState(new ValueStateDescriptor<Long>("startTime", Long.class));
  }

  /\*\* Called for each processed event. \*/
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

  /\*\* Called when a timer fires. \*/
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

这个例子展示了`KeyedProcessFunction`的表现能力，但同时也表明它是一个相当繁琐的接口。

### DataStream API介绍

[DataStream API][3]提供了许多常见的流处理操作原语，例如窗口化，单次记录转换，以及通过查询外部存储的数据来扩展事件。 DataStream API可用于Java和Scala，并且它提供了各类函数，例如`map（）`，`reduce（）`和`aggregate（）`等。 另外，可以通过扩展接口，或Java/Scala的lambda函数来定义函数。

接下来的例子展示了如何对点击流进行会话管理并计算每个会话的点击次数。

{% highlight java %}
// a stream of website clicks
DataStream<Click> clicks = ...

DataStream\<Tuple2\<String, Long\>\> result = clicks
  // project clicks to userId and add a 1 for counting
  .map(
	// define function by implementing the MapFunction interface.
	new MapFunction<Click, Tuple2<String, Long>>() {
	  @Override
	  public Tuple2<String, Long> map(Click click) {
	    return Tuple2.of(click.userId, 1L);
	  }
	})
  // key by userId (field 0)
  .keyBy(0)
  // define session window with 30 minute gap
  .window(EventTimeSessionWindows.withGap(Time.minutes(30L)))
  // count clicks per session. Define function as lambda function.
  .reduce((a, b) -\> Tuple2.of(a.f0, a.f1 + b.f1));
{% endhighlight %}

### SQL &amp; Table API介绍

Flink有两类关系型API[Table API和SQL] [4]。 这两类API都可以用以统一进行批处理和流处理，也就是说，不管是在无界的实时流或有界的录制数据流上都可以以相同的语义执行查询，并产生相同效果的结果。 Table API和SQL利用[Apache Calcite] [5]进行解析、验证和查询优化。 它们可以与DataStream和DataSet的API无缝集成，并支持用户定义的标量，聚合和表值函数。

Flink的关系型API旨在简化[数据分析]({{ site.baseurl }}/usecases.html#analytics)，[数据流水线和ETL应用程序]({{ site.baseurl }}/usecases.html#pipelines)的定义.

The following example shows the SQL query to sessionize a clickstream and count the number of clicks per session. This is the same use case as in the example of the DataStream API.
接下来的例子展示了SQL查询对点击流进行会话管理，计算每个会话的点击次数。 这与DataStream API示例中给的例子相同。

~~~sql
SELECT userId, COUNT(*)
FROM clicks
GROUP BY SESSION(clicktime, INTERVAL '30' MINUTE), userId
~~~

## 函数库

Flink具有几个应用于常见数据处理场景的函数库。 这些库通常嵌入在API中，而不是完全独立的。 因此，它们可以从API的所有功能中受益，并与其它库进行集成。

* **[复杂时间处理库(CEP)][6]**: 模式检测是事件流处理的一种非常常见的应用场景。 Flink的CEP库提供了API用来指定事件的模式（回想一下正则表达式或状态机）。 CEP库与Flink的DataStream API集成，以便在DataStream上进行模式检查。 CEP库的应用包括网络入侵检测，业务流程监控和欺诈检测。
	  
* **[数据集API][7]**: 数据集API是Flink用于构建批处理应用程序的核心API。 数据集API的原语包括*map*，*reduce*，*(outer)join*，*co-group*和*iterate*。 所有操作都有算法和数据结构支持，这些算法和数据结构对内存中的序列化数据进行操作，如果数据大小超过内存则存储到磁盘中。 Flink的数据集API的数据处理算法受到传统数据库运算符的影响，例如也提供混合散列连接或外部合并排序功能。
	  
* **[Gelly库][8]**: Gelly是一个可扩展的图形处理和分析库。 Gelly基于数据集API进行实现，并与之集成。 因此，它受益于数据集API的可扩展、鲁棒的运算符。 Gelly提供了[内置算法] [9]，例如标签传播，三角形枚举和页面排名，但也提供了[图API] [10]，可以简化自定义图算法的实现。

<hr/>
<div class="row">
  <div class="col-sm-12" style="background-color: #f8f8f8;">
    <h2>
      <a href="{{ site.baseurl }}/zh/flink-architecture.html">架构</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      应用 &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/zh/flink-operations.html">操作</a>
    </h2>
  </div>
</div>
<hr/>

[1]:	https://rocksdb.org/
[2]:	https://ci.apache.org/projects/flink/flink-docs-stable/dev/stream/operators/process_function.html
[3]:	https://ci.apache.org/projects/flink/flink-docs-stable/dev/datastream_api.html
[4]:	https://ci.apache.org/projects/flink/flink-docs-stable/dev/table/index.html
[5]:	https://calcite.apache.org
[6]:	https://ci.apache.org/projects/flink/flink-docs-stable/dev/libs/cep.html
[7]:	https://ci.apache.org/projects/flink/flink-docs-stable/dev/batch/index.html
[8]:	https://ci.apache.org/projects/flink/flink-docs-stable/dev/libs/gelly/index.html
[9]:	https://ci.apache.org/projects/flink/flink-docs-stable/dev/libs/gelly/library_methods.html
[10]:	https://ci.apache.org/projects/flink/flink-docs-stable/dev/libs/gelly/graph_api.html