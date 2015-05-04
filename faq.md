---
title: "F.A.Q."
---

The following questions are frequently asked with regard to the Flink project **in general**. If you have further questions, make sure to consult the [documentation]() or [ask the community]().

{% toc %}

## Is Flink a Hadoop Project?

Flink is a data processing system and an **alternative to Hadoop's
MapReduce component**. It comes with its *own runtime*, rather than building on top
of MapReduce. As such, it can work completely independently of the Hadoop
ecosystem. However, Flink can also access Hadoop's distributed file
system (HDFS) to read and write data, and Hadoop's next-generation resource
manager (YARN) to provision cluster resources. Since most Flink users are
using Hadoop HDFS to store their data, Flink already ships the required libraries to
access HDFS.

## Do I have to install Apache Hadoop to use Flink?

**No**. Flink can run **without** a Hadoop installation. However, a *very common*
setup is to use Flink to analyze data stored in the Hadoop Distributed
File System (HDFS). To make these setups work out of the box, Flink bundles the
Hadoop client libraries by default.

Additionally, we provide a special YARN Enabled download of Flink for
users with an existing Hadoop YARN cluster. [Apache Hadoop
YARN](http://hadoop.apache.org/docs/r2.2.0/hadoop-yarn/hadoop-yarn-site/YARN.html) 
is Hadoop's cluster resource manager that allows to use
different execution engines next to each other on a cluster.