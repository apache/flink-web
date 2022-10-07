---
categories: news
date: "2015-03-02T10:00:00Z"
title: February 2015 in the Flink community
---

February might be the shortest month of the year, but this does not
mean that the Flink community has not been busy adding features to the
system and fixing bugs. Here’s a rundown of the activity in the Flink
community last month.

### 0.8.1 release

Flink 0.8.1 was released. This bugfixing release resolves a total of 22 issues.

### New committer

[Max Michels](https://github.com/mxm) has been voted a committer by the Flink PMC.

### Flink adapter for Apache SAMOA

[Apache SAMOA (incubating)](http://samoa.incubator.apache.org) is a
distributed streaming machine learning (ML) framework with a
programming abstraction for distributed streaming ML algorithms. SAMOA
runs on a variety of backend engines, currently Apache Storm and
Apache S4.  A [pull
request](https://github.com/apache/incubator-samoa/pull/11) is
available at the SAMOA repository that adds a Flink adapter for SAMOA.

### Easy Flink deployment on Google Compute Cloud

Flink is now integrated in bdutil, Google’s open source tool for
creating and configuring (Hadoop) clusters in Google Compute
Engine. Deployment of Flink clusters in now supported starting with
[bdutil
1.2.0](https://groups.google.com/forum/#!topic/gcp-hadoop-announce/uVJ_6y9cGKM).

### Flink on the Web

A new blog post on [Flink
Streaming](http://flink.apache.org/news/2015/02/09/streaming-example.html)
was published at the blog. Flink was mentioned in several articles on
the web. Here are some examples:

- [How Flink became an Apache Top-Level Project](http://dataconomy.com/how-flink-became-an-apache-top-level-project/)

- [Stale Synchronous Parallelism: The new frontier for Apache Flink?](https://www.linkedin.com/pulse/stale-synchronous-parallelism-new-frontier-apache-flink-nam-luc-tran?utm_content=buffer461af&utm_medium=social&utm_source=linkedin.com&utm_campaign=buffer)

- [Distributed data processing with Apache Flink](http://www.hadoopsphere.com/2015/02/distributed-data-processing-with-apache.html)

- [Ciao latency, hello speed](http://www.hadoopsphere.com/2015/02/ciao-latency-hallo-speed.html)

## In the Flink master

The following features have been now merged in Flink’s master repository.

### Gelly

Gelly, Flink’s Graph API allows users to manipulate graph-shaped data
directly. Here’s for example a calculation of shortest paths in a
graph:

{{< highlight java >}}
Graph<Long, Double, Double> graph = Graph.fromDataSet(vertices, edges, env);

DataSet<Vertex<Long, Double>> singleSourceShortestPaths = graph
     .run(new SingleSourceShortestPaths<Long>(srcVertexId,
           maxIterations)).getVertices();
{{< / highlight >}}	   

See more Gelly examples
[here](https://github.com/apache/flink/tree/master/flink-libraries/flink-gelly-examples).

### Flink Expressions

The newly merged
[flink-table](https://github.com/apache/flink/tree/master/flink-libraries/flink-table)
module is the first step in Flink’s roadmap towards logical queries
and SQL support. Here’s a preview on how you can read two CSV file,
assign a logical schema to, and apply transformations like filters and
joins using logical attributes rather than physical data types.

{{< highlight scala >}}
val customers = getCustomerDataSet(env)
 .as('id, 'mktSegment)
 .filter( 'mktSegment === "AUTOMOBILE" )

val orders = getOrdersDataSet(env)
 .filter( o => dateFormat.parse(o.orderDate).before(date) )
 .as('orderId, 'custId, 'orderDate, 'shipPrio)

val items =
 orders.join(customers)
   .where('custId === 'id)
   .select('orderId, 'orderDate, 'shipPrio)
{{< / highlight >}}   

### Access to HCatalog tables

With the [flink-hcatalog
module](https://github.com/apache/flink/tree/master/flink-batch-connectors/flink-hcatalog),
you can now conveniently access HCatalog/Hive tables. The module
supports projection (selection and order of fields) and partition
filters.

### Access to secured YARN clusters/HDFS.

With this change users can access Kerberos secured YARN (and HDFS)
Hadoop clusters.  Also, basic support for accessing secured HDFS with
a standalone Flink setup is now available.

