---
authors:
- bowen: null
  name: Bowen Li
  twitter: Bowen__Li
date: "2020-03-27T02:30:00Z"
title: 'Flink as Unified Engine for Modern Data Warehousing: Production-Ready Hive
  Integration'
---

In this blog post, you will learn our motivation behind the Flink-Hive integration, and how Flink 1.10 can help modernize your data warehouse.

{% toc %}


## Introduction 

What are some of the latest requirements for your data warehouse and data infrastructure in 2020?

We’ve came up with some for you.

Firstly, today’s business is shifting to a more real-time fashion, and thus demands abilities to process online streaming data with low latency for near-real-time or even real-time analytics. People become less and less tolerant of delays between when data is generated and when it arrives at their hands, ready to use. Hours or even days of delay is not acceptable anymore. Users are expecting minutes, or even seconds, of end-to-end latency for data in their warehouse, to get quicker-than-ever insights.

Secondly, the infrastructure should be able to handle both offline batch data for offline analytics and exploration, and online streaming data for more timely analytics. Both are indispensable as they both have very valid use cases. Apart from the real time processing mentioned above, batch processing would still exist as it’s good for ad hoc queries and explorations, and full-size calculations. Your modern infrastructure should not force users to choose between one or the other, it should offer users both options for a world-class data infrastructure.

Thirdly, the data players, including data engineers, data scientists, analysts, and operations, urge a more unified infrastructure than ever before for easier ramp-up and higher working efficiency. The big data landscape has been fragmented for years - companies may have one set of infrastructure for real time processing, one set for batch, one set for OLAP, etc. That, oftentimes, comes as a result of the legacy of lambda architecture, which was popular in the era when stream processors were not as mature as today and users had to periodically run batch processing as a way to correct streaming pipelines. Well, it's a different era now! As stream processing becomes mainstream and dominant, end users no longer want to learn shattered pieces of skills and maintain many moving parts with all kinds of tools and pipelines. Instead, what they really need is a unified analytics platform that can be mastered easily, and simplify any operational complexity.

If any of these resonate with you, you just found the right post to read: we have never been this close to the vision by strengthening Flink’s integration with Hive to a production grade.


## Flink and Its Integration With Hive Comes into the Scene

Apache Flink has been a proven scalable system to handle extremely high workload of streaming data in super low latency in many giant tech companies.

