---
title:  "Apache Flink CDC 3.5.0 Release Announcement"
date: "2025-09-26T08:00:00.000Z"
authors:
- yanquan:
  name: "Yanquan Lv"
aliases:
- /news/2025/09/26/release-cdc-3.5.0.html
---

The Apache Flink Community is excited to announce the release of Flink CDC 3.5.0!  
This release introduces new pipeline connectors for [Apache Fluss](https://fluss.apache.org) and PostgreSQL, and improves usability in multi-tables (with frequent table structure changes) synchronization scenario, many issues encountered in the transform and Schema evolution frameworks have also been fixed.

Flink CDC release packages are available at [Releases Page](https://flink.apache.org/downloads.html#flink-cdc),
and documentations are available at [Flink CDC documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.5) page.
Looking forward to any feedback from the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)!

# Highlights

## Pipeline Core

## Schema Evolution Optimization

* [FLINK-38045] During job failover, reissue the schema information stored in the state of Source to enhance the correctness of handling schema changes and make transform operator stateless.
* [FLINK-38243][FLINK-38244] Properly handle schema evolution for case-sensitive table and column names.

## Transform Enhancement

* FLINK-38079] Enhance precision support for DATE and TIME types to improve temporal handling in built-in and user-defined functions.

## Incremental Source Framework

* [FLINK-38265] Properly design the termination logic for stream split to prevent exceptions causing the job to get stuck.

## Pipeline Connectors

### Apache Fluss (newly added)

* [FLINK-37958] Apache Fluss (Incubating) is a streaming storage built for real-time analytics which can serve as the real-time data layer for Lakehouse architectures. In this version, Fluss is supported to be the sink for Pipeline jobs.

### PostgreSQL (newly added)

* [FLINK-35670] PostgreSQL is a powerful, open source object-relational database system with over 35 years of active development that has earned it a strong reputation for reliability, feature robustness, and performance. In this version, PostgreSQL is supported to be the source for Pipeline jobs.

### Apache Paimon

* [FLINK-38142] Bump Paimon version to 1.2.0.
* [FLINK-38206] Support writing to existed table with inconsistent schema with upstream.
* [FLINK-37824] Support column comments when creating a new table.

## Source Connectors

### MySQL CDC

* [FLINK-37065] Fix potential data loss caused by GTID out-of-order scenarios.
* [FLINK-38238] Add support for processing table with varchar(0) column.

### PostgreSQL CDC

* [FLINK-37479] Support discovering partitioned tables.
* [FLINK-37738] Support reading changelog as append only mode.

### OceanBase CDC

* [FLINK-38111] Migrate OceanBase CDC Connector from LogProxy to OceanBase Binlog Service.

# List of Contributors

We would like to express gratitude to all the contributors working on this release:

Sachin Mittal, suhwan, Lanny Boarts, hql0312, yuanoOo, gongzhongqiang, Kunni, North Lin, suntectec, SeungMin, ChengJie1053, kangzai, Ihor Mielientiev, Vinh Pham, wudi, Marta Paes, Shawn Huang, zhangchao.doovvv, linjc13, Sergei Morozov, MOBIN, Junbo Wang, junmuz, lvyanquan, Thorne, zhuxt2015, Xin Gong, linjianchang, tbpure, Tianzhu Wen, yuxiqian.yxq, Naci Simsek, Мухутдинов Артур, Hongshun Wang, proletarians, wangjunbo, Chao Zhang, ouyangwulin, Hang Ruan, Junbo wang, yuxiqian, wuzexian
