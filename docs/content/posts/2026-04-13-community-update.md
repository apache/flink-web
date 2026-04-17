---
authors:
- jlpayne72: null
  name: Julian Payne
date: "2026-04-13T08:00:00Z"
excerpt: Flink Community update for April 2026
title: Flink Community update for April 2026
aliases:
- /news/2026/04/13/community-update.html
---

This is the monthly Flink Community update for April 2026. We scour the latest updates from the Flink community so you don't have to! 
We'll dive into a few hot topics and FLIPs (Flink Improvement Proposals) before providing the usual almanac-style listing of technical updates, user-facing updates, and governance and community.
<!--more-->

<!-- TOC -->
  * [Hot Topics](#hot-topics)
  * [Developer/Technical Updates](#developertechnical-updates)
  * [User-Facing Updates](#user-facing-updates)
  * [Governance and Community](#governance-and-community)
<!-- TOC -->


## Hot Topics

### Apache Flink 2.3 Release Draws Nearer

Four months after the [release of Flink 2.2](https://flink.apache.org/2025/12/04/apache-flink-2.2.0-advancing-real-time-data--ai-and-empowering-stream-processing-for-the-ai-era/) (December 4th 2025), we are hotly anticipating the release of Flink 2.3. 
The code freeze for Apache Flink 2.3 was invoked on April 14th and at time of writing we anticipate the version to be launched toward the end of April 2026. 
Some of the main features in this release will include important updates to Materialized Tables for Flink SQL, OTel gRPC exporter and watermark alignment for backlogged jobs in Runtime, and in Connectors, an update to the S3 Filesink connector. 
Stay tuned to this blog for the release announcement with full details.
We will also re-structure to the Flink documentation to make it easier to navigate for new and existing users. 
You can see the full release scope [here](https://cwiki.apache.org/confluence/display/FLINK/2.3+Release).

### Flink CDC 3.6.0 Release

Flink CDC is used to capture and stream real-time changes from databases (inserts, updates, and deletes) as they happen. 
[Version 3.6.0](https://flink.apache.org/2026/03/30/apache-flink-cdc-3.6.0-release-announcement/) extends Flink version support to 1.20.x and 2.2.x, upgrades JDK version to 11, introduces new Oracle Source and Apache Hudi Sink Pipeline connectors and adds Lenient mode schema evolution support for Fluss Pipeline connector. 
It also introduces PostgreSQL Schema Evolution support, enhances Schema Evolution capabilities for better multi-table synchronization scenarios and table name mapping flexibility, and strengthens the Transform framework with VARIANT type and JSON parsing support.

### Flink Documentation Re-structure

We want to re-structure Flink documentation to aid discoverability and reduce duplication (see [FLIP-561](https://cwiki.apache.org/confluence/display/FLINK/FLIP-561%3A+Restructure+Flink+documentation)). 
Reflecting the broadening use of SQL we plan to create a dedicated Flink SQL section separate from Table API. 
We will move shared concepts (Relational Streaming concepts like Dynamic Tables, Time Attributes) to the top-level Concepts section and also move shared architecture documentation (Source/Sink APIs) to the Connectors section. 
Additionally, Python documentation will now be integrated within the Table API and DataStream API sections where applicable, with the rest moved to the Python API docs (PyDocs).

### Flink Native S3 FileSystem Connector

Amazon S3 is a popular sink and source destination for Apache Flink users. 
Currently, Apache Flink provides two primary mechanisms for interacting with S3 (`flink-s3-fs-hadoop` and `flink-s3-fs-presto`), both of which are adapters wrapping external projects. 
To improve performance and maintainability we propose the creation of `flink-s3-fs-native` ([FLIP-555](https://cwiki.apache.org/confluence/display/FLINK/FLIP-555%3A+Flink+Native+S3+FileSystem)), a clean-slate implementation built directly on the AWS SDK for Java v2. 
We will remove the Hadoop dependency, making the connector a self-contained module depending only on the modular AWS SDK v2. 
The connector will support both state access (FileSystem) and transactional sinks (RecoverableWriter), simplifying the user experience. Additionally, the connector leverages the non-blocking I/O capabilities of Netty and the AWS Common Runtime (CRT) to maximise throughput.

## Developer/Technical Updates

### Runtime & Execution

Adaptive scheduler and `ExecutionGraph` improvements will be part of Flink 2.3. Rescale history now records statistics ([[#27540]](https://github.com/apache/flink/pull/27540)) and rescale information ([[#27539]](https://github.com/apache/flink/pull/27539)). A configurable `ExecutionGraph` cache TTL was introduced ([[#27509]](https://github.com/apache/flink/pull/27509)), and the Flink Web UI was updated to surface rescale and configuration data for adaptive scheduler jobs ([[#27826]](https://github.com/apache/flink/pull/27826)).

### Checkpointing & State

Unaligned checkpoint recovery gained a new configuration option ([FLINK-38541](https://issues.apache.org/jira/browse/FLINK-38541)), giving operators finer control over recovery behaviour under failure conditions. Session-mode HA recovery re-execution was also resolved ([FLINK-38975](https://issues.apache.org/jira/browse/FLINK-38975)).

### Metrics & Observability

gRPC batch export support was added to the metrics pipeline ([[#27692]](https://github.com/apache/flink/pull/27692)), providing a more robust export using gRPC for jobs with large numbers of operators or tasks.

### Python & Multi-language Support

Python users gained support for multiple compression formats in `python.files` ([[#27780]](https://github.com/apache/flink/pull/27780)), expanding deployment flexibility for Python UDF bundles.

## User-Facing Updates

### Table API & SQL

Continued work on Materialized Tables including `START_MODE` clause parser support ([FLINK-39304](https://issues.apache.org/jira/browse/FLINK-39304)), interval reuse for `FRESHNESS` and `START MODE`, and `CREATE OR ALTER` now correctly respects existing table schemas ([FLINK-39284](https://issues.apache.org/jira/browse/FLINK-39284)). `TO_CHANGELOG` retract/upsert stream conversion was also added.

BITMAP Type support was introduced end-to-end: the core data type ([[FLINK-38852]](https://issues.apache.org/jira/browse/FLINK-38852), [[FLINK-39185]](https://issues.apache.org/jira/browse/FLINK-39185)), scalar functions ([[FLINK-39186]](https://issues.apache.org/jira/browse/FLINK-39186)), aggregate functions ([[FLINK-39187]](https://issues.apache.org/jira/browse/FLINK-39187)), and documentation ([[FLINK-39188]](https://issues.apache.org/jira/browse/FLINK-39188), [[#27835]](https://github.com/apache/flink/pull/27835)).

Join Operations saw cascaded delta join support merged ([FLINK-39233](https://issues.apache.org/jira/browse/FLINK-39233)), lookup join after delta join ([FLINK-39174](https://issues.apache.org/jira/browse/FLINK-39174)), and immutable column sink mode traits ([FLINK-39287](https://issues.apache.org/jira/browse/FLINK-39287)).

Code generation and correctness work included: NDU analyzer improvements for non-deterministic function detection ([[FLINK-39313]](https://issues.apache.org/jira/browse/FLINK-39313), [[#27819]](https://github.com/apache/flink/pull/27819)), duplicate function instance elimination ([[FLINK-39094]](https://issues.apache.org/jira/browse/FLINK-39094)), filter optimisation for upsert key groups ([[FLINK-39314]](https://issues.apache.org/jira/browse/FLINK-39314)), a UDF lambda expression argument fix ([[#27787]](https://github.com/apache/flink/pull/27787)), and JSON field name code generation fixes backported across multiple releases ([[#27850]](https://github.com/apache/flink/pull/27850), [[#27851]](https://github.com/apache/flink/pull/27851), [[#27856]](https://github.com/apache/flink/pull/27856)).

### Apache Flink CDC 3.6.0 Release

- **Announcement:** [Apache Flink CDC 3.6.0 Release Announcement](https://flink.apache.org/2026/03/30/apache-flink-cdc-3.6.0-release-announcement/) — *Yanquan Lv, March 30*
- **Release Manager:** Yanquan Lv
- **Key highlights:**
  - Extended Flink version support to 1.20.x and 2.2.x
  - Upgraded minimum JDK to version 11
  - New connectors added
  - Expanded schema evolution capabilities
  - PostgreSQL pipeline connector schema change support [[FLINK-38959]](https://issues.apache.org/jira/browse/FLINK-38959)
  - Oracle pipeline support for column nullable changes [[FLINK-39196]](https://issues.apache.org/jira/browse/FLINK-39196)

### Apache Flink Agents 0.2.1 Release

- **Announcement:** [Apache Flink Agents 0.2.1 Release Announcement](https://flink.apache.org/2026/03/26/apache-flink-agents-0-2-1-release-announcement/) — *Wenjin Xie, March 26*
- **Release Manager:** Wenjin Xie
- **Key highlights:**
  - 3 targeted bug fixes
  - Vulnerability fixes
  - Minor improvements

## Governance and Community

### FLIP (accepted)

Flink Improvement Proposals or FLIPs are the mechanism by which the community propose new features and initiatives. 

* **[FLIP-561](https://cwiki.apache.org/confluence/display/FLINK/FLIP-561%3A+Restructure+Flink+documentation): Restructure Flink Documentation.** (Piotr Nowojski) - A major reorganisation to improve discoverability and reduce duplication across the Flink docs. Updated March 24, 2026.
* **[FLIP-558](https://cwiki.apache.org/confluence/display/FLINK/FLIP-558%3A+Improvements+to+SinkUpsertMaterializer+and+changelog+disorder): Improvements to SinkUpsertMaterializer and Changelog Disorder.** - Addresses correctness issues in upsert materialisation under out-of-order changelog events.
* **[FLIP-557](https://cwiki.apache.org/confluence/display/FLINK/FLIP-557%3A+Granular+Control+over+Data+Reprocessing+in+Materialized+Table+Evolution): Granular Control over Data Reprocessing in Materialized Table Evolution.** - Gives users finer control over which partitions are reprocessed when a materialized table definition changes.
* **[FLIP-551](https://cwiki.apache.org/confluence/display/FLINK/FLIP-551%3A+Make+FRESHNESS+Optional+for+Materialized+Tables): Make FRESHNESS Optional for Materialized Tables.** (targeting Flink 2.2) - Reduces the boilerplate required when defining materialized tables where freshness guarantees are not needed.

### FLIPs (under discussion)

* **[FLIP-202](https://cwiki.apache.org/confluence/display/FLINK/FLIP-202): [DRAFT] Introduce ClickHouse Connector.** - Community discussion ongoing for an officially supported ClickHouse sink connector.
* **[FLIP-332](https://cwiki.apache.org/confluence/display/FLINK/%5BWIP%5DFLIP-332%3A+Introduce+the+concept+of+state+self-sustained): [WIP] Introduce State Self-Sustained Concept.** - Explores state backends capable of managing their own lifecycle independently of checkpoints.
* **[FLIP-267](https://cwiki.apache.org/confluence/display/FLINK/FLIP+267%3A+Iceberg+Connector): Iceberg Connector.** - Continuing effort to formalise the Iceberg integration as a first-class Flink connector.


## Staying up to date

There are several ways that you can keep up to date with what is happening in the Flink community.
For a full list see [here](https://flink.apache.org/what-is-flink/community/).

* Follow this blog.
An [RSS feed](https://flink.apache.org/posts/index.xml) is available.
* Subscribe to one of the [Flink community mailing lists](https://flink.apache.org/community.html#mailing-lists).
Two popular mailing lists are:
    * the [dev list](https://lists.apache.org/list.html?dev@flink.apache.org) for development related discussions
    * the [user list](https://lists.apache.org/list.html?user@flink.apache.org) for user support and questions
* Join the [Apache Flink Slack group](https://flink.apache.org/what-is-flink/community/#slack).
