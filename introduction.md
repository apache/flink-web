---
title: "Introduction to Apache Flink®"
---
<br>
Below is a high-level overview of Apache Flink and stream processing. For a more technical introduction, we recommend the <a href="{{site.docs-stable}}/concepts/programming-model.html" target="_blank">"Concepts" page</a> in the Flink documentation.
<br>
{% toc %}

## Continuous Processing for Unbounded Datasets
Before we go into detail about Flink, let’s review at a higher level the _types of datasets_ you’re likely to encounter when processing data as well as _types of execution models_ you can choose for processing. These two ideas are often conflated, and it’s useful to clearly separate them.

**First, 2 types of datasets**

+ Unbounded: Infinite datasets that are appended to continuously
+ Bounded: Finite, unchanging datasets

Many real-world data sets that are traditionally thought of as bounded or “batch” data are in reality unbounded datasets. This is true whether the data is stored in a sequence of directories on HDFS or in a log-based system like Apache Kafka.

Examples of unbounded datasets include but are not limited to:

+ End users interacting with mobile or web applications
+ Physical sensors providing measurements
+ Financial markets
+ Machine log data

**Second, 2 types of execution models**

+ Streaming: Processing that executes continuously as long as data is being produced
+ Batch: Processing that is executed and runs to completeness in a finite amount of time, releasing computing resources when finished

It’s possible, though not necessarily optimal, to process either type of dataset with either type of execution model. For instance, batch execution has long been applied to unbounded datasets despite potential problems with windowing, state management, and out-of-order data.

Flink relies on a _streaming execution model_, which is an intuitive fit for processing unbounded datasets: streaming execution is continuous processing on data that is continuously produced. And alignment between the type of dataset and the type of execution model offers many advantages with regard to accuracy and performance.


## Features: Why Flink?

Flink is an open-source framework for distributed stream processing that:

+ Provides results that are **accurate**, even in the case of out-of-order or late-arriving data
+ Is **stateful and fault-tolerant** and can seamlessly recover from failures while maintaining exactly-once application state
+ Performs at **large scale**, running on thousands of nodes with very good throughput and latency characteristics

Earlier, we discussed aligning the type of dataset (bounded vs. unbounded) with the type of execution model (batch vs. streaming). Many of the Flink features listed below--state management, handling of out-of-order data, flexible windowing--are essential for computing accurate results on unbounded datasets and are enabled by Flink's streaming execution model.

+ Flink guarantees **exactly-once semantics for stateful computations**. ‘Stateful’ means that applications can maintain an aggregation or summary of data that has been processed over time, and Flink's checkpointing mechanism ensures exactly-once semantics for an application’s state in the event of a failure.

<img class="illu" src="{{ site.baseurl }}/img/exactly_once_state.png" alt="Exactly Once State" width="389px" height="193px"/>

+ Flink supports stream processing and windowing with **event time semantics**. Event time makes it easy to compute accurate results over streams where events arrive out of order and where events may arrive delayed.

<img class="illu" src="{{ site.baseurl }}/img/out_of_order_stream.png" alt="Out Of Order Stream" width="520px" height="130px"/>

+ Flink supports **flexible windowing** based on time, count, or sessions in addition to data-driven windows. Windows can be customized with flexible triggering conditions to support sophisticated streaming patterns. Flink’s windowing makes it possible to model the reality of the environment in which data is created.

<img class="illu" src="{{ site.baseurl }}/img/windows.png" alt="Windows" width="520px" height="134px"/>

+ Flink’s **fault tolerance is lightweight** and allows the system to maintain high throughput rates and provide exactly-once consistency guarantees at the same time. Flink recovers from failures with zero data loss while the tradeoff between reliability and latency is negligible.

<img class="illu" src="{{ site.baseurl }}/img/distributed_snapshots.png" alt="Snapshots" width="260px" height="306px"/>

+ Flink is capable of **high throughput and low latency** (processing lots of data quickly). The charts below show the performance of Apache Flink and Apache Storm completing a distributed item counting task that requires streaming data shuffles.

<img class="illu" src="{{ site.baseurl }}/img/streaming_performance.png" alt="Performance" width="650px" height="232px"/>

+ Flink's **savepoints provide a state versioning mechanism**, making it possible to update applications or reprocess historic data with no lost state and minimal downtime.

<img class="illu" src="{{ site.baseurl }}/img/savepoints.png" alt="Savepoints" width="450px" height="300px"/>

+ Flink is designed to run on **large-scale clusters** with many thousands of nodes, and in addition to a standalone cluster mode, Flink provides support for YARN and Mesos.

