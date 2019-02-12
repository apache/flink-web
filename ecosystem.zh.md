---
title: "生态系统"
---
<br>
Apache Flink 支持广泛的生态系统，并能与许多其他数据处理项目和框架无缝协作。
<br>
{% toc %}

## Connectors

<p>Connector 用于与各种第三方系统进行连接。</p>

<p>目前支持这些系统：</p>

<ul>
  <li><a href="{{site.docs-stable}}/dev/connectors/kafka.html" target="_blank">Apache Kafka</a> (sink/source)</li>
  <li><a href="{{site.docs-stable}}/dev/connectors/elasticsearch.html" target="_blank">Elasticsearch 1.x / 2.x / 5.x / 6.x</a> (sink)</li>
  <li><a href="{{site.docs-stable}}/dev/connectors/filesystem_sink.html" target="_blank">HDFS</a> (sink)</li>
  <li><a href="{{site.docs-stable}}/dev/connectors/rabbitmq.html" target="_blank">RabbitMQ</a> (sink/source)</li>
  <li><a href="{{site.docs-stable}}/dev/connectors/kinesis.html" target="_blank">Amazon Kinesis Streams</a> (sink/source)</li>
  <li><a href="{{site.docs-stable}}/dev/connectors/twitter.html" target="_blank">Twitter</a> (source)</li>
  <li><a href="{{site.docs-stable}}/dev/connectors/nifi.html" target="_blank">Apache NiFi</a> (sink/source)</li>
  <li><a href="{{site.docs-stable}}/dev/connectors/cassandra.html" target="_blank">Apache Cassandra</a> (sink)</li>
  <li><a href="https://github.com/apache/bahir-flink" target="_blank">Redis, Flume, and ActiveMQ (via Apache Bahir)</a> (sink)</li>
</ul>

要使用其中的某个 connector 来运行应用程序，用户通常需要额外安装和启动第三方组件，例如消息队列服务器。有关第三方组件的进一步说明，请参阅相应的小节。

## 第三方项目

这是基于 Flink 构建的第三方软件包（包括库，系统扩展或示例）的列表。
 Flink 社区收集了这些包的链接，但不负责维护它们。
