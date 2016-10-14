---
title: "Features"
layout: features
---


<!-- --------------------------------------------- -->
<!--                Streaming
<!-- --------------------------------------------- -->

----

<div class="row" style="padding: 0 0 0 0">
  <div class="col-sm-12" style="text-align: center;">
    <h1 id="streaming"><b>Streaming</b></h1>
  </div>
</div>

----

<!-- High Performance -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="performance"><i>High Performance & Low Latency</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-12">
    <p class="lead">Flink's data streaming runtime achieves high throughput rates and low latency with little configuration.
    The charts below show the performance of a distributed item counting task, requiring streaming data shuffles.</p>
  </div>
</div>
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12 img-column">
    <img src="{{ site.baseurl }}/img/features/streaming_performance.png" alt="Performance of data streaming applications" style="width:75%" />
  </div>
</div>

----

<!-- Event Time Streaming -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="event_time"><i>Support for Event Time and Out-of-Order Events</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Flink supports stream processing and windowing with <b>Event Time</b> semantics.</p>
    <p class="lead">Event time makes it easy to compute over streams where events arrive out of order, and where events may arrive delayed.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/features/out_of_order_stream.png" alt="Event Time and Out-of-Order Streams" style="width:100%" />
  </div>
</div>

----

<!-- Exactly-once Semantics -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="exactly_once"><i>Exactly-once Semantics for Stateful Computations</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Streaming applications can maintain custom state during their computation.</p>
    <p class="lead">Flink's checkpointing mechanism ensures <i>exactly once</i> semantics for the state in the presence of failures.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/features/exactly_once_state.png" alt="Exactly-once Semantics for Stateful Computations" style="width:50%" />
  </div>
</div>

----

<!-- Windowing -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="windows"><i>Highly flexible Streaming Windows</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Flink supports windows over time, count, or sessions, as well as data-driven windows.</p>
    <p class="lead">Windows can be customized with flexible triggering conditions, to support sophisticated streaming patterns.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/features/windows.png" alt="Windows" style="width:100%" />
  </div>
</div>

----

<!-- Continuous streaming -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="streaming_model"><i>Continuous Streaming Model with Backpressure</i></h1>
  </div>
</div>

<div class="row">
  <div class="col-sm-6">
    <p class="lead">Data streaming applications are executed with continuous (long lived) operators.</p>
    <p class="lead">Flink's streaming runtime has natural flow control: Slow data sinks backpressure faster sources.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/features/continuous_streams.png" alt="Continuous Streaming Model" style="width:60%" />
  </div>
</div>

----

<!-- Lightweight distributed snapshots -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="snapshots"><i>Fault-tolerance via Lightweight Distributed Snapshots</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Flink's fault tolerance mechanism is based on Chandy-Lamport distributed snapshots.</p>
    <p class="lead">The mechanism is lightweight, allowing the system to maintain high throughput rates and provide strong consistency guarantees at the same time.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/features/distributed_snapshots.png" alt="Lightweight Distributed Snapshots" style="width:40%" />
  </div>
</div>

----

<!-- --------------------------------------------- -->
<!--                Batch
<!-- --------------------------------------------- -->

<div class="row" style="padding: 0 0 0 0">
  <div class="col-sm-12" style="text-align: center;">
    <h1 id="batch-on-streaming"><b>Batch and Streaming in One System</b></h1>
  </div>
</div>

----

<!-- One Runtime for Streaming and Batch Processing -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="one_runtime"><i>One Runtime for Streaming and Batch Processing</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Flink uses one common runtime for data streaming applications and batch processing applications.</p>
    <p class="lead">Batch processing applications run efficiently as special cases of stream processing applications.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/features/one_runtime.png" alt="Unified Runtime for Batch and Stream Data Analysis" style="width:50%" />
  </div>
</div>

----


<!-- Memory Management -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="memory_management"><i>Memory Management</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Flink implements its own memory management inside the JVM.</p>
    <p class="lead">Applications scale to data sizes beyond main memory and experience less garbage collection overhead.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/features/memory_heap_division.png" alt="Managed JVM Heap" style="width:50%" />
  </div>
</div>

----

