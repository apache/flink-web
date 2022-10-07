---
categories: news
date: "2015-01-06T10:00:00Z"
title: December 2014 in the Flink community
---

This is the first blog post of a “newsletter” like series where we give a summary of the monthly activity in the Flink community. As the Flink project grows, this can serve as a "tl;dr" for people that are not following the Flink dev and user mailing lists, or those that are simply overwhelmed by the traffic.


### Flink graduation

The biggest news is that the Apache board approved Flink as a top-level Apache project! The Flink team is working closely with the Apache press team for an official announcement, so stay tuned for details!

### New Flink website

The [Flink website](http://flink.apache.org) got a total make-over, both in terms of appearance and content.

### Flink IRC channel

A new IRC channel called #flink was created at irc.freenode.org. An easy way to access the IRC channel is through the [web client](http://webchat.freenode.net/).  Feel free to stop by to ask anything or share your ideas about Apache Flink!

### Meetups and Talks

Apache Flink was presented in the [Amsterdam Hadoop User Group](http://www.meetup.com/Netherlands-Hadoop-User-Group/events/218635152)

## Notable code contributions

**Note:** Code contributions listed here may not be part of a release or even the current snapshot yet.

### [Streaming Scala API](https://github.com/apache/incubator-flink/pull/275)

The Flink Streaming Java API recently got its Scala counterpart. Once merged, Flink Streaming users can use both Scala and Java for their development. The Flink Streaming Scala API is built as a thin layer on top of the Java API, making sure that the APIs are kept easily in sync.

### [Intermediate datasets](https://github.com/apache/incubator-flink/pull/254)

This pull request introduces a major change in the Flink runtime. Currently, the Flink runtime is based on the notion of operators that exchange data through channels. With the PR, intermediate data sets that are produced by operators become first-class citizens in the runtime. While this does not have any user-facing impact yet, it lays the groundwork for a slew of future features such as blocking execution, fine-grained fault-tolerance, and more efficient data sharing between cluster and client.

### [Configurable execution mode](https://github.com/apache/incubator-flink/pull/259)

This pull request allows the user to change the object-reuse behaviour. Before this pull request, some operations would reuse objects passed to the user function while others would always create new objects. This introduces a system wide switch and changes all operators to either reuse objects or don’t reuse objects.

### [Distributed Coordination via Akka](https://github.com/apache/incubator-flink/pull/149)

Another major change is a complete rewrite of the JobManager / TaskManager components in Scala. In addition to that, the old RPC service was replaced by Actors, using the Akka framework.

### [Sorting of very large records](https://github.com/apache/incubator-flink/pull/249 )

Flink's internal sort-algorithms were improved to better handle large records (multiple 100s of megabytes or larger). Previously, the system did in some cases hold instances of multiple large records, resulting in high memory consumption and JVM heap thrashing. Through this fix, large records are streamed through the operators, reducing the memory consumption and GC pressure. The system now requires much less memory to support algorithms that work on such large records.

### [Kryo Serialization as the new default fallback](https://github.com/apache/incubator-flink/pull/271)

Flink’s build-in type serialization framework is handles all common types very efficiently. Prior versions uses Avro to serialize types that the built-in framework could not handle.
Flink serialization system improved a lot over time and by now surpasses the capabilities of Avro in many cases. Kryo now serves as the default fallback serialization framework, supporting a much broader range of types.

### [Hadoop FileSystem support](https://github.com/apache/incubator-flink/pull/268)

This change permits users to use all file systems supported by Hadoop with Flink. In practice this means that users can use Flink with Tachyon, Google Cloud Storage (also out of the box Flink YARN support on Google Compute Cloud), FTP and all the other file system implementations for Hadoop.

## Heading to the 0.8.0 release

The community is working hard together with the Apache infra team to migrate the Flink infrastructure to a top-level project. At the same time, the Flink community is working on the Flink 0.8.0 release which should be out very soon.