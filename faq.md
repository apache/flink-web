---
title: "Frequently Asked Questions (FAQ)"
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

The following questions are frequently asked with regard to the Flink project **in general**.
If you have further questions, make sure to consult the [documentation]({{site.docs-snapshot}}) or [ask the community]({{ site.baseurl }}/community.html).

{% toc %}


# General

## Is Apache Flink only for (near) real-time processing use cases?

Flink is a very general system for data processing and data-driven applications with *data streams* as
the core building block. These data streams can be streams of real-time data, or stored streams of historic data.
For example, in Flink's view a file is a stored stream of bytes. Because of that, Flink
supports both real-time data processing and applications, as well as batch processing applications.

Streams can be *unbounded* (have no end, events continuously keep coming) or be *bounded* (streams have a beginning
and an end). For example, a Twitter feed or a stream of events from a message queue are generally unbounded streams,
whereas a stream of bytes from a file is a bounded stream.

## If everything is a stream, why are there a DataStream and a DataSet API in Flink?

Bounded streams are often more efficient to process than unbounded streams. Processing unbounded streams of events
in (near) real-time requires the system to be able to immediately act on events and to produce intermediate
results (often with low latency). Processing bounded streams usually does not require to produce low latency results, because the data is a while old
anyway (in relative terms). That allows Flink to process the data in a simple and more efficient way.

The *DataStream* API captures the continuous processing of unbounded and bounded streams, with a model that supports
low latency results and flexible reaction to events and time (including event time).

The *DataSet* API has techniques that often speed up the processing of bounded data streams. In the future, the community
plans to combine these optimizations with the techniques in the DataStream API.

## How does Flink relate to the Hadoop Stack?

Flink is independent of [Apache Hadoop](https://hadoop.apache.org/) and runs without any Hadoop dependencies.

However, Flink integrates very well with many Hadoop components, for example *HDFS*, *YARN*, or *HBase*.
When running together with these components, Flink can use HDFS to read data, or write results and checkpoints/snapshots.
Flink can be easily deployed via YARN and integrates with the YARN and HDFS Kerberos security modules.

## What other stacks does Flink run in?

Users run Flink on [Kubernetes](https://kubernetes.io), [Mesos](https://mesos.apache.org/),
[Docker](https://www.docker.com/), or even as standalone services.

## What are the prerequisites to use Flink?

  - You need *Java 8* to run Flink jobs/applications.
  - The Scala API (optional) depends on Scala 2.11.
  - Highly-available setups with no single point of failure require [Apache ZooKeeper](https://zookeeper.apache.org/).
  - For highly-available stream processing setups that can recover from failures, Flink requires some form of distributed storage for checkpoints (HDFS / S3 / NFS / SAN / GFS / Kosmos / Ceph / ...).

## What scale does Flink support?

Users are running Flink jobs both in very small setups (fewer than 5 nodes) and on 1000s of nodes and with TBs of state.

## Is Flink limited to in-memory data sets?

For the DataStream API, Flink supports larger-than-memory state be configuring the RocksDB state backend.

For the DataSet API, all operations (except delta-iterations) can scale beyond main memory.


# Debugging and Common Error Messages

## I have a NotSerializableException.

Flink uses Java serialization to distribute copies of the application logic (the functions and operations you implement,
as well as the program configuration, etc.) to the parallel worker processes.
Because of that, all functions that you pass to the API must be serializable, as defined by
[java.io.Serializable](http://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html).

If your function is an anonymous inner class, consider the following:
  - make the function a standalone class, or a static inner class
  - use a Java 8 lambda function.

Is your function is already a static class, check the fields that you assign when you create
an instance of the class. One of the fields most likely holds a non-serializable type.
  - In Java, use a `RichFunction` and initialize the problematic fields in the `open()` method.
  - In Scala, you can often simply use “lazy val” to defer initialization until the distributed execution happens. This may come at a minor performance cost. You can naturally also use a `RichFunction` in Scala.

## Using the Scala API, I get an error about implicit values and evidence parameters.

This error means that the implicit value for the type information could not be provided.
Make sure that you have an `import org.apache.flink.streaming.api.scala._` (DataStream API) or an
`import org.apache.flink.api.scala._` (DataSet API) statement in your code.

If you are using Flink operations inside functions or classes that take
generic parameters, then a TypeInformation must be available for that parameter.
This can be achieved by using a context bound:

~~~scala
def myFunction[T: TypeInformation](input: DataSet[T]): DataSet[Seq[T]] = {
  input.reduceGroup( i => i.toSeq )
}
~~~

See [Type Extraction and Serialization]({{ site.docs-snapshot }}/dev/types_serialization.html) for
an in-depth discussion of how Flink handles types.

## I see a ClassCastException: X cannot be cast to X.

When you see an exception in the style `com.foo.X` cannot be cast to `com.foo.X` (or cannot be assigned to `com.foo.X`), it means that
multiple versions of the class `com.foo.X` have been loaded by different class loaders, and types of that class are attempted to be assigned to each other.

The reason for that can be:

  - Class duplication through `child-first` classloading. That is an intended mechanism to allow users to use different versions of the same
    dependencies that Flink uses. However, if different copies of these classes move between Flink's core and the user application code, such an exception
    can occur. To verify that this is the reason, try setting `classloader.resolve-order: parent-first` in the configuration.
    If that makes the error disappear, please write to the mailing list to check if that may be a bug.

  - Caching of classes from different execution attempts, for example by utilities like Guava’s Interners, or Avro's Schema cache.
    Try to not use interners, or reduce the scope of the interner/cache to make sure a new cache is created whenever a new task
    execution is started.

## I have an AbstractMethodError or NoSuchFieldError.

Such errors typically indicate a mix-up in some dependency version. That means a different version of a dependency (a library)
is loaded during the execution compared to the version that code was compiled against.

From Flink 1.4.0 on, dependencies in your application JAR file may have different versions compared to dependencies used
by Flink's core, or other dependencies in the classpath (for example from Hadoop). That requires `child-first` classloading
to be activated, which is the default.

If you see these problems in Flink 1.4+, one of the following may be true:
  - You have a dependency version conflict within your application code. Make sure all your dependency versions are consistent.
  - You are conflicting with a library that Flink cannot support via `child-first` classloading. Currently these are the
    Scala standard library classes, as well as Flink's own classes, logging APIs, and any Hadoop core classes.


## My DataStream application produces no output, even though events are going in.

If your DataStream application uses *Event Time*, check that your watermarks get updated. If no watermarks are produced,
event time windows might never trigger, and the application would produce no results.

You can check in Flink's web UI (watermarks section) whether watermarks are making progress.

## I see an exception reporting "Insufficient number of network buffers".

If you run Flink with a very high parallelism, you may need to increase the number of network buffers.

By default, Flink takes 10% of the JVM heap size for network buffers, with a minimum of 64MB and a maximum of 1GB.
You can adjust all these values via `taskmanager.network.memory.fraction`, `taskmanager.network.memory.min`, and
`taskmanager.network.memory.max`.

Please refer to the [Configuration Reference]({{ site.docs-snapshot }}/ops/config.html#configuring-the-network-buffers) for details.

## My job fails with various exceptions from the HDFS/Hadoop code. What can I do?

The most common cause for that is that the Hadoop version in Flink's classpath is different than the
Hadoop version of the cluster you want to connect to (HDFS / YARN).

The easiest way to fix that is to pick a Hadoop-free Flink version and simply export the Hadoop path and
classpath from the cluster.

