---
title:  "Apache Flink CDC 3.2.1 Release Announcement"
date: "2024-11-27T08:00:00.000Z"
authors:
- ruanhang1993:
  name: "Hang Ruan"
aliases:
- /news/2024/11/27/release-release-cdc-3.2.1.html
---
The Apache Flink Community is pleased to announce the first bug fix release of the Flink CDC 3.2 series.

The release contains fixes for several critical issues and improves compatibilities with Apache Flink. Below you will find a list of all bugfixes and improvements (excluding improvements to the build infrastructure and build stability). For a complete list of all changes see:
[JIRA](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12355099).

We highly recommend all users to upgrade to Flink CDC 3.2.1.

## Release Notes

### Sub-task
* [FLINK-36221] Add specification about CAST ... AS ... built-in functions

### Bug
* [FLINK-35980] Add transform test coverage in Integrated / E2e tests
* [FLINK-35982] Transform metadata config doesn't work if no projection block was provided
* [FLINK-35985] SUBSTRING function not available in transform rules
* [FLINK-36105] CDC pipeline job could not restore from state in Flink 1.20
* [FLINK-36247] Potential transaction leak during MySQL snapshot phase
* [FLINK-36326] Newly added table failed in mysql pipeline connector
* [FLINK-36347] Using the offset obtained after a query transaction as a high watermark cannot ensure exactly-once semantics
* [FLINK-36375] Missing default value in AddColumnEvent/RenameColumnEvent
* [FLINK-36407] SchemaRegistry doesn't shutdown its underlying ExecutorService upon closing
* [FLINK-36408] MySQL pipeline connector could not work with FLOAT type with precision
* [FLINK-36461] YAML job failed to schema evolve with unmatched transform tables
* [FLINK-36474] YAML Table-merging route should accept more type widening cases
* [FLINK-36509] Fix 'Unsupported bucket mode: GLOBAL_DYNAMIC' error in Paimon Pipeline Sink.
* [FLINK-36517] Duplicate commit the same datafile in Paimon Sink
* [FLINK-36560] Fix the issue of timestamp_ltz increasing by 8 hours in Paimon
* [FLINK-36572] The local time zone is wrongly set in StarRocks pipeline sink
* [FLINK-36596] YAML Pipeline fails to schema change with no projection fields specified
* [FLINK-36649] Oracle When reading via OracleIncrementalSource, the connection is occasionally closed
* [FLINK-36656] Flink CDC treats MySQL Sharding table with boolean type conversion error
* [FLINK-36681] Wrong chunks splitting query in incremental snapshot reading section in mysql cdc doc

### Improvement
* [FLINK-35291] Improve the ROW data deserialization performance of DebeziumEventDeserializationScheme
* [FLINK-35592] MysqlDebeziumTimeConverter miss timezone convert to timestamp
* [FLINK-36052] add elasticsearch.md for elasticsearch pipeline connector
* [FLINK-36093] PreTransform operator wrongly filters out columns when multiple transform rules were defined
* [FLINK-36151] Add documentations for Schema Evolution related options
* [FLINK-36211] Shade kafka related package in Kafka Pipeline connector
* [FLINK-36214] Error log when building flink-cdc-pipeline-udf-examples from source code
* [FLINK-36541] Occasional met commit conflict problem in PaimonSink
* [FLINK-36565] Pipeline YAML should allow merging decimal with different precisions
* [FLINK-36678] The Flink CDC Yarn deployment mode document description is incorrect
* [FLINK-36750] Paimon connector would reuse sequence number when schema evolution happened

## Release Resources
The source artifacts and binaries are available on the [Downloads page]({{< relref "downloads" >}}) of the Flink website.

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.2/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors
yuxiqian, Xin Gong, Hang Ruan, wudi, qg-lin, Timi988, lvyanquan, ConradJam, Runkang He, Junbo wang, MOBIN, Leonard Xu, Sergei Morozov, liuzeshan

