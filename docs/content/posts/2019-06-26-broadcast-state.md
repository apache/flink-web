---
authors:
- fabian: null
  name: Fabian Hueske
  twitter: fhueske
date: "2019-06-26T12:00:00Z"
excerpt: Apache Flink has multiple types of operator state, one of which is called
  Broadcast State. In this post, we explain what Broadcast State is, and show an example
  of how it can be applied to an application that evaluates dynamic patterns on an
  event stream.
title: A Practical Guide to Broadcast State in Apache Flink
---

Since version 1.5.0, Apache Flink features a new type of state which is called Broadcast State. In this post, we explain what Broadcast State is, and show an example of how it can be applied to an application that evaluates dynamic patterns on an event stream. We walk you through the processing steps and the source code to implement this application in practice.

## What is Broadcast State?

The Broadcast State can be used to combine and jointly process two streams of events in a specific way. The events of the first stream are broadcasted to all parallel instances of an operator, which maintains them as state. The events of the other stream are not broadcasted but sent to individual instances of the same operator and processed together with the events of the broadcasted stream. 
The new broadcast state is a natural fit for applications that need to join a low-throughput and a high-throughput stream or need to dynamically update their processing logic. We will use a concrete example of the latter use case to explain the broadcast state and show its API in more detail in the remainder of this post.

## Dynamic Pattern Evaluation with Broadcast State

Imagine an e-commerce website that captures the interactions of all users as a stream of user actions. The company that operates the website is interested in analyzing the interactions to increase revenue, improve the user experience, and detect and prevent malicious behavior. 
The website implements a streaming application that detects a pattern on the stream of user events. However, the company wants to avoid modifying and redeploying the application every time the pattern changes. Instead, the application ingests a second stream of patterns and updates its active pattern when it receives a new pattern from the pattern stream. In the following, we discuss this application step-by-step and show how it leverages the broadcast state feature in Apache Flink.

<center>
<img src="{{ site.baseurl }}/img/blog/broadcastState/fig1.png" width="600px" alt="Broadcast State in Apache Flink."/>
</center>
<br>

Our example application ingests two data streams. The first stream provides user actions on the website and is illustrated on the top left side of the above figure. A user interaction event consists of the type of the action (user login, user logout, add to cart, or complete payment) and the id of the user, which is encoded by color. The user action event stream in our illustration contains a logout action of User 1001 followed by a payment-complete event for User 1003, and an “add-to-cart” action of User 1002.

The second stream provides action patterns that the application will evaluate. A pattern consists of two consecutive actions. In the figure above, the pattern stream contains the following two:

* Pattern #1: A user logs in and immediately logs out without browsing additional pages on the e-commerce website. 
* Pattern #2: A user adds an item to the shopping cart and logs out without completing the purchase.


Such patterns help a business in better analyzing user behavior, detecting malicious actions, and improving the website experience. For example, in the case of items being added to a shopping cart with no follow up purchase, the website team can take appropriate actions to understand better the reasons why users don’t complete a purchase and initiate specific programs to improve the website conversion (such as providing discount codes, limited free shipping offers etc.)

On the right-hand side, the figure shows three parallel tasks of an operator that ingest the pattern and user action streams, evaluate the patterns on the action stream, and emit pattern matches downstream. For the sake of simplicity, the operator in our example only evaluates a single pattern with exactly two subsequent actions. The currently active pattern is replaced when a new pattern is received from the pattern stream. In principle, the operator could also be implemented to evaluate more complex patterns or multiple patterns concurrently which could be individually added or removed.

We will describe how the pattern matching application processes the user action and pattern streams.

<center>
<img src="{{ site.baseurl }}/img/blog/broadcastState/fig2.png" width="600px" alt="Broadcast State in Apache Flink."/>
</center>
<br>

First a pattern is sent to the operator. The pattern is broadcasted to all three parallel tasks of the operator. The tasks store the pattern in their broadcast state. Since the broadcast state should only be updated using broadcasted data, the state of all tasks is always expected to be the same.

<center>
<img src="{{ site.baseurl }}/img/blog/broadcastState/fig3.png" width="600px" alt="Broadcast State in Apache Flink."/>
</center>
<br>

