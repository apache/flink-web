---
authors:
- brianzhou: null
  name: Yumin Zhou (Brian)
  twitter: crazy__zhou
date: "2022-01-20T00:00:00Z"
excerpt: A brief introduction to the Pravega Flink Connector
title: Pravega Flink Connector 101
---

[Pravega](https://cncf.pravega.io/), which is now a CNCF sandbox project, is a cloud-native storage system based on abstractions for both batch and streaming data consumption. Pravega streams (a new storage abstraction) are durable, consistent, and elastic, while natively supporting long-term data retention. In comparison, [Apache Flink](https://flink.apache.org/) is a popular real-time computing engine that provides unified batch and stream processing. Flink provides high-throughput, low-latency computation, as well as support for complex event processing and state management. Both Pravega and Flink share the same design philosophy and treat data streams as primitives. This makes them a great match when constructing storage+computing data pipelines which can unify batch and streaming use cases.

That's also the main reason why Pravega has chosen to use Flink as the first integrated execution engine among the various distributed computing engines on the market. With the help of Flink, users can use flexible APIs for windowing, complex event processing (CEP), or table abstractions to process streaming data easily and enrich the data being stored. Since its inception in 2016, Pravega has established communication with Flink PMC members and developed the connector together.

In 2017, the Pravega Flink connector module started to move out of the Pravega main repository and has been maintained in a new separate [repository](https://github.com/pravega/flink-connectors) since then. During years of development, many features have been implemented, including: 

- exactly-once processing guarantees for both Reader and Writer, supporting end-to-end exactly-once processing pipelines
- seamless integration with Flink's checkpoints and savepoints
- parallel Readers and Writers supporting high throughput and low latency processing
- support for Batch, Streaming, and Table API to access Pravega Streams

These key features make streaming pipeline applications easier to develop without worrying about performance and correctness which are the common pain points for many streaming use cases. 

In this blog post, we will discuss how to use this connector to read and write Pravega streams with the Flink DataStream API.  

{% toc %}

# Basic usages

## Dependency
To use this connector in your application, add the dependency to your project:

```xml
<dependency>
  <groupId>io.pravega</groupId>
  <artifactId>pravega-connectors-flink-1.13_2.12</artifactId>
  <version>0.10.1</version>
</dependency>
```


In the above example, 

`1.13` is the Flink major version which is put in the middle of the artifact name. The Pravega Flink connector maintains compatibility for the *three* most recent major versions of Flink.

`0.10.1` is the version that aligns with the Pravega version.

You can find the latest release with a support matrix on the [GitHub Releases page](https://github.com/pravega/flink-connectors/releases).

## API introduction

### Configurations

The connector provides a common top-level object `PravegaConfig` for Pravega connection configurations. The config object automatically configures itself from _environment variables_, _system properties_ and _program arguments_.

The basic controller URI and the default scope can be set like this:

|Setting|Environment Variable /<br/>System Property /<br/>Program Argument|Default Value|
|-------|-------------------------------------------------------------|-------------|
|Controller URI|`PRAVEGA_CONTROLLER_URI`<br/>`pravega.controller.uri`<br/>`--controller`|`tcp://localhost:9090`|
|Default Scope|`PRAVEGA_SCOPE`<br/>`pravega.scope`<br/>`--scope`|-|

The recommended way to create an instance of `PravegaConfig` is the following:


```java
// From default environment
PravegaConfig config = PravegaConfig.fromDefaults();

// From program arguments
ParameterTool params = ParameterTool.fromArgs(args);
PravegaConfig config = PravegaConfig.fromParams(params);

// From user specification
PravegaConfig config = PravegaConfig.fromDefaults()
    .withControllerURI("tcp://...")
    .withDefaultScope("SCOPE-NAME")
    .withCredentials(credentials)
    .withHostnameValidation(false);
```

### Serialization/Deserialization

Pravega has defined [`io.pravega.client.stream.Serializer`](http://pravega.io/docs/latest/javadoc/clients/io/pravega/client/stream/Serializer.html) for the serialization/deserialization, while Flink has also defined standard interfaces for the purpose.

- [`org.apache.flink.api.common.serialization.SerializationSchema`](https://ci.apache.org/projects/flink/flink-docs-stable/api/java/org/apache/flink/api/common/serialization/SerializationSchema.html)
- [`org.apache.flink.api.common.serialization.DeserializationSchema`](https://ci.apache.org/projects/flink/flink-docs-stable/api/java/org/apache/flink/api/common/serialization/DeserializationSchema.html)

For interoperability with other pravega client applications, we have built-in adapters `PravegaSerializationSchema` and `PravegaDeserializationSchema` to support processing Pravega stream data produced by a non-Flink application.

Here is the adapter for Pravega Java serializer:

```java
import io.pravega.client.stream.impl.JavaSerializer;
...
DeserializationSchema<MyEvent> adapter = new PravegaDeserializationSchema<>(
    MyEvent.class, new JavaSerializer<MyEvent>());
```

### `FlinkPravegaReader`

`FlinkPravegaReader` is a Flink `SourceFunction` implementation which supports parallel reads from one or more Pravega streams. Internally, it initiates a Pravega reader group and creates Pravega `EventStreamReader` instances to read the data from the stream(s). It provides a builder-style API to construct, and can allow streamcuts to mark the start and end of the read.

You can use it like this:

```java
final StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

// Enable Flink checkpoint to make state fault tolerant
env.enableCheckpointing(60000);

// Define the Pravega configuration
ParameterTool params = ParameterTool.fromArgs(args);
PravegaConfig config = PravegaConfig.fromParams(params);

// Define the event deserializer
DeserializationSchema<MyClass> deserializer = ...

// Define the data stream
FlinkPravegaReader<MyClass> pravegaSource = FlinkPravegaReader.<MyClass>builder()
    .forStream(...)
    .withPravegaConfig(config)
    .withDeserializationSchema(deserializer)
    .build();
DataStream<MyClass> stream = env.addSource(pravegaSource)
    .setParallelism(4)
    .uid("pravega-source");
```

### `FlinkPravegaWriter`

`FlinkPravegaWriter` is a Flink `SinkFunction` implementation which supports parallel writes to Pravega streams.

It supports three writer modes that relate to guarantees about the persistence of events emitted by the sink to a Pravega Stream:

1. **Best-effort** - Any write failures will be ignored and there could be data loss.
2. **At-least-once**(default) - All events are persisted in Pravega. Duplicate events are possible, due to retries or in case of failure and subsequent recovery.
3. **Exactly-once** - All events are persisted in Pravega using a transactional approach integrated with the Flink checkpointing feature.

Internally, it will initiate several Pravega `EventStreamWriter` or `TransactionalEventStreamWriter` (depends on the writer mode) instances to write data to the stream. It provides a builder-style API to construct.

A basic usage looks like this:

```java
StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

// Define the Pravega configuration
PravegaConfig config = PravegaConfig.fromParams(params);

// Define the event serializer
SerializationSchema<MyClass> serializer = ...

// Define the event router for selecting the Routing Key
PravegaEventRouter<MyClass> router = ...

// Define the sink function
FlinkPravegaWriter<MyClass> pravegaSink = FlinkPravegaWriter.<MyClass>builder()
   .forStream(...)
   .withPravegaConfig(config)
   .withSerializationSchema(serializer)
   .withEventRouter(router)
   .withWriterMode(EXACTLY_ONCE)
   .build();

DataStream<MyClass> stream = ...
stream.addSink(pravegaSink)
    .setParallelism(4)
    .uid("pravega-sink");
```

You can see some more examples [here](https://github.com/pravega/pravega-samples).

# Internals of reader and writer

## Checkpoint integration

Flink has periodic checkpoints based on the Chandy-Lamport algorithm to make state in Flink fault-tolerant. By allowing state and the corresponding stream positions to be recovered, the application is given the same semantics as a failure-free execution.

Pravega also has its own Checkpoint concept which is to create a consistent "point in time" persistence of the state of each Reader in the Reader Group, by using a specialized Event (*Checkpoint Event*) to signal each Reader to preserve its state. Once a Checkpoint has been completed, the application can use the Checkpoint to reset all the Readers in the Reader Group to the known consistent state represented by the Checkpoint.

This means that our end-to-end recovery story is not like other messaging systems such as Kafka, which uses a more coupled method and persists its offset in the Flink task state and lets Flink do the coordination. Flink delegates the Pravega source recovery completely to the Pravega server and uses only a lightweight hook to connect. We collaborated with the Flink community and added a new interface `ExternallyInducedSource` ([FLINK-6390](https://issues.apache.org/jira/browse/FLINK-6390)) to allow such external calls for checkpointing. The connector integrated this interface to guarantee exactly-once semantics during a failure recovery.

The checkpoint mechanism works as a two-step process:

   - The [master hook](https://ci.apache.org/projects/flink/flink-docs-stable/api/java/org/apache/flink/runtime/checkpoint/MasterTriggerRestoreHook.html) handler from the JobManager initiates the [`triggerCheckpoint`](https://ci.apache.org/projects/flink/flink-docs-stable/api/java/org/apache/flink/runtime/checkpoint/MasterTriggerRestoreHook.html#triggerCheckpoint-long-long-java.util.concurrent.Executor-) request to the `ReaderCheckpointHook` that was registered with the JobManager during `FlinkPravegaReader` source initialization. The `ReaderCheckpointHook` handler notifies Pravega to checkpoint the current reader state. This is a non-blocking call that returns a `future` once Pravega readers are done with the checkpointing. Once the `future` completes, the Pravega checkpoint will be persisted in a "master state" of a Flink checkpoint.

   - A `Checkpoint` event will be sent by Pravega as part of the data stream flow and, upon receiving the event, the `FlinkPravegaReader` will initiate a [`triggerCheckpoint`](https://github.com/apache/flink/blob/master/flink-streaming-java/src/main/java/org/apache/flink/streaming/api/checkpoint/ExternallyInducedSource.java#L73) request to effectively let Flink continue and complete the checkpoint process.


## End-to-end exactly-once semantics

In the early years of big data processing, results from real-time stream processing were always considered inaccurate/approximate/speculative. However, this correctness is extremely important for some use cases and in some industries such as finance. 

This constraint stems mainly from two issues:

- unordered data source in event time 
- end-to-end exactly-once semantics guarantee

During recent years of development, watermarking has been introduced as a tradeoff between correctness and latency, which is now considered a good solution for unordered data sources in event time.

The guarantee of end-to-end exactly-once semantics is more tricky. When we say “exactly-once semantics”, what we mean is that each incoming event affects the final results exactly once. Even in the event of a machine or software failure, there is no duplicate data and no data that goes unprocessed. This is quite difficult because of the demands of message acknowledgment and recovery during such fast processing and is also why some early distributed streaming engines like Storm(without Trident) chose to support "at-least-once" guarantees.

Flink is one of the first streaming systems that was able to provide exactly-once semantics due to its delicate [checkpoint mechanism](https://www.ververica.com/blog/high-throughput-low-latency-and-exactly-once-stream-processing-with-apache-flink). But to make it work end-to-end, the final stage needs to apply the semantic to external message system sinks that support commits and rollbacks.

To work around this problem, Pravega introduced [transactional writes](https://cncf.pravega.io/docs/latest/transactions/). A Pravega transaction allows an application to prepare a set of events that can be written "all at once" to a Stream. This allows an application to "commit" a bunch of events atomically. When writes are idempotent, it is possible to implement end-to-end exactly-once pipelines together with Flink.

To build such an end-to-end solution requires coordination between Flink and the Pravega sink, which is still challenging. A common approach for coordinating commits and rollbacks in a distributed system is the two-phase commit protocol. We used this protocol and, together with the Flink community, implemented the sink function in a two-phase commit way coordinated with Flink checkpoints.

The Flink community then extracted the common logic from the two-phase commit protocol and provided a general interface `TwoPhaseCommitSinkFunction` ([FLINK-7210](https://issues.apache.org/jira/browse/FLINK-7210)) to make it possible to build end-to-end exactly-once applications with other message systems that have transaction support. This includes Apache Kafka versions 0.11 and above. There is an official Flink [blog post](https://flink.apache.org/features/2018/03/01/end-to-end-exactly-once-apache-flink.html) that describes this feature in detail.

# Summary
The Pravega Flink connector enables Pravega to connect to Flink and allows Pravega to act as a key data store in a streaming pipeline. Both projects share a common design philosophy and can integrate well with each other. Pravega has its own concept of checkpointing and has implemented transactional writes to support end-to-end exactly-once guarantees.

# Future plans

`FlinkPravegaInputFormat` and `FlinkPravegaOutputFormat` are now provided to support batch reads and writes in Flink, but these are under the legacy DataSet API. Since Flink is now making efforts to unify batch and streaming, it is improving its APIs and providing new interfaces for the [source](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface) and [sink](https://cwiki.apache.org/confluence/display/FLINK/FLIP-143%3A+Unified+Sink+API) APIs in the Flink 1.11 and 1.12 releases. We will continue to work with the Flink community and integrate with the new APIs.
 
We will also put more effort into SQL / Table API support in order to provide a better user experience since it is simpler to understand and even more powerful to use in some cases.

**Note:** the original blog post can be found [here](https://cncf.pravega.io/blog/2021/11/01/pravega-flink-connector-101/).