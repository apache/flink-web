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
    * [📊 Key Themes](#-key-themes)
    * [🎉 Community Announcements](#-community-announcements)
    * [📋 Active FLIPs](#-active-flips)
    * [🔧 Kubernetes Operator 1.14.0 Release](#-kubernetes-operator-1140-release)
    * [❓For more information](#for-more-information)
<!-- TOC -->

Previous Blog :
[https:/flink.apache.org/2020/09/04/flink-community-update-august20/](https:/flink.apache.org/2020/09/04/flink-community-update-august20/)

After a gap, the Community update is back for February 2026! As usual this update will summarise what has happened in the previous month (January).
- In the last few years the Flink PR backlog got to around 1200. We introduced the stale bot last year, and it came down to around 200.
Interestingly, in the last month or so the backlog has been creeping up again and is over 250.
- The previous month has seen the connector parent v2 being released, the long awaited connector parent brought up to date and flink 2 ready.
- The AWS connectors have been enhanced and are about be to be released for Flink v1 and v2.
- Flink dev connector slack brought up an interesting discussion the Python connectors are in the Flink core repository
  but the rest of the connector code is in its own repository.
- Flink HTTP connector, addressed all outstanding raised PRs. Preparing for releasing it.
- Flink Kafka connector had quite a busy month with around 10 commits going in. The most interesting were:
    - [FLINK-38947] Handle errors in onCompletion callback only once (#214)
    - [FLINK-38876] Support per-cluster offset in Dynamic Kafka Source (#209)
- Flink Kubenetes operator
    - had 9 commits, improvements to the blue-green deployment stood out.
    - Preparing to release Kubernetes Operator 1.14.0

## Flink related Blogs

* Extensive view on the streaming trends for 2026
[https://www.kai-waehner.de/blog/2025/12/10/top-trends-for-data-streaming-with-apache-kafka-and-flink-in-2026/](https://www.kai-waehner.de/blog/2025/12/10/top-trends-for-data-streaming-with-apache-kafka-and-flink-in-2026/)
* A view on the Flink world from Ververica
[https://www.ververica.com/blog/a-world-without-kafka](https://www.ververica.com/blog/a-world-without-kafka)
* A blog on Flink being the future of stream processing 
[https://www.oreateai.com/blog/understanding-apache-flink-the-future-of-stream-processing/284a4ec5131c57f2dbf5b0b2660f896f](https://www.oreateai.com/blog/understanding-apache-flink-the-future-of-stream-processing/284a4ec5131c57f2dbf5b0b2660f896f)

## Summary of Apache Flink Dev List (covering January 2026)

AI summary.

### 📊 Key Themes

1. Enhanced Application Mode for batch processing
2. Improved observability and error reporting
3. SQL syntax evolution for diverse artifacts
4. Performance optimization through adaptive partitioning
5. Kubernetes Operator maturity

### 🎉 Community Announcements

**New Committers:**
- **David Radley**
- **Yuepeng Pan (RocMarshal)**

**New PMC Member:**
- **Hang Ruan**

### 📋 Active FLIPs

**FLIP-560: Application Capability Enhancement** (Yi Zhang)
- Multi-job execution in Application Mode
- Re-running main method after JobManager restarts
- Expose main method exceptions via REST/UI
- Active discussion on error handling and diagnostics

**FLIP-559: Add ARTIFACT Keyword** (Mika Naylor)
- Generic ARTIFACT keyword for CREATE FUNCTION
- Supports future artifact types beyond JARs
- Moving toward vote

**FLIP-487: Rescale History in Web UI** (Yuepeng Pan)
- Vote started January 7, 2026
- Improves rescaling observability

**FLIP-558: SinkUpsertMaterializer Improvements** (Dawid)
- Vote started

**FLIP-339: Adaptive Partition Selection** (Yuepeng Pan)
- Dynamic partitioning based on downstream load
- Focuses on rebalance/rescale, debate on shuffle()

**FLIP-561: Restructure Flink documentation** (Martijn Visser)
- Vote started January 15, 2026

### 🔧 Kubernetes Operator 1.14.0 Release

- **Target:** Release cut January 30, RC vote early February
- **Release Manager:** Gyula Fóra
- **Key Features:** FlinkBlueGreenDeployment fixes from Shopify team

### ❓For more information

Anything you think has been misrepresented, is wrong or missing, please let me know via Flink Slack.
If you would like to keep a closer eye on what’s happening in the community, subscribe to the Flink [@community mailing list](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more.