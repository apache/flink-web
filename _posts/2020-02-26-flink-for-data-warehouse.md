---
layout: post 
title:  "Flink as Unified Engine for Modern Datawarehousing: Production Ready Hive Integration" 
date: 2020-02-26T02:30:00.000Z
categories: news
authors:
- morsapaes:
  name: "Bowen Li"
---

In this blog post, you will learn what Flink can help modernize your data warehouse and our motivations for Flink-Hive integration, what you can currently do with Flink-Hive integration in Flink latest release 1.10, and our roadmap for Flink 1.11 and beyond.

{% toc %}


## Introduction 

What are some of the latest requirements for your data warehouse and data infrastructure in 2020?

I’ve came up with some for you.

First, today’s business is shifting to a more real-time fashion, and thus demands abilities to process online streaming data with low latency for near-real-time or even real-time analytics. People are becoming less and less tolerant on the delays between when data is generated and when it arrives at their hands ready to use. Hours or even days of latency is not acceptable anymore. Users are expecting minutes, or even seconds, of end-to-end latency for data in their warehouse, to get quicker than ever insights.

Second, the infrasture should be able to handle both offline batch data for offline analytics and exploration, and online streaming data for more timely analytics, both are indispensable as they both have very valid use cases. Despite real time processing mentioned above, batch would still exist as it’s good for ad hoc queries and explorations, and full size calculations. Your modern infrastructure should not force users to choose between one and the other, it should offer users both options of world-class.

Third, the data players, including data engineers, data scientists, analysts, and operations, urge a more unified infrastructure than ever before for easier ramp up and higher working efficiency. Big data landscape has been fragemented for years, companies may have one set of infra for real time processing, one set for batch, one set for OLAP, etc. End users are sick of learning and maintaining shattered pieces of skills to work with all kinds of tools, and would really want to just have a very few of for better mastery.

If any of these resonate with you, you find the right post to read. We have never been this closer to the vision by strengthening Flink’s integration with Hive to a production grade.


## Flink and Its Integration With Hive Comes into the Scene

Apache Flink has been a proven scalable system to handle extremely high workload of streaming data in super low latency in many giant tech companies.

Despite its huge success in real-time processing domain, at its deep root, Flink has been faithfully following its inborn philosophy of being [an unified data processing engine for both batch and streaming](https://flink.apache.org/news/2019/02/13/unified-batch-streaming-blink.html), and taking a streaming-first approach in its architecture to do batch processing. By making batch a special case for streaming, Flink really leverages its cutting edge streaming capabilites and apply them to batch scenarios to gain the best offline performance. Flink’s batch performance has been quite outstanding in the early days, and has become even more impressive, as the community began to merge Blink, an Alibaba’s fork of Flink, back to Flink in 1.9 and finished it in 1.10, according to benchmarks we ran. 

On the other hand, Apache Hive has established itself as a focal point of the data warehousing ecosystem. It serves as not only a SQL engine for big data analytics and ETL, but also a data management platform, where data is discovered and defined. As business evolves, it puts new requirements on data warehouse.

Thus we started integrating Flink and Hive as beta release in Flink 1.9. Over the pass few months, we’ve been listening to users’s requests and feedbacks, further entensively enhancing our product, and running rigurous benchmarks (which will be published soon separately). I’m glad to announce that the integration between Flink and Hive is at production grade in [Flink 1.10](https://flink.apache.org/news/2020/02/11/release-1.10.0.html) right now and we can’t wait to walk you through the details.


### Compatible with More Hive Versions

The beta version in Flink 1.9 covers Hive 1.2 and 2.3, and rely on Hive’s own backward compatibility for other Hive versions.

In Flink 1.10, we brought full coverage to all Hive versions including 1.0, 1.1, 1.2, 2.0, 2.1, 2.2, 2.3, and 3.1. Take a look [here](https://ci.apache.org/projects/flink/flink-docs-release-1.10/dev/table/hive/#supported-hive-versions).


### Unified Metadata Management 

Hive Metastore has evolved into the de facto metadata hub over the years in Hadoop, or even cloud, ecosystem. Many companies have a single Hive Metastore service instance in production to manage all of their schemas, either Hive or non-Hive metadata, as the single source of truth.

In 1.9 we introduced Flink’s [HiveCatalog](https://ci.apache.org/projects/flink/flink-docs-release-1.10/dev/table/hive/hive_catalog.html) , connecting Flink to users’ rich metadata pool. The meaning of `HiveCatalog` has two folds here. First, it enables users to use Hive Metastore to store and manage Flink’s metadata, including tables, UDFs, and statistics of data. Second, it enables Flink to access Hive’s existing metadata, so that Flink can read and write Hive tables.

In 1.10, the metadata experience is further enhanced.

Users can store Flink its own tables, views, UDFs, statistics in Hive Metastore of all the compatible Hive versions mentioned above. [Here’s an end-to-end example](https://ci.apache.org/projects/flink/flink-docs-release-1.10/dev/table/hive/hive_catalog.html#example) of how to store a Flink’s Kafka source table in Hive Metastore and later query the table in Flink SQL.

Users can [reuse both Hive built-in functions and all kinds of UDFs in Flink](https://ci.apache.org/projects/flink/flink-docs-release-1.10/dev/table/hive/hive_functions.html) so they don’t need to rewrite their functions, which is a great win for Flink audience with a business accumulation history of Hive.

### Enhanced Read and Write on Hive Data

Flink 1.10 extends read and write capabilites on Hive data to all the common use cases with better performance. 

On reading side, Flink now can read Hive regular tables, partitioned tables, and views. Lots of optimization technics are developed around reading, including partition pruning and projection pushdown to transport less data from file storage, limit pushdown for faster experiment and exploration, and vectorized reader for ORC files.

On writing side, Flink introduces “INSERT INTO” and “INSERT OVERWRITE” syntax, and can write to not only Hive’s regular tables, but also partitioned tables with either static or dynamic partitions.

### Formats

Your engine should be able to handle all common types of file formats to give you the freedom of choosing one over another in order to fit your business needs. It’s no exception for Flink. We have tested on the following of table storage formats: text, csv, SequenceFile, ORC, and Parquet.

### More Data Types

In Flink 1.10, we added support for a few more frequently used Hive data types that are not covered by Flink 1.9. Users now should have a full, smooth experience to query and manipulate Hive data from Flink.

### Roadmap

Integration between two systems is a never ending story. We are constantly improving Flink itself and Flink-Hive integration on many aspects by collecting user feedbacks and working with folks in this vibrant community.

You asked and we listened. Many of the below requests, together with other improvements, have been prioritized for Flink 1.11.

- Native Parquet reader for better performance
- More interoperability - support creating Hive tables, views, functions in Flink
- Better out-of-box experience with built-in dependencies, including documentations
- Provide JDBC driver so that users can reuse their existing toolings to run SQL jobs on Flink
- Add Hive streaming sink so that Flink can stream data into Hive tables, bringing real streaming experience to Hive

If you have more feature requests or discover bugs, please reach out to the community through mailing list and JIRAs.


## Summary

Data warehousing is shifting to a more real-time fashion, and Flink can make a difference for you on this domain.

Flink 1.10 brings production-ready Hive integration and empowers users to achieve more in both metadata management and unified/batch data processing.

We encourage all our users to get their hands on Flink 1.10. You are very welcome to join the community in development, discussions, and all other kinds of collaborations of this topic.

