---
title: "Features"
---

<!-- System Overview -->
<div class="row" style="padding: 2em 0 0 0">
  <div class="col-sm-12">
    <h1>System Overview</h1>
    <p class="lead">Flink contains APIs in Java and Scala for analyzing data from batch and streaming data sources, as well as its own optimizer and distributed runtime with custom memory management.</p>
  </div>
</div>
<div class="row" style="padding: 0 0 2em 0">
  <div class="col-sm-12 text-center">
    <img src="{{ site.baseurl }}/img/assets/WhatIsFlink.png" alt="Apache Flink is Fast" style="width:100%" />
  </div>
</div>

<!-- Fast -->
<div class="row" style="padding: 2em 0 2em 0">
  <div class="col-sm-6">
    <h1 id="fast">Fast</h1>
    <p class="lead">Flink exploits in-memory data streaming and integrates iterative processing deeply into the system runtime.</p>
    <p class="lead">This makes the system extremely fast for data-intensive and iterative jobs.</p>
  </div>
  <div class="col-sm-6">
    <img src="{{ site.baseurl }}/img/assets/pagerank.png" alt="Apache Flink is Fast" style="width:100%" />
  </div>
</div>

<!-- Reliable and Scalable -->
<div class="row" style="padding: 2em 0 2em 0">
  <div class="col-sm-6 text-center">
    <img src="{{ site.baseurl }}/img/assets/grep.png" alt="Apache Flink is Fast" style="width:100%" />
  </div>
  <div class="col-sm-6">
    <h1 id="reliable-and-scalable">Reliable and Scalable</h1>
    <p class="lead">Flink is designed to perform well when memory runs out.</p>
    <p class="lead">Flink contains its own memory management component, serialization framework, and type inference engine.</p>
    <p class="lead">Tested in clusters of 100s of nodes, Amazon EC2, and Google Compute Engine.</p>
  </div>
</div>

<!-- Expressive -->
<div class="row">
  <div class="col-sm-12">
    <h1 id="expressive">Expressive</h1>
    <p class="lead">Write beautiful, type-safe, and maintainable code in Java or Scala. Execute it on a cluster. You can use native Java and Scala data types without packing them into key-value pairs, logical field addressing, and a wealth of operators.</p>
    <h2>WordCount in Flink's Scala API</h2>
    {% highlight scala %}
case class Word (word: String, frequency: Int)

val counts = text
  .flatMap {line => line.split(" ").map(
    word => Word(word,1))}
  .groupBy("word").sum("frequency")
    {% endhighlight %}
    <h2>Transitive Closure</h2>
    {% highlight scala %}
case class Path (from: Long, to: Long)

val tc = edges.iterate(10) { paths: DataSet[Path] =>
  val next = paths
    .join(edges).where("to").equalTo("from") {
      (path, edge) => Path(path.from, edge.to)
    }
    .union(paths).distinct()
  next
}
    {% endhighlight %}
  </div>
</div>

<!-- Easy to Use -->
<div class="row" style="padding: 2em 0 2em 0">
  <div class="col-sm-6">
    <h1 id="easy-to-use">Easy to Use</h1>
    <p class="lead">Flink requires few configuration parameters. And the system's bult-in optimizer takes care of finding the best way to execute the program in any enviroment.</p>
    <p class="lead">Run on YARN with 3 commands, in a stand-alone cluster, or locally in a debugger.</p>
  </div>
  <div class="col-sm-6 text-center">
    <img src="{{ site.baseurl }}/img/assets/optimizer-visual.png" alt="Apache Flink is easy to use" style="width:100%" />
  </div>
</div>

<!-- Compatible with Hadoop -->
<div class="row" style="padding: 2em 0 2em 0">
  <div class="col-sm-6 text-center">
    <img src="{{ site.baseurl }}/img/assets/hadoop-img.png" alt="Apache Flink is compatible with Hadoop" style="width:100%" />
  </div>
  <div class="col-sm-6">
    <h1 id="hadoop">Compatible with Hadoop</h1>
    <p class="lead">Flink supports all Hadoop input and output formats and data types</p>
    <p class="lead">You can run your legacy MapReduce operators unmodified and faster on Flink..</p>
    <p class="lead">Flink can read data from HDFS and HBase, and runs on top of YARN.</p>
  </div>
</div>

{% comment %}

<p class="lead" markdown="span">Get an overview of **how you can use Flink** and its **design**.</p>

{% toc %}

## Unified Stream &amp; Batch Processing

<p class="lead" markdown="span">Flink's core is a *distributed streaming dataflow engine*, which efficiently supports both *batch* and *stream processing applications*.</p>

