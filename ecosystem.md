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

<p>Currently these systems are supported:</p>

<ul>
  <li><a href="https://ci.apache.org/projects/flink/flink-docs-release-1.2/dev/connectors/kafka.html" target="_blank">Apache Kafka</a> (sink/source)</li>
  <li><a href="https://ci.apache.org/projects/flink/flink-docs-release-1.2/dev/connectors/elasticsearch.html" target="_blank">Elasticsearch</a> (sink)</li>
  <li><a href="https://ci.apache.org/projects/flink/flink-docs-release-1.2/dev/connectors/elasticsearch2.html" target="_blank">Elasticsearch 2.x</a> (sink)</li>
  <li><a href="https://ci.apache.org/projects/flink/flink-docs-release-1.2/dev/connectors/filesystem_sink.html" target="_blank">HDFS</a> (sink)</li>
  <li><a href="https://ci.apache.org/projects/flink/flink-docs-release-1.2/dev/connectors/rabbitmq.html" target="_blank">RabbitMQ</a> (sink/source)</li>
  <li><a href="https://ci.apache.org/projects/flink/flink-docs-release-1.2/dev/connectors/kinesis.html" target="_blank">Amazon Kinesis Streams</a> (sink/source)</li>
  <li><a href="https://ci.apache.org/projects/flink/flink-docs-release-1.2/dev/connectors/twitter.html" target="_blank">Twitter</a> (source)</li>
  <li><a href="https://ci.apache.org/projects/flink/flink-docs-release-1.2/dev/connectors/nifi.html" target="_blank">Apache NiFi</a> (sink/source)</li>
  <li><a href="https://ci.apache.org/projects/flink/flink-docs-release-1.2/dev/connectors/cassandra.html" target="_blank">Apache Cassandra</a> (sink)</li>
  <li><a href="https://github.com/apache/bahir-flink" target="_blank">Redis, Flume, and ActiveMQ (via Apache Bahir)</a> (sink)</li>
</ul>

To run an application using one of these connectors, additional third party
components are usually required to be installed and launched, e.g. the servers
for the message queues. Further instructions for these can be found in the
corresponding subsections.


## Third-Party Projects

This is a list of third party packages (ie, libraries, system extensions, or examples) built on Flink.
The Flink community collects links to these packages but does not maintain them.
Thus, they do not belong to the Apache Flink project, and the community cannot give any support for them.
**Is your project missing?**
Please let us know on the [user/dev mailing list](#mailing-lists).

**Apache Zeppelin**

[Apache Zeppelin](https://zeppelin.incubator.apache.org/) is a web-based notebook that enables interactive data analytics and can be used with
[Flink as an execution engine](https://zeppelin.incubator.apache.org/docs/interpreter/flink.html) (next to others engines).
See also Jim Dowling's [Flink Forward talk](http://www.slideshare.net/FlinkForward/jim-dowling-interactive-flink-analytics-with-hopsworks-and-zeppelin) about Zeppelin on Flink.

**Apache Mahout**

[Apache Mahout](https://mahout.apache.org/) in a machine learning library that will feature Flink as an execution engine soon.
Check out Sebastian Schelter's [Flink Forward talk](http://www.slideshare.net/FlinkForward/sebastian-schelter-distributed-machine-learing-with-the-samsara-dsl) about Mahout-Samsara DSL.

**Cascading**

[Cascading](http://www.cascading.org/cascading-flink/) enables an user to build complex workflows easily on Flink and other execution engines.
[Cascading on Flink](https://github.com/dataArtisans/cascading-flink) is build by [dataArtisans](http://data-artisans.com/) and [Driven, Inc](http://www.driven.io/).
See Fabian Hueske's [Flink Forward talk](http://www.slideshare.net/FlinkForward/fabian-hueske-training-cascading-on-flink) for more details.

**Apache Beam (incubating)**

[Apache Beam (incubating)](http://beam.incubator.apache.org/) is an open source, unified programming model that you can use to create a data processing pipeline. Flink is one of the back-ends supported by the Beam programming model.

**GRADOOP**

[GRADOOP](http://dbs.uni-leipzig.de/en/research/projects/gradoop) enables scalable graph analytics on top of Flink and is developed at Leipzig University. Check out [Martin Junghanns’ Flink Forward talk](http://www.slideshare.net/FlinkForward/martin-junghans-gradoop-scalable-graph-analytics-with-apache-flink).

**BigPetStore**

[BigPetStore](https://github.com/apache/bigtop/tree/master/bigtop-bigpetstore) is a benchmarking suite including a data generator and will be available for Flink soon.
See Suneel Marthi's [Flink Forward talk](http://www.slideshare.net/FlinkForward/suneel-marthi-bigpetstore-flink-a-comprehensive-blueprint-for-apache-flink?ref=http://flink-forward.org/?session=tbd-3) as preview.

**FastR**

[FastR](https://bitbucket.org/allr/fastr-flink) in an implemenation of the R language in Java. [FastR Flink](https://bitbucket.org/allr/fastr-flink/src/3535a9b7c7f208508d6afbcdaf1de7d04fa2bf79/README_FASTR_FLINK.md?at=default&fileviewer=file-view-default) exeutes R workload on top of Flink.

**Apache SAMOA**

[Apache SAMOA (incubating)](https://samoa.incubator.apache.org/) a streaming ML library featuring Flink an execution engine soon. Albert Bifet introduced SAMOA on Flink at his [Flink Forward talk](http://www.slideshare.net/FlinkForward/albert-bifet-apache-samoa-mining-big-data-streams-with-apache-flink?ref=http://flink-forward.org/?session=apache-samoa-mining-big-data-streams-with-apache-flink).

**Python Examples on Flink**

A [collection of examples](https://github.com/wdm0006/flink-python-examples) using Apache Flink's Python API.

**WordCount Example in Clojure**

Small [WordCount example](https://github.com/mjsax/flink-external/tree/master/flink-clojure) on how to write a Flink program in Clojure.

**Anomaly Detection and Prediction in Flink**

[flink-htm](https://github.com/nupic-community/flink-htm) is a library for anomaly detection and prediction in Apache Flink. The algorithms are based on Hierarchical Temporal Memory (HTM) as implemented by the Numenta Platform for Intelligent Computing (NuPIC).

**Apache Ignite**

[Apache Ignite](https://ignite.apache.org) is a high-performance, integrated and distributed in-memory platform for computing and transacting on large-scale data sets in real-time. See [Flink sink streaming connector](https://github.com/apache/ignite/tree/master/modules/flink) to inject data into Ignite cache.
