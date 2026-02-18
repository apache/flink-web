---
authors:
- davidrad: null
  name: David Radley
date: "2026-02-01T08:00:00Z"
excerpt: Flink Community update for February 2026
title: Flink Community Update - February'26
aliases:
- /news/2026/02/01/community-update.html
---

<!-- TOC -->
  * [January 2026 overview](#january-2026-overview)
  * [Flink related Blogs](#flink-related-blogs)
  * [Summary of Apache Flink Dev List (covering January 2026)](#summary-of-apache-flink-dev-list-covering-january-2026)
    * [Key Themes](#key-themes)
    * [Community Announcements](#community-announcements)
      * [New Committers](#new-committers)
      * [New PMC Member](#new-pmc-member)
    * [FLIP Activity](#flip-activity)
      * [Accepted - being implemented](#accepted---being-implemented)
      * [Being discussed](#being-discussed)
    * [Kubernetes Operator 1.14.0 Release](#kubernetes-operator-1140-release)
  * [For more information](#for-more-information)
<!-- TOC -->

Previous Blog:
[Flink community update August 2020](https://flink.apache.org/2020/09/04/flink-community-update-august20/)

After a [gap](https://flink.apache.org/2020/09/04/flink-community-update-august20/), the Community update is back for February 2026! The intention going forward is that we will look to produce a monthly blog that will
highlight what has occurred in the community over the previous month. This will include new PMC and committers, any interesting blogs, new releases, active FLIPs and 
a view of the themes in the dev list from the previous month.

The Flink community has made many improvements during the last five years since the last blog; this blog will not cover those achievements. It is focused on the previous month (January 2026). 

In the last few years the Flink PR backlog got to around 1200. We introduced the stale bot last year, and it came down to around 200.
Interestingly, in the last month or so the backlog has been creeping up again and is over 250.

## January 2026 overview
This will summarise what has happened in the previous month (January).

* The previous month has seen the [connector parent](https://github.com/apache/flink-connector-shared-utils/tree/parent_pom) v2 being released, the long-awaited connector parent brought up to date and flink v2 ready.
* The [AWS connectors](https://github.com/apache/flink-connector-aws) have been enhanced and are about to be released for Flink v1 and v2. 
  * Version 5.1 [fixes](https://github.com/apache/flink-connector-aws/pull/193) a data loss issue for DynamoDB Streams and Kinesis Source which was caused when a job restarts from an inflight shard rotation / split during checkpoints.
  * Version 6.0 introduces [support](https://github.com/apache/flink-connector-aws/pull/219) for the ShardFilter API for DynamoDB Streams source, improving efficiency and responsiveness when processing data from DynamoDB Streams.  
* An interesting discussion in the Flink dev connector Slack channel highlighted that Python connectors are in the Flink core repository, but the rest of the connector code is in its own connector-specific repository. 
* Flink HTTP connector addressed all outstanding raised PRs. We are preparing to release it.
* Flink Kafka connector had quite a busy month with around 10 commits going in. The most interesting were:
  * [FLINK-38947] Handle errors in onCompletion callback only once ([#214](https://github.com/apache/flink-connector-kafka/pull/214))
  * [FLINK-38876] Support per-cluster offset in Dynamic Kafka Source ([#209](https://github.com/apache/flink-connector-kafka/pull/209))
* Flink Kubernetes operator
  * Improvements to the blue-green deployment stood out.
  * Preparing to release Kubernetes Operator 1.14.0.

## Flink related Blogs

* Kai Waehner 
[Extensive view on the streaming trends for 2026](https://www.kai-waehner.de/blog/2025/12/10/top-trends-for-data-streaming-with-apache-kafka-and-flink-in-2026/)
* A view on Flink from Ververica
[A world without Kafka](https://www.ververica.com/blog/a-world-without-kafka)

## Summary of Apache Flink Dev List (covering January 2026)

### Key Themes

1. SQL improvements
   - [Altering query should be possible if MATERIALIZED TABLE schema contains non persisted columns](https://lists.apache.org/thread/rbnv8k9qbvlrv087x196o3st3rrvswcw)
   - [SQL syntax evolution for diverse artifacts](https://lists.apache.org/thread/ty6pscdlr2sllx4no4mvj6sb2kdvc9rz)
   - [Support INET_ATON and INET_NTOA functions for IP address conversion](https://lists.apache.org/thread/d39vxv3fjwbvzdrlrxo9g1wlwk6gc9fz)
   - [Exception creating table of nested objects](https://lists.apache.org/list?dev@flink.apache.org:lte=1M:FLINK-38913)
2. Technical debt - more Scala to Java rule conversions in the table planner including:
   -  [Migrate BatchPhysicalSortMergeJoinRule](https://lists.apache.org/thread/x8fyng2pz2t16jxthqgb47h17cftjjsn)
3. Kubernetes Operator maturity 
   - FlinkBlueGreenDeployment
        - [FLINK-38867](https://issues.apache.org/jira/browse/FLINK-38867)
        - [FLINK-38915](https://issues.apache.org/jira/browse/FLINK-38915)
        - [FLINK-38787](https://issues.apache.org/jira/browse/FLINK-38787)
   - [New release planning](https://lists.apache.org/thread/scrs2664s0hznjf15tz2dd5g5yh923tr)

### Community Announcements

#### New Committers
- David Radley
- Yuepeng Pan (RocMarshal)

#### New PMC Member
- Hang Ruan

### FLIP Activity

#### Accepted - being implemented
**[FLIP-339](https://cwiki.apache.org/confluence/display/FLINK/FLIP-339%3A+Support+Adaptive+Partition+Selection+for+StreamPartitioner): Adaptive Partition Selection** (Yuepeng Pan)
- Dynamic partitioning based on downstream load
- Focuses on rebalance/rescale, debate on shuffle()

**[FLIP-487](https://cwiki.apache.org/confluence/display/FLINK/FLIP-487%3A+Show+history+of+rescales+in+Web+UI+for+AdaptiveScheduler): Rescale History in Web UI** (Yuepeng Pan)
- Improves rescaling observability

**[FLIP-558](https://cwiki.apache.org/confluence/display/FLINK/FLIP-558%3A+Improvements+to+SinkUpsertMaterializer+and+changelog+disorder): SinkUpsertMaterializer Improvements** (Dawid)
- Addresses the poor performance and high resource consumption caused by Flink's current implicit handling of data integrity issues, specifically when the upsert key of a stream differs from the PRIMARY KEY of the sink; the use case requiring the Sink Upsert Materializer (SUM).

**[FLIP-560](https://cwiki.apache.org/confluence/display/FLINK/FLIP-560%3A+Application+Capability+Enhancement): Application Capability Enhancement** (Yi Zhang)
- Job Manager Configuration and exceptions exposed in REST/UI

**[FLIP-561](https://cwiki.apache.org/confluence/display/FLINK/FLIP-561%3A+Restructure+Flink+documentation): Restructure Flink documentation** (Martijn Visser)
- A more intuitive structure of the documentation.

#### Being discussed
**[FLIP-557](https://cwiki.apache.org/confluence/display/FLINK/FLIP-557%3A+Granular+Control+over+Data+Reprocessing+and+State+Retention+in+Materialized+Table+Evolution): Granular Control over Data Reprocessing and State Retention in Materialized Table Evolution** (Ramin Gharib) 
- Introduces control of the data processing window for the evolution of materialized tables.
- Allows the scope of state retention to be specified for materialized tables. 

**[FLIP-559](https://cwiki.apache.org/confluence/display/FLINK/FLIP-559%3A+Add+ARTIFACT+keyword+option+in+CREATE+FUNCTION%27s+USING+clause): Add ARTIFACT Keyword** (Mika Naylor)
- Generic ARTIFACT keyword for CREATE FUNCTION
- Supports future artifact types beyond JARs
- Moving toward vote

**[FLIP-563](https://cwiki.apache.org/confluence/display/FLINK/FLIP-563+Support+provided+lib+archives+for+YARN+application+mode): Support provided lib archives for YARN application mode** (Archit Goyal) 
- Discussion thread started but no responses yet. 

### Kubernetes Operator 1.14.0 Release

- **Target:** Release cut January 30, RC vote early February
- **Release Manager:** Gyula Fóra
- **Key Features:** FlinkBlueGreenDeployment fixes from Shopify team

## For more information

Follow this blog to keep up to date with what is happening in the Flink community.

If you have ideas for what you would like to see in these blogs or there is anything you think has been misrepresented, is wrong or missing, please let us know via the dev list (detail below) or [Slack](https://flink.apache.org/how-to-contribute/getting-help/#slack).   

If you would like to keep a closer eye on what’s happening in the community, subscribe to one of the Flink [@community mailing list](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more.
Two popular mailing lists are:
* the [dev list](https://lists.apache.org/list.html?dev@flink.apache.org) for development related discussions
* the [user list](https://lists.apache.org/list.html?user@flink.apache.org) for user support and questions 

