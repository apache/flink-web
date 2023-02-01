---
date: "2015-02-04T10:00:00Z"
title: January 2015 in the Flink community
---

Happy 2015! Here is a (hopefully digestible) summary of what happened last month in the Flink community.

### 0.8.0 release

Flink 0.8.0 was released. See [here](http://flink.apache.org/news/2015/01/21/release-0.8.html) for the release notes.

### Flink roadmap

The community has published a [roadmap for 2015](https://cwiki.apache.org/confluence/display/FLINK/Flink+Roadmap) on the Flink wiki. Check it out to see what is coming up in Flink, and pick up an issue to contribute!

### Articles in the press

The Apache Software Foundation [announced](https://blogs.apache.org/foundation/entry/the_apache_software_foundation_announces69) Flink as a Top-Level Project. The announcement was picked up by the media, e.g., [here](http://sdtimes.com/inside-apache-software-foundations-newest-top-level-project-apache-flink/?utm_content=11232092&utm_medium=social&utm_source=twitter), [here](http://www.datanami.com/2015/01/12/apache-flink-takes-route-distributed-data-processing/), and [here](http://i-programmer.info/news/197-data-mining/8176-flink-reaches-top-level-status.html).

### Hadoop Summit

A submitted abstract on Flink Streaming won the community vote at “The Future of Hadoop” track.

### Meetups and talks

Flink was presented at the [Paris Hadoop User Group](http://www.meetup.com/Hadoop-User-Group-France/events/219778022/), the [Bay Area Hadoop User Group](http://www.meetup.com/hadoop/events/167785202/), the [Apache Tez User Group](http://www.meetup.com/Apache-Tez-User-Group/events/219302692/), and [FOSDEM 2015](https://fosdem.org/2015/schedule/track/graph_processing/). The January [Flink meetup in Berlin](http://www.meetup.com/Apache-Flink-Meetup/events/219639984/) had talks on recent community updates and new features.

## Notable code contributions

**Note:** Code contributions listed here may not be part of a release or even the Flink master repository yet.

### [Using off-heap memory](https://github.com/apache/flink/pull/290)

This pull request enables Flink to use off-heap memory for its internal memory uses (sort, hash, caching of intermediate data sets). 

### [Gelly, Flink’s Graph API](https://github.com/apache/flink/pull/335)

This pull request introduces Gelly, Flink’s brand new Graph API. Gelly offers a native graph programming abstraction with functionality for vertex-centric programming, as well as available graph algorithms. See [this slide set](http://www.slideshare.net/vkalavri/largescale-graph-processing-with-apache-flink-graphdevroom-fosdem15) for an overview of Gelly.

### [Semantic annotations](https://github.com/apache/flink/pull/311)

Semantic annotations are a powerful mechanism to expose information about the behavior of Flink functions to Flink’s optimizer. The optimizer can leverage this information to generate more efficient execution plans. For example the output of a Reduce operator that groups on the second field of a tuple is still partitioned on that field if the Reduce function does not modify the value of the second field. By exposing this information to the optimizer, the optimizer can generate plans that avoid expensive data shuffling and reuse the partitioned output of Reduce. Semantic annotations can be defined for most data types, including (nested) tuples and POJOs. See the snapshot documentation for details (not online yet).

### [New YARN client](https://github.com/apache/flink/pull/292)

The improved YARN client of Flink now allows users to deploy Flink on YARN for executing a single job. Older versions only supported a long-running YARN session. The code of the YARN client has been refactored to provide an (internal) Java API for controlling YARN clusters more easily.
