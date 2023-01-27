---
authors:
- morsapaes: null
  name: Marta Paes
  twitter: morsapaes
categories: news
date: "2020-03-30T08:00:00Z"
excerpt: While things slow down around us, the Apache Flink community is privileged
  to remain as active as ever. This blogpost combs through the past few months to
  give you an update on the state of things in Flink — from core releases to Stateful
  Functions; from some good old community stats to a new development blog.
title: Flink Community Update - April'20
---

While things slow down around us, the Apache Flink community is privileged to remain as active as ever. This blogpost combs through the past few months to give you an update on the state of things in Flink — from core releases to Stateful Functions; from some good old community stats to a new development blog.

And since now it's more important than ever to keep up the spirits, we’d like to invite you to join the [Flink Forward Virtual Conference](https://www.flink-forward.org/sf-2020), on April 22-24 (see [Upcoming Events](#upcoming-events)). Hope to see you there!

{% toc %}

# The Year (so far) in Flink

## Flink 1.10 Release

To kick off the new year, the Flink community [released Flink 1.10](https://flink.apache.org/news/2020/02/11/release-1.10.0.html) with the record contribution of over 200 engineers. This release introduced significant improvements to the overall performance and stability of Flink jobs, a preview of native Kubernetes integration and advances in Python support (PyFlink). Flink 1.10 also marked the completion of the [Blink integration](https://flink.apache.org/news/2019/08/22/release-1.9.0.html#preview-of-the-new-blink-sql-query-processor), hardening streaming SQL and bringing mature batch processing to Flink with production-ready Hive integration and TPC-DS coverage.

The community is now discussing the [release of Flink 1.10.1](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Releasing-Flink-1-10-1-td38689.html#a38690), covering some outstanding bugs from Flink 1.10.

## Stateful Functions Contribution and 2.0 Release

Last January, the first version of Stateful Functions ([statefun.io](https://statefun.io/)) code was pushed to the [Flink repository](https://github.com/apache/flink-statefun). Stateful Functions started out as an API to build general purpose event-driven applications on Flink, taking advantage of its advanced state management mechanism to cut the “middleman” that usually handles state coordination in such applications (e.g. a database).

In a [recent update](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Update-on-Flink-Stateful-Functions-what-are-the-next-steps-tp38646.html), some new features were announced, like multi-language support (including a Python SDK), function unit testing and Stateful Functions’ own flavor of the [State Processor API]({{< param DocsBaseUrl >}}flink-docs-stable/dev/libs/state_processor_api.html). The release cycle will be independent from core Flink releases and the Release Candidate (RC) has been created — so, **you can expect Stateful Functions 2.0 to be released very soon!**

## Building up to Flink 1.11

Amidst the usual outpour of discussion threads, JIRA tickets and FLIPs, the community is working full steam on bringing Flink 1.11 to life in the next few months. The feature freeze is currently scheduled for late April, so the release is expected around mid May. 
The upcoming release will focus on new features and integrations that broaden the scope of Flink use cases, as well as core runtime enhancements to streamline the operations of complex deployments.

Some of the plans on the use case side include support for changelog streams in the Table API/SQL ([FLIP-105](https://cwiki.apache.org/confluence/display/FLINK/FLIP-105%3A+Support+to+Interpret+and+Emit+Changelog+in+Flink+SQL)), easy streaming data ingestion into Apache Hive ([FLIP-115](https://cwiki.apache.org/confluence/display/FLINK/FLIP-115%3A+Filesystem+connector+in+Table)) and support for Pandas DataFrames in PyFlink. On the operational side, the much anticipated new Source API ([FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)) will unify batch and streaming sources, and improve out-of-the-box event-time behavior; while unaligned checkpoints ([FLIP-76](https://cwiki.apache.org/confluence/display/FLINK/FLIP-76%3A+Unaligned+Checkpoints)) and some changes to network memory management will allow to speed up checkpointing under backpressure. 

Throw into the mix improvements around type systems, the WebUI, metrics reporting and supported formats, this release is bound to keep the community busy. For a complete overview of the ongoing development, check [this discussion](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Features-of-Apache-Flink-1-11-td38724.html#a38793) and follow the weekly updates on the Flink [@community mailing list](https://flink.apache.org/community.html#mailing-lists).
	
## New Committers and PMC Members

The Apache Flink community has welcomed **1 PMC (Project Management Committee) Member** and **5 new Committers** since the last update (September 2019):

### New PMC Members
	Jark Wu

### New Committers
	Zili Chen, Jingsong Lee, Yu Li, Dian Fu, Zhu Zhu

Congratulations to all and thank you for your hardworking commitment to Flink!

# The Bigger Picture

## A Look into the Flink Repository

In the [last update](https://flink.apache.org/news/2019/09/10/community-update.html), we shared some numbers around Flink releases and mailing list activity. This time, we’re looking into the activity in the Flink repository and how it’s evolving.

<center>
<img src="{{< siteurl >}}/img/blog/2020-03-30-flink-community-update/2020-03-30-flink-community-update_1.png" width="725px" alt="GitHub 1"/>
</center>

There is a clear upward trend in the number of contributions to the repository, based on the number of commits. This reflects the **fast pace of development** the project is experiencing and also the **successful integration of the China-based Flink contributors** started early last year. To complement these observations, the repository registered a **1.5x increase in the number of individual contributors in 2019**, compared to the previous year. 

But did this increase in capacity produce any other measurable benefits?

<center>
<img src="{{< siteurl >}}/img/blog/2020-03-30-flink-community-update/2020-03-30-flink-community-update_2.png" width="725px" alt="GitHub 2"/>
</center>

If we look at the average time of Pull Request (PR) “resolution”, it seems like it did: **the average time it takes to close a PR these days has been steadily decreasing** since last year, sitting between 5-6 days for the past few months. 

These are great indicators of the health of Flink as an open source project!

## Flink Community Packages

If you missed the launch of [flink-packages.org](http://flink-packages.org/), here’s a reminder! Ververica has [created (and open sourced)](https://www.ververica.com/blog/announcing-flink-community-packages) a website that showcases the work of the community to push forward the ecosystem surrounding Flink. There, you can explore existing packages (like the Pravega and Pulsar Flink connectors, or the Flink Kubernetes operators developed by Google and Lyft) and also submit your own contributions to the ecosystem.

## Flink "Engine Room"

The community has recently launched the [“Engine Room”](https://cwiki.apache.org/confluence/pages/viewrecentblogposts.action?key=FLINK), a dedicated space in Flink’s Wiki for knowledge sharing between contributors. The goal of this initiative is to make ongoing development on Flink internals more transparent across different work streams, and also to help new contributors get on board with best practices. The first blogpost is already up and sheds light on the [migration of Flink’s CI infrastructure from Travis to Azure Pipelines](https://cwiki.apache.org/confluence/display/FLINK/2020/03/22/Migrating+Flink%27s+CI+Infrastructure+from+Travis+CI+to+Azure+Pipelines).

# Upcoming Events

## Flink Forward Virtual Conference

The organization of Flink Forward had to make the hard decision of cancelling this year’s event in San Francisco. But all is not lost! **Flink Forward SF will be held online on April 22-24 and you can register (for free)** [here](https://www.flink-forward.org/sf-2020). Join the community for interactive talks and Q&A sessions with core Flink contributors and companies like Splunk, Lyft, Netflix or Google.

## Others

Events across the globe have come to a halt due to the growing concerns around COVID-19, so this time we’ll leave you with some interesting content to read instead. In addition to this written content, you can also recap last year’s sessions from [Flink Forward Berlin](https://www.youtube.com/playlist?list=PLDX4T_cnKjD207Aa8b5CsZjc7Z_KRezGz) and [Flink Forward China](https://www.youtube.com/playlist?list=PLDX4T_cnKjD3ANoNinSx3Au-poZTHvbF5)!

<table class="table table-bordered">
  <thead>
    <tr>
      <th>Type</th>
      <th>Links</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><span class="glyphicon glyphicon glyphicon-bookmark" aria-hidden="true"></span> Blogposts</td>
      <td><ul>
		  <li><a href="https://medium.com/bird-engineering/replayable-process-functions-in-flink-time-ordering-and-timers-28007a0210e1">Replayable Process Functions: Time, Ordering, and Timers @Bird</a></li>
		  <li><a href="https://engineering.salesforce.com/application-log-intelligence-performance-insights-at-salesforce-using-flink-92955f30573f">Application Log Intelligence & Performance Insights at Salesforce Using Flink @Salesforce</a></li>
		  </ul>
		  <ul>
		  <li><a href="https://flink.apache.org/news/2020/01/29/state-unlocked-interacting-with-state-in-apache-flink.html">State Unlocked: Interacting with State in Apache Flink</a></li>
		  <li><a href="https://flink.apache.org/news/2020/01/15/demo-fraud-detection.html">Advanced Flink Application Patterns Vol.1: Case Study of a Fraud Detection System</a></li>
		  <li><a href="https://flink.apache.org/news/2020/03/24/demo-fraud-detection-2.html">Advanced Flink Application Patterns Vol.2: Dynamic Updates of Application Logic</a></li>
		  <li><a href="https://flink.apache.org/ecosystem/2020/02/22/apache-beam-how-beam-runs-on-top-of-flink.html">Apache Beam: How Beam Runs on Top of Flink</a></li>
		  <li><a href="https://flink.apache.org/features/2020/03/27/flink-for-data-warehouse.html">Flink as Unified Engine for Modern Data Warehousing: Production-Ready Hive Integration</a></li>
		</ul>
	  </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-console" aria-hidden="true"></span> Tutorials</td>
      <td><ul>
      	  <li><a href="https://medium.com/@zjffdu/flink-on-zeppelin-part-3-streaming-5fca1e16754">Flink on Zeppelin — (Part 3). Streaming</a></li>
		  <li><a href="https://aws.amazon.com/blogs/big-data/streaming-etl-with-apache-flink-and-amazon-kinesis-data-analytics">Streaming ETL with Apache Flink and Amazon Kinesis Data Analytics</a></li>
		  <li><a href="https://flink.apache.org/news/2020/02/20/ddl.html">No Java Required: Configuring Sources and Sinks in SQL</a></li>
		  <li><a href="https://flink.apache.org/news/2020/02/07/a-guide-for-unit-testing-in-apache-flink.html">A Guide for Unit Testing in Apache Flink</a></li>
		  </ul>
	  </td>
    </tr>
  </tbody>
</table>

If you’d like to keep a closer eye on what’s happening in the community, subscribe to the Flink [@community mailing list](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more.
