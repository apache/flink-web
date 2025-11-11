---
title: "From Stream to Lakehouse: Kafka Ingestion with the Flink Dynamic Iceberg Sink"
date: "2025-10-14T00:00:00.000Z"
aliases:
- /news/2025/10/14/2025-10-14-kafka-dynamic-iceberg-sink.html
authors:
- Swapna:
  name: "Swapna Marru"

---

Ingesting thousands of evolving Kafka topics into a lakehouse often creates complex, brittle pipelines that require constant manual intervention as its write patterns change. But what if your ingestion pipeline could adapt on its own, with zero downtime?

Enter the **Flink Dynamic Iceberg Sink**, a powerful pattern for Apache Flink that allows users to write streaming data into multiple Iceberg tables—dynamically, efficiently, and with full schema evolution support. The sink can create and write to new tables based on instructions within the records themselves. As the schema of incoming records evolves, the dynamic sink automatically evolves the Iceberg table schema in the lakehouse. It can even adapt to changes in the table's partitioning scheme. The key is that all of this happens in real-time, **without a single job restart.**

In this post, we'll guide you through building this exact system. We will start by exploring the limitations of traditional, static pipelines and then demonstrate how the dynamic sink pattern provides a robust, scalable solution. We'll focus on a common use case: ingesting Kafka data with dynamic Avro schemas sourced from a Confluent Schema Registry. By the end, you'll have a blueprint for building a scalable, self-adapting ingestion layer that eliminates operational toil and truly bridges your streams and your lakehouse.


## The Building Block: A Simple Kafka-to-Iceberg Pipeline

Let's start with the basics. Our goal is to get data from a single Kafka topic into a corresponding Iceberg table.

<div style="text-align: center;">
<img src="/img/blog/2025-10-03-kafka-dynamic-iceberg-sink/simple-single-kafka-topic-to-iceberg.png" style="width:70%;margin:15px">
</div>

### How to write to an Iceberg table with Flink

A standard Flink job for this task consists of three main components. 

1.  **Kafka Source**: Connects to Kafka, subscribes to the topic, and distributes records for parallel processing.

2.  **A `RowData` Converter**: This component is responsible for schema-aware processing. It takes the raw `byte[]` records from Kafka, deserializes them, and transforms them into Flink's internal `RowData` format. The logic here can vary:
    *   **Specific Logic:** The converter could contain custom deserialization logic tailored to a single, known topic schema.
    *   **Generic Logic:** More powerful, generic pipelines use a schema registry. For formats like Avro or Protobuf, the converter fetches the correct writer's schema from the registry (using an ID from the message header or payload). It then deserializes the bytes into a generic structure like Avro's `GenericRecord` or Protobuf's `DynamicMessage`.

    This post will focus on the generic pipeline approach, which is designed for evolving data environments. Even in this generic deserialization approach, a standard job then maps these records to a **static `RowData` schema** that is hardcoded or configured in the Flink job. This static schema must correspond to the target Iceberg table's schema.

3.  **Iceberg Sink**: Writes the stream of `RowData` to a specific Iceberg table, managing transactions and ensuring exactly-once semantics.

This setup is simple, robust, and works perfectly for a single topic with a stable schema.


## Scaling Up: The Naive Approach

Now, what if we have thousands of topics? The logical next step is to create a dedicated processing graph (or DAG) for each topic-to-table mapping within a single Flink application.

<div style="text-align: center;">
<img src="/img/blog/2025-10-03-kafka-dynamic-iceberg-sink/multiple-dag-pipeline.png" style="width:70%;margin:15px">
</div>

This looks good, but this static architecture cannot adapt to the changes: an Iceberg sink can only write to **one predefined table**, the table must **exist beforehand**, and its **schema is fixed** for the lifetime of the job.

### Scaling Up: Problems Ahead

This static model becomes an operational bottleneck when faced with real-world scenarios.

**Scenario 1: Schema Evolution**
When a producer adds a new field to an event schema, the running Flink job, which was configured with the old schema, cannot process the new field. It continues to write the events with the older schema.
This requires a manual update to the job's code or configuration, followed by a job restart.


The target Iceberg table's schema must also be updated before the job is restarted. Once restarted, the Flink job's Iceberg sink will use the new table schema, allowing it to write events correctly from both the old and new schemas.

**Scenario 2: A New Topic Appears**
A new microservice starts producing events. The Flink job has no idea this topic exists. You must add a new DAG to the job code and **restart the application**.

**Scenario 3: Dynamic Routing from a Single Topic**
A single Kafka topic contains multiple event types that need to be routed to different Iceberg tables. A static sink, hard-wired to one table, can't do this.

All these scenarios require complex workarounds and a way to **automatically restart the application** whenever something changes.

### The Solution: The Flink Dynamic Iceberg Sink ("Dynamic Sink")

Here’s the new architecture:

<div style="text-align: center;">
<img src="/img/blog/2025-10-03-kafka-dynamic-iceberg-sink/dynamic-iceberg-sink.png" style="width:70%;margin:15px">
</div>

This single, unified pipeline can ingest from any number of topics and write to any number of tables, automatically handling new topics and schema changes without restarts.



#### A Look at the Implementation

