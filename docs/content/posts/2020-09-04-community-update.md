---
authors:
- morsapaes: null
  name: Marta Paes
  twitter: morsapaes
date: "2020-09-04T08:00:00Z"
excerpt: Ah, so much for a quiet August month. This time around, we bring you some
  new Flink Improvement Proposals (FLIPs), a preview of the upcoming Flink Stateful
  Functions 2.2 release and a look into how far Flink has come in comparison to 2019.
title: Flink Community Update - August'20
---

Ah, so much for a quiet August month. This time around, we bring you some new Flink Improvement Proposals (FLIPs), a preview of the upcoming [Flink Stateful Functions]({{< param DocsBaseUrl >}}flink-statefun-docs-master/) 2.2 release and a look into how far Flink has come in comparison to 2019.

{% toc %}

# The Past Month in Flink

## Flink Releases

### Getting Ready for Flink Stateful Functions 2.2

The details of the next release of [Stateful Functions]({{< param DocsBaseUrl >}}flink-statefun-docs-master/) are under discussion in [this @dev mailing list thread](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/Next-Stateful-Functions-Release-td44063.html), and the feature freeze is set for **September 10th** — so, you can expect Stateful Functions 2.2 to be released soon after! Some of the most relevant features in the upcoming release are:

* **DataStream API interoperability**, allowing users to embed Stateful Functions pipelines in regular [DataStream API]({{< param DocsBaseUrl >}}flink-docs-stable/dev/datastream_api.html) programs with `DataStream` ingress/egress.

* **Fine-grained control over state** for remote functions, including the ability to configure different state expiration modes for each individual function.

