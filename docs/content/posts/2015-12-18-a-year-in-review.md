---
author: Robert Metzger
author-twitter: rmetzger_
date: "2015-12-18T10:00:00Z"
excerpt: <p>With 2015 ending, we thought that this would be good time to reflect on
  the amazing work done by the Flink community over this past year, and how much this
  community has grown.</p>
title: 'Flink 2015: A year in review, and a lookout to 2016'
---

With 2015 ending, we thought that this would be good time to reflect
on the amazing work done by the Flink community over this past year,
and how much this community has grown.

Overall, we have seen Flink grow in terms of functionality from an
engine to one of the most complete open-source stream processing
frameworks available. The community grew from a relatively small and
geographically focused team, to a truly global, and one of the largest
big data communities in the the Apache Software Foundation.

We will also look at some interesting stats, including that the
busiest days for Flink are Mondays (who would have thought :-).

# Community growth

Let us start with some simple statistics from [Flink's
github repository](https://github.com/apache/flink). During 2015, the
Flink community **doubled** in size, from about 75 contributors to
over 150. Forks of the repository more than **tripled** from 160 in
February 2015 to 544 in December 2015, and the number of stars of the
repository almost tripled from 289 to 813.

<center>
<img src="/img/blog/community-growth.png" style="height:400px;margin:15px">
</center>

Although Flink started out geographically in Berlin, Germany, the
community is by now spread all around the globe, with many
contributors from North America, Europe, and Asia. A simple search at
meetup.com for groups that mention Flink as a focus area reveals [16
meetups around the globe](http://apache-flink.meetup.com/):

<center>
<img src="/img/blog/meetup-map.png" style="height:400px;margin:15px">
</center>

# Flink Forward 2015

One of the highlights of the year for Flink was undoubtedly the [Flink
Forward](http://2015.flink-forward.org/) conference, the first conference
on Apache Flink that was held in October in Berlin. More than 250
participants (roughly half based outside Germany where the conference
was held) attended more than 33 technical talks from organizations
including Google, MongoDB, Bouygues Telecom, NFLabs, Euranova, RedHat,
IBM, Huawei, Intel, Ericsson, Capital One, Zalando, Amadeus, the Otto
Group, and ResearchGate. If you have not yet watched their talks,
check out the [slides](http://2015.flink-forward.org/?post_type=day) and
[videos](https://www.youtube.com/playlist?list=PLDX4T_cnKjD31JeWR1aMOi9LXPRQ6nyHO)
from Flink Forward.

<center>
<img src="/img/blog/ff-speakers.png" style="height:400px;margin:15px">
</center>

# Media coverage

And of course, interest in Flink was picked up by the tech
media. During 2015, articles about Flink appeared in
[InfoQ](http://www.infoq.com/Apache-Flink/news/),
[ZDNet](http://www.zdnet.com/article/five-open-source-big-data-projects-to-watch/),
[Datanami](http://www.datanami.com/tag/apache-flink/),
[Infoworld](http://www.infoworld.com/article/2919602/hadoop/flink-hadoops-new-contender-for-mapreduce-spark.html)
(including being one of the [best open source big data tools of
2015](http://www.infoworld.com/article/2982429/open-source-tools/bossie-awards-2015-the-best-open-source-big-data-tools.html)),
the [Gartner
blog](http://blogs.gartner.com/nick-heudecker/apache-flink-offers-a-challenge-to-spark/),
[Dataconomy](http://dataconomy.com/tag/apache-flink/),
[SDTimes](http://sdtimes.com/tag/apache-flink/), the [MapR
blog](https://www.mapr.com/blog/apache-flink-new-way-handle-streaming-data),
[KDnuggets](http://www.kdnuggets.com/2015/08/apache-flink-stream-processing.html),
and
[HadoopSphere](http://www.hadoopsphere.com/2015/02/distributed-data-processing-with-apache.html).

<center>
<img src="/img/blog/appeared-in.png" style="height:400px;margin:15px">
</center>

It is interesting to see that Hadoop Summit EMEA 2016 had a whopping
number of 17 (!) talks submitted that are mentioning Flink in their
title and abstract:

<center>
<img src="/img/blog/hadoop-summit.png" style="height:400px;margin:15px">
</center>

# Fun with stats: when do committers commit?

To get some deeper insight on what is happening in the Flink
community, let us do some analytics on the git log of the project :-)
The easiest thing we can do is count the number of commits at the
repository in 2015. Running

```
git log --pretty=oneline --after=1/1/2015  | wc -l
```

on the Flink repository yields a total of **2203 commits** in 2015.

To dig deeper, we will use an open source tool called gitstats that
will give us some interesting statistics on the committer
behavior. You can create these also yourself and see many more by
following four easy steps:

1. Download gitstats from the [project homepage](http://gitstats.sourceforge.net/).. E.g., on OS X with homebrew, type

```
brew install --HEAD homebrew/head-only/gitstats
```

2. Clone the Apache Flink git repository:

```
git clone git@github.com:apache/flink.git
```

3. Generate the statistics

```
gitstats flink/ flink-stats/
```

4. View all the statistics as an html page using your favorite browser (e.g., chrome):

```
chrome flink-stats/index.html
```

First, we can see a steady growth of lines of code in Flink since the
initial Apache incubator project. During 2015, the codebase almost
**doubled** from 500,000 LOC to 900,000 LOC.

<center>
<img src="/img/blog/code-growth.png" style="height:400px;margin:15px">
</center>

It is interesting to see when committers commit. For Flink, Monday
afternoons are by far the most popular times to commit to the
repository:

<center>
<img src="/img/blog/commit-stats.png" style="height:400px;margin:15px">
</center>

# Feature timeline

So, what were the major features added to Flink and the Flink
ecosystem during 2015? Here is a (non-exhaustive) chronological list:

<center>
<img src="/img/blog/feature-timeline.png" style="height:400px;margin:15px">
</center>

# Roadmap for 2016

With 2015 coming to a close, the Flink community has already started
discussing Flink's roadmap for the future. Some highlights
are:

* **Runtime scaling of streaming jobs:** streaming jobs are running
    forever, and need to react to a changing environment. Runtime
    scaling means dynamically increasing and decreasing the
    parallelism of a job to sustain certain SLAs, or react to changing
    input throughput.

* **SQL queries for static data sets and streams:** building on top of
    Flink's Table API, users should be able to write SQL
    queries for static data sets, as well as SQL queries on data
    streams that continuously produce new results.

* **Streaming operators backed by managed memory:** currently,
    streaming operators like user-defined state and windows are backed
    by JVM heap objects. Moving those to Flink managed memory will add
    the ability to spill to disk, GC efficiency, as well as better
    control over memory utilization.

* **Library for detecting temporal event patterns:** a common use case
    for stream processing is detecting patterns in an event stream
    with timestamps. Flink makes this possible with its support for
    event time, so many of these operators can be surfaced in the form
    of a library.

* **Support for Apache Mesos, and resource-dynamic YARN support:**
    support for both Mesos and YARN, including dynamic allocation and
    release of resource for more resource elasticity (for both batch
    and stream processing).

* **Security:** encrypt both the messages exchanged between
    TaskManagers and JobManager, as well as the connections for data
    exchange between workers.

* **More streaming connectors, more runtime metrics, and continuous
    DataStream API enhancements:** add support for more sources and
    sinks (e.g., Amazon Kinesis, Cassandra, Flume, etc), expose more
    metrics to the user, and provide continuous improvements to the
    DataStream API.

If you are interested in these features, we highly encourage you to
take a look at the [current
draft](https://docs.google.com/document/d/1ExmtVpeVVT3TIhO1JoBpC5JKXm-778DAD7eqw5GANwE/edit),
and [join the
discussion](https://mail-archives.apache.org/mod_mbox/flink-dev/201512.mbox/browser)
on the Flink mailing lists.

