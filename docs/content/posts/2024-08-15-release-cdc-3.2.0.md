---
title:  "Apache Flink CDC 3.2.0 Release Announcement"
date: "2024-08-15T08:00:00.000Z"
authors:
- renqs:
  name: "Qingsheng Ren"
  twitter: "renqstuite"
aliases:
- /news/2024/08/15/release-release-cdc-3.2.0.html
---

The Apache Flink Community is excited to announce the release of Flink CDC 3.2.0!
This release aims to improve usability and stability of existing features, 
including transform and schema evolution. 
Also, backwards-compatible code and tests have been added to help users upgrade from previous CDC versions more smoothly.

Flink CDC release packages are available at [Releases Page](https://flink.apache.org/downloads.html#flink-cdc),
and documentations are available at [Flink CDC documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.2) page.
Looking forward to any feedback from the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)!

# Highlights

## Connectors

### New Pipeline Connectors

Flink CDC 3.2.0 introduces 1 new pipeline connector:

* Elasticsearch sink (verified on Elasticsearch 6.8, 7.10, and 8.12)

### Apache Paimon

Paimon connector has bumped its dependency to an up-to-date version and could benefit from all bug fixes and improvements. 
Also, there are other improvements including:

* Added dynamic bucket mode support for data distribution cases.
* Handle specified column positions correctly.
* Fixed duplicate commit issue after failover.

### Apache Kafka

Now, it is possible to configure Kafka partitioning strategy with new `key.format` and `partition.strategy` configurations.

### MySQL

* `AlterColumnTypeEvent` could be correctly parsed from `MODIFY COLUMN` DDL. 
* Assigning any column as snapshot chunk column is supported in both pipeline and source connector.
* Fixed a bug that may cause infinite hanging with timestamp startup mode

### MongoDB

* MongoDB CDC connector has been tested and verified on MongoDB 7.x.

## Kubernetes Deployment Mode

Now it is possible to deploy a YAML pipeline job to Kubernetes cluster with CDC CLI. 
See [Deployment Docs](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.2/docs/deployment/kubernetes/) for more details.

## Customizable Schema Evolution

More customizable schema evolution modes have been added.
Now, apart from existing "Evolve", "Ignore", and "Exception" mode, a pipeline job could be configured as:

### "Lenient" Mode

Similar to "TryEvolve" mode, but it always keeps original table structure as a part of evolved schema, which guarantees lossless recoverability from job fail-over.

In this mode, pipeline will ignore all `DropColumnEvent`s, and insert `NULL` values to fill in the gap. 
Also, `AddColumnEvent`s will be relocated to the end of the table to maximize compatibility with those sinks that don't allow inserting new columns arbitrarily.  

> Note: This is the default schema change behavior now. You may override it with `pipeline.schema.change.behavior` configuration.

### "TryEvolve" Mode

Always do schema evolution attempts, but evolution failures will be tolerated.

In this mode, if a schema change event wasn't applied to downstream successfully, pipeline will tolerate the failure and allow the job running by appending `NULL` or trimming original data.

> Note: Using TryEvolve mode might potentially drop some data when some schema change requests failed. Use `Evolve` or `Lenient` if it's unacceptable.

### Per-type Configuration

Also, it is possible to enable / disable some types of schema evolution events with the following syntax:

```yaml
sink:
  include.schema.changes: [column]
  exclude.schema.changes: [alter, drop]
```

Here, only `AddColumnEvent` and `RenameColumnEvent` will be applied to downstream. (`AlterColumnTypeEvent` and `DropColumnEvent` are excluded explicitly.)

## Enhanced Transform

Transform feature was initially shipped with CDC 3.1.0, with a few known limitations and quirks that needs attention when writing rules.
Most of them have been fixed in this release, including:

* Provided new `CAST ... AS ...` built-in function to cast values to specified types.
* Calculation columns could reference columns omitted from projection result now.
* Calculation columns could shade upstream columns now.
* Built-in temporary functions have the same semantic with Flink SQL now.
* Transform rules could work with routing rules now.
* Transform could handle upstream schema changes now.

## Transform UDF Support

Now, it is possible to declare a customizable UDF by implementing `org.apache.flink.cdc.common.udf.UserDefinedFunction` interface, and reference them in projection and filtering expressions like built-in functions.
UDFs are defined in pipeline level, and could be used in all transform blocks:

```yaml
transform:
  - source-table: db.tbl
    projection: "fmt('id -> %d', id) as fmt_id"
    filter: "inc(id) < 100"

pipeline:
  user-defined-function:
    - name: inc
      classpath: org.apache.flink.cdc.udf.examples.java.AddOneFunctionClass
    - name: fmt
      classpath: org.apache.flink.cdc.udf.examples.java.FormatFunctionClass
```

Plain Flink SQL Scalar Functions could be used with no modification. See [UDF docs](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.2/docs/core-concept/transform/#user-defined-functions) for more details.

## Complex Routing Rules

Route operator has been improved to allow declaring more complicated route topologies:

* Routing one table to multiple sink tables (broadcasting) is supported now. 
* One can define multiple parallel routing rules in batch with pattern replacing symbols.

# List of Contributors

We would like to express gratitude to all the contributors working on this release:

ChengJie1053, ConradJam, FangXiangmin, GOODBOY008, Hang Ruan, He Wang, Hongshun Wang, Jiabao Sun, Joao Boto, Junbo wang, Kunni, Laffery, Leonard Xu, MOBIN, Muhammet Orazov, North Lin, PONYLEE, Paul Lin, Qingsheng Ren, SeungMin, Shawn Huang, Thorne, Wink, Xie Yi, Xin Gong, Zhongmin Qiao, Zmm, gong, gongzhongqiang, hk__lrzy, joyCurry30, lipl, lvyanquan, ouyangwulin, skylines, wuzexian, yanghuaiGit, yux, yuxiqian, 鼎昕