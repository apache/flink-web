---
title: "Ecosystem"
---
<br>
Apache Flink supports a broad ecosystem and works seamlessly with
many other data processing projects and frameworks.
<br>
{% toc %}

## Connectors

<p>Connectors provide code for interfacing with various third-party systems.</p>

<p>
  The following tables list the connectors that are available in the Flink ecosystem.
  Connector authors are welcome to add their connector to this list via a Github
  Pull Request. See <a href="{{site.docs-stable}}/improve-website.html">Improve the Website</a>
  for more details.
</p>

### Message Queue
<table class="table table-bordered">
  <tr>
    <th>System Name</th>
    <th>Connector Type</th>
    <th>Location</th>
    <th>License</th>
    <th>Last Released</th>
    <th>Available For</th>
    <th>Maintained By</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/kafka.html" target="_blank">Apache Kafka</a></td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream/Table</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/rabbitmq.html" target="_blank">RabbitMQ</a></td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/kinesis.html" target="_blank">Amazon Kinesis Streams</a></td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-activemq" target="_blank">Apache ActiveMQ</a></td>
    <td>sink</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>Apache Bahir</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-flume/" target="_blank">Apache Flume</a></td>
    <td>sink</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>Apache Bahir</td>
  </tr>
</table>

### File System / Data Store
<table class="table table-bordered">
  <tr>
    <th>System Name</th>
    <th>Connector Type</th>
    <th>Location</th>
    <th>License</th>
    <th>Last Released</th>
    <th>Available For</th>
    <th>Maintained By</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/streamfile_sink.html" target="_blank">File Systems</a> (S3, <a href="{{site.docs-stable}}/dev/connectors/filesystem_sink.html" target="_blank">HDFS</a>, others)</td>
    <td>sink</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataSet / Table / DataStream (source only)</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/current/flink-streaming-kudu/" target="_blank">Apache Kudu</a></td>
    <td>sink/source</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>N/A</td>
    <td>DataStream/DataSet</td>
    <td>Apache Bahir</td>
  </tr>
</table>

### Database
<table class="table table-bordered">
  <tr>
    <th>System Name</th>
    <th>Connector Type</th>
    <th>Location</th>
    <th>License</th>
    <th>Last Released</th>
    <th>Available For</th>
    <th>Maintained By</th>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/current/flink-streaming-influxdb/" target="_blank">InfluxDB</a></td>
    <td>sink</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>Apache Bahir</td>
  </tr>
  <tr>
    <td>JDBC</td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>Table / DataSet</td>
    <td>Apache Flink</td>
  </tr>
</table>

### K-V Store
<table class="table table-bordered">
  <tr>
    <th>System Name</th>
    <th>Connector Type</th>
    <th>Location</th>
    <th>License</th>
    <th>Last Released</th>
    <th>Available For</th>
    <th>Maintained By</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/cassandra.html" target="_blank">Apache Cassandra</a></td>
    <td>sink</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream/Table</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-redis/" target="_blank">Redis</a></td>
    <td>sink/source</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>Apache Bahir</td>
  </tr>
  <tr>
    <td>HBase</td>
    <td>source</td>
    <td><a href="https://github.com/apache/flink/tree/master/flink-connectors/flink-hbase">Apache Flink</a></td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataSet / Table</td>
    <td>Apache Flink</td>
  </tr>
</table>

### Search Engine
<table class="table table-bordered">
  <tr>
    <th>System Name</th>
    <th>Connector Type</th>
    <th>Location</th>
    <th>License</th>
    <th>Last Released</th>
    <th>Available For</th>
    <th>Maintained By</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/elasticsearch.html" target="_blank">Elasticsearch 1.x / 2.x / 5.x / 6.x</a></td>
    <td>sink</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream/Table</td>
    <td>Apache Flink</td>
  </tr>
</table>

