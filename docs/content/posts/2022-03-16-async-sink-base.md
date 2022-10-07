---
authors:
- CrynetLogistics: null
  name: Zichen Liu
date: "2022-03-16T16:00:00Z"
excerpt: An overview of the new AsyncBaseSink and how to use it for building your
  own concrete sink
title: The Generic Asynchronous Base Sink
---

Flink sinks share a lot of similar behavior. Most sinks batch records according to user-defined buffering hints, sign requests, write them to the destination, retry unsuccessful or throttled requests, and participate in checkpointing.

This is why for Flink 1.15 we have decided to create the [`AsyncSinkBase` (FLIP-171)](https://cwiki.apache.org/confluence/display/FLINK/FLIP-171%3A+Async+Sink), an abstract sink with a number of common functionalities extracted. 

This is a base implementation for asynchronous sinks, which you should use whenever you need to implement a sink that doesn't offer transactional capabilities. Adding support for a new destination now only requires a lightweight shim that implements the specific interfaces of the destination using a client that supports async requests.

This common abstraction will reduce the effort required to maintain individual sinks that extend from this abstract sink, with bug fixes and improvements to the sink core benefiting all implementations that extend it. The design of `AsyncSinkBase` focuses on extensibility and a broad support of destinations. The core of the sink is kept generic and free of any connector-specific dependencies.

The sink base is designed to participate in checkpointing to provide at-least-once semantics and can work directly with destinations that provide a client that supports asynchronous requests.

In this post, we will go over the details of the AsyncSinkBase so that you can start using it to build your own concrete sink.

{% toc %}

# Adding the base sink as a dependency

In order to use the base sink, you will need to add the following dependency to your project. The example below follows the Maven syntax:

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-connector-base</artifactId>
  <version>${flink.version}</version>
</dependency>
```

# The Public Interfaces of AsyncSinkBase

## Generic Types

`<InputT>` – type of elements in a DataStream that should be passed to the sink

`<RequestEntryT>` – type of a payload containing the element and additional metadata that is required to submit a single element to the destination


## Element Converter Interface

[ElementConverter](https://github.com/apache/flink/blob/release-1.15.0/flink-connectors/flink-connector-base/src/main/java/org/apache/flink/connector/base/sink/writer/ElementConverter.java)

```java
public interface ElementConverter<InputT, RequestEntryT> extends Serializable {
    RequestEntryT apply(InputT element, SinkWriter.Context context);
}
```
The concrete sink implementation should provide a way to convert from an element in the DataStream to the payload type that contains all the additional metadata required to submit that element to the destination by the sink. Ideally, this would be encapsulated from the end user since it allows concrete sink implementers to adapt to changes in the destination API without breaking end user code.

## Sink Writer Interface

[AsyncSinkWriter](https://github.com/apache/flink/blob/release-1.15.0/flink-connectors/flink-connector-base/src/main/java/org/apache/flink/connector/base/sink/writer/AsyncSinkWriter.java)

There is a buffer in the sink writer that holds the request entries that have been sent to the sink but not yet written to the destination. An element of the buffer is a `RequestEntryWrapper<RequestEntryT>` consisting of the `RequestEntryT` along with the size of that record.

```java
public abstract class AsyncSinkWriter<InputT, RequestEntryT extends Serializable>
        implements StatefulSink.StatefulSinkWriter<InputT, BufferedRequestState<RequestEntryT>> {
    // ...
    protected abstract void submitRequestEntries(
            List<RequestEntryT> requestEntries, Consumer<List<RequestEntryT>> requestResult);
    // ...
}
```

We will submit the `requestEntries` asynchronously to the destination from here. Sink implementers should use the client libraries of the destination they intend to write to, to perform this.

Should any elements fail to be persisted, they will be requeued back in the buffer for retry using `requestResult.accept(...list of failed entries...)`. However, retrying any element that is known to be faulty and consistently failing, will result in that element being requeued forever, therefore a sensible strategy for determining what should be retried is highly recommended. If no errors were returned, we must indicate this with `requestResult.accept(Collections.emptyList())`.

If at any point, it is determined that a fatal error has occurred and that we should throw a runtime exception from the sink, we can call `getFatalExceptionCons().accept(...);` from anywhere in the concrete sink writer.

```java
public abstract class AsyncSinkWriter<InputT, RequestEntryT extends Serializable>
        implements StatefulSink.StatefulSinkWriter<InputT, BufferedRequestState<RequestEntryT>> {
    // ...
    protected abstract long getSizeInBytes(RequestEntryT requestEntry);
    // ...
}
```
The async sink has a concept of size of elements in the buffer. This allows users to specify a byte size threshold beyond which elements will be flushed. However the sink implementer is best positioned to determine what the most sensible measure of size for each `RequestEntryT` is. If there is no way to determine the size of a record, then the value `0` may be returned, and the sink will not flush based on record size triggers.

```java
public abstract class AsyncSinkWriter<InputT, RequestEntryT extends Serializable>
        implements StatefulSink.StatefulSinkWriter<InputT, BufferedRequestState<RequestEntryT>> {
    // ...
    public AsyncSinkWriter(
            ElementConverter<InputT, RequestEntryT> elementConverter,
            Sink.InitContext context,
            int maxBatchSize,
            int maxInFlightRequests,
            int maxBufferedRequests,
            long maxBatchSizeInBytes,
            long maxTimeInBufferMS,
            long maxRecordSizeInBytes) { /* ... */ }
    // ...
}
```

By default, the method `snapshotState` returns all the elements in the buffer to be saved for snapshots. Any elements that were previously removed from the buffer are guaranteed to be persisted in the destination by a preceding call to `AsyncWriter#flush(true)`.
You may want to save additional state from the concrete sink. You can achieve this by overriding `snapshotState`, and restoring from the saved state in the constructor. You will receive the saved state by overriding `restoreWriter` in your concrete sink. In this method, you should construct a sink writer, passing in the recovered state.

```java
class MySinkWriter<InputT> extends AsyncSinkWriter<InputT, RequestEntryT> {

    MySinkWriter(
          // ... 
          Collection<BufferedRequestState<Record>> initialStates) {
        super(
            // ...
            initialStates);
        // restore concrete sink state from initialStates
    }
    
    @Override
    public List<BufferedRequestState<RequestEntryT>> snapshotState(long checkpointId) {
        super.snapshotState(checkpointId);
        // ...
    }

}
```

## Sink Interface

[AsyncSinkBase](https://github.com/apache/flink/blob/release-1.15.0/flink-connectors/flink-connector-base/src/main/java/org/apache/flink/connector/base/sink/AsyncSinkBase.java)

```java
class MySink<InputT> extends AsyncSinkBase<InputT, RequestEntryT> {
    // ...
    @Override
    public StatefulSinkWriter<InputT, BufferedRequestState<RequestEntryT>> createWriter(InitContext context) {
        return new MySinkWriter(context);
    }
    // ...
}
```
AsyncSinkBase implementations return their own extension of the `AsyncSinkWriter` from `createWriter()`.

At the time of writing, the [Kinesis Data Streams sink](https://github.com/apache/flink/tree/release-1.15.0/flink-connectors/flink-connector-aws-kinesis-streams) and [Kinesis Data Firehose sink](https://github.com/apache/flink/tree/release-1.15.0/flink-connectors/flink-connector-aws-kinesis-firehose) are using this base sink. 

# Metrics

There are three metrics that automatically exist when you implement sinks (and, thus, should not be implemented by yourself).

* CurrentSendTime Gauge - returns the amount of time in milliseconds it took for the most recent request to write records to complete, whether successful or not.  
* NumBytesOut Counter - counts the total number of bytes the sink has tried to write to the destination, using the method `getSizeInBytes` to determine the size of each record. This will double count failures that may need to be retried. 
* NumRecordsOut Counter - similar to above, this counts the total number of records the sink has tried to write to the destination. This will double count failures that may need to be retried.

# Sink Behavior

There are six sink configuration settings that control the buffering, flushing, and retry behavior of the sink.

* `int maxBatchSize` - maximum number of elements that may be passed in the list to submitRequestEntries to be written downstream.
* `int maxInFlightRequests` - maximum number of uncompleted calls to submitRequestEntries that the SinkWriter will allow at any given point. Once this point has reached, writes and callbacks to add elements to the buffer may block until one or more requests to submitRequestEntries completes.
* `int maxBufferedRequests` - maximum buffer length. Callbacks to add elements to the buffer and calls to write will block if this length has been reached and will only unblock if elements from the buffer have been removed for flushing.
* `long maxBatchSizeInBytes` - a flush will be attempted if the most recent call to write introduces an element to the buffer such that the total size of the buffer is greater than or equal to this threshold value.
* `long maxTimeInBufferMS` - maximum amount of time an element may remain in the buffer. In most cases elements are flushed as a result of the batch size (in bytes or number) being reached or during a snapshot. However, there are scenarios where an element may remain in the buffer forever or a long period of time. To mitigate this, a timer is constantly active in the buffer such that: while the buffer is not empty, it will flush every maxTimeInBufferMS milliseconds.
* `long maxRecordSizeInBytes` - maximum size in bytes allowed for a single record, as determined by `getSizeInBytes()`.

Destinations typically have a defined throughput limit and will begin throttling or rejecting requests once near. We employ [Additive Increase Multiplicative Decrease (AIMD)](https://en.wikipedia.org/wiki/Additive_increase/multiplicative_decrease) as a strategy for selecting the optimal batch size.

# Summary

The AsyncSinkBase is a new abstraction that makes creating and maintaining async sinks easier. This will be available in Flink 1.15 and we hope that you will try it out and give us feedback on it.
