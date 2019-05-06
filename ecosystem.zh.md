---
title: "生态系统"
---
<br>
Apache Flink 支持广泛的生态系统，并能与许多其他数据处理项目和框架无缝协作。
<br>
{% toc %}

## Connectors

<p>Connector 用于与各种第三方系统进行连接。</p>

<p>
下表中所列出的是 Flink 生态中的 Connector。我们非常欢迎 Connector 的作者将为
Flink 编写的 Connector 也加入到下表中与更多 Flink 用户进行分享。如果您希望
将您的 Connector 加入列表，请参照 <a href="{{site.docs-stable}}/improve-website.html">改进 Flink 网站</a>
提交 Jira Ticket 以及相应的 Github Pull Request。
</p>

### 消息队列
<table class="table table-bordered">
  <tr>
    <th>对接系统</th>
    <th>Connector 类型</th>
    <th>源代码位置</th>
    <th>License</th>
    <th>最近发布时间</th>
    <th>可用API</th>
    <th>兼容的 Flink 版本号</th>
    <th>维护者</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/kafka.html" target="_blank">Apache Kafka</a></td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream/Table</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/rabbitmq.html" target="_blank">RabbitMQ</a></td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/kinesis.html" target="_blank">Amazon Kinesis Streams</a></td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-activemq" target="_blank">Apache ActiveMQ</a></td>
    <td>sink</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Bahir</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-flume/" target="_blank">Apache Flume</a></td>
    <td>sink</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Bahir</td>
  </tr>
</table>

### 文件系统 / 数据存储系统
<table class="table table-bordered">
  <tr>
    <th>对接系统</th>
    <th>Connector 类型</th>
    <th>源代码位置</th>
    <th>License</th>
    <th>最近发布时间</th>
    <th>可用API</th>
    <th>兼容的 Flink 版本号</th>
    <th>维护者</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/filesystem_sink.html" target="_blank">HDFS</a></td>
    <td>sink</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataSet / Table</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/streamfile_sink.html" target="_blank">Others File Systems (S3, others)</a></td>
    <td>sink</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataSet / Table</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/current/flink-streaming-kudu/" target="_blank">Apache Kudu</a></td>
    <td>sink/source</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>N/A</td>
    <td>DataStream/DataSet</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Bahir</td>
  </tr>
</table>

### 数据库
<table class="table table-bordered">
  <tr>
    <th>对接系统</th>
    <th>Connector 类型</th>
    <th>源代码位置</th>
    <th>License</th>
    <th>最近发布时间</th>
    <th>可用API</th>
    <th>兼容的 Flink 版本号</th>
    <th>维护者</th>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/current/flink-streaming-influxdb/" target="_blank">InfluxDB</a></td>
    <td>sink</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Bahir</td>
  </tr>
  <tr>
    <td>JDBC</td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>Table / DataSet</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
</table>

### 键值库
<table class="table table-bordered">
  <tr>
    <th>对接系统</th>
    <th>Connector 类型</th>
    <th>源代码位置</th>
    <th>License</th>
    <th>最近发布时间</th>
    <th>可用API</th>
    <th>兼容的 Flink 版本号</th>
    <th>维护者</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/cassandra.html" target="_blank">Apache Cassandra</a></td>
    <td>sink</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream/Table</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-redis/" target="_blank">Redis</a></td>
    <td>sink/source</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Bahir</td>
  </tr>
  <tr>
    <td>HBase</td>
    <td>source</td>
    <td><a href="https://github.com/apache/flink/tree/master/flink-connectors/flink-hbase">Apache Flink</a></td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataSet / Table</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
</table>

### 搜索引擎
<table class="table table-bordered">
  <tr>
    <th>对接系统</th>
    <th>Connector 类型</th>
    <th>源代码位置</th>
    <th>License</th>
    <th>最近发布时间</th>
    <th>可用API</th>
    <th>兼容的 Flink 版本号</th>
    <th>维护者</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/elasticsearch.html" target="_blank">Elasticsearch 1.x / 2.x / 5.x / 6.x</a></td>
    <td>sink</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream/Table</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
</table>

