---
layout: post
title:  "Apache Flink Table Store 0.1.0 Release Announcement"
subtitle: "For building dynamic tables for both stream and batch processing in Flink, supporting high speed data ingestion and timely data query."
date: 2022-05-01T08:00:00.000Z
categories: news
authors:
- JingsongLi:
  name: "Jingsong Lee"
- becketqin:
  name: "Jiangjie (Becket) Qin"
---

The Apache Flink community is pleased to announce the preview release of the
[Apache Flink Table Store](https://github.com/apache/flink-table-store) (0.1.0).

Please check out the full [documentation]({{site.DOCS_BASE_URL}}flink-table-store-docs-release-0.1/) for detailed information and user guides.

Note: Flink Table Store is still in beta status and undergoing rapid development,
we do not recommend that you use it directly in a production environment.

## What is Flink Table Store

In the past years, thanks to our numerous contributors and users, Apache Flink has established
itself as one of the best distributed computing engines, especially for stateful stream processing
at large scale. However, there are still a few challenges people are facing when they try to obtain
insights from their data in real-time. Among these challenges, one prominent problem is lack of
storage that caters to all the computing patterns.

As of now it is quite common that people deploy a few storage systems to work with Flink for different
purposes. A typical setup is a message queue for stream processing, a scannable file system / object store
for batch processing and ad-hoc queries, and a K-V store for lookups. Such architecture posts challenges
in data quality and sysetm maintenance, due to its complexity and heterogeneity. This is becoming a major
issue that hurts the end-to-end user experience of streaming and batch unification brought by Apache Flink.

The goal of Flink table store is to address the above issues. It is an important step of the project.
It extends Flink's capability from computing to the storage domain. So we can provide a better end-to-end
experience to the users.

Flink Table Store aims to provide a unified storage abstraction, the user will only see one abstraction. 
Table Store offers the following core capabilities:

* Table Store provides storage of historical data while providing queue abstraction.
* Table Store provides streaming queries with minimum latency down to milliseconds.
* Table Store provides Batch/OLAP queries with minimum latency down to the second level.
* Table Store provides incremental snapshots for stream consumption by default. Users
  don't need to solve the problem of hybrid different stores.

<center>
<img src="{{site.baseurl}}/img/blog/table-store/table-store-architecture.png" width="100%"/>
</center>

In this preview version, as shown in the architecture above:

* Users can use Flink to insert data into the Table Store, supporting not only CDC stream inserts from the database,
  but also batch inserts from the offline data warehouse.
* Users can use Flink to stream query the table store, users can also use Flink or Hive or other engines to
  batch/OLAP query the table store.
* Table Store uses a hybrid storage architecture, using Lake Store to store historical data and Queue system
  (Kafka integration is currently supported) to store incremental data, and provides incremental snapshots
  for hybrid streaming reads.
* Table Store's Lake Store stores data as columnar files on file system / object store, uses the LSM Structure
  for a large amount of data updates and high performance queries.

Many thanks for the inspiration of the following systems: [Apache Iceberg](https://iceberg.apache.org/) and [RocksDB](http://rocksdb.org/).

## Getting started

Please refer to the [getting started guide]({{site.DOCS_BASE_URL}}flink-table-store-docs-release-0.1/docs/try-table-store/quick-start/) for more details.

## What's Next?

The community is currently working on hardening the core logic, stabilizing the storage format and adding the remaining bits for making the Flink Table Store production-ready.

In the upcoming 0.2.0 release you can expect (at-least) the following additional features:

* Ecosystem: Support Flink Table Store Reader for Apache Hive Engine
* Core: Support the adjustment of the number of Bucket
* Core: Support for Append Only Data, Table Store is not just limited to update scenarios
* Core: Full Schema Evolution
* Improvements based on feedback from the preview release

In the medium term, you can also expect:

* Ecosystem: Support Flink Table Store Reader for Trino, PrestoDB and Apache Spark
* Flink Table Store Service to accelerate updates and improve query performance

Please give the preview release a try, share your feedback on the Flink mailing list and contribute to the project!

## Release Resources

The source artifacts and binaries are now available on the updated [Downloads](https://flink.apache.org/downloads.html)
page of the Flink website.

We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists)
or [JIRA](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20component%20%3D%20%22Table%20Store%22).

## List of Contributors

The Apache Flink community would like to thank every one of the contributors that have made this release possible:

Jane Chan, Jiangjie (Becket) Qin, Jingsong Lee, Leonard Xu, Nicholas Jiang, Shen Zhu, tsreaper, Yubin Li
