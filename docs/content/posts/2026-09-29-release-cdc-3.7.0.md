---
title:  "Apache Flink CDC 3.7.0 Release Announcement"
date: "2026-10-10T08:00:00.000Z"
authors:
- yux:
  name: "Xiqian Yu"
aliases:
- /news/2026/10/10/release-cdc-3.7.0.html
---

The Apache Flink Community is excited to announce the release of Flink CDC 3.7.0!

This release brings AI-powered data processing to Flink CDC pipelines with a pluggable model API, an OpenAI-compatible model client, built-in text and multimodal functions, and ordered asynchronous transform execution.
It also introduces inline Python UDFs, new SQL Server and Fluss Pipeline source connectors, broader YAML Transform functions, and safer schema handling for existing sink tables.
In addition, this release improves pipeline configuration and routing, and delivers reliability fixes for various connectors.

Flink CDC release packages are available at the [Releases Page](https://flink.apache.org/downloads.html#flink-cdc),
and documentation is available on the [Flink CDC documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.7) page.
We look forward to feedback from the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)!

# Highlights

## AI-Powered and Extensible Transform

* [FLINK-39568][FLINK-40411] Introduce a pluggable AI model client API and an OpenAI-compatible model client for text generation and embedding in YAML Transform expressions.
* [FLINK-40416][FLINK-40513][FLINK-40572] Add built-in AI functions for completion, classification, translation, summarization, sentiment analysis, information extraction, masking, text embedding, and image understanding, with support for selecting models dynamically for each record.
* [FLINK-40552] Add experimental ordered asynchronous execution for post-transform operations. This improves throughput for I/O-bound expressions such as AI model calls while preserving data and schema event ordering.
* [FLINK-40409] Support defining Python UDFs directly in Pipeline YAML, allowing Python functions to be used in transform projections and filters.
* [FLINK-40151][FLINK-40223][FLINK-40239][FLINK-40240][FLINK-40312][FLINK-40313] Expand YAML Transform with more predicates, nullable Boolean logic, string and regular-expression functions, `TRY_CAST`, `IFNULL`, `NULLIF`, date-part and interval operations, and nested collection functions.
* [FLINK-40337][FLINK-40360] Preserve expression operator precedence and support configurable DECIMAL precision up to 38 digits in Transform evaluation.

## Pipeline and Schema Evolution

* [FLINK-40647] Add existing-table schema validation and expansion. Paimon and Fluss sinks can use `CHECK`, `TRY_EXPAND`, or `EXPAND` mode to validate an existing target table and safely add or widen non-key columns before writing data.
* [FLINK-39777] Add configurable sink partitioning strategies, including sink-defined, primary-key, and table-ID partitioning.
* [FLINK-39696] Use source partitions when dispatching distributed flush events, improving correctness for non-hash or custom partitioning strategies.
* [FLINK-36581] Allow Flink configuration to be specified in the Pipeline YAML through `pipeline.flink-conf`, with CLI arguments retaining the highest priority.
* [FLINK-40148] Correct table routing when source table names contain multi-digit suffixes. Route replacement now consumes the complete source table ID instead of leaking unmatched suffixes into the sink table name.
* [FLINK-40656] Reset schema coordinator state correctly when restoring from a checkpoint.

## New Pipeline Source Connectors

### SQL Server (newly added)

* [FLINK-39252] Introduce the SQL Server Pipeline source connector. It supports incremental snapshot reading, schema change synchronization, metadata columns, multiple startup modes, and scanning newly added tables after restoring from a checkpoint or savepoint.

### Apache Fluss (newly added)

* [FLINK-39722] Introduce the Fluss Pipeline source connector, supporting both primary-key and log tables, snapshot and log reading, and periodic table discovery.
* [FLINK-40575] Support dynamic table unsubscription and re-subscription for Fluss sources.
* [FLINK-40331][FLINK-40690] Add forward-shuffle support to the Fluss sink and preserve nested row field positions during conversion.
* Upgrade Apache Fluss to 1.0.0.

## Pipeline Connectors

### Apache Paimon