Let's dive into the key components that make this dynamic behavior possible.

##### Step 1: Preserving Kafka Metadata with `KafkaRecord`

To make dynamic decisions, our pipeline needs metadata. For example, to use the topic name as the table name, we need access to the topic! Standard deserializers often discard this, returning only the deserialized payload.

To solve this, we first pass the raw Kafka `ConsumerRecord` through a lightweight wrapper. This wrapper converts it into a simple POJO, `KafkaRecord`, that preserves all the essential metadata for downstream processing.

Here is the structure of our `KafkaRecord` class:

```java
public class KafkaRecord {
    public final String topic;
    public final byte[] key;
    public final byte[] value;
    public final Headers headers;
    ....
}
```
Now, every record flowing through our Flink pipeline is a `KafkaRecord` object, giving our converter access to the `topic` for table routing and the `value` (the raw byte payload) for schema discovery.

##### Step 2: The `KafkaRecordToDynamicRecordGenerator`

It takes a `KafkaRecord` and performs the "late binding" of schema and table information. For each message, it:

1.  **Extracts the schema ID** from the `value` byte array (using the Confluent wire format).
2.  **Fetches the writer's schema** from Schema Registry.
3.  **Deserializes the Avro payload** and converts it into Flink's `RowData`.
4.  **Bundles everything** into a `DynamicRecord`, which contains:
    *   The `TableIdentifier` (created from `kafkaRecord.topic`).
    *   The `org.apache.iceberg.Schema` (converted from the Avro schema).
    *   The `PartitionSpec` (e.g., based on a timestamp field).
    *   The `RowData` payload itself.

```java
public class KafkaRecordToDynamicRecordGenerator implements DynamicRecordGenerator<KafkaRecord> {
    @Override
    public DynamicRecord convert(KafkaRecord kafkaRecord) throws Exception {
        // 1. Get schema ID from kafkaRecord.value and fetch schema
        int schemaId = getSchemaId(kafkaRecord.value);
        Schema writerSchema = schemaRegistryClient.getById(schemaId);

        // 2. Deserialize and convert to RowData
        GenericRecord genericRecord = deserialize(payload);
        RowData rowData = avroToRowDataMapper.map(genericRecord);

        // 3. Dynamically create table info from the KafkaRecord
        TableIdentifier tableId = TableIdentifier.of(kafkaRecord.topic);
        org.apache.iceberg.Schema icebergSchema = AvroSchemaUtil.toIceberg(writerSchema);
        PartitionSpec spec = buildPartitionSpec(icebergSchema, kafkaRecord);

        // 4. Return the complete DynamicRecord
        return new DynamicRecord(
                tableId,
                "branch",
                icebergSchema,
                rowData,
                spec,
                DistributionMode.NONE,
                1);
    }
}
```
Find more details on options passed to DynamicRecord [here](https://iceberg.apache.org/docs/nightly/flink-writes/#flink-dynamic-iceberg-sink) 

##### Step 3: Assembling the Flink Job

```java
// A single stream from ALL topics, producing KafkaRecord objects
DataStream<KafkaRecord> sourceStream = env.fromSource(kafkaSource, ...);

// A single sink that handles everything
DynamicIcebergSink.forInput(sourceStream)
    .generator(new KafkaRecordToDynamicRecordGenerator())
    .catalogLoader(getCatalogLoader())
    .append();
```

## Project Details: Availability, Credits, and Development

This powerful capability is now officially available as part of the Apache Iceberg project.

Find more details on the Dynamic Sink [here](https://iceberg.apache.org/docs/nightly/flink-writes/#flink-dynamic-iceberg-sink).

### Supported Versions
You can start using the dynamic sink with the following versions:
*   **Apache Iceberg 1.10.0** or newer. Full release notes [here](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.10.0).
*   **Apache Flink 1.20, 2.0, and 2.1**.

### Contributors
The journey began with a detailed project proposal authored by **Peter Vary**, which laid the groundwork for this development. You can read the original proposal [here](https://docs.google.com/document/d/1R3NZmi65S4lwnmNjH4gLCuXZbgvZV5GNrQKJ5NYdO9s/edit?tab=t.0#heading=h.xv1r23unqyn3).

Major development efforts were led by **Maximilian Michels**, with contributions from several community members.

## Conclusion

In conclusion, the choice between a dynamic and a static Iceberg sink represents a trade-off between operational agility and the performance benefits of static bindings. While a simple, static Kafka-to-Iceberg sink is a performant and straightforward solution for stable data environments, the Dynamic Iceberg Sink pattern helps manage the complexity and velocity of frequently changing data.

The most significant advantage of the Dynamic Sink is its ability to reduce operational burden by automating schema evolution. By leveraging a central schema registry, new schema versions can be published without any direct intervention in the Flink application. The dynamic sink detects these changes and adapts the downstream Iceberg table schema on the fly, eliminating the need for manual code changes, configuration updates, and disruptive job restarts. This creates a truly resilient and hands-off data ingestion pipeline.


Furthermore, the dynamic sink enables powerful, data-driven logic, such as routing records to different tables based on signals within the data itself. This facilitates advanced use cases like multi-tenant data segregation or event-type-based routing without needing to pre-configure every possible outcome.

