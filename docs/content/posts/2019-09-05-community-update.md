---
authors:
- morsapaes: null
  name: Marta Paes
  twitter: morsapaes
categories: news
date: "2019-09-05T12:00:00Z"
excerpt: This has been an exciting, fast-paced year for the Apache Flink community.
  But with over 10k messages across the mailing lists, 3k Jira tickets and 2k pull
  requests, it is not easy to keep up with the latest state of the project. Plus everything
  happening around it. With that in mind, we want to bring back regular community
  updates to the Flink blog.
title: Flink Community Update - September'19
---

This has been an exciting, fast-paced year for the Apache Flink community. But with over 10k messages across the mailing lists, 3k Jira tickets and 2k pull requests, it is not easy to keep up with the latest state of the project. Plus everything happening around it. With that in mind, we want to bring back regular community updates to the Flink blog.

The first post in the series takes you on an little detour across the year, to freshen up and make sure you're all up to date.

{% toc %}

# The Year (so far) in Flink

Two major versions were released this year: [Flink 1.8](https://flink.apache.org/news/2019/04/09/release-1.8.0.html) and [Flink 1.9](https://flink.apache.org/news/2019/08/22/release-1.9.0.html); paving the way for the goal of making Flink the first framework to seamlessly support stream and batch processing with a single, unified runtime. The [contribution of Blink](https://flink.apache.org/news/2019/02/13/unified-batch-streaming-blink.html) to Apache Flink was key in accelerating the path to this vision and reduced the waiting time for long-pending user requests — such as Hive integration, (better) Python support, the rework of Flink's Machine Learning library and...fine-grained failure recovery ([FLIP-1](https://cwiki.apache.org/confluence/display/FLINK/FLIP-1+%3A+Fine+Grained+Recovery+from+Task+Failures)).

The 1.9 release was the result of the **biggest community effort the project has experienced so far**, with the number of contributors soaring to 190 (see [The Bigger Picture](#the-bigger-picture)). For a quick overview of the upcoming work for Flink 1.10 (and beyond), have a look at the updated [roadmap](https://flink.apache.org/roadmap.html)!

## Integration of the Chinese-speaking community

As the number of Chinese-speaking Flink users rapidly grows, the community is working on translating resources and creating dedicated spaces for discussion to invite and include these users in the wider Flink community. Part of the ongoing work is described in [FLIP-35](https://cwiki.apache.org/confluence/display/FLINK/FLIP-35%3A+Support+Chinese+Documents+and+Website) and has resulted in:

* A new user mailing list (user-zh@f.a.o) dedicated to Chinese-speakers.
<p></p>
* A Chinese translation of the Apache Flink [website](https://flink.apache.org/zh/) and [documentation]({{< param DocsBaseUrl >}}flink-docs-master/zh/).
<p></p>
* Multiple meetups organized all over China, with the biggest one reaching a whopping number of 500+ participants. Some of these meetups were also organized in collaboration with communities from other projects, like Apache Pulsar and Apache Kafka.

<center>
<img src="{{ site.baseurl }}/img/blog/2019-09-05-flink-community-update/2019-09-05-flink-community-update_3.png" width="800px" alt="China Meetup"/>
</center>

In case you're interested in knowing more about this work in progress, Robert Metzger and Fabian Hueske will be diving into "Inviting Apache Flink's Chinese User Community" at the upcoming ApacheCon Europe 2019 (see [Upcoming Flink Community Events](#upcoming-flink-community-events)).

## Improving Flink's Documentation

Besides the translation effort, the community has also been working quite hard on a **Flink docs overhaul**. The main goals are to:

 * Organize and clean-up the structure of the docs;
 <p></p>
 * Align the content with the overall direction of the project;
 <p></p>
 * Improve the _getting-started_ material and make the content more accessible to different levels of Flink experience. 

Given that there has been some confusion in the past regarding unclear definition of core Flink concepts, one of the first completed efforts was to introduce a [Glossary]({{< param DocsBaseUrl >}}flink-docs-release-1.9/concepts/glossary.html#glossary) in the docs. To get up to speed with the roadmap for the remainder efforts, you can refer to [FLIP-42](https://cwiki.apache.org/confluence/display/FLINK/FLIP-42%3A+Rework+Flink+Documentation) and the corresponding [umbrella Jira ticket](https://issues.apache.org/jira/browse/FLINK-12639).

## Adjusting the Contribution Process and Experience

The [guidelines](https://flink.apache.org/contributing/how-to-contribute.html) to contribute to Apache Flink have been reworked on the website, in an effort to lower the entry barrier for new contributors and reduce the overall friction in the contribution process. In addition, the Flink community discussed and adopted [bylaws](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=120731026) to help the community collaborate and coordinate more smoothly.

For code contributors, a [Code Style and Quality Guide](https://flink.apache.org/contributing/code-style-and-quality-preamble.html) that captures the expected standards for contributions was also added to the "Contributing" section of the Flink website.

It's important to stress that **contributions are not restricted to code**. Non-code contributions such as mailing list support, documentation work or organization of community events are equally as important to the development of the project and highly encouraged.

## New Committers and PMC Members

The Apache Flink community has welcomed **5 new Committers** and **4 PMC (Project Management Committee) Members** in 2019, so far:

### New PMC Members
	Jincheng Sun, Kete (Kurt) Young, Kostas Kloudas, Thomas Weise

### New Committers
	Andrey Zagrebin, Hequn, Jiangjie (Becket) Qin, Rong Rong, Zhijiang Wang

Congratulations and thank you for your hardworking commitment to Flink!

# The Bigger Picture

Flink continues to push the boundaries of (stream) data processing, and the community is proud to see an ever-increasingly diverse set of contributors, users and technologies join the ecosystem. 

In the timeframe of three releases, the project jumped from **112 to 190 contributors**, also doubling down on the number of requested changes and improvements. To top it off, the Flink GitHub repository recently reached the milestone of **10k stars**, all the way up from the incubation days in 2014.

<center>
<img src="{{ site.baseurl }}/img/blog/2019-09-05-flink-community-update/2019-09-05-flink-community-update_1.png" width="1000px" alt="GitHub"/>
</center>

The activity across the user@ and dev@<sup>1</sup> mailing lists shows a healthy heartbeat, and the gradual ramp up of user-zh@ suggests that this was a well-received community effort. Looking at the numbers for the same period in 2018, the dev@ mailing list has seen the biggest surge in activity, with an average growth of **2.5x in the number of messages and distinct users** — a great reflection of the hyperactive pace of development of the Flink codebase.

<img style="float: right;" src="{{ site.baseurl }}/img/blog/2019-09-05-flink-community-update/2019-09-05-flink-community-update_2.png" width="420px" alt="Mailing Lists"/>

In support of these observations, the report for the financial year of 2019 from the Apache Software Foundation (ASF) features Flink as one of the most thriving open source projects, with mentions for: 

* Most Active Visits and Downloads
<p></p>
* Most Active Sources: Visits
<p></p>
* Most Active Sources: Clones
<p></p>
* Top Repositories by Number of Commits
<p></p>
* Top Most Active Apache Mailing Lists (user@ and dev@)

Hats off to our fellows at Apache Beam for an astounding year, too! For more detailed insights, check the [full report](https://s3.amazonaws.com/files-dist/AnnualReports/FY2018%20Annual%20Report.pdf).
<p></p>
<sup>1. Excluding messages from "jira@apache.org".</sup>

# Upcoming Events

As the conference and meetup season ramps up again, here are some events to keep an eye out for talks about Flink and opportunities to mingle with the wider stream processing community.

### North America

* [Conference] **[Strata Data Conference 2019](https://conferences.oreilly.com/strata/strata-ny)**, September 23-26, New York, USA
  <p></p>
* [Meetup] **[Apache Flink Bay Area Meetup](https://www.meetup.com/Bay-Area-Apache-Flink-Meetup/events/262680261/)**, September 24, San Francisco, USA
  <p></p>
* [Conference] **[Scale By The Bay 2019](https://www.meetup.com/Bay-Area-Apache-Flink-Meetup/events/262680261/)**, November 13-15, San Francisco, USA

### Europe

* [Meetup] **[Apache Flink London Meetup](https://www.meetup.com/Apache-Flink-London-Meetup/events/264123672)**, September 23, London, UK 
	<p></p>
* [Conference] **[Flink Forward Europe 2019](https://europe-2019.flink-forward.org)**, October 7-9, Berlin, Germany 
	<p></p>
	* The next edition of Flink Forward Europe is around the corner and the [program](https://europe-2019.flink-forward.org/conference-program) has been announced, featuring 70+ talks as well as panel discussions and interactive "Ask Me Anything" sessions with core Flink committers. If you're looking to learn more about Flink and share your experience with other community members, there really is [no better place]((https://vimeo.com/296403091)) than Flink Forward!

	* **Note:** if you are a **committer for any Apache project**, you can **get a free ticket** by registering with your Apache email address and using the discount code: *FFEU19-ApacheCommitter*.
<p></p>
* [Conference] **[ApacheCon Berlin 2019](https://aceu19.apachecon.com/)**, October 22-24, Berlin, Germany
<p></p>
* [Conference] **[Data2Day 2019](https://www.data2day.de/)**, October 22-24, Ludwigshafen, Germany
<p></p>
* [Conference] **[Big Data Tech Warsaw 2020](https://bigdatatechwarsaw.eu)**, February 7, Warsaw, Poland
	<p></p>
	* The Call For Presentations (CFP) is now [open](https://bigdatatechwarsaw.eu/cfp/).

### Asia

* [Conference] **[Flink Forward Asia 2019](https://m.aliyun.com/markets/aliyun/developer/ffa2019)**, November 28-30, Beijing, China
	<p></p>
	* The second edition of Flink Forward Asia is also happening later this year, in Beijing, and the CFP is [open](https://developer.aliyun.com/special/ffa2019) until September 20.

If you'd like to keep a closer eye on what’s happening in the community, subscribe to the [community mailing list](https://flink.apache.org/community.html#mailing-lists) to get fine-grained weekly updates, upcoming event announcements and more. Also, please reach out if you're interested in organizing or being part of Flink events in your area!