* [FLINK-37731][FLINK-39567] Support postpone bucket mode and BLOB fields in the Paimon Pipeline sink.
* [FLINK-40507] Upgrade the Paimon dependency to 2.0.0.
* [FLINK-39718][FLINK-39684][FLINK-40043] Fix failures when writing from a distributed source to a missing target table, handling `REPLACE` events, or restoring with increased parallelism.

### Apache Hudi

* [FLINK-40159] Add Hive synchronization support to the Hudi Pipeline sink.

### Apache Iceberg

* [FLINK-39342] Support passing Hadoop configuration properties through the `hadoop.conf.*` prefix.
* [FLINK-38450][FLINK-40640] Fix duplicate records when schema changes split writes within a checkpoint or when an update changes the partition value.

### Apache Kafka

* [FLINK-39757] Fix Debezium JSON serialization when columns contain default values.

### Elasticsearch

* [FLINK-39410] Improve Elasticsearch Pipeline connector compatibility with Flink 1.20 and Flink 2.x.

### StarRocks

* [FLINK-39759] Correct `CHAR` and `VARCHAR` mapping for `utf8mb4` data.
* [FLINK-39228] Escape quoted default values and comments in generated DDL statements.

### Oracle

* [FLINK-39196] Support changing column nullability without requiring a data type in the Oracle Pipeline connector.
* [FLINK-39832] Correct the mapping of `NUMBER(p, 0)` when the precision is 19 or greater.

### MaxCompute

* [FLINK-40739] Fix partition handling for MaxCompute sink writes.

## Incremental Source Framework

* [FLINK-39732] Introduce an `ObjectIdDiscoverer` SPI for flexible source table discovery, with JDBC discovery provided by default.
* [FLINK-40623] Release the chunk splitter JDBC connection after a table has been split.
* [FLINK-39775][FLINK-40697][FLINK-40732] Release completed snapshot split metadata after entering the stream phase for MySQL, incremental snapshot based sources, and MongoDB, reducing long-running coordinator state and memory usage.
* [FLINK-39621] Fix incremental snapshot based sources that could become stuck during binlog backfill.
* [FLINK-39824] Cache relational table filter results to reduce repeated schema and table matching work.

## Source Connectors

### MySQL CDC

* [FLINK-39372] Correct binlog filename comparison when numeric suffixes have different lengths.
* [FLINK-39197] Fix a possible `NullPointerException` while finding chunk boundaries.
* [FLINK-39916] Fix validation of batch startup options.
* [FLINK-40340] Fix schema change parsing for MySQL `ZEROFILL` types without an explicit `UNSIGNED` keyword.
* [FLINK-39315] Unregister `BinaryLogClient` listeners to prevent snapshot readers from hanging during backfill.
* [FLINK-40741] Fix recovery of newly added tables after a region failover.
* Fix comparison of `VARBINARY` split keys by byte value.

### PostgreSQL CDC

* [FLINK-39582] Allow PostgreSQL logical messages in the replication stream.
* [FLINK-34806] Expose `scan.newly-added-table.enabled` for the PostgreSQL source connector.
* [FLINK-40007] Fix snapshot fetch size configuration not taking effect.
* [FLINK-38835] Correct timestamp conversion for dates before January 1, 1970.
* [FLINK-38742] Correct `TIMESTAMPTZ` mapping to `TIMESTAMP_LTZ` in the PostgreSQL Pipeline connector.
* [FLINK-40441] Fix a HikariCP class conflict in the PostgreSQL Pipeline connector.

### MongoDB CDC

* [FLINK-39610] Support configuring an individual SSL context for each MongoDB CDC source.

# List of Contributors

We would like to express our gratitude to all contributors who made this release possible:

A S Rakesh Krishna, Arvind Kandpal, BreadS, Chengbing Liu, chengcongchina, daishuyuan, EricZeng, Hang Ruan, haruki, Hongshun Wang, Jia Fan, jj.lee, Joao Boto, Jubin Soni, Jzjsnow, Kunni, Leonard Xu, Mehmet Can Şakiroğlu, mike, Mingliang Zhu, MOBIN, naivedogger, nhuantho, Patrick, Pei Yu, Purushottam Sinha, Ran Tao, Spoorthi Basu, suntectec, Thorne, Vishal, wudi, Xiaobing Fang, Xiqian Yu, xucq07, yuanoOo, yueqingshu