<div class="row">
  <div class="col-sm-4">
    <img src="{{ site.baseurl }}/img/runtime.png" alt="Apache Flink Stack" title="Apache Flink Stack" width="100%" />
  </div>
  <div class="col-sm-8" markdown="1">

Programs written with the [fluent programming APIs]() or using the [domain-specific APIs and libraries]() are translated to dataflows for the Flink engine. Flink takes care of data distribution, communication, and fault tolerance.

Batch programs are as a special case of streaming programs as data inside the system is streamed whereever possible, including **pipelined shuffles**.
  </div>
</div>

<hr>

# Programming Flink

## Fluent Programming APIs

<p class="lead">
Write beautiful, type-safe, and maintainable code in Java or Scala. You can use native Java and Scala data types without packing them into key-value pairs, logical field addressing, and a wealth of operators.
</p>

<div class="row">
  <!-- DataSet API -->
  <div class="col-sm-4" markdown="1">
### DataSet API

**Batch Processing**. Use the DataSet API to process static inputs. The following example takes an input text and counts all distinct words in it (the infamous [WordCount]() example).

{% highlight java %}
DataSet<Tuple2<String, Integer>> counts = 
  text.flatMap(new Tokenizer())
      .groupBy(0)
      .sum(1);
{% endhighlight %}

Check out the [full example code]() and read the [programming guide]() for all features of the DataSet API.
  </div>

  <!-- DataStream API -->
  <div class="col-sm-4" markdown="1">
### DataStream API

**Stream Processing**. Use the DataStream API to process continuous streams of data. The following example counts all distinct words in a sliding window over the input stream.

{% highlight java %}
DataStream<Tuple2<String, Integer>> counts =
  text.flatMap(new Tokenizer())
      .window(Count.of(windowSize))
      .every(Count.of(slideSize))
      .groupBy(0).sum(1);
{% endhighlight %}

Check out the [full example code]() and read the [streaming guide]() for all features of the DataStream API.
  </div>

  <!-- Table API -->
  <div class="col-sm-4" markdown="1">
### Table API

**Language integrated queries**. Specify operations using SQL-like expressions. These operations work both with static inputs as well as continuous streams.

{% highlight java %}
Table table = tableEnv.toTable(text);
Table filtered = table
  .groupBy("word")
  .select("word.count as count, word")
  .filter("count = 2");
{% endhighlight %}

Check out the [full example code]() and read the [Table API guide]() for all features of the Table API.
  </div>
</div>

<br>
<hr>
<br>

## Domain-specific APIs &amp; Libraries

<p class="lead" markdown="1">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod</p>

<div class="row">
  <div class="col-sm-6" markdown="1">
### Graph API &amp; Library: Gelly
  </div>

  <div class="col-sm-6" markdown="1">
### Machine Learning Library

  </div>
</div>

<br>

## Deployment and Integration

<p class="lead" markdown="1">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod</p>

<br>

# System Design

## Stateful Operators

Applications that go beyond simple filters or line-by-line transformations of the input need stateful operators. There are three kinds of state that are offered by Flink:

- **User-defined state**: As Flink is a streaming dataflow system, operators are continuously running, and can contain user-defined state in the form of Java/Scala objects. This is the most elementary (but most flexible) operator state, but is not backed up or restored by the system in cases of failures.

- **Managed state**: User-defined operations will be able to use a special interface to put their state into an object that is backed up and restored in case of failures. Flink contains managed state internally, and the community is working on exposing this to the user-facing APIs shortly.

- **Windowed streams**: Flink offers the ability to create a finite stream from an infinite stream using (sliding) windows over the stream. The contents of those windows is special form of state that is managed by the system.

Flink uses a variation of the [Chandy-Lamport algorithm]() for consistent asynchronous distributed snapshots. The state backup works hand-in-hand with checkpoint barriers for stream replay. This allows Flink to give **exactly-once processing guarantees** by replaying parts of a stream, reproducing the results of a user program.

## Memory Management

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


## Iterative Dataflows

<div class="row">
  <div class="col-sm-4">
    <img src="{{ site.baseurl }}/img/main/section/pagerank.png" alt="Apache Flink Stack" title="Apache Flink Stack" width="100%" />
  </div>
  <div class="col-sm-8" markdown="1">

Flink exploits in-memory data streaming and integrates iterative processing deeply into the system runtime.

This makes the system extremely fast for data-intensive and iterative jobs.
  </div>
</div>


## Program Optimizer

{% endcomment %}
