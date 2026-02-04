---
authors:
- davidrad: null
  name: David Radley
date: "2026-02-02T08:00:00Z"
excerpt: Flink Community update for February 2026
title: Flink Community Update - February'26
aliases:
- /news/2026/02/02/community-update.html
---

# This past month in Flink

<!-- TOC -->
* [This past month in Flink](#this-past-month-in-flink)
  * [Flink related Blogs](#flink-related-blogs)
  * [Summary of Apache Flink Dev List (covering January 2026)](#summary-of-apache-flink-dev-list-covering-january-2026)
    * [Key Themes](#key-themes)
    * [Community Announcements](#community-announcements)
    * [Active FLIPs](#active-flips)
    * [Kubernetes Operator 1.14.0 Release](#kubernetes-operator-1140-release)
  * [For more information](#for-more-information)
<!-- TOC -->

Previous Blog :
[https://flink.apache.org/2020/09/04/flink-community-update-august20/](https://flink.apache.org/2020/09/04/flink-community-update-august20/)

After a gap, the Community update is back for February 2026! The intention going forward is that we will look to produce a monthly blog, that will
highlight what has occurred in the community over the previous month. This will include new PMC and committers, any interesting blogs, new releases, active Flips and 
a view of the themes in the dev list from the previous month.
<p>
Since 2020, the Flink community has been very busy, to give a flavour of what has changed, Flink has 

* added many new connectors, moved out to their own repositories.
* benefited from newer Calcite levels
* introduced Change Data Capture
* introduced kubernetes Operator support
* added support for AI capabilities 
* new DataStream API V2
* new Flink SQL gateway
* released Flink v2, with disaggregated state, support of more up to date JAVA levels and removing deprecated APIs.
<p>
In the last few years the Flink PR backlog got to around 1200. We introduced the stale bot last year, and it came down to around 200.
Interestingly, in the last month or so the backlog has been creeping up again and is over 250.
<p>
As usual this update will summarise what has happened in the previous month (January).

* The previous month has seen the connector parent v2 being released, the long awaited connector parent brought up to date and flink v2 ready.
* The AWS connectors have been enhanced and are about to be released for Flink v1 and v2.
* An interesting discussion in the Flink dev connector Slack channel highlighted that Python connectors are in the Flink core repository, but the rest of the connector code is in their own connector specific repository. 
* Flink HTTP connector, addressed all outstanding raised PRs. Preparing for releasing it.
* Flink Kafka connector had quite a busy month with around 10 commits going in. The most interesting were:
    * [FLINK-38947] Handle errors in onCompletion callback only once ([#214](https://github.com/apache/flink-connector-kafka/pull/214))
    * [FLINK-38876] Support per-cluster offset in Dynamic Kafka Source ([#209](https://github.com/apache/flink-connector-kafka/pull/209))
* Flink kubernetes operator
    * commits, improvements to the blue-green deployment stood out.
    * Preparing to release Kubernetes Operator 1.14.0

## Flink related Blogs

* Kai Waehner 
[Extensive view on the streaming trends for 2026](https://www.kai-waehner.de/blog/2025/12/10/top-trends-for-data-streaming-with-apache-kafka-and-flink-in-2026/)
* A view on the Flink world from Ververica
[https://www.ververica.com/blog/a-world-without-kafka](https://www.ververica.com/blog/a-world-without-kafka)

## Summary of Apache Flink Dev List (covering January 2026)

The following section was generated with AI assistance and reviewed by the community.

### Key Themes

1. SQL improvements
   - Altering query should be possible if MATERIALIZED TABLE schema contains non persisted columns [https://lists.apache.org/thread/rbnv8k9qbvlrv087x196o3st3rrvswcw](https://lists.apache.org/thread/rbnv8k9qbvlrv087x196o3st3rrvswcw)
   - SQL syntax evolution for diverse artifacts https://lists.apache.org/thread/ty6pscdlr2sllx4no4mvj6sb2kdvc9rz
   - Support INET_ATON and INET_NTOA functions for IP address conversion [https://lists.apache.org/thread/d39vxv3fjwbvzdrlrxo9g1wlwk6gc9fz](https://lists.apache.org/thread/d39vxv3fjwbvzdrlrxo9g1wlwk6gc9fz)
   - Exception creating table of nested objects [https://lists.apache.org/list?dev@flink.apache.org:lte=1M:FLINK-38913](https://lists.apache.org/list?dev@flink.apache.org:lte=1M:FLINK-38913)
2. More Scala to java rule conversion in the table planner including:
   -  [https://lists.apache.org/thread/x8fyng2pz2t16jxthqgb47h17cftjjsn](https://lists.apache.org/thread/x8fyng2pz2t16jxthqgb47h17cftjjsn)
3. Kubernetes Operator maturity 
   - FlinkBlueGreenDeployment
        - [FLINK-38867](https://issues.apache.org/jira/browse/FLINK-38867)
        - [FLINK-38915](https://issues.apache.org/jira/browse/FLINK-38915)
        - [FLINK-38787](https://issues.apache.org/jira/browse/FLINK-38787)
   - [New release planning](https://lists.apache.org/thread/scrs2664s0hznjf15tz2dd5g5yh923tr)

### Community Announcements

**New Committers:**
- **David Radley**
- **Yuepeng Pan (RocMarshal)**

**New PMC Member:**
- **Hang Ruan**

### Active FLIPs

**[FLIP-560](https://cwiki.apache.org/confluence/display/FLINK/FLIP-560%3A+Application+Capability+Enhancement) Application Capability Enhancement** (Yi Zhang)
- Job manager Config and exceptions exposed in REST/UI
- Active discussion on error handling and diagnostics

**[FLIP-559](https://cwiki.apache.org/confluence/display/FLINK/FLIP-559%3A+Add+ARTIFACT+keyword+option+in+CREATE+FUNCTION%27s+USING+clause): Add ARTIFACT Keyword** (Mika Naylor)
- Generic ARTIFACT keyword for CREATE FUNCTION
- Supports future artifact types beyond JARs
- Moving toward vote

**[FLIP-487](https://cwiki.apache.org/confluence/display/FLINK/FLIP-487%3A+Show+history+of+rescales+in+Web+UI+for+AdaptiveScheduler): Rescale History in Web UI** (Yuepeng Pan)
- Vote started January 7, 2026
- Improves rescaling observability

**[FLIP-558](https://cwiki.apache.org/confluence/display/FLINK/FLIP-558%3A+Improvements+to+SinkUpsertMaterializer+and+changelog+disorder): SinkUpsertMaterializer Improvements** (Dawid)
- Vote started

**[FLIP-339](https://cwiki.apache.org/confluence/display/FLINK/FLIP-339%3A+Support+Adaptive+Partition+Selection+for+StreamPartitioner): Adaptive Partition Selection** (Yuepeng Pan)
- Dynamic partitioning based on downstream load
- Focuses on rebalance/rescale, debate on shuffle()

**[FLIP-561](https://cwiki.apache.org/confluence/display/FLINK/FLIP-561%3A+Restructure+Flink+documentation): Restructure Flink documentation** (Martijn Visser)
- Vote started January 15, 2026

### Kubernetes Operator 1.14.0 Release

- **Target:** Release cut January 30, RC vote early February
- **Release Manager:** Gyula Fóra
- **Key Features:** FlinkBlueGreenDeployment fixes from Shopify team

## For more information

Anything you think has been misrepresented, is wrong or missing, please let me know via Flink Slack.

If you would like to keep a closer eye on what’s happening in the community, subscribe to one of the Flink [@community mailing list](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more.
Two popular mailing lists are:
* the [dev list](https://lists.apache.org/list.html?dev@flink.apache.org) for development related discussions
* the [user list](https://lists.apache.org/list.html?user@flink.apache.org) for user support and questions 