As the community around StateFun grows, the release cycle will follow this pattern of smaller and more frequent releases to incorporate user feedback and allow for faster iteration. If you’d like to get involved, we’re always looking for [new contributors](https://github.com/apache/flink-statefun#contributing)!

### Flink 1.10.2

The community has announced the second patch version to cover some outstanding issues in Flink 1.10. You can find a detailed list with all the improvements and bugfixes that went into Flink 1.10.2 in the [announcement blogpost](https://flink.apache.org/news/2020/08/25/release-1.10.2.html).

<hr>

## New Flink Improvement Proposals (FLIPs)

The number of FLIPs being created and discussed in the @dev mailing list is growing week over week, as the Flink 1.12 release takes form and some longer-term efforts are kicked-off. Below are some of the new FLIPs to keep an eye out for!

<table class="table table-bordered">
   <thead>
    <tr>
      <th><center>#</center></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><a href="https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=158866741">FLIP-131</a></td>
        <td><ul>
        <li><b>Consolidate User-Facing APIs and Deprecate the DataSet API</b></li>
        <p>The community proposes to deprecate the DataSet API in favor of the Table API/SQL and the DataStream API, in the long run. For this to be feasible, both APIs first need to be <a href="https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=158866741#FLIP131:ConsolidatetheuserfacingDataflowSDKs/APIs(anddeprecatetheDataSetAPI)-ProposedChanges">adapted and expanded</a> to support the additional use cases currently covered by the DataSet API.</p>
        <p> The first discussion to branch out of this "umbrella" FLIP is around support for a batch execution mode in the DataStream API (<a href="https://cwiki.apache.org/confluence/display/FLINK/FLIP-134%3A+Semantics+of+Bounded+Applications+on+the+DataStream+API">FLIP-134</a>).</p>
      </ul>
      </td>
    </tr>
    <tr>
      <td><a href="https://cwiki.apache.org/confluence/display/FLINK/FLIP-135+Approximate+Task-Local+Recovery">FLIP-135</a></td>
        <td><ul>
        <li><b>Approximate Task-Local Recovery</b></li>
        <p>To better accommodate recovery scenarios where a certain amount of data loss is tolerable, but a full pipeline restart is not desirable, the community plans to introduce a new failover strategy that allows to restart only the failed task(s). Approximate task-local recovery will allow users to trade consistency for fast failure recovery, which is handy for use cases like online training.</p>
      </ul>
      </td>
    </tr>
    <tr>
      <td><a href="https://cwiki.apache.org/confluence/display/FLINK/FLIP-136%3A++Improve+interoperability+between+DataStream+and+Table+API">FLIP-136</a></td>
        <td><ul>
        <li><b>Improve the interoperability between DataStream and Table API</b></li>
        <p>The Table API has seen a great deal of refactoring and new features in recent releases, but the interfaces to and from the DataStream API haven't been updated accordingly. The work in this FLIP will cover multiple known gaps to improve interoperability and expose important functionality also to the DataStream API (e.g. changelog handling).</p>
      </ul>
      </td>
    </tr>
    <tr>
      <td><a href="https://cwiki.apache.org/confluence/display/FLINK/FLIP-139%3A+General+Python+User-Defined+Aggregate+Function+Support+on+Table+API">FLIP-139</a></td>
        <td><ul>
        <li><b>Support Stateful Python UDFs</b></li>
        <p>Python UDFs have been supported in PyFlink <a href="https://flink.apache.org/news/2020/02/11/release-1.10.0.html#pyflink-support-for-native-user-defined-functions-udfs">since 1.10</a>, but were so far limited to stateless functions. The community is now looking to introduce stateful aggregate functions (UDAFs) in the Python Table API.</p>
        <p><b>Note: </b>Pandas UDAFs are covered in a separate proposal (<a href="https://cwiki.apache.org/confluence/display/FLINK/FLIP-137%3A+Support+Pandas+UDAF+in+PyFlink">FLIP-137</a>).</p>
      </ul>
      </td>
    </tr>
  </tbody>
</table>

For a complete overview of the development threads coming up in the project, check the [Flink 1.12 Release Wiki](https://cwiki.apache.org/confluence/display/FLINK/1.12+Release) and follow the feature discussions in the [@dev mailing list](https://lists.apache.org/list.html?dev@flink.apache.org).

## New Committers and PMC Members

The Apache Flink community has welcomed **1 new PMC Member** and **1 new Committer** since the last update. Congratulations!

### New PMC Members

<div class="row">
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars3.githubusercontent.com/u/5466492?s=400&u=7e01cfb0dd0e0dc57d181b986a379027bba48ec4&v=4" width="90" height="90">
      <p><a href="https://github.com/dianfu">Dian Fu</a></p>
    </div>
  </div>
</div>

### New Committers

<div class="row">
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars3.githubusercontent.com/u/43608?s=400&v=4" width="90" height="90">
      <p><a href="https://twitter.com/alpinegizmo">David Anderson</a></p>
    </div>
  </div>
</div>

<hr>
	
# The Bigger Picture

## Flink in 2019: the Aftermath

Roughly a year ago, we did a [roundup of community stats](https://flink.apache.org/news/2019/09/10/community-update.html#the-bigger-picture) to understand how far Flink (and the Flink community) had come in 2019. Where does Flink stand now? What changed?

Perhaps the most impressive result this time around is the surge in activity in the @user-zh mailing list. What started as an effort to better support the chinese-speaking users early in 2019 is now even **exceeding** the level of activity of the (already very active) main @user mailing list. Also @dev<sup>1</sup> registered the highest ever peaks in activity in the months leading to the release of Flink 1.11!

For what it's worth, the Flink GitHub repository is now headed to **15k stars**, after reaching the 10k milestone last year. If you consider some other numbers we gathered previously on [repository activity](https://flink.apache.org/news/2020/04/01/community-update.html#a-look-into-the-flink-repository) and [releases over time](https://flink.apache.org/news/2020/07/27/community-update.html#a-look-into-the-evolution-of-flink-releases), 2020 is looking like one for the books in the Flink community.

<center>
<img src="/img/blog/2020-09-04-community-update/2020-09-04-community-update_1.png" width="1000px" alt=""/>
</center>

<sup>1. Excluding messages from "jira@apache.org".</sup>

<div style="line-height:60%;">
    <br>
</div>

To put these numbers into perspective, the report for the financial year of 2020 from the Apache Software Foundation (ASF) features Flink as **one of the most active open source projects**, with mentions for: 

* Most Active Sources: Visits (#2)
<p></p>
* Top Repositories by Number of Commits (#2)
<p></p>
* Top Most Active Apache Mailing Lists (@user (#1) and @dev (#2))

For more details on where Flink and other open source projects stand in the bigger ASF picture, check out the [full report](https://www.apache.org/foundation/docs/FY2020AnnualReport.pdf).

## Google Season of Docs 2020 Results

In a [previous update](https://flink.apache.org/news/2020/06/11/community-update.html#google-season-of-docs-2020), we announced that Flink had been selected for [Google Season of Docs (GSoD)](https://developers.google.com/season-of-docs) 2020, an initiative to pair technical writers with mentors to work on documentation for open source projects. Today, we'd like to welcome the two technical writers that will be working with the Flink community to improve the Table API/SQL documentation: **Kartik Khare** and **Muhammad Haseeb Asif**!

* [Kartik](https://github.com/KKcorps) is a software engineer at Walmart Labs and a regular contributor to multiple Apache projects. He is also a prolific writer on [Medium](https://medium.com/@kharekartik) and has previously published on the [Flink blog](https://flink.apache.org/news/2020/02/07/a-guide-for-unit-testing-in-apache-flink.html). Last year, he contributed to Apache Airflow as part of GSoD and he's currently revamping the Apache Pinot documentation.

* [Muhammad](https://www.linkedin.com/in/haseebasif/) is a dual degree master student at KTH and TU Berlin, with a focus on distributed systems and data intensive processing (in particular, performance optimization of state backends). He writes frequently about Flink on [Medium](https://medium.com/@haseeb1431) and you can catch him at [Flink Forward](https://www.flink-forward.org/global-2020/conference-program#flinkndb---skyrocketing-stateful-capabilities-of-apache-flink) later this year!

We're looking forward to the next 3 months of collaboration, and would like to thank again all the applicants that invested time into their applications for GSoD with Flink.

<hr>

# Upcoming Events (and More!)

With conference season in full swing, we're glad to see some great Flink content coming up in September! Here, we highlight some of the Flink talks happening soon in virtual events.

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
        <b>ODSC Europe (Sep. 17-19)</b>
        <p><a href="https://odsc.com/speakers/snakes-on-a-plane-interactive-data-exploration-with-pyflink-and-zeppelin-notebooks/">Snakes on a Plane: Interactive Data Exploration with PyFlink and Zeppelin Notebooks</a></p>
      </ul>
      <ul>
        <b>Big Data LDN (Sep. 23-24)</b>
        <p><a href="https://bigdataldn.com/">Flink SQL: From Real-Time Pattern Detection to Online View Maintenance</a></p>
      </ul>
      <ul>
        <b>ApacheCon @Home (Sep. 29-Oct.1)</b>
        <p><a href="https://www.apachecon.com/acah2020/tracks/bigdata-1.html">Integrate Apache Flink with Cloud Native Ecosystem</a></p>
        <p><a href="https://www.apachecon.com/acah2020/tracks/bigdata-1.html">Snakes on a Plane: Interactive Data Exploration with PyFlink and Zeppelin Notebooks</a></p>
        <p><a href="https://www.apachecon.com/acah2020/tracks/bigdata-1.html">Interactive Streaming Data Analytics via Flink on Zeppelin</a></p>
        <p><a href="https://www.apachecon.com/acah2020/tracks/bigdata-2.html">Flink SQL in 2020: Time to show off!</a></p>
        <p><a href="https://www.apachecon.com/acah2020/tracks/streaming.html">Change Data Capture with Flink SQL and Debezium</a></p>
        <p><a href="https://www.apachecon.com/acah2020/tracks/streaming.html">Real-Time Stock Processing With Apache NiFi, Apache Flink and Apache Kafka</a></p>
        <p><a href="https://www.apachecon.com/acah2020/tracks/iot.html">Using the Mm FLaNK Stack for Edge AI (Apache MXNet, Apache Flink, Apache NiFi, Apache Kafka, Apache Kudu)</a></p>
      </ul>
    </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-fire" aria-hidden="true"></span> Blogposts</td>
        <td><ul>
        <b>Flink 1.11 Series</b>
        <li><a href="https://flink.apache.org/news/2020/08/20/flink-docker.html">The State of Flink on Docker</a></li>
        <li><a href="https://flink.apache.org/news/2020/08/06/external-resource.html">Accelerating your workload with GPU and other external resources</a></li>
        <li><a href="https://flink.apache.org/2020/08/04/pyflink-pandas-udf-support-flink.html">PyFlink: The integration of Pandas into PyFlink</a></li>
        <p></p>
        <b>Other</b>
        <li><a href="https://flink.apache.org/2020/08/19/statefun.html">Monitoring and Controlling Networks of IoT Devices with Flink Stateful Functions</a></li>
        <li><a href="https://flink.apache.org/news/2020/07/30/demo-fraud-detection-3.html">Advanced Flink Application Patterns Vol.3: Custom Window Processing</a></li>
      </ul>
      </td>
    </tr>
      <td><span class="glyphicon glyphicon glyphicon-certificate" aria-hidden="true"></span> Flink Packages</td>
      <td><ul><p><a href="https://flink-packages.org/">Flink Packages</a> is a website where you can explore (and contribute to) the Flink <br /> ecosystem of connectors, extensions, APIs, tools and integrations. <b>New in:</b> </p>
          <li><a href="https://flink-packages.org/packages/cdc-connectors"> Flink CDC Connectors</a></li>
          <li><a href="https://flink-packages.org/packages/streaming-flink-file-source">Flink File Source</a></li>
          <li><a href="https://flink-packages.org/packages/streaming-flink-dynamodb-connector">Flink DynamoDB Connector</a></li>
      </ul>
    </td>
    </tr>
  </tbody>
</table>

<hr>

If you’d like to keep a closer eye on what’s happening in the community, subscribe to the Flink [@community mailing list](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more.