<!-- Iterations -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="iterations"><i>Iterations and Delta Iterations</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Flink has dedicated support for iterative computations (as in machine learning and graph analysis).</p>
    <p class="lead">Delta iterations can exploit computational dependencies for faster convergence.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/features/iterations.png" alt="Performance of iterations and delta iterations" style="width:75%" />
  </div>
</div>

----

<!-- Optimizer -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="optimizer"><i>Program Optimizer</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Batch programs are automatically optimized to exploit situations where expensive operations (like shuffles and sorts) can be avoided, and when intermediate data should be cached.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/features/optimizer_choice.png" alt="Optimizer choosing between different execution strategies" style="width:100%" />
  </div>
</div>

----

<!-- --------------------------------------------- -->
<!--             APIs and Libraries
<!-- --------------------------------------------- -->

<div class="row" style="padding: 0 0 0 0">
  <div class="col-sm-12" style="text-align: center;">
    <h1 id="apis-and-libs"><b>APIs and Libraries</b></h1>
  </div>
</div>

----

<!-- Data Streaming API -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="streaming_api"><i>Streaming Data Applications</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-5">
    <p class="lead">The <i>DataStream</i> API supports functional transformations on data streams, with user-defined state, and flexible windows.</p>
    <p class="lead">The example shows how to compute a sliding histogram of word occurrences of a data stream of texts.</p>
  </div>
  <div class="col-sm-7">
    <p class="lead">WindowWordCount in Flink's DataStream API</p>
{% highlight scala %}
case class Word(word: String, freq: Long)

val texts: DataStream[String] = ...

val counts = text
  .flatMap { line => line.split("\\W+") }
  .map { token => Word(token, 1) }
  .keyBy("word")
  .timeWindow(Time.seconds(5), Time.seconds(1))
  .sum("freq")
{% endhighlight %}
  </div>
</div>

----

<!-- Batch Processing API -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="batch_api"><i>Batch Processing Applications</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-5">
    <p class="lead">Flink's <i>DataSet</i> API lets you write beautiful type-safe and maintainable code in Java or Scala. It supports a wide range of data types beyond key/value pairs, and a wealth of operators.</p>
    <p class="lead">The example shows the core loop of the PageRank algorithm for graphs.</p>
  </div>
  <div class="col-sm-7">
{% highlight scala %}
case class Page(pageId: Long, rank: Double)
case class Adjacency(id: Long, neighbors: Array[Long])

val result = initialRanks.iterate(30) { pages =>
  pages.join(adjacency).where("pageId").equalTo("id") {

    (page, adj, out: Collector[Page]) => {
      out.collect(Page(page.pageId, 0.15 / numPages))

      val nLen = adj.neighbors.length
      for (n <- adj.neighbors) {
        out.collect(Page(n, 0.85 * page.rank / nLen))
      }
    }
  }
  .groupBy("pageId").sum("rank")
}
{% endhighlight %}
  </div>
</div>

----

<!-- Library Ecosystem -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="libraries"><i>Library Ecosystem</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Flink's stack offers libraries with high-level APIs for different use cases: Complex Event Processing, Machine Learning, and Graph Analytics.</p>
    <p class="lead">The libraries are currently in <i>beta</i> status and are heavily developed.</p>
  </div>
  <div class="col-sm-6 img-column">
    <img src="{{ site.baseurl }}/img/flink-stack-frontpage.png" alt="Flink Stack with Libraries" style="width:100%" />
  </div>
</div>

----

<!-- --------------------------------------------- -->
<!--             Ecosystem
<!-- --------------------------------------------- -->

<div class="row" style="padding: 0 0 0 0">
  <div class="col-sm-12" style="text-align: center;">
    <h1><b>Ecosystem</b></h1>
  </div>
</div>

----

<!-- Ecosystem -->
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12">
    <h1 id="ecosystem"><i>Broad Integration</i></h1>
  </div>
</div>
<div class="row">
  <div class="col-sm-6">
    <p class="lead">Flink is integrated with many other projects in the open-source data processing ecosystem.</p>
    <p class="lead">Flink runs on YARN, works with HDFS, streams data from Kafka, can execute Hadoop program code, and connects to various other data storage systems.</p>
  </div>
  <div class="col-sm-6  img-column">
    <img src="{{ site.baseurl }}/img/features/ecosystem_logos.png" alt="Other projects that Flink is integrated with" style="width:75%" />
  </div>
</div>