Next, the first user actions are partitioned on the user id and shipped to the operator tasks. The partitioning ensures that all actions of the same user are processed by the same task. The figure above shows the state of the application after the first pattern and the first three action events were consumed by the operator tasks.

When a task receives a new user action, it evaluates the currently active pattern by looking at the user’s latest and previous actions. For each user, the operator stores the previous action in the keyed state. Since the tasks in the figure above only received a single action for each user so far (we just started the application), the pattern does not need to be evaluated. Finally, the previous action in the user’s keyed state is updated to the latest action, to be able to look it up when the next action of the same user arrives. 

<center>
<img src="{{ site.baseurl }}/img/blog/broadcastState/fig4.png" width="600px" alt="Broadcast State in Apache Flink."/>
</center>
<br>

After the first three actions are processed, the next event, the logout action of User 1001, is shipped to the task that processes the events of User 1001. When the task receives the actions, it looks up the current pattern from the broadcast state and the previous action of User 1001. Since the pattern matches both actions, the task emits a pattern match event. Finally, the task updates its keyed state by overriding the previous event with the latest action.

<center>
<img src="{{ site.baseurl }}/img/blog/broadcastState/fig5.png" width="600px" alt="Broadcast State in Apache Flink."/>
</center>
<br>

When a new pattern arrives in the pattern stream, it is broadcasted to all tasks and each task updates its broadcast state by replacing the current pattern with the new one.

<center>
<img src="{{ site.baseurl }}/img/blog/broadcastState/fig6.png" width="600px" alt="Broadcast State in Apache Flink."/>
</center>
<br>

Once the broadcast state is updated with a new pattern, the matching logic continues as before, i.e., user action events are partitioned by key and evaluated by the responsible task.


## How to Implement an Application with Broadcast State?

Until now, we conceptually discussed the application and explained how it uses broadcast state to evaluate dynamic patterns over event streams. Next, we’ll show how to implement the example application with Flink’s DataStream API and the broadcast state feature.

Let’s start with the input data of the application. We have two data streams, actions, and patterns. At this point, we don’t really care where the streams come from. The streams could be ingested from Apache Kafka or Kinesis or any other system. Action and Pattern are Pojos with two fields each:

```java
DataStream<Action> actions = ???
DataStream<Pattern> patterns = ???
```

`Action` and `Pattern` are Pojos with two fields each:

- `Action: Long userId, String action`

- `Pattern: String firstAction, String secondAction`

As a first step, we key the action stream on the `userId` attribute.

```java
KeyedStream<Action, Long> actionsByUser = actions
  .keyBy((KeySelector<Action, Long>) action -> action.userId);
```

Next, we prepare the broadcast state. Broadcast state is always represented as `MapState`, the most versatile state primitive that Flink provides.

```java
MapStateDescriptor<Void, Pattern> bcStateDescriptor = 
  new MapStateDescriptor<>("patterns", Types.VOID, Types.POJO(Pattern.class));
```

Since our application only evaluates and stores a single `Pattern` at a time, we configure the broadcast state as a `MapState` with key type `Void` and value type `Pattern`. The `Pattern` is always stored in the `MapState` with `null` as key.

```java
BroadcastStream<Pattern> bcedPatterns = patterns.broadcast(bcStateDescriptor);
```
Using the `MapStateDescriptor` for the broadcast state, we apply the `broadcast()` transformation on the patterns stream and receive a `BroadcastStream bcedPatterns`.

```java
DataStream<Tuple2<Long, Pattern>> matches = actionsByUser
 .connect(bcedPatterns)
 .process(new PatternEvaluator());
```

After we obtained the keyed `actionsByUser` stream and the broadcasted `bcedPatterns` stream, we `connect()` both streams and apply a `PatternEvaluator` on the connected streams. `PatternEvaluator` is a custom function that implements the `KeyedBroadcastProcessFunction` interface. It applies the pattern matching logic that we discussed before and emits `Tuple2<Long, Pattern>` records which contain the user id and the matched pattern.

