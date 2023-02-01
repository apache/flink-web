---
date: "2015-04-07T10:00:00Z"
title: March 2015 in the Flink community
---

March has been a busy month in the Flink community.

### Scaling ALS

Flink committers employed at [data Artisans](http://data-artisans.com) published a [blog post](http://data-artisans.com/how-to-factorize-a-700-gb-matrix-with-apache-flink/) on how they scaled matrix factorization with Flink and Google Compute Engine to matrices with 28 billion elements.

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
API](https://github.com/apache/flink/tree/master/flink-libraries/flink-table)
in Flink is now available in both Java and Scala. Check out the
examples [here (Java)](https://github.com/apache/flink/blob/master/flink-libraries/flink-table/src/main/java/org/apache/flink/examples/java/JavaTableExample.java) and [here (Scala)](https://github.com/apache/flink/tree/master/flink-libraries/flink-table/src/main/scala/org/apache/flink/examples/scala).

### Additions to the Machine Learning library

Flink's [Machine Learning
library](https://github.com/apache/flink/tree/master/flink-libraries/flink-ml)
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

