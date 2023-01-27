---
authors:
- morsapaes: null
  name: Marta Paes
  twitter: morsapaes
categories: news
date: "2020-06-10T08:00:00Z"
excerpt: And suddenly it’s June. The previous month has been calm on the surface,
  but quite hectic underneath — the final testing phase for Flink 1.11 is moving at
  full speed, Stateful Functions 2.1 is out in the wild and Flink has made it into
  Google Season of Docs 2020.
title: Flink Community Update - June'20
---

And suddenly it’s June. The previous month has been calm on the surface, but quite hectic underneath — the final testing phase for Flink 1.11 is moving at full speed, Stateful Functions 2.1 is out in the wild and Flink has made it into Google Season of Docs 2020. 

To top it off, a piece of good news: [Flink Forward](https://www.flink-forward.org/global-2020) is back on October 19-22 as a free virtual event!

{% toc %}

# The Past Month in Flink

## Flink Stateful Functions 2.1 Release

It might seem like [Stateful Functions 2.0 was announced](https://flink.apache.org/news/2020/04/07/release-statefun-2.0.0.html) only a handful of weeks ago (and it was!), but the Flink community has just released Stateful Functions 2.1! This release introduces two new features: state expiration for any kind of persisted state and support for UNIX Domain Sockets (UDS) to improve the performance of inter-container communication in co-located deployments; as well as other important changes that improve the overall stability and testability of the project. You can read the [announcement blogpost](https://flink.apache.org/news/2020/06/09/release-statefun-2.1.0.html) for more details on the release!

As the community around StateFun grows, the release cycle will follow this pattern of smaller and more frequent releases to incorporate user feedback and allow for faster iteration. If you’d like to get involved, we’re always [looking for new contributors](https://github.com/apache/flink-statefun#contributing) — especially around SDKs for other languages (e.g. Go, Rust, Javascript).

<hr>

## Testing is ON for Flink 1.11

Things have been pretty quiet in the Flink community, as all efforts shifted to testing the newest features shipping with Flink 1.11. While we wait for a voting Release Candidate (RC) to be out, you can check the progress of testing in [this JIRA burndown board](https://issues.apache.org/jira/secure/RapidBoard.jspa?rapidView=364&projectKey=FLINK) and learn more about some of the [upcoming features](https://flink.apache.org/news/2020/05/07/community-update.html#warming-up-for-flink-111) in these Flink Forward videos:

* [Rethinking of fault tolerance in Flink: what lies ahead?](https://www.youtube.com/watch?v=ssEmeLcL5Uk)

* [It’s finally here: Python on Flink & Flink on Zeppelin](https://www.youtube.com/watch?v=t7fAN3xNJ3Q)

* [A deep dive into Flink SQL](https://www.youtube.com/watch?v=KDD8e4GE12w)

* [Production-Ready Flink and Hive Integration - what story you can tell now?](https://www.youtube.com/watch?v=4ce1H9CRyEc)

We encourage the wider community to also get involved in testing once the voting RC is out. Keep an eye on the [@dev mailing list](https://flink.apache.org/community.html#mailing-lists) for updates!

<hr>

## Flink Minor Releases

### Flink 1.10.1

The community released Flink 1.10.1, covering some outstanding bugs in Flink 1.10. You can find more in the [announcement blogpost](https://flink.apache.org/news/2020/05/12/release-1.10.1.html)!

<hr>

## New Committers and PMC Members

The Apache Flink community has welcomed **2 new Committers** since the last update. Congratulations!

### New Committers

<div class="row">
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars3.githubusercontent.com/u/4471524?s=400&v=4" width="90" height="90">
      <p>Benchao Li</p>
    </div>
  </div>
  <div class="col-lg-3">
    <div class="text-center">
      <img class="img-circle" src="https://avatars0.githubusercontent.com/u/6509172?s=400&v=4" width="90" height="90">
      <p>Xintong Song</p>
    </div>
  </div>
</div>

<hr>
	
# The Bigger Picture

## Flink Forward Global Virtual Conference 2020

After a first successful [virtual conference](https://www.youtube.com/playlist?list=PLDX4T_cnKjD0ngnBSU-bYGfgVv17MiwA7) last April, Flink Forward will be hosting a second free virtual edition on October 19-22. This time around, the conference will feature two days of hands-on training and two full days of conference talks!

Got a Flink story to share? Maybe your recent adventures with Stateful Functions? The [Call for Presentations is now open](https://www.flink-forward.org/global-2020/call-for-presentations) and accepting submissions from the community until **June 19th, 11:59 PM CEST**.

<div style="line-height:60%;">
    <br>
</div>

<center>
<img src="{{< siteurl >}}/img/blog/2020-06-10-community-update/FlinkForward_Banner_CFP_Global_2020.png" width="600px" alt="Flink Forward Global 2020"/>
</center>

<div style="line-height:60%;">
    <br>
</div>

<hr>

## Google Season of Docs 2020

In the last update, we announced that Flink was applying to [Google Season of Docs (GSoD)](https://developers.google.com/season-of-docs) again this year. The good news: we’ve made it into the shortlist of accepted projects! This represents an invaluable opportunity for the Flink community to collaborate with technical writers to improve the Table API & SQL documentation. We’re honored to have seen a great number of people reach out over the last couple of weeks, and look forward to receiving applications from this week on!

If you’re interested in learning more about our project idea or want to get involved in GSoD as a technical writer, check out the [announcement blogpost](https://flink.apache.org/news/2020/05/04/season-of-docs.html) and [submit your application](https://developers.google.com/season-of-docs/docs/tech-writer-application-hints). The deadline for GSoD applications is **July 9th, 18:00 UTC**.

<hr>

If you’d like to keep a closer eye on what’s happening in the community, subscribe to the Flink [@community mailing list](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more.