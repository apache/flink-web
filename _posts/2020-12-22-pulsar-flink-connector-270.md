---
layout: post 
title:  "What's New in Pulsar Flink Connector 2.7.0"
date: 2020-12-22T08:00:00.000Z
categories: news
authors:
- jianyun:
  name: "Jianyun Zhao"
  twitter: "yihy8023"
- jennifer:
  name: "Jennifer Huang"
  twitter: "Jennife06125739"

excerpt: Batch and streaming is the future, Pulsar Flink Connector provides an ideal solution for unified batch and streaming with Apache Pulsar and Apache Flink. Pulsar Flink Connector 2.7.0 supports features in Pulsar 2.7 and Flink 1.12, and is fully compatible with Flink data format. Pulsar Flink Connector 2.7.0 will be contributed to the Flink repository, the contribution process is ongoing.
---

## About Pulsar Flink Connector
In order for companies to access real-time data insights, they need unified batch and streaming capabilities. Apache Flink unifies batch and stream processing into one single computing engine with “streams” as the unified data representation. Although developers have done extensive work at the computing and API layers, very little work has been done at the data and messaging and storage layers. However, in reality, data is segregated into data silos, created by various storage and messaging technologies. As a result, there is still no single source-of-truth and the overall operation for the developer teams is still messy. To address the messy operations, we need to store data in streams. Apache Pulsar (together with Apache BookKeeper) perfectly meets the criteria: data is stored as one copy (source-of-truth), and can be accessed in streams (via pub-sub interfaces) and segments (for batch processing). When Flink and Pulsar come together, the two open source technologies create a unified data architecture for real-time data-driven businesses. 

