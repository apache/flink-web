---
authors:
- morsapaes: null
  name: Marta Paes
  twitter: morsapaes
categories: news
date: "2020-07-29T08:00:00Z"
excerpt: As July draws to an end, we look back at a monthful of activity in the Flink
  community, including two releases (!) and some work around improving the first-time
  contribution experience in the project. Also, events are starting to pick up again,
  so we've put together a list of some great events you can (virtually) attend in
  August!
title: Flink Community Update - July'20
---

As July draws to an end, we look back at a monthful of activity in the Flink community, including two releases (!) and some work around improving the first-time contribution experience in the project.

Also, events are starting to pick up again, so we've put together a list of some great ones you can (virtually) attend in August!

{% toc %}

# The Past Month in Flink

## Flink Releases

### Flink 1.11

A couple of weeks ago, Flink 1.11 was announced in what was (again) the biggest Flink release to date (_see ["A Look Into the Evolution of Flink Releases"](#a-look-into-the-evolution-of-flink-releases)_)! The new release brought significant improvements to usability as well as new features to Flink users across the API stack. Some highlights of Flink 1.11 are:

  * Unaligned checkpoints to cope with high backpressure scenarios;

  * The new source API, that simplifies and unifies the implementation of (custom) sources;

  * Support for Change Data Capture (CDC) and other common use cases in the Table API/SQL;

  * Pandas UDFs and other performance optimizations in PyFlink, making it more powerful for data science and ML workloads.

For a more detailed look into the release, you can recap the [announcement blogpost](https://flink.apache.org/news/2020/07/06/release-1.11.0.html) and join the upcoming meetup on [“What’s new in Flink 1.11?”](https://www.meetup.com/seattle-flink/events/271922632/), where you’ll be able to ask anything release-related to Aljoscha Krettek (Flink PMC Member). The community has also been working on a series of blogposts that deep-dive into the most significant features and improvements in 1.11, so keep an eye on the [Flink blog](https://flink.apache.org/blog/)!

### Flink 1.11.1

Shortly after releasing Flink 1.11, the community announced the first patch version to cover some outstanding issues in the major release. This version is **particularly important for users of the Table API/SQL**, as it addresses known limitations that affect the usability of new features like changelog sources and support for JDBC catalogs. 

You can find a detailed list with all the improvements and bugfixes that went into Flink 1.11.1 in the [announcement blogpost](https://flink.apache.org/news/2020/07/21/release-1.11.1.html).

<hr>

## Gearing up for Flink 1.12

The Flink 1.12 release cycle has been kicked-off last week and a discussion about what features will go into the upcoming release is underway in [this @dev Mailing List thread](https://lists.apache.org/thread.html/rb01160c7c9c26304a7665f9a252d4ed1583173620df307015c095fcf%40%3Cdev.flink.apache.org%3E). While we wait for more of these ideas to turn into proposals and JIRA issues, here are some recent FLIPs that are already being discussed in the Flink community:

<table class="table table-bordered">
  <thead>
    <tr>
      <th>FLIP</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><a href="https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=158866298">FLIP-130</a></td>
        <td><ul>
        <li><b>Support Python DataStream API</b></li>
        <p>Python support in Flink has so far been bounded to the Table API/SQL. These APIs are high-level and convenient, but have some limitations for more complex stream processing use cases. To expand the usability of PyFlink to a broader set of use cases, FLIP-130 proposes to support it also in the DataStream API, starting with stateless operations.</p>
      </ul>
      </td>
    </tr>
    <tr>
      <td><a href="https://cwiki.apache.org/confluence/display/FLINK/FLIP-132+Temporal+Table+DDL">FLIP-132</a></td>
        <td><ul>
        <li><b>Temporal Table DDL</b></li>
        <p>Flink SQL users can't currently create temporal tables using SQL DDL, which forces them to change context frequently for use cases that require them. FLIP-132 proposes to extend the DDL syntax to support temporal tables, which in turn will allow to also bring <a href="{{< param DocsBaseUrl >}}flink-docs-stable/dev/table/streaming/joins.html#join-with-a-temporal-table">temporal joins</a> with changelog sources to Flink SQL.</p>
      </ul>
      </td>
    </tr>
  </tbody>
</table>

<hr>

## New Committers and PMC Members

The Apache Flink community has welcomed **2 new PMC Members** since the last update. Congratulations!

### New PMC Members

<div class="row">
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars0.githubusercontent.com/u/8957547?s=400&u=4560f775da9ebc5f3aa2e1563f57cdad03862ce8&v=4" width="90" height="90">
      <p><a href="https://twitter.com/PiotrNowojski">Piotr Nowojski</a></p>
    </div>
  </div>
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars0.githubusercontent.com/u/6239804?s=460&u=6cd81b1ab38fcc6a5736fcfa957c51093bf060e2&v=4" width="90" height="90">
      <p><a href="https://twitter.com/LiyuApache">Yu Li</a></p>
    </div>
  </div>
</div>

<hr>
	
# The Bigger Picture

## A Look Into the Evolution of Flink Releases

It’s [been a while](https://flink.apache.org/news/2020/04/01/community-update.html#a-look-into-the-flink-repository) since we had a look at community numbers, so this time we’d like to shed some light on the evolution of contributors and, well, work across releases. Let’s have a look at some _git_ data:

<div style="line-height:60%;">
    <br>
</div>

<center>
<img src="{{< siteurl >}}/img/blog/2020-07-29-community-update/2020-07-29_releases.png" width="600px" alt="Flink Releases"/>
</center>

<div style="line-height:60%;">
    <br>
</div>

If we consider Flink 1.8 (Apr. 2019) as the baseline, the Flink community more than **tripled** the number of implemented and/or resolved issues in a single release with the support of an **additional ~100 contributors** in Flink 1.11. This is pretty impressive on its own, and even more so if you consider that Flink contributors are distributed around the globe, working across different locations and timezones!

<hr>

## First-time Contributor Guide

Flink has an extensive guide for [code and non-code contributions](https://flink.apache.org/contributing/how-to-contribute.html) that helps new community members navigate the project and get familiar with existing contribution guidelines. In particular for code contributions, knowing where to start can be difficult, given the sheer size of the Flink codebase and the pace of development of the project. 

To better guide new contributors, a brief section was added to the guide on [how to look for what to contribute](https://flink.apache.org/contributing/contribute-code.html#looking-for-what-to-contribute) and the [_starter_ label](https://issues.apache.org/jira/browse/FLINK-18704?filter=12349196) has been revived in Jira to highlight issues that are suitable for first-time contributors.

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note </span>
As a reminder, you no longer need to ask for contributor permissions to start contributing to Flink. Once you’ve found something you’d like to work on, read the <a href="https://flink.apache.org/contributing/contribute-code.html">contribution guide</a> carefully and reach out to a Flink Committer, who will be able to help you get started.
</div>

## Replacing “charged” words in the Flink repo

The community is working on gradually replacing words that are outdated and carry a negative connotation in the Flink codebase, such as “master/slave” and “whitelist/blacklist”. The progress of this work can be tracked in [FLINK-18209](https://issues.apache.org/jira/browse/FLINK-18209).

<hr>

# Upcoming Events (and More!)

We're happy to see the "high season" of virtual events approaching, with a lot of great conferences taking place in the coming month, as well as some meetups. Here, we highlight some of the Flink talks happening in those events, but we recommend checking out the complete event programs!

As usual, we also leave you with some resources to read and explore.

<table class="table table-bordered">
  <thead>
    <tr>
      <th>Category</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><span class="glyphicon glyphicon glyphicon-console" aria-hidden="true"></span> Events</td>
      <td><ul>
        <b>Virtual Flink Meetup (Jul. 29)</b>
        <p><a href="https://www.meetup.com/seattle-flink/events/271922632/">What’s new in Flink 1.11? + Q&A with Aljoscha Krettek</a></p>
      </ul>
      <ul>
        <b>DC Thursday (Jul. 30)</b>
        <p><a href="https://www.eventbrite.com/e/dc-thurs-apache-flink-w-stephan-ewen-tickets-112137488246?utm_campaign=Events%20%26%20Talks&utm_content=135006406&utm_medium=social&utm_source=twitter&hss_channel=tw-2581958070">Interview and Community Q&A with Stephan Ewen</a></p>
      </ul>
      <ul>
        <b>KubeCon + CloudNativeCon Europe (Aug. 17-20)</b>
        <p><a href="https://kccnceu20.sched.com/event/ZelA/stateful-serverless-and-the-elephant-in-the-room-stephan-ewen-ververica">Stateful Serverless and the Elephant in the Room</a></p>
      </ul>
      <ul>
        <b>DataEngBytes (Aug. 20-21)</b>
        <p><a href="https://dataengconf.com.au/">Change Data Capture with Flink SQL and Debezium</a></p>
        <p><a href="https://dataengconf.com.au/">Sweet Streams are Made of These: Data Driven Development with Stream Processing</a></p>
      </ul>
      <ul>
        <b>Beam Summit (Aug. 24-29)</b>
        <p><a href="https://2020.beamsummit.org/sessions/streaming-fast-slow/">Streaming, Fast and Slow</a></p>
        <p><a href="https://2020.beamsummit.org/sessions/building-stateful-streaming-pipelines/">Building Stateful Streaming Pipelines With Beam</a></p>
      </ul>
    </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-fire" aria-hidden="true"></span> Blogposts</td>
        <td><ul>
        <b>Flink 1.11 Series</b>
        <li><a href="https://flink.apache.org/news/2020/07/14/application-mode.html">Application Deployment in Flink: Current State and the new Application Mode</a></li>
        <li><a href="https://flink.apache.org/2020/07/23/catalogs.html">Sharing is caring - Catalogs in Flink SQL (Tutorial)</a></li>
        <li><a href="https://flink.apache.org/2020/07/28/flink-sql-demo-building-e2e-streaming-application.html">Flink SQL Demo: Building an End-to-End Streaming Application (Tutorial)</a></li>
        <p></p>
        <b>Other</b>
        <li><a href="https://blogs.oracle.com/javamagazine/streaming-analytics-with-java-and-apache-flink?source=:em:nw:mt::RC_WWMK200429P00043:NSL400072808&elq_mid=167902&sh=162609181316181313222609291604350235&cmid=WWMK200429P00043C0004">Streaming analytics with Java and Apache Flink (Tutorial)</a></li>
        <li><a href="https://www.ververica.com/blog/flink-for-online-machine-learning-and-real-time-processing-at-weibo">Flink for online Machine Learning and real-time processing at Weibo</a></li>
        <li><a href="https://www.ververica.com/blog/data-driven-matchmaking-at-azar-with-apache-flink">Data-driven Matchmaking at Azar with Apache Flink</a></li>
      </ul>
      </td>
    </tr>
      <td><span class="glyphicon glyphicon glyphicon-certificate" aria-hidden="true"></span> Flink Packages</td>
      <td><ul><p><a href="https://flink-packages.org/">Flink Packages</a> is a website where you can explore (and contribute to) the Flink <br /> ecosystem of connectors, extensions, APIs, tools and integrations. <b>New in:</b> </p>
          <li><a href="https://flink-packages.org/packages/flink-metrics-signalfx"> SignalFx Metrics Reporter</a></li>
          <li><a href="https://flink-packages.org/packages/yauaa">Yauaa: Yet Another UserAgent Analyzer</a></li>
      </ul>
    </td>
    </tr>
  </tbody>
</table>

<hr>

If you’d like to keep a closer eye on what’s happening in the community, subscribe to the Flink [@community mailing list](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more.
