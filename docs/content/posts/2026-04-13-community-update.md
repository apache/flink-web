---
authors:
- jlpayne72: null
  name: Julian Payne
- davidrad: null
  name: David Radley  
date: "2026-04-13T08:00:00Z"
excerpt: Flink Community update for April 2026
title: Flink Community update for April 2026
aliases:
- /news/2026/04/13/community-update.html
---

This is the monthly Flink Community update for April 2026. We scour the latest updates from the Flink community so you don't have to! 

<!--more-->

We'll dive into a few hot topics and FLIPs (Flink Improvement Proposals) before providing the usual almanac-style listing of technical updates, user-facing updates, and governance and community.


<!-- TOC -->
  * [Hot topics](#hot-topics)
    * [Apache Flink 2.3 Release Draws Nearer](#apache-flink-23-release-draws-nearer)
    * [Table API & SQL](#table-api--sql)
    * [Runtime & Execution](#runtime--execution)
    * [Checkpointing & State](#checkpointing--state)
    * [Metrics & Observability](#metrics--observability)
    * [Python & Multi-language Support](#python--multi-language-support)
  * [New Releases](#new-releases)
    * [Apache Flink CDC 3.6.0 Release](#apache-flink-cdc-360-release)
    * [Apache Flink Agents 0.2.1 Release](#apache-flink-agents-021-release)
  * [Governance and Community](#governance-and-community)
    * [Stateful Functions Sub-Project Being Sunsetted](#stateful-functions-sub-project-being-sunsetted)
    * [FLIP (accepted)](#flip-accepted)
    * [FLIPs Being Discussed](#flips-being-discussed)
      * [Table/SQL evolution](#tablesql-evolution)
      * [Operations and platform management](#operations-and-platform-management)
  * [Staying up to date](#staying-up-to-date)
<!-- TOC -->

## Hot topics

### Apache Flink 2.3 Release Draws Nearer

Four months after the [release of Flink 2.2](https://flink.apache.org/2025/12/04/apache-flink-2.2.0-advancing-real-time-data--ai-and-empowering-stream-processing-for-the-ai-era/) (December 4th 2025), we are hotly anticipating the release of Flink 2.3. 
The code freeze for Apache Flink 2.3 is planned for April 14th and at time of writing we anticipate the version to be launched soon. 
Some of the main features in this release will include important updates to Materialized Tables for Flink SQL, OTel gRPC exporter and watermark alignment for backlogged jobs in Runtime, and in Connectors, an update to the S3 FileSink connector. 
Stay tuned to this blog for the release announcement with full details.
We will also restructure the Flink documentation to make it easier to navigate for new and existing users.
You can see the full release scope [here](https://cwiki.apache.org/confluence/display/FLINK/2.3+Release).


### Table API & SQL

Continued work on Materialized Tables including `START_MODE` clause parser support ([FLINK-39304](https://issues.apache.org/jira/browse/FLINK-39304)), interval reuse for `FRESHNESS` and `START MODE`, and `CREATE OR ALTER` now correctly respects existing table schemas ([FLINK-39284](https://issues.apache.org/jira/browse/FLINK-39284)). `TO_CHANGELOG` retract/upsert stream conversion was also added.

`BITMAP` Type support was introduced end-to-end: the core data type ([FLINK-38852](https://issues.apache.org/jira/browse/FLINK-38852), [FLINK-39185](https://issues.apache.org/jira/browse/FLINK-39185)), scalar functions ([FLINK-39186](https://issues.apache.org/jira/browse/FLINK-39186)), aggregate functions ([FLINK-39187](https://issues.apache.org/jira/browse/FLINK-39187)), and documentation ([FLINK-39188](https://issues.apache.org/jira/browse/FLINK-39188)).

Join Operations saw cascaded delta join support merged ([FLINK-39233](https://issues.apache.org/jira/browse/FLINK-39233)), lookup join after delta join ([FLINK-39174](https://issues.apache.org/jira/browse/FLINK-39174)), and immutable column sink mode traits ([FLINK-39287](https://issues.apache.org/jira/browse/FLINK-39287)). This removes restrictions, allowing the delta join to be used in more scenarios.

Code generation and correctness work included: NDU analyzer improvements for non-deterministic function detection ([FLINK-39313](https://issues.apache.org/jira/browse/FLINK-39313)), duplicate function instance elimination ([FLINK-39094](https://issues.apache.org/jira/browse/FLINK-39094)), filter optimisation for upsert key groups ([FLINK-39314](https://issues.apache.org/jira/browse/FLINK-39314)), a UDF lambda expression argument fix ([FLINK-39273](https://issues.apache.org/jira/browse/FLINK-39273)), and JSON field name code generation fixes backported across multiple releases ([FLINK-39355](https://issues.apache.org/jira/browse/FLINK-39355)).

### Runtime & Execution

The end of the month saw rescale enhancements with the rescale history recording statistics ([FLINK-38343](https://issues.apache.org/jira/browse/FLINK-38343)) and rescale information ([FLINK-38342](https://issues.apache.org/jira/browse/FLINK-38342)). A configurable `ExecutionGraph` cache TTL was introduced ([FLINK-39016](https://issues.apache.org/jira/browse/FLINK-39016)), and the Flink Web UI was updated to surface rescale and configuration data for adaptive scheduler jobs ([FLINK-38901](https://issues.apache.org/jira/browse/FLINK-38901)).

### Checkpointing & State

Unaligned checkpoint recovery gained a new configuration option ([FLINK-38541](https://issues.apache.org/jira/browse/FLINK-38541)), giving operators finer control over recovery behaviour under failure conditions. Session-mode HA recovery has been enhanced with [FLINK-38975](https://issues.apache.org/jira/browse/FLINK-38975), introducing new Application stores for running and terminated applications.

### Metrics & Observability

gRPC batch export support was added to the metrics pipeline ([FLINK-39126](https://issues.apache.org/jira/browse/FLINK-39126)), providing a more robust export using gRPC for jobs with large numbers of operators or tasks.

### Python & Multi-language Support

Python users gained support for multiple compression formats in `python.files` ([FLINK-39260](https://issues.apache.org/jira/browse/FLINK-39260)), expanding deployment flexibility for Python UDF bundles.

## New Releases

### Apache Flink CDC 3.6.0 Release

- **Announcement:** [Apache Flink CDC 3.6.0 Release Announcement](https://flink.apache.org/2026/03/30/apache-flink-cdc-3.6.0-release-announcement/) — *Yanquan Lv, March 30*
- **Release Manager:** Yanquan Lv
- **Key highlights:**
  - Extended Flink version support to 1.20.x and 2.2.x
  - Upgraded minimum JDK to version 11
  - New connectors added
  - Expanded schema evolution capabilities
  - PostgreSQL pipeline connector schema change support ([FLINK-38959](https://issues.apache.org/jira/browse/FLINK-38959))
  - Oracle pipeline support for column nullable changes ([FLINK-39196](https://issues.apache.org/jira/browse/FLINK-39196))

### Apache Flink Agents 0.2.1 Release

- **Announcement:** [Apache Flink Agents 0.2.1 Release Announcement](https://flink.apache.org/2026/03/26/apache-flink-agents-0-2-1-release-announcement/) — *Wenjin Xie, March 26*
- **Release Manager:** Wenjin Xie
- **Key highlights:**
  - 3 targeted bug fixes
  - Vulnerability fixes
  - Minor improvements

## Governance and Community

### Stateful Functions Sub-Project Being Sunsetted

[Stateful Functions](https://cwiki.apache.org/confluence/display/FLINK/FLIP-569%3A+Sunset+the+Stateful+Functions+%28StateFun%29+Sub-project) (StateFun) is being sunsetted, due to lack of activity.

### FLIP (accepted)

Flink Improvement Proposals or FLIPs are the mechanism by which the community propose new features and initiatives. 

* **[FLIP-557](https://cwiki.apache.org/confluence/display/FLINK/FLIP-557%3A+Granular+Control+over+Data+Reprocessing+in+Materialized+Table+Evolution): Granular Control over Data Reprocessing in Materialized Table Evolution.** (Ramin Gharib)
- Gives users finer control over which partitions are reprocessed when a materialized table definition changes.

### FLIPs Being Discussed

The main FLIPs being discussed or opened this month fit into two categories:
- Table/SQL evolution, continuing the strategy to enhance the easy-to-use, standards-based SQL interface.
- Operations and platform management.

#### Table/SQL evolution

* **[FLIP-556](https://cwiki.apache.org/confluence/display/FLINK/FLIP-556%3A+Introduce+BITMAP+Data+Type): Introduce BITMAP Data Type.** (Lincoln Lee)
- Introduces the BITMAP data type for efficient storage and set operations on large collections of integers.

* **[FLIP-564](https://cwiki.apache.org/confluence/display/FLINK/FLIP-564%3A+Support+FROM_CHANGELOG+and+TO_CHANGELOG+built-in+PTFs): Support FROM_CHANGELOG and TO_CHANGELOG built-in PTFs.** (Gustavo de Morais)
- Enables PTFs to declare that they take in or produce CDC (Change Data Capture) information in change logs.
- This brings another DataStream capability into the SQL world.
- `FROM_CHANGELOG` enables custom SQL connectors by handling custom CDC formats.
- `TO_CHANGELOG` enables creating a CDC append stream from a Flink Table.

* **[FLIP-565](https://cwiki.apache.org/confluence/display/FLINK/FLIP-565%3A+Improve+ProcessTableFunctions+for+late+data+handling+and+state+access): Improve ProcessTableFunctions for late data handling and state access.** (Timo Walther)
- Avoids dropping late data in ProcessTableFunctions, where data loss is usually not intended.
- Introduces `ValueView` to enable a supplier pattern for state access, similar to `MapView` and `ListView`.
- Introduces `BROADCAST_SEMANTIC_TABLE` as a new kind of argument to PTFs.

* **[FLIP-566](https://cwiki.apache.org/confluence/display/FLINK/FLIP-566%3A+Introduce+a+new+IMMUTABLE+columns+constraint): Introduce a new IMMUTABLE columns constraint.**  (Xuyang Zhong)
- Introduces IMMUTABLE columns so delta joins can rely on stable join keys for correct processing.

* **[FLIP-567](https://cwiki.apache.org/confluence/display/FLINK/FLIP-567%3A+Introduce+a+ProcessTableFunction+Test+Harness): Introduce a ProcessTableFunction Test Harness.** (Mika Naylor)
- Proposes a standard test harness for validating PTFs.

* **[FLIP-568](https://cwiki.apache.org/confluence/display/FLINK/FLIP-568%3A+Strict+BYTES-to-STRING+CAST+with+UTF-8+Validation+Utilities): Strict BYTES-to-STRING CAST with UTF-8 Validation Utilities.** (Gustavo de Morais)
- Proposes a strict form of `CAST(bytes AS STRING)` that does not silently replace invalid UTF-8 bytes with `U+FFFD`.

#### Operations and platform management

* **[FLIP-504](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=337677650): Blue/Green Deployments for Flink on Kubernetes: Phase 2 (coordination).** (Timo Walther)
- Continues work on blue/green deployments for Flink on Kubernetes, focusing on coordination.

* **[FLIP-570](https://cwiki.apache.org/confluence/display/FLINK/FLIP-570%3A+Support+Runtime+Data+Sampling+for+Operators+with+WebUI+Visualization): Support Runtime Data Sampling for Operators with WebUI Visualization.** (Jiangang Liu)
- Proposes runtime data sampling with Web UI support so operators can inspect live data for troubleshooting and anomaly investigation.

* **[FLIP-571](https://cwiki.apache.org/confluence/display/FLINK/FLIP-571%3A+Support+Dynamically+Updating+Checkpoint+Configuration+at+Runtime+via+REST+API): Support Dynamically Updating Checkpoint Configuration at Runtime via REST API.** (Jiangang Liu)
- Proposes updating checkpoint configuration dynamically via REST API so variable workloads can be managed in real time.

* **[FLIP-572](https://cwiki.apache.org/confluence/display/FLINK/FLIP-572%3A+Introduce+Flink-Kafka+Transactions+Management+Tool): Introduce Flink-Kafka Transactions Management Tool.**  (Aleksandr Savonin)
- Proposes a CLI for handling Kafka transactions stuck in the ONGOING state by committing or aborting them.

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
