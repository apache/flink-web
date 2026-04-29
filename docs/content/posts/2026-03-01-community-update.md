---
authors:
- davidrad: null
  name: David Radley
date: "2026-03-01T08:00:00Z"
excerpt: Flink Community update for March 2026
title: Flink Community update for March 2026
aliases:
- /news/2026/03/01/community-update.html
---

This is the monthly Flink Community update for March 2026. It covers the
main developments in the community over the past month, including technical updates,
user-facing updates, and governance and community.
<!--more-->

<!-- TOC -->
  * [Developer/Technical Updates](#developertechnical-updates)
    * [Key Themes](#key-themes)
    * [What happened last month](#what-happened-last-month)
  * [User-Facing Updates](#user-facing-updates)
    * [Kubernetes Operator 1.14.0 Release](#kubernetes-operator-1140-release)
    * [Apache Flink Connector Parent 2.0.0 Release](#apache-flink-connector-parent-200-release)
    * [Apache Flink Connector AWS 6.0 Release](#apache-flink-connector-aws-60-release)
    * [Apache Flink Agents 0.2.0 released](#apache-flink-agents-020-released)
    * [Blogs](#blogs)
  * [Governance and Community](#governance-and-community)
    * [FLIP Activity](#flip-activity)
      * [Accepted - being implemented](#accepted---being-implemented)
      * [Being discussed](#being-discussed)
    * [Apache Flink Dev List activity](#apache-flink-dev-list-activity)
  * [For more information](#for-more-information)
<!-- TOC -->

Previous Blog: [Flink community update February 2026](https://flink.apache.org/2026/02/01/flink-community-update-february26/)

## Developer/Technical Updates

### Key Themes

1. Additional Serviceability
   - [[FLINK-38977] Expose exceptions for applications](https://issues.apache.org/jira/browse/FLINK-38977)
   - [[hotfix] Log watermark alignment duration (and all other stages)](https://github.com/apache/flink/commit/f6fffd7d33f617acc69f405deecf050ef710d439)
   - [[hotfix] Log unexpected non-terminal task state](https://github.com/apache/flink/commit/79e79fcd26eeaabb956198ce2c6293cc221a9f5e)
2. Improvements to watermarks
   - [[FLINK-37399] Buffer watermarks for watermark alignment](https://issues.apache.org/jira/browse/FLINK-37399)
   - [[FLINK-37399] Add SamplingWatermarkRingBuffer](https://issues.apache.org/jira/browse/FLINK-37399)
   - [[FLINK-39167] Initialize source output before emitting final watermark](https://issues.apache.org/jira/browse/FLINK-39167)
3. Improved recovery with checkpoints
   - [[hotfix] Try to get last checkpoint on recovery regardless of checkpointing interval](https://github.com/apache/flink/commit/c0ada39aafa23e58e6c80883bdb740a89d02c1ff)
   - [[hotfix] Move checkpointing configuration code to CheckpointCoordinatorConfiguration](https://github.com/apache/flink/commit/b2b044dc66814498f0cdfb4e9249f446e2c6fce9)
   - [[FLINK-38939] Pause Sources until the first checkpoint barrier is received](https://issues.apache.org/jira/browse/FLINK-38939)
4. Enhancements around [splits](https://nightlies.apache.org/flink/flink-docs-release-2.2/docs/dev/datastream/sources/#data-source-concepts)
   - [[FLINK-39073] Improve logging of invalid split transitions](https://issues.apache.org/jira/browse/FLINK-39073)
   - [[FLINK-39073] Defer alignment check for idle splits](https://issues.apache.org/jira/browse/FLINK-39073)
5. Table planner enhancements
   - [[FLINK-37924] Introduce Built-in Function to Access field or element in the Variant](https://issues.apache.org/jira/browse/FLINK-37924)
   - [[FLINK-35661] Fix MiniBatchGroupAggFunction silently dropping records](https://issues.apache.org/jira/browse/FLINK-35661)
   - [[FLINK-39088] Fix upsert key preservation by introducing injective cast checks for CAST](https://issues.apache.org/jira/browse/FLINK-39088)
   - [[FLINK-38624] Type Mismatch Exception in StreamPhysicalOverAggregateRule](https://issues.apache.org/jira/browse/FLINK-38624) Fix for a breaking change, that occurs migrating from 1.20 to 2.x.

### What happened last month
* Flink
  * All CI builds were failing; this was fixed in a [PR](https://github.com/apache/flink/pull/27619) that upgraded Kubernetes client libraries.
* Flink JDBC connector
  * [FLINK-38851](https://issues.apache.org/jira/browse/FLINK-38851) Support passing arbitrary database options to JDBC Catalog.
* Flink Kafka connector had 14 commits going in. The most interesting were:
  * [FLINK-39012](https://issues.apache.org/jira/browse/FLINK-39012) Support global enumerator/dispatcher for dynamic Kafka source (handling multiple cluster topologies)
  * [FLINK-39120](https://issues.apache.org/jira/browse/FLINK-39120) Update to Kafka 4.2.0.

## User-Facing Updates

### Kubernetes Operator 1.14.0 Release

- **Announcement:** [Kubernetes Operator 1.14.0 Released](https://flink.apache.org/2026/02/15/apache-flink-kubernetes-operator-1.14.0-release-announcement/)
- **Release Manager:** Gyula Fóra
- **Key Features:** FlinkBlueGreenDeployment fixes from Shopify team

### Apache Flink Connector Parent 2.0.0 Release

- **Announcement:** [Apache flink-connector-parent 2.0.0 released](https://lists.apache.org/thread/7vkchx6mtlth5vg5koz0vv5kov6v0899)
- **Release Manager:** Ferenc Csaky
- **Key Features:** Flink 2 compatible and license checking.

### Apache Flink Connector AWS 6.0 Release

- **Announcement:** [Apache flink-connector-aws 6.0 released](https://lists.apache.org/thread/dx7cotdf4bq4go158cwh81q6obqjgsv1)
- **Release Manager:** Ferenc Csaky
- **Key Features:** Flink 2.0 compatible and supports enhancements AWS Glue Schema Registry.

### Apache Flink Agents 0.2.0 released

- **Announcement:** [Apache Flink Agents 0.2.0 released](https://flink.apache.org/2026/02/06/apache-flink-agents-0.2.0-release-announcement/)
- **Release Manager:** Xintong Song
- **Key Features:** Added Embedding Models, Vector Stores, MCP Server and Asynchronous Execution for JAVA.

### Blogs

* Rion Williams - [Prepare for Launch: Enrichment Strategies for Apache Flink](https://rion.io/2026/01/27/prepare-for-launch-enrichment-strategies-for-apache-flink/)
* Hongshun Wang - [Fluss 0.9 + Flink CDC V3.6 (coming soon) = production level schema evolution](https://www.linkedin.com/posts/hongshun-wang-82169a233_apachefluss-streamhouse-opensource-activity-7434953224673181696-sfrO?utm_source=share&utm_medium=member_desktop&rcm=ACoAAAEGQNUBcKgSajZ7VR3bxeiquOHZcR2Gq80)
* Robin Moffatt was kind enough to point me to his list of [Interesting Links - February 2026 (Stream Processing section)](https://rmoff.net/2026/02/27/interesting-links-february-2026/#_stream_processing). There are lots of interesting Flink blogs here.

## Governance and Community

### FLIP Activity

#### Accepted - being implemented
**[FLIP-555](https://cwiki.apache.org/confluence/display/FLINK/FLIP-555%3A+Flink+Native+S3+FileSystem): Flink Native S3 FileSystem.** (Samrat Deb)
- Offer native S3 filesystem (flink-s3-fs-native) for Apache Flink
- Directly use AWS SDK V2 and is completely independent of Hadoop and Presto libraries.

#### Being discussed
**[FLIP-566](https://cwiki.apache.org/confluence/display/FLINK/FLIP-566%3A+Introduce+a+new+IMMUTABLE+columns+constraint): Introduce a new IMMUTABLE columns constraint.** (Xuyang Zhong) 
- Introduce a new IMMUTABLE columns constraint, which is useful for delta join, as join keys will be stable. 
- This means for a given primary key, the column values comprising the join key cannot be modified.

**[FLIP-564](https://cwiki.apache.org/confluence/display/FLINK/FLIP-564%3A+Support+FROM_CHANGELOG+and+TO_CHANGELOG+built-in+PTFs): Support FROM_CHANGELOG and TO_CHANGELOG built-in PTFs.** (Gustavo de Morais)
- Enables PTFs to declare that take in or produce CDC (Change Data Capture) information in change logs.
- This is another datastream capability that is now present in the SQL world.
- FROM_CHANGELOG: enables custom SQL connectors by handling custom Change Data Capture (CDC) formats.
- TO_CHANGELOG: enables creating a CDC append stream from a Flink Table. This is the first operator that makes it possible to change an retract/upsert stream back to append.

**[FLIP-495](https://cwiki.apache.org/confluence/display/FLINK/FLIP-495%3A+Support+AdaptiveScheduler+record+and+query+the+rescale+history): Support AdaptiveScheduler record and query the rescale history.** (RocMarshal)
- Allows rescale history to be recorded and queried.
- This history allows the user to optimize future rescales based on historical behaviour. 

**[FLIP-523](https://cwiki.apache.org/confluence/display/FLINK/FLIP-523%3A+Handle+TLS+Certificate+Renewal): Handle TLS Certificate Renewal.** (Oleksandr Nitavskyi)
- Ability to reload TLS certificates when the underlying truststore and keystore are updated.
- Aims to provide a solution for reloading TLS certificates in place, eliminating the need for system restarts.
- Allows clusters to remain active using short lived TLS certificates.  

### Apache Flink Dev List activity

You can view the dev list archives [online](https://lists.apache.org/list.html?dev@flink.apache.org) or [subscribe](https://flink.apache.org/community.html#mailing-lists) to receive emails.

Release planning for Flink 2.3 is [ongoing](https://lists.apache.org/thread/o1lsjzmh2np1fp3b5dk0x6bwzqg4cvw5).

## For more information

Follow this blog to keep up to date with what is happening in the Flink community.

If you have ideas for what you would like to see in these blogs or there is anything you think has been misrepresented, is wrong or missing, please let us know via the dev list (detail below) or [Slack](https://flink.apache.org/how-to-contribute/getting-help/#slack).   

If you would like to keep a closer eye on what's happening in the community, subscribe to one of the [Flink community mailing lists](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more.
Two popular mailing lists are:
* the [dev list](https://lists.apache.org/list.html?dev@flink.apache.org) for development related discussions
* the [user list](https://lists.apache.org/list.html?user@flink.apache.org) for user support and questions 

