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

以下这些是 Flink 项目中经常会被问到的**常见**问题。

如果你还有其他问题，请先查阅[文档]({{site.docs-stable}})或[咨询社区]({{ site.baseurl }}/zh/gettinghelp.html)。

{% toc %}


# 常见问题

## Apache Flink 仅适用于（近）实时处理场景吗？

Flink 是一个非常通用的系统，它以 *数据流* 为核心，用于数据处理和数据驱动的应用程序。这些数据流可以是实时数据流或存储的历史数据流。例如，Flink 认为文件是存储的字节流。因此，Flink 同时支持实时数据处理和批处理应用程序。

流可以是 *无界的* （不会结束，源源不断地发生事件）或 *有界的* （流有开始和结束）。例如，来自消息队列的 Twitter 信息流或事件流通常是无界的流，而来自文件的字节流是有界的流。

## 如果一切都是流，为什么 Flink 中同时有 DataStream 和 DataSet API？

处理有界流的数据通常比无界流更有效。在（近）实时要求的系统中，处理无限的事件流要求系统能够立即响应事件并产生中间结果（通常具有低延迟）。处理有界流通常不需要产生低延迟结果，因为无论如何数据都有点旧（相对而言）。这样 Flink 就能以更加简单有效的方式去处理数据。

*DataStream* API 基于一个支持低延迟和对事件和时间（包括事件时间）灵活反应的模型，用来连续处理无界流和有界流。

*DataSet* API 具有通常可加速有界数据流处理的技术。在未来，社区计划将这些优化与 DataStream API 中的技术相结合。

## Flink 与 Hadoop 软件栈是什么关系?

Flink 独立于[Apache Hadoop](https://hadoop.apache.org/)，且能在没有任何 Hadoop 依赖的情况下运行。

但是，Flink 可以很好的集成很多 Hadoop 组件，例如 *HDFS*、*YARN* 或 *HBase*。
当与这些组件一起运行时，Flink 可以从 HDFS 读取数据，或写入结果和检查点（checkpoint）/快照（snapshot）数据到 HDFS 。
Flink 还可以通过 YARN 轻松部署，并与 YARN 和 HDFS Kerberos 安全模块集成。

## Flink 运行的其他软件栈是什么？

用户还可以在 [Kubernetes](https://kubernetes.io)、 [Mesos](https://mesos.apache.org/) 或 [Docker](https://www.docker.com/) 上运行 Flink，甚至可以独立部署。

## 使用Flink的先决条件是什么？

  - 你需要 *Java 8* 来运行 Flink 作业/应用程序。
  - Scala API（可选）依赖 Scala 2.11。
  - 避免单点故障的高可用性配置需要有 [Apache ZooKeeper](https://zookeeper.apache.org/)。
  - 对于可以从故障中恢复的高可用流处理配置，Flink 需要某种形式的分布式存储用于保存检查点（HDFS / S3 / NFS / SAN / GFS / Kosmos / Ceph / ...）。

## Flink支持多大的规模？

用户可以同时在小集群（少于5个节点）和拥有 TB 级别状态的1000个节点上运行 Flink 任务。

## Flink是否仅限于内存数据集？

对于 DataStream API，Flink 通过配置 RocksDB 状态后端来支持大于内存的状态。

对于 DataSet API，所有操作（除增量迭代外）都可以扩展到主内存之外。

# 常见错误消息

常见错误消息在[获得帮助]({{ site.baseurl }}/zh/gettinghelp.html#got-an-error-message)页面上。