因此，它们不属于 Apache Flink 项目，社区无法为它们提供任何支持。
**是否遗漏了您的项目？**
请通过[用户或开发者邮件列表]({{ site.baseurl }}/zh/community.html#mailing-lists)告诉我们。

**Apache Zeppelin**

[Apache Zeppelin](https://zeppelin.apache.org/) 是一个 Web 笔记形式的交互式数据查询分析工具，它可以使用 [Flink作为执行引擎](https://zeppelin.apache.org/docs/latest/interpreter/flink.html)。可以查看 Jim Dowling 在 Flink Forward 会议上关于在 Flink 上使用 Zeppelin 的[演讲](http://www.slideshare.net/FlinkForward/jim-dowling-interactive-flink-analytics-with-hopsworks-and-zeppelin)。

**Apache Mahout**

[Apache Mahout](https://mahout.apache.org/) 是一个机器学习库，很快会将 Flink 作为执行引擎。可以查看 Sebastian Schelter 在 Flink Forward 会议上关于 Mahout-Samsara DSL 的[演讲](http://www.slideshare.net/FlinkForward/sebastian-schelter-distributed-machine-learing-with-the-samsara-dsl)。

**Cascading**

[Cascading](http://www.cascading.org/cascading-flink/) 使用户可以在 Flink 和其他执行引擎上轻松构建复杂的工作流。
[Cascading on Flink](https://github.com/dataArtisans/cascading-flink) 项目是由 [dataArtisans](http://data-artisans.com/) 和 [Driven, Inc](http://www.driven.io/) 建立。请参阅 Fabian Hueske 在 [Flink Forward 会议上的演讲](http://www.slideshare.net/FlinkForward/fabian-hueske-training-cascading-on-flink)以获取更多细节。

**Apache Beam**

[Apache Beam](https://beam.apache.org/) 是一种开源统一的编程模型，可用于创建数据处理管道。 Flink 是 Beam 编程模型支持的后端引擎之一。

**GRADOOP**

[GRADOOP](http://dbs.uni-leipzig.de/en/research/projects/gradoop) 是在 Leipzig 大学开发的，用于在 Flink 之上实现可扩展的图形分析。请参阅 Martin Junghanns 在 [Flink Forward 会议上的演讲](http://www.slideshare.net/FlinkForward/martin-junghans-gradoop-scalable-graph-analytics-with-apache-flink)。

**BigPetStore**

[BigPetStore](https://github.com/apache/bigtop/tree/master/bigtop-bigpetstore) 是一个包含数据生成器的基准测试套件，很快就可以用于 Flink 。 请参阅 Suneel Marthi 在 [Flink Forward 会议上的演讲](http://www.slideshare.net/FlinkForward/suneel-marthi-bigpetstore-flink-a-comprehensive-blueprint-for-apache-flink?ref=http://flink-forward.org/?session=tbd-3)。

**FastR**

[FastR](https://github.com/oracle/fastr) 是 Java 中 R 语言的实现。 [FastR Flink](https://bitbucket.org/allr/fastr-flink/src/3535a9b7c7f208508d6afbcdaf1de7d04fa2bf79/README_FASTR_FLINK.md?at=default&fileviewer=file-view-default) 可以在 Flink 之上执行 R 任务。

**Apache SAMOA**

[Apache SAMOA (incubating)](https://samoa.incubator.apache.org/) 是一个流式的机器学习库，很快将支持 Flink 作为执行引擎。 Albert Bifet 在 [Flink Forward 会议上的演讲](http://www.slideshare.net/FlinkForward/albert-bifet-apache-samoa-mining-big-data-streams-with-apache-flink?ref=http://flink-forward.org/?session=apache-samoa-mining-big-data-streams-with-apache-flink)中介绍了 SAMOA。

**Alluxio**

[Alluxio](http://www.alluxio.org/) 是一个开源的，能匹配内存速度的虚拟分布式存储，使应用程序能够在[统一的命名空间](http://www.alluxio.org/docs/master/en/Unified-and-Transparent-Namespace.html)中有效地共享数据并跨不同存储系统访问数据。以下是[使用 Flink 通过 Alluxio 访问数据的示例](http://www.alluxio.org/docs/master/en/Running-Flink-on-Alluxio.html)。

**Python示例**

使用 Apache Flink 的 Python API 的[一组示例](https://github.com/wdm0006/flink-python-examples)。

**使用 Clojure 编写的 WordCount 示例**

关于如何在 Clojure 中编写 Flink 程序的 [WordCount示例](https://github.com/mjsax/flink-external/tree/master/flink-clojure)。

**异常检测与预测**

[flink-htm](https://github.com/nupic-community/flink-htm) 是 Apache Flink 中用于异常检测和预测的库。该算法基于由 Numenta 智能计算平台（NuPIC）实现的 Hierarchical Temporal Memory（HTM）。

**Apache Ignite**

[Apache Ignite](https://ignite.apache.org) 是一个高性能，集成和分布式的内存计算和事务平台，用于实时处理大规模数据集。请参阅 [Flink sink streaming connector](https://github.com/apache/ignite/tree/master/modules/flink) 以将数据写入 Ignite 缓存。

**Tink 时态图库**

[Tink](https://github.com/otherwise777/Temporal_Graph_library) 
是一个建立在 Flink 之上的时态图库。它可以分析时态图，如对最短时间路径算法的不同解释，以及诸如时间间隔和时间紧密度之类的度量。这里是 Wouter Ligtenberg 的[论文](http://www.win.tue.nl/~gfletche/ligtenberg2017.pdf)。