### Others
<table class="table table-bordered">
  <tr>
    <th>System Name</th>
    <th>Connector Type</th>
    <th>Location</th>
    <th>License</th>
    <th>Last Released</th>
    <th>Available For</th>
    <th>Maintained By</th>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/twitter.html" target="_blank">Twitter</a></td>
    <td>source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="{{site.docs-stable}}/dev/connectors/nifi.html" target="_blank">Apache NiFi</a></td>
    <td>sink/source</td>
    <td>Apache Flink</td>
    <td>Apache 2.0</td>
    <td>{{site.FLINK_VERSION_STABLE_RELEASE_DATE}}</td>
    <td>DataStream</td>
    <td>Apache Flink</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-akka/" target="_blank">Akka</a></td>
    <td>Source</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>Apache Bahir</td>
  </tr>
  <tr>
    <td><a href="http://bahir.apache.org/docs/flink/1.0/flink-streaming-netty/" target="_blank">Netty</a></td>
    <td>source</td>
    <td><a href="https://github.com/apache/bahir-flink">Apache Bahir</a></td>
    <td>Apache 2.0</td>
    <td>05/24/2017</td>
    <td>DataStream</td>
    <td>Apache Bahir</td>
  </tr>
</table>

To run an application using one of these connectors, additional third party
components are usually required to be installed and launched, e.g., the servers
for the message queues. Further instructions for these can be found in the
corresponding subsections.


## Third-Party Projects

This is a list of third party packages (i.e., libraries, system extensions, or examples) built on Flink.
The Flink community collects links to these packages but does not maintain them.
Thus, they do not belong to the Apache Flink project, and the community cannot give any support for them.
**Is your project missing?**
Please let us know on the [user/dev mailing list]({{ site.baseurl }}/community.html#mailing-lists).

**Alluxio**

[Alluxio](http://www.alluxio.org/) is an open-source memory-speed virtual distributed storage that enables applications to efficiently share data and access data across different storage systems in a [unified namespace](http://www.alluxio.org/docs/master/en/Unified-and-Transparent-Namespace.html). Here is an example of [using Flink to access data through Alluxio](http://www.alluxio.org/docs/master/en/Running-Flink-on-Alluxio.html).

**Apache Beam**

[Apache Beam](https://beam.apache.org/) is an open-source, unified programming model that you can use to create a data processing pipeline. Flink is one of the back-ends supported by the Beam programming model.

**Apache Ignite**

[Apache Ignite](https://ignite.apache.org) is a high-performance, integrated and distributed in-memory platform for computing and transacting on large-scale data sets in real-time. See [Flink sink streaming connector](https://github.com/apache/ignite/tree/master/modules/flink) to inject data into Ignite cache.

**Apache Mahout**

[Apache Mahout](https://mahout.apache.org/) is a machine learning library that will feature Flink as an execution engine soon.
Check out Sebastian Schelter's [Flink Forward talk](http://www.slideshare.net/FlinkForward/sebastian-schelter-distributed-machine-learing-with-the-samsara-dsl) about Mahout-Samsara DSL.

**Apache Zeppelin**

[Apache Zeppelin](https://zeppelin.apache.org/) is a web-based notebook that enables interactive data analytics and can be used with
[Flink as an execution engine](https://zeppelin.apache.org/docs/latest/interpreter/flink.html).
See also Jim Dowling's [Flink Forward talk](http://www.slideshare.net/FlinkForward/jim-dowling-interactive-flink-analytics-with-hopsworks-and-zeppelin) about Zeppelin on Flink.

**GRADOOP**

[GRADOOP](http://dbs.uni-leipzig.de/en/research/projects/gradoop) enables scalable graph analytics on top of Flink and is developed at Leipzig University. Check out Martin Junghanns’ [Flink Forward talk](http://www.slideshare.net/FlinkForward/martin-junghans-gradoop-scalable-graph-analytics-with-apache-flink).

**Nussknacker**

[Nussknacker](https://github.com/TouK/nussknacker/) is an open-source process authoring tool for Apache Flink. Nussknacker lets you design, deploy and monitor streaming processes using easy to use GUI. We leverage power, performance and reliability of Apache Flink to make your processes fast and accurate.

## Examples of Non-JVM Languages
**Python Examples on Flink**

A [collection of examples](https://github.com/wdm0006/flink-python-examples) using Apache Flink's Python API.

**WordCount Example in Clojure**

A small [WordCount example](https://github.com/mjsax/flink-external/tree/master/flink-clojure) on how to write a Flink program in Clojure.