<img class="illu" src="{{ site.baseurl }}/img/parallel_dataflows.png" alt="Parallel" width="695px" height="459px"/>

## Flink, the streaming model, and bounded datasets

If you’ve reviewed Flink’s documentation, you might have noticed both a DataStream API for working with unbounded data as well as a DataSet API for working with bounded data.

Earlier in this write-up, we introduced the streaming execution model (“processing that executes continuously, an event-at-a-time”) as an intuitive fit for unbounded datasets. So how do bounded datasets relate to the stream processing paradigm?

In Flink’s case, the relationship is quite natural. A bounded dataset can simply be treated as a special case of an unbounded one, so it’s possible to apply all of the same streaming concepts that we’ve laid out above to finite data.

This is exactly how Flink's DataSet API behaves. A bounded dataset is handled inside of Flink as a “finite stream”, with only a few minor differences in how Flink manages bounded vs. unbounded datasets.

And so it’s possible to use Flink to process both bounded and unbounded data, with both APIs running on the same distributed streaming execution engine--a simple yet powerful architecture.


## The “What”: Flink from the bottom-up

<img class="illu" src="{{ site.baseurl }}/img/flink-stack-frontpage.png" alt="Source" width="596px" height="110px"/>

### Deployment modes
Flink can run in the cloud or on premise and on a standalone cluster or on a cluster managed by YARN or Mesos.

### Runtime
Flink’s core is a distributed streaming dataflow engine, meaning that data is processed an event-at-a-time rather than as a series of batches--an important distinction, as this is what enables many of Flink’s resilience and performance features that are detailed above.

### APIs

+ Flink’s <a href="{{site.docs-stable}}/dev/datastream_api.html" target="_blank">DataStream API</a> is for programs that implement transformations on data streams (e.g., filtering, updating state, defining windows, aggregating).
+ The <a href="{{site.docs-stable}}/dev/batch/index.html" target="_blank">DataSet API</a> is for programs that implement transformations on data sets (e.g., filtering, mapping, joining, grouping).
+ The <a href="{{site.docs-stable}}/dev/table_api.html#table-api" target="_blank">Table API</a> is a SQL-like expression language for relational stream and batch processing that can be easily embedded in Flink’s DataSet and DataStream APIs (Java and Scala).
+ <a href="{{site.docs-stable}}/dev/table_api.html#sql" target="_blank">Streaming SQL</a> enables SQL queries to be executed on streaming and batch tables. The syntax is based on <a href="https://calcite.apache.org/docs/stream.html" target="_blank">Apache Calcite™</a>.

### Libraries
Flink also includes special-purpose libraries for <a href="{{site.docs-stable}}/dev/libs/cep.html" target="_blank">complex event processing</a>, <a href="{{site.docs-stable}}/dev/libs/ml/index.html" target="_blank">machine learning</a>, <a href="{{site.docs-stable}}/dev/libs/gelly/index.html" target="_blank">graph processing</a>, and <a href="{{site.docs-stable}}/dev/libs/storm_compatibility.html" target="_blank">Apache Storm compatibility</a>.

## Flink and other frameworks

At the most basic level, a Flink program is made up of:

+ **Data source:** Incoming data that Flink processes
+ **Transformations:** The processing step, when Flink modifies incoming data
+ **Data sink:** Where Flink sends data after processing

<img class="illu" src="{{ site.baseurl }}/img/source-transform-sink-update.png" alt="Source" width="1000px" height="232px"/>

A well-developed ecosystem is necessary for the efficient movement of data in and out of a Flink program, and Flink supports a wide range of connectors to third-party systems for data sources and sinks.

If you’re interested in learning more, we’ve collected [information about the Flink ecosystem here]({{ site.baseurl }}/ecosystem.html).

## Key Takeaways and Next Steps

In summary, Apache Flink is an open-source stream processing framework that eliminates the "performance vs. reliability" tradeoff often associated with open-source streaming engines and performs consistently in both categories. Following this introduction, we recommend you try our <a href="{{site.docs-stable}}/quickstart/setup_quickstart.html" target="_blank">quickstart</a>, [download]({{ site.baseurl }}/downloads.html) the most recent stable version of Flink, or review the <a href="{{site.docs-stable}}/index.html" target="_blank">documentation</a>.

And we encourage you to join the Flink [user mailing list]( {{ site.base }}/community.html#mailing-lists ) and to share your questions with the community. We’re here to help you get the most out of Flink.
