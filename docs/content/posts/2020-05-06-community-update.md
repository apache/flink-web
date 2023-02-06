---
authors:
- morsapaes: null
  name: Marta Paes
  twitter: morsapaes
date: "2020-05-06T08:00:00Z"
excerpt: Can you smell it? It’s release month! This time around, we’re warming up
  for Flink 1.11 and peeping back to the past month in the Flink community — with
  the release of Stateful Functions 2.0, a new self-paced Flink training and some
  efforts to improve the Flink documentation experience.
title: Flink Community Update - May'20
---

Can you smell it? It’s release month! It took a while, but now that we’re [all caught up with the past](https://flink.apache.org/news/2020/04/01/community-update.html), the Community Update is here to stay. This time around, we’re warming up for Flink 1.11 and peeping back to the month of April in the Flink community — with the release of Stateful Functions 2.0, a new self-paced Flink training and some efforts to improve the Flink documentation experience.

Last month also marked the debut of Flink Forward Virtual Conference 2020: what did you think? If you missed it altogether or just want to recap some of the sessions, the [videos](https://www.youtube.com/playlist?list=PLDX4T_cnKjD0ngnBSU-bYGfgVv17MiwA7) and [slides](https://www.slideshare.net/FlinkForward) are now available!

{% toc %}

# The Past Month in Flink

## Flink Stateful Functions 2.0 is out!

In the beginning of April, the Flink community announced the [release of Stateful Functions 2.0](https://flink.apache.org/news/2020/04/07/release-statefun-2.0.0.html) — the first as part of the Apache Flink project. From this release, you can use Flink as the base of a (stateful) serverless platform with out-of-the-box consistent and scalable state, and efficient messaging between functions. You can even run your stateful functions on platforms like AWS Lambda, as Gordon ([@tzulitai](https://twitter.com/tzulitai)) demonstrated in [his Flink Forward talk](https://www.youtube.com/watch?v=tuSylBadNSo&list=PLDX4T_cnKjD0ngnBSU-bYGfgVv17MiwA7&index=27&t=8s).

<div style="line-height:60%;">
    <br>
</div>

<center>
<img src="/img/blog/2020-05-06-community-update/2020-05-06-community-update_2.png" width="550px" alt="Stateful Functions"/>
</center>

<div style="line-height:60%;">
    <br>
</div>

It’s been encouraging to see so many questions about Stateful Functions popping up in the [mailing list](https://lists.apache.org/list.html?user@flink.apache.org:lte=3M:statefun) and Stack Overflow! If you’d like to get involved, we’re always [looking for new contributors](https://github.com/apache/flink-statefun#contributing) — especially around SDKs for other languages like Go, Javascript and Rust.

<hr>

## Warming up for Flink 1.11

The final preparations for the release of Flink 1.11 are well underway, with the feature freeze scheduled for May 15th, and there’s a lot of new features and improvements to look out for:

* On the **usability** side, you can expect a big focus on smoothing data ingestion with contributions like support for Change Data Capture (CDC) in the Table API/SQL ([FLIP-105](https://cwiki.apache.org/confluence/display/FLINK/FLIP-105%3A+Support+to+Interpret+and+Emit+Changelog+in+Flink+SQL)), easy streaming data ingestion into Apache Hive ([FLIP-115](https://cwiki.apache.org/confluence/display/FLINK/FLIP-115%3A+Filesystem+connector+in+Table)) or support for Pandas DataFrames in PyFlink ([FLIP-120](https://cwiki.apache.org/confluence/display/FLINK/FLIP-120%3A+Support+conversion+between+PyFlink+Table+and+Pandas+DataFrame)). A great deal of effort has also gone into maturing PyFlink, with the introduction of user defined metrics in Python UDFs ([FLIP-112](https://cwiki.apache.org/confluence/display/FLINK/FLIP-112%3A+Support+User-Defined+Metrics+in++Python+UDF)) and the extension of Python UDF support beyond the Python Table API ([FLIP-106](https://cwiki.apache.org/confluence/display/FLINK/FLIP-106%3A+Support+Python+UDF+in+SQL+Function+DDL),[FLIP-114](https://cwiki.apache.org/confluence/display/FLINK/FLIP-114%3A+Support+Python+UDF+in+SQL+Client)).

* On the **operational** side, the much anticipated new Source API ([FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)) will unify batch and streaming sources, and improve out-of-the-box event-time behavior; while unaligned checkpoints ([FLIP-76](https://cwiki.apache.org/confluence/display/FLINK/FLIP-76%3A+Unaligned+Checkpoints)) and changes to network memory management will allow to speed up checkpointing under backpressure — this is part of a bigger effort to rethink fault tolerance that will introduce many other non-trivial changes to Flink. You can learn more about it in [this](https://youtu.be/ssEmeLcL5Uk) recent Flink Forward talk!

Throw into the mix improvements around type systems, the WebUI, metrics reporting, supported formats and...we can't wait! To get an overview of the ongoing developments, have a look at [this thread](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/ANNOUNCE-Development-progress-of-Apache-Flink-1-11-tp40718.html). We encourage the community to get involved in testing once an RC (Release Candidate) is out. Keep an eye on the [@dev mailing list](https://flink.apache.org/community.html#mailing-lists) for updates!

<hr>

## Flink Minor Releases

### Flink 1.9.3

The community released Flink 1.9.3, covering some outstanding bugs from Flink 1.9! You can find more in the [announcement blogpost]((https://flink.apache.org/news/2020/04/24/release-1.9.3.html)).

### Flink 1.10.1

Also in the pipeline is the release of Flink 1.10.1, already in the [RC voting](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/VOTE-Release-1-10-1-release-candidate-2-td41019.html) phase. So, you can expect Flink 1.10.1 to be released soon!

<hr>

## New Committers and PMC Members

The Apache Flink community has welcomed **3 PMC Members** and **2 new Committers** since the last update. Congratulations!

### New PMC Members

<div class="row">
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars2.githubusercontent.com/u/6242259?s=400&u=6e39f4fdbabc8ce4ccde9125166f791957d3ae80&v=4" width="90" height="90">
      <p><a href="https://twitter.com/dwysakowicz">Dawid Wysakowicz</a></p>
    </div>
  </div>
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars1.githubusercontent.com/u/4971479?s=400&u=49d4f217e26186606ab13a17a23a038b62b86682&v=4" width="90" height="90">
      <p><a href="https://twitter.com/HequnC">Hequn Cheng</a></p>
    </div>
  </div>
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars3.githubusercontent.com/u/12387855?s=400&u=37edbfccb6908541f359433f420f9f1bc25bc714&v=4" width="90" height="90">
      <p>Zhijiang Wang</p>
    </div>
  </div>
</div>

### New Committers

<div class="row">
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars3.githubusercontent.com/u/11538663?s=400&u=f4643f1981e2a8f8a1962c34511b0d32a31d9502&v=4" width="90" height="90">
      <p><a href="https://twitter.com/snntrable">Konstantin Knauf</a></p>
    </div>
  </div>
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars1.githubusercontent.com/u/1891970?s=400&u=b7718355ceb1f4a8d1e554c3ae7221e2f32cc8e0&v=4" width="90" height="90">
      <p><a href="https://twitter.com/sjwiesman">Seth Wiesman</a></p>
    </div>
  </div>
</div>

<hr>
	
# The Bigger Picture

## A new self-paced Apache Flink training

<div style="line-height:60%;">
    <br>
</div>

This week, the Flink website received the invaluable contribution of a self-paced training course curated by David ([@alpinegizmo](https://twitter.com/alpinegizmo)) — or, what used to be the entire training materials under [training.ververica.com](training.ververica.com). The new materials guide you through the very basics of Flink and the DataStream API, and round off every concepts section with hands-on exercises to help you better assimilate what you learned.

<div style="line-height:60%;">
    <br>
</div>

<center>
<img src="/img/blog/2020-05-06-community-update/2020-05-06-community-update_1.png" width="1000px" alt="Self-paced Flink Training"/>
</center>

<div style="line-height:140%;">
    <br>
</div>

Whether you're new to Flink or just looking to strengthen your foundations, this training is the most comprehensive way to get started and is now completely open source: [https://flink.apache.org/training.html](https://flink.apache.org/training.html). For now, the materials are only available in English, but the community intends to also provide a Chinese translation in the future.

<hr>

## Google Season of Docs 2020

Google Season of Docs (GSOD) is a great initiative organized by [Google Open Source](https://opensource.google.com/) to pair technical writers with mentors to work on documentation for open source projects. Last year, the Flink community submitted [an application](https://flink.apache.org/news/2019/04/17/sod.html) that unfortunately didn’t make the cut — but we are trying again! This time, with a project idea to improve the Table API & SQL documentation:

**1) Restructure the Table API & SQL Documentation**

Reworking the current documentation structure would allow to:

* Lower the entry barrier to Flink for non-programmatic (i.e. SQL) users.

* Make the available features more easily discoverable.

* Improve the flow and logical correlation of topics.

[FLIP-60](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=127405685) contains a detailed proposal on how to reorganize the existing documentation, which can be used as a starting point.

**2) Extend the Table API & SQL Documentation**

Some areas of the documentation have insufficient detail or are not [accessible](https://flink.apache.org/contributing/docs-style.html#general-guiding-principles) for new Flink users. Examples of topics and sections that require attention are: planners, built-in functions, connectors, overview and concepts sections. There is a lot of work to be done and the technical writer could choose what areas to focus on — these improvements could then be added to the documentation rework umbrella issue ([FLINK-12639](https://issues.apache.org/jira/browse/FLINK-12639)).

If you’re interested in learning more about this project idea or want to get involved in GSoD as a technical writer, check out the [announcement blogpost](https://flink.apache.org/news/2020/05/04/season-of-docs.html).

<hr>

# ...and something to read!

Events across the globe have pretty much come to a halt, so we’ll leave you with some interesting resources to read and explore instead. In addition to this written content, you can also recap the sessions from the [Flink Forward Virtual Conference](https://www.youtube.com/playlist?list=PLDX4T_cnKjD0ngnBSU-bYGfgVv17MiwA7)!

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
		  <li><a href="https://medium.com/@abdelkrim.hadjidj/event-driven-supply-chain-for-crisis-with-flinksql-be80cb3ad4f9">Event-Driven Supply Chain for Crisis with FlinkSQL and Zeppelin</a></li>
		  </ul>
		  <ul>
		  <li><a href="https://flink.apache.org/news/2020/04/21/memory-management-improvements-flink-1.10.html">Memory Management Improvements with Apache Flink 1.10</a></li>
		  <li><a href="https://flink.apache.org/news/2020/04/15/flink-serialization-tuning-vol-1.html">Flink Serialization Tuning Vol. 1: Choosing your Serializer — if you can</a></li>
		</ul>
	  </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon-console" aria-hidden="true"></span> Tutorials</td>
      <td><ul>
      	  <li><a href="https://flink.apache.org/2020/04/09/pyflink-udf-support-flink.html">PyFlink: Introducing Python Support for UDFs in Flink's Table API</a></li>
      	  <li><a href="https://dev.to/morsapaes/flink-stateful-functions-where-to-start-2j39">Flink Stateful Functions: where to start?</a></li>
		  </ul>
	  </td>
    </tr>
    <tr>
      <td><span class="glyphicon glyphicon glyphicon-certificate" aria-hidden="true"></span> Flink Packages</td>
      <td><ul><p><a href="https://flink-packages.org/">Flink Packages</a> is a website where you can explore (and contribute to) the Flink <br /> ecosystem of connectors, extensions, APIs, tools and integrations. <b>New in:</b> </p>
      	  <li><a href="https://flink-packages.org/packages/spillable-state-backend-for-flink">Spillable State Backend for Flink</a></li>
		  <li><a href="https://flink-packages.org/packages/flink-memory-calculator">Flink Memory Calculator</a></li>
		  <li><a href="https://flink-packages.org/packages/ververica-platform-community-edition">Ververica Platform Community Edition</a></li>
		  </ul>
	  </td>
    </tr>
  </tbody>
</table>

If you’d like to keep a closer eye on what’s happening in the community, subscribe to the Flink [@community mailing list](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more.