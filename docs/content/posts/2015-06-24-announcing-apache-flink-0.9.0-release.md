---
categories: news
date: "2015-06-24T14:00:00Z"
title: Announcing Apache Flink 0.9.0
---

The Apache Flink community is pleased to announce the availability of the 0.9.0 release. The release is the result of many months of hard work within the Flink community. It contains many new features and improvements which were previewed in the 0.9.0-milestone1 release and have been polished since then. This is the largest Flink release so far.

[Download the release](http://flink.apache.org/downloads.html) and check out [the documentation]({{< param DocsBaseUrl >}}flink-docs-release-0.9/). Feedback through the Flink[ mailing lists](http://flink.apache.org/community.html#mailing-lists) is, as always, very welcome!

## New Features

### Exactly-once Fault Tolerance for streaming programs

This release introduces a new fault tolerance mechanism for streaming dataflows. The new checkpointing algorithm takes data sources and also user-defined state into account and recovers failures such that all records are reflected exactly once in the operator states.

The checkpointing algorithm is lightweight and driven by barriers that are periodically injected into the data streams at the sources. As such, it has an extremely low coordination overhead and is able to sustain very high throughput rates. User-defined state can be automatically backed up to configurable storage by the fault tolerance mechanism.

Please refer to [the documentation on stateful computation]({{< param DocsBaseUrl >}}flink-docs-release-0.9/apis/streaming_guide.html#stateful-computation) for details in how to use fault tolerant data streams with Flink.

The fault tolerance mechanism requires data sources that can replay recent parts of the stream, such as [Apache Kafka](http://kafka.apache.org). Read more [about how to use the persistent Kafka source]({{< param DocsBaseUrl >}}flink-docs-release-0.9/apis/streaming_guide.html#apache-kafka).

### Table API

Flink’s new Table API offers a higher-level abstraction for interacting with structured data sources. The Table API allows users to execute logical, SQL-like queries on distributed data sets while allowing them to freely mix declarative queries with regular Flink operators. Here is an example that groups and joins two tables:

```scala
val clickCounts = clicks
  .groupBy('user).select('userId, 'url.count as 'count)

val activeUsers = users.join(clickCounts)
  .where('id === 'userId && 'count > 10).select('username, 'count, ...)
```

Tables consist of logical attributes that can be selected by name rather than physical Java and Scala data types. This alleviates a lot of boilerplate code for common ETL tasks and raises the abstraction for Flink programs. Tables are available for both static and streaming data sources (DataSet and DataStream APIs).

[Check out the Table guide for Java and Scala]({{< param DocsBaseUrl >}}flink-docs-release-0.9/libs/table.html).

### Gelly Graph Processing API

Gelly is a Java Graph API for Flink. It contains a set of utilities for graph analysis, support for iterative graph processing and a library of graph algorithms. Gelly exposes a Graph data structure that wraps DataSets for vertices and edges, as well as methods for creating graphs from DataSets, graph transformations and utilities (e.g., in- and out- degrees of vertices), neighborhood aggregations, iterative vertex-centric graph processing, as well as a library of common graph algorithms, including PageRank, SSSP, label propagation, and community detection.

Gelly internally builds on top of Flink’s[ delta iterations]({{< param DocsBaseUrl >}}flink-docs-release-0.9/apis/iterations.html). Iterative graph algorithms are executed leveraging mutable state, achieving similar performance with specialized graph processing systems.

Gelly will eventually subsume Spargel, Flink’s Pregel-like API.

Note: The Gelly library is still in beta status and subject to improvements and heavy performance tuning.

[Check out the Gelly guide]({{< param DocsBaseUrl >}}flink-docs-release-0.9/libs/gelly_guide.html).

### Flink Machine Learning Library

This release includes the first version of Flink’s Machine Learning library. The library’s pipeline approach, which has been strongly inspired by scikit-learn’s abstraction of transformers and predictors, makes it easy to quickly set up a data processing pipeline and to get your job done.

Flink distinguishes between transformers and predictors. Transformers are components which transform your input data into a new format allowing you to extract features, cleanse your data or to sample from it. Predictors on the other hand constitute the components which take your input data and train a model on it. The model you obtain from the learner can then be evaluated and used to make predictions on unseen data.

Currently, the machine learning library contains transformers and predictors to do multiple tasks. The library supports multiple linear regression using stochastic gradient descent to scale to large data sizes. Furthermore, it includes an alternating least squares (ALS) implementation to factorizes large matrices. The matrix factorization can be used to do collaborative filtering. An implementation of the communication efficient distributed dual coordinate ascent (CoCoA) algorithm is the latest addition to the library. The CoCoA algorithm can be used to train distributed soft-margin SVMs.

Note: The ML library is still in beta status and subject to improvements and heavy performance tuning.

[Check out FlinkML]({{< param DocsBaseUrl >}}flink-docs-release-0.9/libs/ml/)

### Flink on YARN leveraging Apache Tez

We are introducing a new execution mode for Flink to be able to run restricted Flink programs on top of[ Apache Tez](http://tez.apache.org). This mode retains Flink’s APIs, optimizer, as well as Flink’s runtime operators, but instead of wrapping those in Flink tasks that are executed by Flink TaskManagers, it wraps them in Tez runtime tasks and builds a Tez DAG that represents the program.

By using Flink on Tez, users have an additional choice for an execution platform for Flink programs. While Flink’s distributed runtime favors low latency, streaming shuffles, and iterative algorithms, Tez focuses on scalability and elastic resource usage in shared YARN clusters.

[Get started with Flink on Tez]({{< param DocsBaseUrl >}}flink-docs-release-0.9/setup/flink_on_tez.html).

### Reworked Distributed Runtime on Akka

Flink’s RPC system has been replaced by the widely adopted[ Akka](http://akka.io) framework. Akka’s concurrency model offers the right abstraction to develop a fast as well as robust distributed system. By using Akka’s own failure detection mechanism the stability of Flink’s runtime is significantly improved, because the system can now react in proper form to node outages. Furthermore, Akka improves Flink’s scalability by introducing asynchronous messages to the system. These asynchronous messages allow Flink to be run on many more nodes than before.

### Improved YARN support

Flink’s YARN client contains several improvements, such as a detached mode for starting a YARN session in the background, the ability to submit a single Flink job to a YARN cluster without starting a session, including a "fire and forget" mode. Flink is now also able to reallocate failed YARN containers to maintain the size of the requested cluster. This feature allows to implement fault-tolerant setups on top of YARN. There is also an internal Java API to deploy and control a running YARN cluster. This is being used by system integrators to easily control Flink on YARN within their Hadoop 2 cluster.

[See the YARN docs]({{< param DocsBaseUrl >}}flink-docs-release-0.9/setup/yarn_setup.html).

### Static Code Analysis for the Flink Optimizer: Opening the UDF blackboxes

This release introduces a first version of a static code analyzer that pre-interprets functions written by the user to get information about the function’s internal dataflow. The code analyzer can provide useful information about [forwarded fields]({{< param DocsBaseUrl >}}flink-docs-release-0.9/apis/programming_guide.html#semantic-annotations) to Flink's optimizer and thus speedup job executions. It also informs if the code contains obvious mistakes. For stability reasons, the code analyzer is initially disabled by default. It can be activated through

ExecutionEnvironment.getExecutionConfig().setCodeAnalysisMode(...)

either as an assistant that gives hints during the implementation or by directly applying the optimizations that have been found.

## More Improvements and Fixes

* [FLINK-1605](https://issues.apache.org/jira/browse/FLINK-1605): Flink is not exposing its Guava and ASM dependencies to Maven projects depending on Flink. We use the maven-shade-plugin to relocate these dependencies into our own namespace. This allows users to use any Guava or ASM version.

* [FLINK-1417](https://issues.apache.org/jira/browse/FLINK-1605): Automatic recognition and registration of Java Types at Kryo and the internal serializers: Flink has its own type handling and serialization framework falling back to Kryo for types that it cannot handle. To get the best performance Flink is automatically registering all types a user is using in their program with Kryo.Flink also registers serializers for Protocol Buffers, Thrift, Avro and YodaTime automatically. Users can also manually register serializers to Kryo (https://issues.apache.org/jira/browse/FLINK-1399)

* [FLINK-1296](https://issues.apache.org/jira/browse/FLINK-1296): Add support for sorting very large records

* [FLINK-1679](https://issues.apache.org/jira/browse/FLINK-1679): "degreeOfParallelism" methods renamed to “parallelism”

* [FLINK-1501](https://issues.apache.org/jira/browse/FLINK-1501): Add metrics library for monitoring TaskManagers

* [FLINK-1760](https://issues.apache.org/jira/browse/FLINK-1760): Add support for building Flink with Scala 2.11

* [FLINK-1648](https://issues.apache.org/jira/browse/FLINK-1648): Add a mode where the system automatically sets the parallelism to the available task slots

* [FLINK-1622](https://issues.apache.org/jira/browse/FLINK-1622): Add groupCombine operator

* [FLINK-1589](https://issues.apache.org/jira/browse/FLINK-1589): Add option to pass Configuration to LocalExecutor

* [FLINK-1504](https://issues.apache.org/jira/browse/FLINK-1504): Add support for accessing secured HDFS clusters in standalone mode

* [FLINK-1478](https://issues.apache.org/jira/browse/FLINK-1478): Add strictly local input split assignment

* [FLINK-1512](https://issues.apache.org/jira/browse/FLINK-1512): Add CsvReader for reading into POJOs.

* [FLINK-1461](https://issues.apache.org/jira/browse/FLINK-1461): Add sortPartition operator

* [FLINK-1450](https://issues.apache.org/jira/browse/FLINK-1450): Add Fold operator to the Streaming api

* [FLINK-1389](https://issues.apache.org/jira/browse/FLINK-1389): Allow setting custom file extensions for files created by the FileOutputFormat

* [FLINK-1236](https://issues.apache.org/jira/browse/FLINK-1236): Add support for localization of Hadoop Input Splits

* [FLINK-1179](https://issues.apache.org/jira/browse/FLINK-1179): Add button to JobManager web interface to request stack trace of a TaskManager

* [FLINK-1105](https://issues.apache.org/jira/browse/FLINK-1105): Add support for locally sorted output

* [FLINK-1688](https://issues.apache.org/jira/browse/FLINK-1688): Add socket sink

* [FLINK-1436](https://issues.apache.org/jira/browse/FLINK-1436): Improve usability of command line interface

* [FLINK-2174](https://issues.apache.org/jira/browse/FLINK-2174): Allow comments in 'slaves' file

* [FLINK-1698](https://issues.apache.org/jira/browse/FLINK-1698): Add polynomial base feature mapper to ML library

* [FLINK-1697](https://issues.apache.org/jira/browse/FLINK-1697): Add alternating least squares algorithm for matrix factorization to ML library

* [FLINK-1792](https://issues.apache.org/jira/browse/FLINK-1792): FLINK-456 Improve TM Monitoring: CPU utilization, hide graphs by default and show summary only

* [FLINK-1672](https://issues.apache.org/jira/browse/FLINK-1672): Refactor task registration/unregistration

* [FLINK-2001](https://issues.apache.org/jira/browse/FLINK-2001): DistanceMetric cannot be serialized

* [FLINK-1676](https://issues.apache.org/jira/browse/FLINK-1676): enableForceKryo() is not working as expected

* [FLINK-1959](https://issues.apache.org/jira/browse/FLINK-1959): Accumulators BROKEN after Partitioning

* [FLINK-1696](https://issues.apache.org/jira/browse/FLINK-1696): Add multiple linear regression to ML library

* [FLINK-1820](https://issues.apache.org/jira/browse/FLINK-1820): Bug in DoubleParser and FloatParser - empty String is not casted to 0

* [FLINK-1985](https://issues.apache.org/jira/browse/FLINK-1985): Streaming does not correctly forward ExecutionConfig to runtime

* [FLINK-1828](https://issues.apache.org/jira/browse/FLINK-1828): Impossible to output data to an HBase table

* [FLINK-1952](https://issues.apache.org/jira/browse/FLINK-1952): Cannot run ConnectedComponents example: Could not allocate a slot on instance

* [FLINK-1848](https://issues.apache.org/jira/browse/FLINK-1848): Paths containing a Windows drive letter cannot be used in FileOutputFormats

* [FLINK-1954](https://issues.apache.org/jira/browse/FLINK-1954): Task Failures and Error Handling

* [FLINK-2004](https://issues.apache.org/jira/browse/FLINK-2004): Memory leak in presence of failed checkpoints in KafkaSource

* [FLINK-2132](https://issues.apache.org/jira/browse/FLINK-2132): Java version parsing is not working for OpenJDK

* [FLINK-2098](https://issues.apache.org/jira/browse/FLINK-2098): Checkpoint barrier initiation at source is not aligned with snapshotting

* [FLINK-2069](https://issues.apache.org/jira/browse/FLINK-2069): writeAsCSV function in DataStream Scala API creates no file

* [FLINK-2092](https://issues.apache.org/jira/browse/FLINK-2092): Document (new) behavior of print() and execute()

* [FLINK-2177](https://issues.apache.org/jira/browse/FLINK-2177): NullPointer in task resource release

* [FLINK-2054](https://issues.apache.org/jira/browse/FLINK-2054): StreamOperator rework removed copy calls when passing output to a chained operator

* [FLINK-2196](https://issues.apache.org/jira/browse/FLINK-2196): Missplaced Class in flink-java SortPartitionOperator

* [FLINK-2191](https://issues.apache.org/jira/browse/FLINK-2191): Inconsistent use of Closure Cleaner in Streaming API

* [FLINK-2206](https://issues.apache.org/jira/browse/FLINK-2206): JobManager webinterface shows 5 finished jobs at most

* [FLINK-2188](https://issues.apache.org/jira/browse/FLINK-2188): Reading from big HBase Tables

* [FLINK-1781](https://issues.apache.org/jira/browse/FLINK-1781): Quickstarts broken due to Scala Version Variables

## Notice

The 0.9 series of Flink is the last version to support Java 6. If you are still using Java 6, please consider upgrading to Java 8 (Java 7 ended its free support in April 2015).

Flink will require at least Java 7 in major releases after 0.9.0.
