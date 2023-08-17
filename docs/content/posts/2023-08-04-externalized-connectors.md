---
title: "Announcing three new Apache Flink connectors, the new connector versioning strategy and externalization"
date: "2023-08-04T12:00:00Z"
authors:
- elphastori: 
  name: "Elphas Toringepi"
  twitter: "elphastori"
aliases:
- /news/2023/08/04/externalized-connectors.html
---

## New connectors

We're excited to announce that Apache Flink now supports three new connectors: [Amazon DynamoDB](https://aws.amazon.com/dynamodb), [MongoDB](https://www.mongodb.com/) and [OpenSearch](https://opensearch.org/)! The connectors are available for both the [DataStream](https://nightlies.apache.org/flink/flink-docs-master/docs/connectors/datastream/overview/) and [Table/SQL](https://nightlies.apache.org/flink/flink-docs-master/docs/connectors/table/overview/) APIs.  

- **[Amazon DynamoDB](https://nightlies.apache.org/flink/flink-docs-master/docs/connectors/datastream/dynamodb/)** - This connector includes a sink that provides at-least-once delivery guarantees.
- **[MongoDB connector](https://nightlies.apache.org/flink/flink-docs-master/docs/connectors/datastream/mongodb/)** - This connector includes a source and sink that provide at-least-once guarantees.
- **[OpenSearch sink](https://github.com/apache/flink-connector-opensearch/blob/main/docs/content/docs/connectors/datastream/opensearch.md)** - This connector includes a sink that provides at-least-once guarantees.

|Connector|Date Released|Supported Flink Versions|
|---|---|---|
|Amazon DynamoDB sink|2022-12-02|1.15+|
|MongoDB connector|2023-03-31|1.16+|
|OpenSearch sink|2022-12-21|1.16+|

### List of Contributors

The Apache Flink community would like to express gratitude to all the new connector contributors:

Andriy Redko, Chesnay Schepler, Danny Cranmer, darenwkt, Hong Liang Teoh, Jiabao Sun, Leonid Ilyevsky, Martijn Visser, nir.tsruya, Sergey Nuyanzin, Weijie Guo, Yuri Gusev, Yuxin Tan

## Externalized connectors

The community has externalized connectors from [Flink’s main repository](https://github.com/apache/flink). This was driven to realise the following benefits:
- **Faster releases of connectors:** New features can be added more quickly, bugs can be fixed immediately, and we can have faster security patches in case of direct or indirect (through dependencies) security flaws.
- **Adding newer connector features to older Flink versions:** By having stable connector APIs, the same connector artifact may be used with different Flink versions. Thus, new features can also immediately be used with older Flink versions. 
- **More activity and contributions around connectors:** By easing the contribution and development process around connectors, we will see faster development and also more connectors.
- **Documentation:** Standardized documentation and user experience for the connectors, regardless of where they are maintained. 
- **A faster Flink CI:** By not needing to build and test connectors, the Flink CI pipeline will be faster and Flink developers will experience fewer build instabilities (which mostly come from connectors). That should speed up Flink development.

The following connectors have been moved to individual repositories:  

- [Kafka / Upsert-Kafka](https://github.com/apache/flink-connector-kafka)
- [Cassandra](https://github.com/apache/flink-connector-cassandra)
- [Elasticsearch](https://github.com/apache/flink-connector-elasticsearch/)
- [**MongoDB**](https://github.com/apache/flink-connector-mongodb)
- **[OpenSearch](https://github.com/apache/flink-connector-opensearch)**
- [RabbitMQ](https://github.com/apache/flink-connector-rabbitmq)
- [Google Cloud PubSub](https://github.com/apache/flink-connector-gcp-pubsub)
- [Pulsar](https://github.com/apache/flink-connector-pulsar/)
- [JDBC](https://github.com/apache/flink-connector-jdbc)
- [HBase](https://github.com/apache/flink-connector-hbase)
- [Hive](https://github.com/apache/flink-connector-hive)
- [AWS connectors](https://github.com/apache/flink-connector-aws):
	- Firehose
	- Kinesis
	- **DynamoDB**

### Versioning

Connectors continue to use the same Maven dependency `groupId` and `artifactId`. However, the JAR artifact `version` has changed and now uses the format, `<major>.<minor>.<patch>-<flink-major>.<flink-minor>`. For example, to use the DynamoDB connector for Flink 1.17, add the following dependency to your project:  

```
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-connector-dynamodb</artifactId>
    <version>4.1.0-1.17</version>
</dependency>
```

You can find the maven dependency for a connector in the [Flink connectors documentation](https://nightlies.apache.org/flink/flink-docs-release-1.17/docs/connectors/datastream/overview) for a specific Flink version. Use the [Flink Downloads page](https://flink.apache.org/downloads) to verify which version your connector is compatible with.  

### Contributing

Similarly, when creating JIRAs to report issues or to contribute to externalized connectors, the `Affects Version/s` and `Fix Version/s` fields should now use the connector version instead of a Flink version. The format should be `<connector-name>-<major>.<minor>.<patch>`.  For example, use `opensearch-1.1.0` for the OpenSearch connector. All other fields in the JIRA like `Component/s` remain the same.  

For more information on how to contribute to externalized connectors, see the [Externalized Connector development wiki](https://cwiki.apache.org/confluence/display/FLINK/Externalized+Connector+development).