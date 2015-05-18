---
layout: post
title:  'March 2015 in the Flink community'
date:   2015-04-07 10:00:00
categories: news
---

March has been a busy month in the Flink community.

### Flink runner for Google Cloud Dataflow

A Flink runner for Google Cloud Dataflow was announced. See the blog
posts by [data Artisans](http://data-artisans.com/dataflow.html) and
the [Google Cloud Platform Blog](http://googlecloudplatform.blogspot.de/2015/03/announcing-Google-Cloud-Dataflow-runner-for-Apache-Flink.html).
Google Cloud Dataflow programs can be written using and open-source
SDK and run in multiple backends, either as a managed service inside
Google's infrastructure, or leveraging open source runners,
including Apache Flink.

### Learn about the internals of Flink

The community has started an effort to better document the internals
of Flink. Check out the first articles on the Flink wiki on [how Flink
manages
memory](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=53741525),
[how tasks in Flink exchange
data](https://cwiki.apache.org/confluence/display/FLINK/Data+exchange+between+tasks),
[type extraction and serialization in
Flink](https://cwiki.apache.org/confluence/display/FLINK/Type+System%2C+Type+Extraction%2C+Serialization),
as well as [how Flink builds on Akka for distributed
coordination](https://cwiki.apache.org/confluence/display/FLINK/Akka+and+Actors).

Check out also the [new blog
post](http://flink.apache.org/news/2015/03/13/peeking-into-Apache-Flinks-Engine-Room.html)
on how Flink executes joins with several insights into Flink's runtime.

### Meetups and talks

Flink's machine learning efforts were presented at the [Machine
Learning Stockholm meetup
group](http://www.meetup.com/Machine-Learning-Stockholm/events/221144997/). The
regular Berlin Flink meetup featured a talk on the past, present, and
future of Flink. The talk is available on
[youtube](https://www.youtube.com/watch?v=fw2DBE6ZiEQ&feature=youtu.be).

## In the Flink master

### Table API in Scala and Java

The new [Table
API](https://github.com/apache/flink/tree/master/flink-staging/flink-table)
in Flink is now available in both Java and Scala. Check out the
examples [here (Java)](https://github.com/apache/flink/blob/master/flink-staging/flink-table/src/main/java/org/apache/flink/examples/java/JavaTableExample.java) and [here (Scala)](https://github.com/apache/flink/tree/master/flink-staging/flink-table/src/main/scala/org/apache/flink/examples/scala).

### Additions to the Machine Learning library

Flink's [Machine Learning
library](https://github.com/apache/flink/tree/master/flink-staging/flink-ml)
is seeing quite a bit of traction. Recent additions include the [CoCoA
algorithm](http://arxiv.org/abs/1409.1458) for distributed
optimization.

### Exactly-once delivery guarantees for streaming jobs

Flink streaming jobs now provide exactly once processing guarantees
when coupled with persistent sources (notably [Apache
Kafka](http://kafka.apache.org)). Flink periodically checkpoints and
persists the offsets of the sources and restarts from those
checkpoints at failure recovery. This functionality is currently
limited in that it does not yet handle large state and iterative
programs.

### Flink on Tez

A new execution environment enables non-iterative Flink jobs to use
Tez as an execution backend instead of Flink's own network stack. Learn more
[here](http://ci.apache.org/projects/flink/flink-docs-master/setup/flink_on_tez.html).