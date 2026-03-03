---
title:  "Apache Flink CDC 3.3.0 Release Announcement"
date: "2025-01-21T08:00:00.000Z"
authors:
- ruanhang:
  name: "Hang Ruan"
aliases:
- /news/2025/01/21/release-cdc-3.3.0.html
---

The Apache Flink Community is excited to announce the release of Flink CDC 3.3.0!
This release introduces more features in transform and connectors and improve 
usability and stability of existing features.

Flink CDC release packages are available at [Releases Page](https://flink.apache.org/downloads.html#flink-cdc),
and documentations are available at [Flink CDC documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.3) page.
Looking forward to any feedback from the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)!

# Highlights

## Connectors

### New Pipeline Connectors

Flink CDC 3.3.0 introduces 2 new pipeline connectors:

* OceanBase sink
* MaxCompute sink 

### MySQL

* Support parsing [gh-ost](https://github.com/github/gh-ost) and [pt-osc](https://docs.percona.com/percona-toolkit/pt-online-schema-change.html) generated schema changes.
* Parse array-typed key index binlog created between 8.0.17 and 8.0.18 rightly.
* Support passing op_ts to meta field in Event.
* Support parsing the comments of table and column.
* Fixed deadlock after adding new tables.
* Fixed a bug that works with FLOAT type with precision.

### Apache Paimon

* Apply default value options when apply add column change.
* Reuse sequence number when schema evolution happened.
* Fixed commit conflict problem in PaimonSink.
* Remove Catalog.ColumnAlreadyExistException when apply applyAddColumnEventWithPosition in paimon.
* Bump Paimon version to 0.9.0.

### Postgres

*  Support metadata 'op_type' virtual column for Postgres CDC Connector.
*  Improve PostgresDialect.discoverDataCollections to reduce the start time of Postgres CDC.

### Flink CDC Base

* CDC framework split snapshot chunks asynchronously.
* Improve the ROW data deserialization performance of DebeziumEventDeserializationScheme.
* Allow applying Truncate & Drop table to Doris/Paimon/Starrocks connectors.
* The flink-cdc-base module supports source metric statistics.
* Use fixed format for SnapshotSplit's splitId in all connectors.
* Merge result of data type BIGINT and DOUBLE is DOUBLE instead of STRING.

## Upgrade Flink compatibility to 1.19+ 

Flink latest version have been updated to 1.20. Flink CDC version 3.3.0 will support Flink 1.19+ 
and drop supports for Flink 1.17.* and 1.18.* .

## Cdcup: quickly start a testing job

Flink CDC 3.3.0 comes with a `cdc-up` utility script to set up a data integration PoC pipeline and required 
environment easily. Follow the latest [quickstart steps](https://github.com/apache/flink-cdc#quickstart-guide) to get started.

## Transform 

* Support `timestampdiff`, `timestampadd`, `unix_timestamp` function.
* Support to add metadata columns for data in the meta fields of DataChangeEvent at transform.
* Support to convert delete events as insert events.
* Add "OpType" metadata column in transform.
* Support for AI Model Integration for Data Processing.
* Improve get source field value by column name in PreTransformProcessor.
* Deduce primary key column types to be NOT NULL.

# List of Contributors

We would like to express gratitude to all the contributors working on this release:

ConradJam, Hang Ruan, Hongshun Wang, Jason Zhang, Junbo wang, Jzjsnow, Kunni, Leonard Xu, MOBIN, North Lin, Olivier, Petrichor, Robin Moffatt, Runkang He, Sergei Morozov, Seung-Min Lee, Shawn Huang, Thorne, Timi, Umesh Dangat, Wink, Xin Gong, hiliuxg, liuxiaodong, moses, ouyangwulin, stayrascal, wenmo, wudi, yuanoOo, yuxiqian, MOBIN-F, helloliuxg, jzjsnow, molin.lxd, wuzhiping, zhangchaoming.zcm
