---
title:  "Apache Flink CDC 3.4.0 Release Announcement"
date: "2025-05-16T08:00:00.000Z"
authors:
- yanquan:
  name: "Yanquan Lv"
aliases:
- /news/2025/05/16/release-cdc-3.4.0.html
---

The Apache Flink Community is excited to announce the release of Flink CDC 3.4.0!
This release introduces a new pipeline Connector for Apache Iceberg, and provides support for batch execution mode, many issues encountered in the transform and Schema evolution frameworks have also been fixed.

Flink CDC release packages are available at [Releases Page](https://flink.apache.org/downloads.html#flink-cdc),
and documentations are available at [Flink CDC documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.4) page.
Looking forward to any feedback from the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)!

# Highlights

## Update Flink dependency to 1.20 in Flink CDC

Flink CDC version 3.4.0 supports Flink 1.19.x and 1.20.x.

## Connectors

### New Pipeline Connectors

Flink CDC 3.4.0 introduces 1 new pipeline connector:

* Iceberg sink. Iceberg is a high-performance format for huge analytic tables. Iceberg brings the reliability and simplicity of SQL tables to big data, while making it possible for engines like Spark, Trino, Flink, Presto, Hive and Impala to safely work with the same tables, at the same time. In this version, Iceberg is supported to be the downstream for Pipeline jobs.

### MySQL

* Support read changelog as append only mode for MySQL CDC connector.
* MySqlSnapshotSplitAssigner assign the ending chunk early to avoid out of memory error from TaskManager.
* Fix MySQL CDC captures common-prefix database accidentally when scan.binlog.newly-added-table option is enabled.

### Apache Paimon

* Bump Paimon version to 1.0.1.
* Add support for writing to Append Only table.
* Write full changelog to Paimon Sink.
* Performance optimization in Paimon Sink to reduce end-to-end checkpoint time.

### MongoDB

*  Support metadata 'row_kind' virtual column for Mongo CDC Connector.

## Schema Evolution

* Optimized the situation where a large number of CreateTableEvents were sent and processed when a job is started.
* Optimized the situation where it takes a long time to wait when processing multiple SchemaChangeEvents.

## Transform

* Transform arithmetic functions support parameters of null and more numerical types.
* Fix failure of adding a new column that has the same column name with source table using transform.

## Batch execution

We have introduced support for scenarios where only full data synchronization is performed without incremental data synchronization. Currently, users can use this feature by specifying `execution.runtime-mode` as `BATCH` in the pipeline.

## Application mode

Users can submit job though Cli with command `./bin/flink-cdc.sh -t yarn-application` to run job in YARN application mode.

# List of Contributors

We would like to express gratitude to all the contributors working on this release:

911432, chenhongyu, ConradJam, Ferenc Csaky, gongzhongqiang, Hang Ruan, He Wang, hiliuxg, Hongshun Wang, Jason Zhang, Jiabao Sun, Junbo Wang, Jzjsnow, Kevin Caesar, Kevin Wang, Kunni, Leonard Xu, lidoudou1993, linjianchang, liuxiaodong, lvyanquan, lzshlzsh, MOBIN-F, moses, North Lin, Olivier, ouyangwulin, Petrichor, proletarians, qinghuanwang, Qingsheng Ren, Robin Moffatt, Runkang He, Sergei Morozov, Seung-Min Lee, Shawn Huang, stayrascal, Thorne, Timi, Umesh Dangat, Vincent-Woo, Vinh Pham, wenmo, Wink, wudi, Xin Gong, yohei yoshimuta, yuanoOo, yuxiqian, zhangzheng