```java
public static class PatternEvaluator
    extends KeyedBroadcastProcessFunction<Long, Action, Pattern, Tuple2<Long, Pattern>> {
 
  // handle for keyed state (per user)
  ValueState<String> prevActionState;
  // broadcast state descriptor
  MapStateDescriptor<Void, Pattern> patternDesc;
 
  @Override
  public void open(Configuration conf) {
    // initialize keyed state
    prevActionState = getRuntimeContext().getState(
      new ValueStateDescriptor<>("lastAction", Types.STRING));
    patternDesc = 
      new MapStateDescriptor<>("patterns", Types.VOID, Types.POJO(Pattern.class));
  }

  /**
   * Called for each user action.
   * Evaluates the current pattern against the previous and
   * current action of the user.
   */
  @Override
  public void processElement(
     Action action, 
     ReadOnlyContext ctx, 
     Collector<Tuple2<Long, Pattern>> out) throws Exception {
   // get current pattern from broadcast state
   Pattern pattern = ctx
     .getBroadcastState(this.patternDesc)
     // access MapState with null as VOID default value
     .get(null);
   // get previous action of current user from keyed state
   String prevAction = prevActionState.value();
   if (pattern != null && prevAction != null) {
     // user had an action before, check if pattern matches
     if (pattern.firstAction.equals(prevAction) && 
         pattern.secondAction.equals(action.action)) {
       // MATCH
       out.collect(new Tuple2<>(ctx.getCurrentKey(), pattern));
     }
   }
   // update keyed state and remember action for next pattern evaluation
   prevActionState.update(action.action);
 }

 /**
  * Called for each new pattern.
  * Overwrites the current pattern with the new pattern.
  */
 @Override
 public void processBroadcastElement(
     Pattern pattern, 
     Context ctx, 
     Collector<Tuple2<Long, Pattern>> out) throws Exception {
   // store the new pattern by updating the broadcast state
   BroadcastState<Void, Pattern> bcState = ctx.getBroadcastState(patternDesc);
   // storing in MapState with null as VOID default value
   bcState.put(null, pattern);
 }
}
```

The `KeyedBroadcastProcessFunction` interface provides three methods to process records and emit results.

- `processBroadcastElement()` is called for each record of the broadcasted stream. In our `PatternEvaluator` function, we simply put the received `Pattern` record in to the broadcast state using the `null` key (remember, we only store a single pattern in the `MapState`).
- `processElement()` is called for each record of the keyed stream. It provides read-only access to the broadcast state to prevent modification that result in different broadcast states across the parallel instances of the function. The `processElement()` method of the `PatternEvaluator` retrieves the current pattern from the broadcast state and the previous action of the user from the keyed state. If both are present, it checks whether the previous and current action match with the pattern and emits a pattern match record if that is the case. Finally, it updates the keyed state to the current user action.
- `onTimer()` is called when a previously registered timer fires. Timers can be registered in the `processElement` method and are used to perform computations or to clean up state in the future. We did not implement this method in our example to keep the code concise. However, it could be used to remove the last action of a user when the user was not active for a certain period of time to avoid growing state due to inactive users.

You might have noticed the context objects of the `KeyedBroadcastProcessFunction`’s processing method. The context objects give access to additional functionality such as:

- The broadcast state (read-write or read-only, depending on the method), 
- A `TimerService`, which gives access to the record’s timestamp, the current watermark, and which can register timers,
- The current key (only available in `processElement()`), and
- A method to apply a function the keyed state of each registered key (only available in `processBroadcastElement()`)

The `KeyedBroadcastProcessFunction` has full access to Flink state and time features just like any other ProcessFunction and hence can be used to implement sophisticated application logic. Broadcast state was designed to be a versatile feature that adapts to different scenarios and use cases. Although we only discussed a fairly simple and restricted application, you can use broadcast state in many ways to implement the requirements of your application. 

## Conclusion

In this blog post, we walked you through an example application to explain what Apache Flink’s broadcast state is and how it can be used to evaluate dynamic patterns on event streams. We’ve also discussed the API and showed the source code of our example application. 

We invite you to check the [documentation]({{ site.DOCS_BASE_URL }}flink-docs-stable/dev/stream/state/broadcast_state.html) of this feature and provide feedback or suggestions for further improvements through our [mailing list](http://mail-archives.apache.org/mod_mbox/flink-community/).
