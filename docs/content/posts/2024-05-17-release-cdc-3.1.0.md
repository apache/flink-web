---
title:  "Apache Flink CDC 3.1.0 Release Announcement"
date: "2024-05-17T08:00:00.000Z"
authors:
- renqs:
  name: "Qingsheng Ren"
  twitter: "renqstuite"
aliases:
- /news/2024/05/17/release-cdc-3.1.0.html
---

The Apache Flink community is excited to announce the release of Flink CDC 3.1.0! This is the first release after the community accepted the donation of Flink CDC as a sub-project of Apache Flink, with exciting new features such as transform and table merging. The eco-system of Flink CDC keeps expanding, including new Kafka and Paimon pipeline sinks and enhancement to existing connectors.

We'd like to invite you to check out [Flink CDC documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1) and have a try on [the quickstart tutorial](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/docs/get-started/introduction) to explore the world of Flink CDC. Also we encourage you to [download the release](https://flink.apache.org/downloads.html#flink-cdc) and share your feedback with the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)! We hope you like the new release and we’d be eager to learn about your experience with it.

## Highlights

### Transformation Support in Pipeline

Flink CDC 3.1.0 introduces the ability of making transformations in the CDC pipeline. By incorporating a `transform` section within the YAML pipeline definitions, users can now easily apply a variety of transformations to data change event from source, including projections, calculations, and addition of constant columns, enhancing the effectiveness of data integration pipelines. Leveraging an SQL-like syntax for defining these transformations, the new feature ensures that users can quickly adapt to and utilize it.

You can find examples of using transformations in the [Flink CDC documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/docs/core-concept/transform/#example).

### Table Merging Support

Flink CDC 3.1.0 now supports merging multiple tables into one by configuring `route` in the YAML pipeline definition.  It is a prevalent occurrence where business data is partitioned across tables even databases due to the substantial volume. By configuring `route`s that map multiple tables into one, data change events will be merged into the same destination table. Moreover, schema changes on source tables will also be applied to the destination.

You can find examples of using routes in the [Flink CDC documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/docs/core-concept/route/#example).

### Connectors

#### Distributions of MySQL / Oracle / OceanBase / Db2 connectors

Unfortunately due to the license incompatibility, we cannot ship JDBC drivers of the following connectors together with our binary release:

- Db2
- MySQL
- Oracle
- OceanBase

Please manually download the corresponding JDBC driver into `$FLINK_HOME/lib` of your Flink cluster, or specify the path of driver when submitting YAML pipelines with `--jar`. Please make sure they are under the classpath if you are using Flink SQL.

#### SinkFunction Support

Although `SinkFunction` has been marked as deprecated in Flink, considering some connectors are still using the API, we also support `SinkFunction` API for CDC pipeline sinks to help expand the ecosystem of Flink CDC.

#### New Pipeline Connectors

Flink CDC 3.1.0 introduces 2 new pipeline connectors:

- Apache Kafka sink (depends on Kafka 3.2.3)
- Apache Paimon sink (depends on Paimon 0.7.0)

#### MySQL

In this release, MySQL pipeline source introduces a new option `tables.exclude` to exclude unnecessary tables from capturing with an easier expression. MySQL CDC source is now shipped with a custom converter `MysqlDebeziumTimeConverter` for converting temporal type columns to a more human-readable and serialize-friendly string.

#### OceanBase

OceanBase CDC source now supports specifying the general `DebeziumDeserializationSchema` for reusing existing Debezium deserializers.

#### Db2

Db2 CDC source is now migrated to the unified incremental snapshot framework.

### CLI

Flink CDC pipeline submission CLI now supports recovering a pipeline execution from a specific savepoint file by using command line argument `--from-savepoint`

## List of Contributors
Check Null, FocusComputing, GOODBOY008, Hang Ruan, He Wang, Hongshun Wang, Jiabao Sun, Kunni, L, Laffery, Leonard Xu, Muhammet Orazov, Paul Lin, PengFei Li, Qingsheng Ren, Qishang Zhong, Shawn Huang, Thorne, TorinJie, Xianxun Ye, Xin Gong, Yaroslav Tkachenko, e-mhui, gongzhongqiang, joyCurry30, kunni, lzshlzsh, qwding, shikai93, sky, skylines, wenmo, wudi, xleoken, xuzifu666, yanghuaiGit, yux, yuxiqian, 张田