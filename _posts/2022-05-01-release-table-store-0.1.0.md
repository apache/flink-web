---
layout: post
title:  "Apache Flink Table Store 0.1.0 Release Announcement"
subtitle: "Unified streaming and batch store for building dynamic tables on Apache Flink."
date: 2022-05-01T08:00:00.000Z
categories: news
authors:
- Jingsong Lee:
  name: "Jingsong Lee"

---

The Apache Flink community is pleased to announce the preview release of the
[Apache Flink Table Store](https://github.com/apache/flink-table-store) (0.1.0).

Flink Table Store is a unified streaming and batch store for building dynamic tables
on Apache Flink. It uses a full Log-Structured Merge-Tree (LSM) structure for high speed
and a large amount of data update & query capability.

Please check out the full [documentation]({{site.DOCS_BASE_URL}}flink-table-store-docs-release-0.1/) for detailed information and user guides.

Note: Flink Table Store is still in beta status and undergoing rapid development,
we do not recommend that you use it directly in a production environment.

## What is Flink Table Store

Open [Flink official website](https://flink.apache.org/), you can see the following line:
`Apache Flink - Stateful Computations over Data Streams.` Flink focuses on distributed computing,
which brings real-time big data computing. Users need to combine Flink with some kind of external storage.

The message queue will be used in both source & intermediate stages in streaming pipeline, to guarantee the
latency stay within seconds. There will also be a real-time OLAP system receiving processed data in streaming
fashion and serving user’s ad-hoc queries.

Everything works fine as long as users only care about the aggregated results. But when users start to care
about the intermediate data, they will immediately hit a blocker: Intermediate kafka tables are not queryable.

Therefore, users use multiple systems. Writing to a lake store like Apache Hudi, Apache Iceberg while writing to Queue,
the lake store keeps historical data at a lower cost.

There are two main issues with doing this:
- High understanding bar for users: It’s also not easy for users to understand all the SQL connectors,
  learn the capabilities and restrictions for each of those. Users may also want to play around with
  streaming & batch unification, but don't really know how, given the connectors are most of the time different
  in batch and streaming use cases.
- Increasing architecture complexity: It’s hard to choose the most suited external systems when the requirements
  include streaming pipelines, offline batch jobs, ad-hoc queries. Multiple systems will increase the operation
  and maintenance complexity. Users at least need to coordinate between the queue system and file system of each
  table, which is error-prone.

The Flink Table Store aims to provide a unified storage abstraction:
- Table Store provides storage of historical data while providing queue abstraction.
- Table Store provides competitive historical storage with lake storage capability, using LSM file structure
  to store data on DFS, providing real-time updates and queries at a lower cost.
- Table Store coordinates between the queue storage and historical storage, providing hybrid read and write capabilities.
- Table Store is a storage created for Flink, which satisfies all the concepts of Flink SQL and is the most
  suitable storage abstraction for Flink.

## Core Features

Flink Table Store supports the following usage:
- **Streaming Insert**: Write changelog streams, including CDC from the database and streams.
- **Batch Insert**: Write batch data as offline warehouse, including OVERWRITE support.
- **Batch/OLAP Query**: Read the snapshot of the storage, efficient querying of real-time data.
- **Streaming Query**: Read the storage changes, ensure exactly-once consistency.

Flink Table Store uses the following technologies to support the above user usages:
- Hybrid Storage: Integrating Apache Kafka to achieve real-time stream computation.
- LSM Structure: For a large amount of data updates and high performance queries.
- Columnar File Format: Use Apache ORC to support efficient querying.
- Lake Storage: Metadata and data on DFS and Object Store.

Many thanks for the inspiration of the following systems: [Apache Iceberg](https://iceberg.apache.org/) and [RocksDB](http://rocksdb.org/).

## Getting started

For a detailed [getting started guide]({{site.DOCS_BASE_URL}}flink-table-store-docs-release-0.1/docs/try-table-store/quick-start/) please check the documentation site.

## What's Next?

The community is currently working on hardening the core logic, stabilizing the storage format and adding the remaining bits for making the Flink Table Store production-ready.

In the upcoming 0.2.0 release you can expect (at-least) the following additional features:

* Ecology: Support Flink Table Store Reader for Apache Hive Engine
* Core: Support the adjustment of the number of Bucket
* Core: Support for Append Only Data, Table Store is not just limited to update scenarios
* Core: Full Schema Evolution
* Improvements based on feedback from the preview release

In the medium term, you can also expect:

* Ecology: Support Flink Table Store Reader for Trino, PrestoDB and Apache Spark
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
