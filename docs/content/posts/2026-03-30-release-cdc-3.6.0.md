---
title:  "Apache Flink CDC 3.6.0 Release Announcement"
date: "2026-03-30T08:00:00.000Z"
authors:
- yanquan:
  name: "Yanquan Lv"
aliases:
- /news/2026/03/30/release-cdc-3.6.0.html
---

The Apache Flink Community is excited to announce the release of Flink CDC 3.6.0!
This release extends Flink version support to 1.20.x and 2.2.x, upgrades JDK version to 11, introduces new Oracle Source and Apache Hudi Sink Pipeline connectors, adds Lenient mode schema evolution support for Fluss Pipeline connector, introduces PostgreSQL Schema Evolution support, enhances Schema Evolution capabilities for better multi-table synchronization scenarios and table name mapping flexibility, and strengthens Transform framework with VARIANT type and JSON parsing support. Numerous bug fixes and improvements have been made across various connectors including MySQL, MongoDB, Oracle, Iceberg, StarRocks, Kafka, and Paimon.

Flink CDC release packages are available at [Releases Page](https://flink.apache.org/downloads.html#flink-cdc),
and documentations are available at [Flink CDC documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.6) page.
Looking forward to any feedback from the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)!

# Highlights

## Flink Version and JDK Version

* [FLINK-38729][FLINK-38730] Bump Flink version support to 1.20.x and 2.2.x, and **bump JDK version to 11**.
  * For YAML/SQL jobs: Choose the corresponding version of the tgz and jar files as before.
  * For DataStream jobs: Update JDK version to 11 and add the corresponding connector dependencies. Please refer to the [DataStream API Package Guidance](https://nightlies.apache.org/flink/flink-cdc-docs-master/docs/connectors/flink-sources/datastream-api-package-guidance/) for detailed examples.

## Schema Evolution Optimization

* [FLINK-37203] Support AlterTableCommentEvent and AlterColumnCommentEvent for comprehensive schema change handling.
* [FLINK-37837] Always add `create.table` to `include.schema.changes` option for better control over schema evolution behavior.

## Transform Enhancement

* [FLINK-37447][FLINK-38874][FLINK-38877] Introduce VARIANT type and `PARSE_JSON` function to Flink CDC pipeline, enabling flexible semi-structured data handling.
* [FLINK-38888][FLINK-39010] YAML Pipeline supports item subscription of complex types and variant types.
* [FLINK-38887] YAML Transform module supports nested types for more flexible data transformations.
* [FLINK-38779] YAML Pipeline router supports RegEx based routing for advanced table routing scenarios.
* [FLINK-38831] The route configuration supports matching the first one to provide more deterministic routing behavior.
* [FLINK-39232] CDC Transform matches first matching rule and deprecates partial filtering.

## Incremental Source Framework

* [FLINK-38568] Fix performance bottleneck in BinlogSplitReader with large number of snapshot splits.
* [FLINK-38618] Fix StreamSplitAssigner reassign stream split when scan start mode is latest-offset and taskmanager failover.

## Pipeline Connectors

### Apache Hudi (newly added)

* [FLINK-36313] Support pipeline sink Hudi, enabling CDC data synchronization to Apache Hudi tables.

### Oracle (newly added)

* [FLINK-36796] Oracle CDC supports pipeline configuration connector, enabling CDC data ingestion from Oracle databases in pipeline jobs.

### PostgreSQL

* [FLINK-38959] Support schema changes in the PostgreSQL pipeline connector.
* [FLINK-38844] Add metadata column support for PostgreSQL Pipeline Connector.
* [FLINK-38514][FLINK-38520] PostgreSQL YAML CDC supports UUID_ARRAY and array with null element.

### Apache Fluss

* [FLINK-38726] Bump Fluss version to 0.9.0-incubating for improved stability and features.
* [FLINK-39204][FLINK-39205] YAML Fluss sink supports lenient schema evolution mode and array/map/row complex types.

### Apache Paimon

* [FLINK-38879] Add VARIANT type support in Paimon pipeline sink.
* [FLINK-38833] Partitioned fixed-bucket Paimon table write parallelism optimization.

### Apache Iceberg

* [FLINK-39245] Support AWS Glue Catalog for Iceberg pipeline connector.
* [FLINK-38100] Add BigQuery catalog support for Iceberg pipeline sink connector.
* [FLINK-38808] Support partition transforms in Iceberg sink.
* [FLINK-39055] Support default column values in Iceberg sink connector.

### Apache Kafka

* [FLINK-38889] YAML Kafka sink connector supports serializing complex types.

### StarRocks

* [FLINK-38829][FLINK-38834] Support rename column DDL and alter column type DDL for StarRocks sink connector.
* [FLINK-37485][FLINK-38160] StarRocks Pipeline connector supports TIME/BINARY/VARBINARY type mapping.

### Doris

* [FLINK-39209] Fix Flink CDC Doris connector throw exception when serializing time data type columns.

## Source Connectors

### MySQL CDC

* [FLINK-36520] Fix Flink CDC doesn't support MySQL > 8.0.
* [FLINK-38218] Fix MySQL CDC source may ignore newly added tables while reading the binlog.
* [FLINK-38531] Fix MySQL CDC BinlogOffset compareTo method issue when gtidSet is same, which may cause data loss when restored from gtid.
* [FLINK-38247] Fix MySqlChunkSplitter may continuously generate splits when using BIGINT UNSIGNED as primary key.
* [FLINK-39207] Fix MySQL CDC connector could get stuck in backfill binlog reading after a failover within snapshot phase.

### MongoDB CDC

* [FLINK-38601] Fix MongoDB CDC silently stops consuming from unbounded streams when Throwable errors occur and never recovers.

### Oracle CDC

* [FLINK-36631] Supports reading incremental data from Oracle from a specified SCN.

# List of Contributors

We would like to express gratitude to all the contributors working on this release:

5herhom, big face cat, chengcongchina, chenhongyu, Dustin Washington, Edward Zhuang, fcfangcc, HUANG XIAO, Hongshun Wang, Jia Fan, Junbo Wang, Kevin Liu, Kunni, Lanny Boarts, Leonard Xu, linjianchang, Luca Occhipinti, lvyanquan, Martijn Visser, Mingliang Zhu, moses, Mukhutdinov Artur, ouyangwulin, Pei Yu, Sachin Mittal, Sergei Morozov, Shuo Cheng, SkylerLin, suhwan, Tejansh, Thorne, Tianzhu Wen, voonhous, Wink, wudi, Xin Gong, yuxiqian