### 其他
<table class="table table-bordered">
  <tr>
    <th>对接系统</th>
    <th>Connector 类型</th>
    <th>源代码位置</th>
    <th>License</th>
    <th>最近发布时间</th>
    <th>可用API</th>
    <th>兼容的 Flink 版本号</th>
    <th>维护者</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/twitter.html" target="_blank">Twitter</a></td>
    <td>source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/nifi.html" target="_blank">Apache NiFi</a></td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-akka/" target="_blank">Akka</a></td>
    <td>Source</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Bahir</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-netty/" target="_blank">Netty</a></td>
    <td>source</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>{{site.stable}}.x</td>
    <td>Apache Bahir</td>
  </tr>
</table>

要使用其中的某个 connector 来运行应用程序，用户通常需要额外安装和启动第三方组件，例如消息队列服务器。有关第三方组件的进一步说明，请参阅相应的小节。

## 第三方项目

这是基于 Flink 构建的第三方软件包（包括库，系统扩展或示例）的列表。
 Flink 社区收集了这些包的链接，但不负责维护它们。
因此，它们不属于 Apache Flink 项目，社区无法为它们提供任何支持。
**是否遗漏了您的项目？**
请通过[用户或开发者邮件列表]({{ site.baseurl }}/zh/community.html#mailing-lists)告诉我们。

**Alluxio**

[Alluxio](http://www.alluxio.org/) 是一个开源的，能匹配内存速度的虚拟分布式存储，使应用程序能够在[统一的命名空间](http://www.alluxio.org/docs/master/en/Unified-and-Transparent-Namespace.html)中有效地共享数据并跨不同存储系统访问数据。以下是[使用 Flink 通过 Alluxio 访问数据的示例](http://www.alluxio.org/docs/master/en/Running-Flink-on-Alluxio.html)。

**Apache Beam**

[Apache Beam](https://beam.apache.org/) 是一种开源统一的编程模型，可用于创建数据处理管道。 Flink 是 Beam 编程模型支持的后端引擎之一。

**Apache Ignite**

[Apache Ignite](https://ignite.apache.org) 是一个高性能，集成和分布式的内存计算和事务平台，用于实时处理大规模数据集。请参阅 [Flink sink streaming connector](https://github.com/apache/ignite/tree/master/modules/flink) 以将数据写入 Ignite 缓存。

**Apache Mahout**

[Apache Mahout](https://mahout.apache.org/) 是一个机器学习库，很快会将 Flink 作为执行引擎。可以查看 Sebastian Schelter 在 Flink Forward 会议上关于 Mahout-Samsara DSL 的[演讲](http://www.slideshare.net/FlinkForward/sebastian-schelter-distributed-machine-learing-with-the-samsara-dsl)。

**Apache Zeppelin**

[Apache Zeppelin](https://zeppelin.apache.org/) 是一个 Web 笔记形式的交互式数据查询分析工具，它可以使用 [Flink作为执行引擎](https://zeppelin.apache.org/docs/latest/interpreter/flink.html)。可以查看 Jim Dowling 在 Flink Forward 会议上关于在 Flink 上使用 Zeppelin 的[演讲](http://www.slideshare.net/FlinkForward/jim-dowling-interactive-flink-analytics-with-hopsworks-and-zeppelin)。

**GRADOOP**

[GRADOOP](http://dbs.uni-leipzig.de/en/research/projects/gradoop) 是在 Leipzig 大学开发的，用于在 Flink 之上实现可扩展的图形分析。请参阅 Martin Junghanns 在 [Flink Forward 会议上的演讲](http://www.slideshare.net/FlinkForward/martin-junghans-gradoop-scalable-graph-analytics-with-apache-flink)。

**Nussknacker**

[Nussknacker](https://github.com/TouK/nussknacker/) 是一个开源的 Apache Flink 流程编写工具。Nussknacker 提供了一个简单易用的图形化界面来帮助你设计、部署和监控流处理程序。它利用 Apache Flink 的强大功能、性能和可靠性来快速准确的执行处理程序。

## 非 JVM 语言的示例

**Python示例**

使用 Apache Flink 的 Python API 的[一组示例](https://github.com/wdm0006/flink-python-examples)。

**使用 Clojure 编写的 WordCount 示例**

关于如何在 Clojure 中编写 Flink 程序的 [WordCount示例](https://github.com/mjsax/flink-external/tree/master/flink-clojure)。
