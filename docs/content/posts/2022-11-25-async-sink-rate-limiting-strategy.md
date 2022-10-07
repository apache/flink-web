---
authors:
- liangtl: null
  name: Hong Liang Teoh
date: "2022-11-25T12:00:00Z"
excerpt: An overview of how to optimise the throughput of async sinks using a custom
  RateLimitingStrategy
title: Optimising the throughput of async sinks using a custom RateLimitingStrategy
---

## Introduction

When designing a Flink data processing job, one of the key concerns is maximising job throughput. Sink throughput is a crucial factor because it can determine the entire job’s throughput. We generally want the highest possible write rate in the sink without overloading the destination. However, since the factors impacting a destination’s performance are variable over the job’s lifetime, the sink needs to adjust its write rate dynamically. Depending on the sink’s destination, it helps to tune the write rate using a different RateLimitingStrategy.

**This post explains how you can optimise sink throughput by configuring a custom RateLimitingStrategy on a connector that builds on the** [**AsyncSinkBase (FLIP-171)**](https://cwiki.apache.org/confluence/display/FLINK/FLIP-171%3A+Async+Sink)**.** In the sections below, we cover the design logic behind the AsyncSinkBase and the RateLimitingStrategy, then we take you through two example implementations of rate limiting strategies, specifically the CongestionControlRateLimitingStrategy and TokenBucketRateLimitingStrategy.

### Background of the AsyncSinkBase

When implementing the AsyncSinkBase, our goal was to simplify building new async sinks to custom destinations by providing common async sink functionality used with at least once processing. This has allowed users to more easily write sinks to custom destinations, such as Amazon Kinesis Data Streams and Amazon Kinesis Firehose. An additional async sink to Amazon DynamoDB ([FLIP-252](https://cwiki.apache.org/confluence/display/FLINK/FLIP-252%3A+Amazon+DynamoDB+Sink+Connector)) is also being developed at the time of writing.

The AsyncSinkBase provides the core implementation which handles the mechanics of async requests and responses. This includes retrying failed messages, deciding when to flush records to the destination, and persisting un-flushed records to state during checkpointing. In order to increase throughput, the async sink also dynamically adjusts the request rate depending on the destination’s responses. Read more about this in our [previous 1.15 release blog post](https://flink.apache.org/2022/05/06/async-sink-base.html) or watch our [FlinkForward talk recording explaining the design of the Async Sink](https://www.youtube.com/watch?v=z-hYuLgbHuo).

### Configuring the AsyncSinkBase

When designing the AsyncSinkBase, we wanted users to be able to tune their custom connector implementations based on their use case and needs, without having to understand the low-level workings of the base sink itself.

So, as part of our initial implementation in Flink 1.15, we exposed configurations such as `maxBatchSize`, `maxInFlightRequests`, `maxBufferedRequests`, `maxBatchSizeInBytes`, `maxTimeInBufferMS` and `maxRecordSizeInBytes` so that users can adapt the flushing and writing behaviour of the sink.

In Flink 1.16, we have further extended this configurability to the RateLimitingStrategy used by the AsyncSinkBase ([FLIP-242](https://cwiki.apache.org/confluence/display/FLINK/FLIP-242%3A+Introduce+configurable+RateLimitingStrategy+for+Async+Sink)). With this change, users can now customise how the AsyncSinkBase dynamically adjusts the request rate in real-time to optimise throughput whilst mitigating back pressure. Example customisations include changing the mathematical function used to scale the request rate, implementing a cool off period between rate adjustments, or implementing a token bucket RateLimitingStrategy.

## Rationale behind the RateLimitingStrategy interface

```java
public interface RateLimitingStrategy {

    // Information provided to the RateLimitingStrategy
    void registerInFlightRequest(RequestInfo requestInfo);
    void registerCompletedRequest(ResultInfo resultInfo);
    
    // Controls offered to the RateLimitingStrategy
    boolean shouldBlock(RequestInfo requestInfo);
    int getMaxBatchSize();
    
}
```

There are 2 core ideas behind the RateLimitingStrategy interface:

* **Information methods:** We need methods to provide the RateLimitingStrategy with sufficient information to track the rate of requests or rate of sent messages (each request can comprise multiple messages)
* **Control methods:** We also need methods to allow the RateLimitingStrategy to control the sink’s request rate.

These are the type of methods that we see in the RateLimitingStrategy interface. With `registerInFlightRequest()` and `registerCompletedRequest()`, the RateLimitingStrategy has sufficient information to track the number in-flight requests and messages, as well as the rate of these requests.

With `shouldBlock()`, the RateLimitingStrategy can decide to postpone new requests until a specified condition is met (e.g. current in-flight requests must not exceed a given number). This allows the RateLimitingStrategy to control the rate of requests to the destination. It can decide to increase throughput or to increase backpressure in the Flink job graph.

With `getMaxBatchSize()`, the RateLimitingStrategy can dynamically adjust the number of messages packaged into a single request. This can be useful to optimise sink throughput if the request size affects the destination’s performance.

## Implementing a custom RateLimitingStrategy

### [Example 1]  CongestionControlRateLimitingStrategy

The AsyncSinkBase comes pre-packaged with the CongestionControlRateLimitingStrategy. In this section, we explore its implementation.

This strategy is modelled after [TCP congestion control](https://en.wikipedia.org/wiki/TCP_congestion_control), and aims to discover a destination’s highest possible request rate. It achieves this by increasing the request rate until the sink is throttled by the destination, at which point it will reduce the request rate.

In this RateLimitingStrategy, we want to dynamically adjust the request rate by:

* Setting a maximum number of in-flight requests at any time
* Setting a maximum number of in-flight messages at any time (each request can comprise multiple messages)
* Increasing the maximum number of in-flight messages after each successful request, to maximise the request rate
* Decreasing the maximum number of in-flight messages after an unsuccessful request, to prevent overloading the destination
* Independently keeping track of the maximum number of in-flight messages if there are multiple sink subtasks

This strategy means we will start with a low request rate (slow start), but aggressively increase it until the destination throttles us, which allows us to discover the highest possible request rate. It will also adjust the request rate if the conditions of the destination changes (e.g. another client starts writing to the same destination). This strategy works well if destinations implement traffic shaping and throttles once the bandwidth limit is reached (e.g. Amazon Kinesis Data Streams, Amazon Kinesis Data Firehose).

First, we implement the information methods to keep track of the number of in-flight requests and in-flight messages.

```java
public class CongestionControlRateLimitingStrategy implements RateLimitingStrategy {
    // ...
    @Override
    public void registerInFlightRequest(RequestInfo requestInfo) {
        currentInFlightRequests++;
        currentInFlightMessages += requestInfo.getBatchSize();
    }
    
    @Override
    public void registerCompletedRequest(ResultInfo resultInfo) {
        currentInFlightRequests = Math.max(0, currentInFlightRequests - 1);
        currentInFlightMessages = Math.max(0, currentInFlightMessages - resultInfo.getBatchSize());
        
        if (resultInfo.getFailedMessages() > 0) {
            maxInFlightMessages = scalingStrategy.scaleDown(maxInFlightMessages);
        } else {
            maxInFlightMessages = scalingStrategy.scaleUp(maxInFlightMessages);
        }
    }
    // ...
}
```

Then we implement the control methods to dynamically adjust the request rate.

We keep a current value for maxInFlightMessages and maxInFlightRequests, and postpone all new requests if maxInFlightRequests or maxInFlightMessages have been reached.

Every time a request completes, the CongestionControlRateLimitingStrategy will check if there are any failed messages in the response. If there are, it will decrease maxInFlightMessages. If there are no failed messages, it will increase maxInFlightMessages. This gives us indirect control of the rate of messages being written to the destination.

Side note: The default CongestionControlRateLimitingStrategy uses an Additive Increase / Multiplicative Decrease (AIMD) scaling strategy. This is also used in TCP congestion control to avoid overloading the destination by increasing write rate slowly but backing off quickly if throttled.

```java
public class CongestionControlRateLimitingStrategy implements RateLimitingStrategy {
    // ...
    @Override
    public void registerCompletedRequest(ResultInfo resultInfo) {
        // ...
        if (resultInfo.getFailedMessages() > 0) {
            maxInFlightMessages = scalingStrategy.scaleDown(maxInFlightMessages);
        } else {
            maxInFlightMessages = scalingStrategy.scaleUp(maxInFlightMessages);
        }
    }
    
    public boolean shouldBlock(RequestInfo requestInfo) {
        return currentInFlightRequests >= maxInFlightRequests
                || (currentInFlightMessages + requestInfo.getBatchSize() > maxInFlightMessages);
    }
    // ...
}
```

### [Example 2] TokenBucketRateLimitingStrategy

The CongestionControlRateLimitingStrategy is rather aggressive, and relies on a robust server-side rate limiting strategy. In the event we don’t have a robust server-side rate limiting strategy, we can implement a client-side rate limiting strategy.

As an example, we can look at the [token bucket rate limiting strategy](https://en.wikipedia.org/wiki/Token_bucket). This strategy allows us to set the exact rate of the sink (e.g. requests per second, messages per second). If the limits are set correctly, we will avoid overloading the destination altogether.

In this strategy, we want to do the following:

* Implement a TokenBucket that has a given initial number of tokens (e.g. 10). These tokens refill at a given rate (e.g. 1 token per second).
* When preparing an async request, we check if the token bucket has sufficient tokens. If not, we postpone the request.

Let’s look at an example implementation:

```java
public class TokenBucketRateLimitingStrategy implements RateLimitingStrategy {
    
    private final Bucket bucket;

    public TokenBucketRateLimitingStrategy() {
        Refill refill = Refill.intervally(1, Duration.ofSeconds(1));
        Bandwidth limit = Bandwidth.classic(10, refill);
        this.bucket = Bucket4j.builder()
            .addLimit(limit)
            .build();
    }
    
    // ... (information methods not needed)
    
    @Override
    public boolean shouldBlock(RequestInfo requestInfo) {
        return bucket.tryConsume(requestInfo.getBatchSize());
    }
    
}
```

In the above example, we use the [Bucket4j](https://github.com/bucket4j/bucket4j) library’s Token Bucket implementation. We also map 1 message to 1 token. Since our token bucket has a size of 10 tokens and a refill rate of 1 token per second, we can be sure that we will not exceed a burst of 10 messages, and will also not exceed a constant rate of 1 message per second.

This would be useful if we know that our destination will failover ungracefully if a rate of 1 message per second is exceeded, or if we intentionally want to limit our sink’s throughput to provide higher bandwidth for other clients writing to the same destination.

## Specifying a custom RateLimitingStrategy

To specify a custom RateLimitingStrategy, we have to specify it in the AsyncSinkWriterConfiguration which is passed into the constructor of the AsyncSinkWriter. For example:

```java
class MyCustomSinkWriter<InputT> extends AsyncSinkWriter<InputT, MyCustomRequestEntry> {

    MyCustomSinkWriter(
        ElementConverter<InputT, MyCustomRequestEntry> elementConverter,
        Sink.InitContext context,
        Collection<BufferedRequestState<MyCustomRequestEntry>> states) {
            super(
                elementConverter,
                context,
                AsyncSinkWriterConfiguration.builder()
                    // ...
                    .setRateLimitingStrategy(new TokenBucketRateLimitingStrategy())
                    .build(),
                states);
    }
    
}
```

## Summary

From Apache Flink 1.16 we can customise the RateLimitingStrategy used to dynamically adjust the behaviour of the Async Sink at runtime. This allows users to tune their connector implementations based on specific use cases and needs, without having to understand the base sink’s low-level workings.

We hope this extension will be useful for you. If you have any feedback, feel free to reach out!

