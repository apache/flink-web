---
title: "常见问题"
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

<hr />

The following questions are frequently asked with regard to the Flink project **in general**. 

If you have further questions, make sure to consult the [documentation]({{site.docs-stable}}) or [ask the community]({{ site.baseurl }}/gettinghelp.html).

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
results (often with low latency). Processing bounded streams usually does not require producing low latency results, because the data is a while old
anyway (in relative terms). That allows Flink to process the data in a simple and more efficient way.

The *DataStream* API captures the continuous processing of unbounded and bounded streams, with a model that supports
low latency results and flexible reaction to events and time (including event time).

The *DataSet* API has techniques that often speed up the processing of bounded data streams. In the future, the community
plans to combine these optimizations with the techniques in the DataStream API.

## How does Flink relate to the Hadoop Stack?

Flink is independent of [Apache Hadoop](https://hadoop.apache.org/) and runs without any Hadoop dependencies.

However, Flink integrates very well with many Hadoop components, for example, *HDFS*, *YARN*, or *HBase*.
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

# Common Error Messages

Common error messages are listed on the [Getting Help]({{ site.baseurl }}/gettinghelp.html#got-an-error-message) page.
