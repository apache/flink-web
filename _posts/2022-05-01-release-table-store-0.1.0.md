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

The Apache Flink Community is pleased to announce the preview release of the
[Apache Flink Table Store](https://github.com/apache/flink-table-store) (0.1.0).

Flink Table Store is a unified streaming and batch store for building dynamic tables
on Apache Flink. It uses a full Log-Structured Merge-Tree (LSM) structure for high speed
and large amount of data update & query capability.

Please check out the full [documentation]({{site.DOCS_BASE_URL}}flink-table-store-docs-release-0.1/) for detailed information and user guides.

Note: Flink Table Store is still in beta status and undergoing rapid development,
we do not recommend that you use it directly in a production environment.

## What is Flink Table Store

Open [Flink official website](https://flink.apache.org/), you can see the following line:
`Apache Flink - Stateful Computations over Data Streams.` Flink focuses on distributed computing,
which brings real-time big data computing. But pure computation doesn't bring value, users need
to combine Flink with some kind of external storage.

For a long time, we found that no external storage can fit Flink's computation model perfectly,
which brings troubles to users. So Flink Table Store was born, it is a storage built specifically
for Flink, for big data real-time update scenario. From now on, Flink is no longer just a computing
engine.

Flink Table Store is a unified streaming and batch table format:
- As the storage of Flink, it first provides the capability of Queue.
- On top of the Queue capability, it precipitates historical data to data lakes.
- The data on data lakes can be updated and analyzed in near real-time.

## Core Features

Flink Table Store supports the following usage:
- **Streaming Insert**: Write changelog streams, including CDC from database and streams.
- **Batch Insert**: Write batch data as offline warehouse, including OVERWRITE support.
- **Batch/OLAP Query**: Read snapshot of the storage, efficient querying of real-time data.
- **Streaming Query**: Read changes of the storage, ensure exactly-once consistency.

Flink Table Store uses the following technologies to support the above user usages:
- Hybrid Storage: Integrating Apache Kafka to achieve real-time stream computation.
- LSM Structure: For large amount of data updates and high performance query.
- Columnar File Format: Use Apache ORC to support efficient querying.
- Lake Storage: Metadata and data on DFS and Object Store.

Many thanks for the inspiration of the following systems: Apache Iceberg, RocksDB.

## Getting started

For a detailed [getting started guide]({{site.DOCS_BASE_URL}}flink-table-store-docs-release-0.1/docs/try-table-store/quick-start/) please check the documentation site.

## What's Next?

The community is currently working on hardening the core operator logic, stabilizing the storage format and adding the remaining bits for making the Flink Table Store production ready.

In the upcoming 0.2.0 release you can expect (at-least) the following additional features:

* Ecology: Support Flink Table Store Reader for Apache Hive Engine
* Core: Support the adjustment of the number of Bucket
* Core: Support for Append Only Data, Table Store is not just limited to update scenarios
* Core: Full Schema Evolution
* Improvements based on feedback from the preview release

In the medium term you can also expect:

* Ecology: Support Flink Table Store Reader for Trino, PrestoDB and Apache Spark
* Flink Table Store Service to accelerate update and improve query performance

Please give the preview release a try, share your feedback on the Flink mailing list and contribute to the project!

## Release Resources

The source artifacts and binaries are now available on the updated [Downloads](https://flink.apache.org/downloads.html)
page of the Flink website.

We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists)
or [JIRA](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20component%20%3D%20%22Table%20Store%22).

## List of Contributors

The Apache Flink community would like to thank each and every one of the contributors that have made this release possible:

Jane Chan, Jiangjie (Becket) Qin, Jingsong Lee, Leonard Xu, Nicholas Jiang, Shen Zhu, tsreaper, Yubin Li
