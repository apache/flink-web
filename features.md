---
title: "Features"
---

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

Batch programs are as a special case of streaming programs as data inside the system is streamed all the way, including **pipelined shuffles**.
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