The [Pulsar Flink connector](https://github.com/streamnative/pulsar-flink/) provides elastic data processing with [Apache Pulsar](https://pulsar.apache.org/) and [Apache Flink](https://flink.apache.org/), allowing Apache Flink to read/write data from/to Apache Pulsar. The Pulsar Flink Connector enables you to concentrate on your business logic without worrying about the storage details.

## Challenges
When we first developed the Pulsar Flink Connector, it received wide adoption from both the Flink and Pulsar communities. Leveraging the Pulsar Flink connector, [Hewlett Packard Enterprise (HPE)](https://www.hpe.com/us/en/home.html) built a real-time computing platform, [BIGO](https://www.bigo.sg/) built a real-time message processing system, and [Zhihu](https://www.zhihu.com/) is in the process of assessing the Connector’s fit for a real-time computing system. 

As more users adopted the Pulsar Flink Connector, we heard a common issue from the community: it’s hard to do serialization and deserialization. While the Pulsar Flink connector leverages Pulsar serialization, the previous versions did not support the Flink data format. As a result, users had to do a lot of configurations in order to use the connector to do real-time computing.

To make the Pulsar Flink connector easier to use, we decided to build the capabilities to fully support the Flink data format, so users do not need to spend time on configuration.

## What’s New in Pulsar Flink Connector 2.7.0?
The Pulsar Flink Connector 2.7.0 supports features in Apache Pulsar 2.7.0 and Apache Flink 1.12, and is fully compatible with the Flink connector and Flink message format. Now, you can use important features in Flink, such as exactly-once sink, upsert Pulsar mechanism, Data Definition Language (DDL) computed columns, watermarks, and metadata. You can also leverage the Key-Shared subscription in Pulsar, and conduct serialization and deserialization without much configuration. Additionally, you can customize the configuration based on your business easily. 
 
Below, we introduce the key features in Pulsar Flink Connector 2.7.0 in detail.

### Ordered message queue with high-performance
When users needed to guarantee the ordering of messages strictly, only one consumer was allowed to consume messages. This had a severe impact on the throughput. To address this, we designed a Key_Shared subscription model in Pulsar. It guarantees the ordering of messages and improves throughput by adding a Key to each message, and routes messages with the same Key Hash to one consumer. 

<br>
<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/blog/pulsar-flink/pulsar-key-shared.png" width="640px" alt="Apache Pulsar Key-Shared Subscription"/>
</div>

Pulsar Flink Connector 2.7.0 supports the Key_Shared subscription model. You can enable this feature by setting `enable-key-hash-range` to `true`. The Key Hash range processed by each consumer is decided by the parallelism of tasks.


### Introducing exactly-once semantics for Pulsar sink (based on the Pulsar transaction)
In previous versions, sink operators only supported at-least-once semantics, which could not fully meet requirements for end-to-end consistency. To deduplicate messages, users had to do some dirty work, which was not user-friendly.

Transactions are supported in Pulsar 2.7.0, which will greatly improve the fault tolerance capability of Flink sink. In Pulsar Flink Connector 2.7.0, we designed exactly-once semantics for sink operators based on Pulsar transactions. Flink uses the two-phase commit protocol to implement TwoPhaseCommitSinkFunction. The main life cycle methods are beginTransaction(), preCommit(), commit(), abort(), recoverAndCommit(), recoverAndAbort(). 

You can select semantics flexibly when creating a sink operator, and the internal logic changes are transparent. Pulsar transactions are similar to the two-phase commit protocol in Flink, which will greatly improve the reliability of Connector Sink.

It’s easy to implement beginTransaction and preCommit. You only need to start a Pulsar transaction, and persist the TID of the transaction after the checkpoint. In the preCommit phase, you need to ensure that all messages are flushed to Pulsar, and messages pre-committed will be committed eventually. 

We focus on recoverAndCommit and recoverAndAbort in implementation. Limited by Kafka features, Kafka connector adopts hack styles for recoverAndCommit. Pulsar transactions do not rely on the specific Producer, so it’s easy for you to commit and abort transactions based on TID.

Pulsar transactions are highly efficient and flexible. Taking advantages of Pulsar and Flink, the Pulsar Flink connector is even more powerful. We will continue to improve transactional sink in the Pulsar Flink connector.

### Introducing upsert-pulsar connector

Users in the Flink community expressed their needs for the upsert Pulsar. After looking through mailing lists and issues, we’ve summarized the following three reasons.

- Interpret Pulsar topic as a changelog stream that interprets records with keys as upsert (aka insert/update) events.  
- As a part of the real time pipeline, join multiple streams for enrichment and store results into a Pulsar topic for further calculation later. However, the result may contain update events.
- As a part of the real time pipeline, aggregate on data streams and store results into a Pulsar topic for further calculation later. However, the result may contain update events.

Based on the requirements, we add support for Upsert Pulsar. The upsert-pulsar connector allows for reading data from and writing data into Pulsar topics in the upsert fashion.

- As a source, the upsert-pulsar connector produces a changelog stream, where each data record represents an update or delete event. More precisely, the value in a data record is interpreted as an UPDATE of the last value for the same key, if any (if a corresponding key does not exist yet, the update will be considered an INSERT). Using the table analogy, a data record in a changelog stream is interpreted as an UPSERT (aka INSERT/UPDATE) because any existing row with the same key is overwritten. Also, null values are interpreted in a special way: a record with a null value represents a “DELETE”.

- As a sink, the upsert-pulsar connector can consume a changelog stream. It will write INSERT/UPDATE_AFTER data as normal Pulsar messages value, and write DELETE data as Pulsar messages with null values (indicate tombstone for the key). Flink will guarantee the message ordering on the primary key by partition data on the values of the primary key columns, so the update/deletion messages on the same key will fall into the same partition.

### Support new source interface and Table API introduced in [FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface#FLIP27:RefactorSourceInterface-BatchandStreamingUnification) and [FLIP-95](https://cwiki.apache.org/confluence/display/FLINK/FLIP-95%3A+New+TableSource+and+TableSink+interfaces)
This feature unifies the source of the batch stream and optimizes the mechanism for task discovery and data reading. It is also the cornerstone of our implementation of Pulsar batch and streaming unification. The new Table API supports DDL computed columns, watermarks and metadata.

### Support SQL read and write metadata as described in [FLIP-107](https://cwiki.apache.org/confluence/display/FLINK/FLIP-107%3A+Handling+of+metadata+in+SQL+connectors)
FLIP-107 enables users to access connector metadata as a metadata column in table definitions. In real-time computing, users usually need additional information, such as eventTime, customized fields. Pulsar Flink connector supports SQL read and write metadata, so it is flexible and easy for users to manage metadata of Pulsar messages in Pulsar Flink Connector 2.7.0. For details on the configuration, refer to [Pulsar Message metadata manipulation](https://github.com/streamnative/pulsar-flink#pulsar-message-metadata-manipulation).
 
### Add Flink format type `atomic` to support Pulsar primitive types
In Pulsar Flink Connector 2.7.0, we add Flink format type `atomic` to support Pulsar primitive types. When Flink processing requires a Pulsar primitive type, you can use `atomic` as the connector format. For more information on Pulsar primitive types, see https://pulsar.apache.org/docs/en/schema-understand/.
 
## Migration
If you’re using the previous Pulsar Flink Connector version, you need to adjust SQL and API parameters accordingly. Below we provide details on each.

## SQL
In SQL, we’ve changed Pulsar configuration parameters in DDL declaration. The name of some parameters are changed, but the values are not changed. 
- Remove the `connector.` prefix from the parameter names. 
- Change the name of the `connector.type` parameter into `connector`.
- Change the startup mode parameter name from `connector.startup-mode` into `scan.startup.mode`.
- Adjust Pulsar properties as `properties.pulsar.reader.readername=testReaderName`.

If you use SQL in Pulsar Flink Connector, you need to adjust your SQL configuration accordingly when migrating to Pulsar Flink Connector 2.7.0. The following sample shows the differences between previous versions and the 2.7.0 version for SQL.

SQL in previous versions：
```
create table topic1(
    `rip` VARCHAR,
    `rtime` VARCHAR,
    `uid` bigint,
    `client_ip` VARCHAR,
    `day` as TO_DATE(rtime),
    `hour` as date_format(rtime,'HH')
) with (
    'connector.type' ='pulsar',
    'connector.version' = '1',
    'connector.topic' ='persistent://public/default/test_flink_sql',
    'connector.service-url' ='pulsar://xxx',
    'connector.admin-url' ='http://xxx',
    'connector.startup-mode' ='earliest',
    'connector.properties.0.key' ='pulsar.reader.readerName',
    'connector.properties.0.value' ='testReaderName',
    'format.type' ='json',
    'update-mode' ='append'
);
```

SQL in Pulsar Flink Connector 2.7.0: 

```
create table topic1(
    `rip` VARCHAR,
    `rtime` VARCHAR,
    `uid` bigint,
    `client_ip` VARCHAR,
    `day` as TO_DATE(rtime),
    `hour` as date_format(rtime,'HH')
) with (
    'connector' ='pulsar',
    'topic' ='persistent://public/default/test_flink_sql',
    'service-url' ='pulsar://xxx',
    'admin-url' ='http://xxx',
    'scan.startup.mode' ='earliest',
    'properties.pulsar.reader.readername' = 'testReaderName',
    'format' ='json');
```

## API
From an API perspective, we adjusted some classes and enabled easier customization.

- To solve serialization issues, we changed the signature of the construction method `FlinkPulsarSink`, and added `PulsarSerializationSchema`.
- We removed inappropriate classes related to row, such as `FlinkPulsarRowSink`, `FlinkPulsarRowSource`. If you need to deal with Row format, you can use Flink Row related serialization components.

You can build `PulsarSerializationSchema` by using `PulsarSerializationSchemaWrapper.Builder`. `TopicKeyExtractor` is moved into `PulsarSerializationSchemaWrapper`. When you adjust your API, you can take the following sample as reference.

```
new PulsarSerializationSchemaWrapper.Builder<>(new SimpleStringSchema())
                .setTopicExtractor(str -> getTopic(str))
                .build();
```

## Future Plan
Today, we are designing a batch and stream solution integrated with Pulsar Source, based on the new Flink Source API (FLIP-27). The new solution will unlock limitations of the current streaming source interface (SourceFunction) and simultaneously to unify the source interfaces between the batch and streaming APIs.

Pulsar offers a hierarchical architecture where data is divided into streaming, batch, and cold data, which enables Pulsar to provide infinite capacity. This makes Pulsar an ideal solution for unified batch and streaming. 

The batch and stream solution based on the new Flink Source API is divided into two simple parts: SplitEnumerator and Reader. SplitEnumerator discovers and assigns partitions, and Reader reads data from the partition.

<br>
<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/pulsar-flink-batch-stream.png" width="700px" />
</div>

<br>
<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/blog/pulsar-flink-batch-stream.png" width="640px" alt="Batch and Stream Solution with Apache Pulsar and Apache Flink"/>
</div>

Pulsar stores messages in the ledger block, and you can locate the ledgers through Pulsar admin, and then provide broker partition, BookKeeper partition, Offloader partition, and other information through different partitioning policies. For more details, refer to https://github.com/streamnative/pulsar-flink/issues/187.


## Conclusion
Pulsar Flink Connector 2.7.0 is released and we strongly encourage everyone to use Pulsar Flink Connector 2.7.0. The new version is more user-friendly and is enabled with various features in Pulsar 2.7 and Flink 1.12. We’ll contribute Pulsar Flink Connector 2.7.0 to [Flink repository](https://github.com/apache/flink/). If you have any concern on Pulsar Flink Connector, feel free to open issues in https://github.com/streamnative/pulsar-flink/issues.