Despite its huge success in the real time processing domain, at its deep root, Flink has been faithfully following its inborn philosophy of being [a unified data processing engine for both batch and streaming](https://flink.apache.org/news/2019/02/13/unified-batch-streaming-blink.html), and taking a streaming-first approach in its architecture to do batch processing. By making batch a special case for streaming, Flink really leverages its cutting edge streaming capabilities and applies them to batch scenarios to gain the best offline performance. Flink’s batch performance has been quite outstanding in the early days and has become even more impressive, as the community started merging Blink, Alibaba’s fork of Flink, back to Flink in 1.9 and finished it in 1.10.

On the other hand, Apache Hive has established itself as a focal point of the data warehousing ecosystem. It serves as not only a SQL engine for big data analytics and ETL, but also a data management platform, where data is discovered and defined. As business evolves, it puts new requirements on data warehouse.

Thus we started integrating Flink and Hive as a beta version in Flink 1.9. Over the past few months, we have been listening to users’ requests and feedback, extensively enhancing our product, and running rigorous benchmarks (which will be published soon separately). I’m glad to announce that the integration between Flink and Hive is at production grade in [Flink 1.10](https://flink.apache.org/news/2020/02/11/release-1.10.0.html) and we can’t wait to walk you through the details.


### Unified Metadata Management 

Hive Metastore has evolved into the de facto metadata hub over the years in the Hadoop, or even the cloud, ecosystem. Many companies have a single Hive Metastore service instance in production to manage all of their schemas, either Hive or non-Hive metadata, as the single source of truth.

In 1.9 we introduced Flink’s [HiveCatalog]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/table/hive/hive_catalog.html), connecting Flink to users’ rich metadata pool. The meaning of `HiveCatalog` is two-fold here. First, it allows Apache Flink users to utilize Hive Metastore to store and manage Flink’s metadata, including tables, UDFs, and statistics of data. Second, it enables Flink to access Hive’s existing metadata, so that Flink itself can read and write Hive tables.

In Flink 1.10, users can store Flink's own tables, views, UDFs, statistics in Hive Metastore on all of the compatible Hive versions mentioned above. [Here’s an end-to-end example]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/table/hive/hive_catalog.html#example) of how to store a Flink’s Kafka source table in Hive Metastore and later query the table in Flink SQL.


### Stream Processing

The Hive integration feature in Flink 1.10 empowers users to re-imagine what they can accomplish with their Hive data and unlock stream processing use cases:

- join real-time streaming data in Flink with offline Hive data for more complex data processing
- backfill Hive data with Flink directly in a unified fashion
- leverage Flink to move real-time data into Hive more quickly, greatly shortening the end-to-end latency between when data is generated and when it arrives at your data warehouse for analytics, from hours — or even days — to minutes


### Compatible with More Hive Versions

In Flink 1.10, we brought full coverage to most Hive versions including 1.0, 1.1, 1.2, 2.0, 2.1, 2.2, 2.3, and 3.1. Take a look [here]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/table/hive/#supported-hive-versions).


### Reuse Hive User Defined Functions (UDFs)

Users can [reuse all kinds of Hive UDFs in Flink]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/table/hive/hive_functions.html#hive-user-defined-functions) since Flink 1.9.

This is a great win for Flink users with past history with the Hive ecosystem, as they may have developed custom business logic in their Hive UDFs. Being able to run these functions without any rewrite saves users a lot of time and brings them a much smoother experience when they migrate to Flink.

To take it a step further, Flink 1.10 introduces [compatibility of Hive built-in functions via HiveModule]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/table/hive/hive_functions.html#use-hive-built-in-functions-via-hivemodule). Over the years, the Hive community has developed a few hundreds of built-in functions that are super handy for users. For those built-in functions that don't exist in Flink yet, users are now able to leverage the existing Hive built-in functions that they are familiar with and complete their jobs seamlessly.


### Enhanced Read and Write on Hive Data

Flink 1.10 extends its read and write capabilities on Hive data to all the common use cases with better performance. 

On the reading side, Flink now can read Hive regular tables, partitioned tables, and views. Lots of optimization techniques are developed around reading, including partition pruning and projection pushdown to transport less data from file storage, limit pushdown for faster experiment and exploration, and vectorized reader for ORC files.

On the writing side, Flink 1.10 introduces “INSERT INTO” and “INSERT OVERWRITE” to its syntax, and can write to not only Hive’s regular tables, but also partitioned tables with either static or dynamic partitions.

### Formats

Your engine should be able to handle all common types of file formats to give you the freedom of choosing one over another in order to fit your business needs. It’s no exception for Flink. We have tested the following table storage formats: text, csv, SequenceFile, ORC, and Parquet.

### More Data Types

In Flink 1.10, we added support for a few more frequently-used Hive data types that were not covered by Flink 1.9. Flink users now should have a full, smooth experience to query and manipulate Hive data from Flink.


### Roadmap

Integration between any two systems is a never-ending story. 

We are constantly improving Flink itself and the Flink-Hive integration also gets improved by collecting user feedback and working with folks in this vibrant community.

After careful consideration and prioritization of the feedback we received, we have prioritize many of the below requests for the next Flink release of 1.11.

- Hive streaming sink so that Flink can stream data into Hive tables, bringing a real streaming experience to Hive
- Native Parquet reader for better performance
- Additional interoperability - support creating Hive tables, views, functions in Flink
- Better out-of-box experience with built-in dependencies, including documentations
- JDBC driver so that users can reuse their existing toolings to run SQL jobs on Flink
- Hive syntax and semantic compatible mode

If you have more feature requests or discover bugs, please reach out to the community through mailing list and JIRAs.


## Summary

Data warehousing is shifting to a more real-time fashion, and Apache Flink can make a difference for your organization in this space.

Flink 1.10 brings production-ready Hive integration and empowers users to achieve more in both metadata management and unified/batch data processing.

We encourage all our users to get their hands on Flink 1.10. You are very welcome to join the community in development, discussions, and all other kinds of collaborations in this topic.

