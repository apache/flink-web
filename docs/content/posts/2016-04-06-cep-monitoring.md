---
author: Till Rohrmann
author-twitter: stsffap
categories: news
date: "2016-04-06T10:00:00Z"
excerpt: In this blog post, we introduce Flink's new <a href="{{< param DocsBaseUrl >}}flink-docs-master/apis/streaming/libs/cep.html">CEP
  library</a> that allows you to do pattern matching on event streams. Through the
  example of monitoring a data center and generating alerts, we showcase the library's
  ease of use and its intuitive Pattern API.
title: Introducing Complex Event Processing (CEP) with Apache Flink
---

With the ubiquity of sensor networks and smart devices continuously collecting more and more data, we face the challenge to analyze an ever growing stream of data in near real-time. 
Being able to react quickly to changing trends or to deliver up to date business intelligence can be a decisive factor for a company’s success or failure. 
A key problem in real time processing is the detection of event patterns in data streams.

Complex event processing (CEP) addresses exactly this problem of matching continuously incoming events against a pattern. 
The result of a matching are usually complex events which are derived from the input events. 
In contrast to traditional DBMSs where a query is executed on stored data, CEP executes data on a stored query. 
All data which is not relevant for the query can be immediately discarded. 
The advantages of this approach are obvious, given that CEP queries are applied on a potentially infinite stream of data. 
Furthermore, inputs are processed immediately. 
Once the system has seen all events for a matching sequence, results are emitted straight away. 
This aspect effectively leads to CEP’s real time analytics capability.

Consequently, CEP’s processing paradigm drew significant interest and found application in a wide variety of use cases. 
Most notably, CEP is used nowadays for financial applications such as stock market trend and credit card fraud detection. 
Moreover, it is used in RFID-based tracking and monitoring, for example, to detect thefts in a warehouse where items are not properly checked out. 
CEP can also be used to detect network intrusion by specifying patterns of suspicious user behaviour.

Apache Flink with its true streaming nature and its capabilities for low latency as well as high throughput stream processing is a natural fit for CEP workloads. 
Consequently, the Flink community has introduced the first version of a new [CEP library]({{< param DocsBaseUrl >}}flink-docs-master/apis/streaming/libs/cep.html) with [Flink 1.0](http://flink.apache.org/news/2016/03/08/release-1.0.0.html). 
In the remainder of this blog post, we introduce Flink’s CEP library and we illustrate its ease of use through the example of monitoring a data center.

## Monitoring and alert generation for data centers

<center>
<img src="{{site.baseurl}}/img/blog/cep-monitoring.svg" style="width:600px;margin:15px">
</center>

Assume we have a data center with a number of racks. 
For each rack the power consumption and the temperature are monitored. 
Whenever such a measurement takes place, a new power or temperature event is generated, respectively. 
Based on this monitoring event stream, we want to detect racks that are about to overheat, and dynamically adapt their workload and cooling.

For this scenario we use a two staged approach. 
First, we monitor the temperature events. 
Whenever we see two consecutive events whose temperature exceeds a threshold value, we generate a temperature warning with the current average temperature. 
A temperature warning does not necessarily indicate that a rack is about to overheat. 
But whenever we see two consecutive warnings with increasing temperatures, then we want to issue an alert for this rack. 
This alert can then lead to countermeasures to cool the rack.

### Implementation with Apache Flink

First, we define the messages of the incoming monitoring event stream. 
Every monitoring message contains its originating rack ID. 
The temperature event additionally contains the current temperature and the power consumption event contains the current voltage. 
We model the events as POJOs:

```java
public abstract class MonitoringEvent {
    private int rackID;
    ...
}

public class TemperatureEvent extends MonitoringEvent {
    private double temperature;
    ...
}

public class PowerEvent extends MonitoringEvent {
    private double voltage;
    ...
}
```

Now we can ingest the monitoring event stream using one of Flink’s connectors (e.g. Kafka, RabbitMQ, etc.). 
This will give us a `DataStream<MonitoringEvent> inputEventStream` which we will use as the input for Flink’s CEP operator. 
But first, we have to define the event pattern to detect temperature warnings. 
The CEP library offers an intuitive [Pattern API]({{< param DocsBaseUrl >}}flink-docs-master/apis/streaming/libs/cep.html#the-pattern-api) to easily define these complex patterns.

Every pattern consists of a sequence of events which can have optional filter conditions assigned. 
A pattern always starts with a first event to which we will assign the name `“First Event”`.

```java
Pattern.<MonitoringEvent>begin("First Event");
```

This pattern will match every monitoring event. 
Since we are only interested in `TemperatureEvents` whose temperature is above a threshold value, we have to add an additional subtype constraint and a where clause:

```java
Pattern.<MonitoringEvent>begin("First Event")
    .subtype(TemperatureEvent.class)
    .where(evt -> evt.getTemperature() >= TEMPERATURE_THRESHOLD);
```

As stated before, we want to generate a `TemperatureWarning` if and only if we see two consecutive `TemperatureEvents` for the same rack whose temperatures are too high. 
The Pattern API offers the `next` call which allows us to add a new event to our pattern. 
This event has to follow directly the first matching event in order for the whole pattern to match.

```java
Pattern<MonitoringEvent, ?> warningPattern = Pattern.<MonitoringEvent>begin("First Event")
    .subtype(TemperatureEvent.class)
    .where(evt -> evt.getTemperature() >= TEMPERATURE_THRESHOLD)
    .next("Second Event")
    .subtype(TemperatureEvent.class)
    .where(evt -> evt.getTemperature() >= TEMPERATURE_THRESHOLD)
    .within(Time.seconds(10));
```

The final pattern definition also contains the `within` API call which defines that two consecutive `TemperatureEvents` have to occur within a time interval of 10 seconds for the pattern to match. 
Depending on the time characteristic setting, this can either be processing, ingestion or event time.

Having defined the event pattern, we can now apply it on the `inputEventStream`.

```java
PatternStream<MonitoringEvent> tempPatternStream = CEP.pattern(
    inputEventStream.keyBy("rackID"),
    warningPattern);
```

Since we want to generate our warnings for each rack individually, we `keyBy` the input event stream by the `“rackID”` POJO field. 
This enforces that matching events of our pattern will all have the same rack ID.

The `PatternStream<MonitoringEvent>` gives us access to successfully matched event sequences. 
They can be accessed using the `select` API call. 
The `select` API call takes a `PatternSelectFunction` which is called for every matching event sequence. 
The event sequence is provided as a `Map<String, MonitoringEvent>` where each `MonitoringEvent` is identified by its assigned event name. 
Our pattern select function generates for each matching pattern a `TemperatureWarning` event.

```java
public class TemperatureWarning {
    private int rackID;
    private double averageTemperature;
    ...
}

DataStream<TemperatureWarning> warnings = tempPatternStream.select(
    (Map<String, MonitoringEvent> pattern) -> {
        TemperatureEvent first = (TemperatureEvent) pattern.get("First Event");
        TemperatureEvent second = (TemperatureEvent) pattern.get("Second Event");

        return new TemperatureWarning(
            first.getRackID(), 
            (first.getTemperature() + second.getTemperature()) / 2);
    }
);
```

Now we have generated a new complex event stream `DataStream<TemperatureWarning> warnings` from the initial monitoring event stream. 
This complex event stream can again be used as the input for another round of complex event processing. 
We use the `TemperatureWarnings` to generate `TemperatureAlerts` whenever we see two consecutive `TemperatureWarnings` for the same rack with increasing temperatures. 
The `TemperatureAlerts` have the following definition:

```java
public class TemperatureAlert {
    private int rackID;
    ...
}
```

At first, we have to define our alert event pattern:

```java
Pattern<TemperatureWarning, ?> alertPattern = Pattern.<TemperatureWarning>begin("First Event")
    .next("Second Event")
    .within(Time.seconds(20));
```

This definition says that we want to see two `TemperatureWarnings` within 20 seconds. 
The first event has the name `“First Event”` and the second consecutive event has the name `“Second Event”`. 
The individual events don’t have a where clause assigned, because we need access to both events in order to decide whether the temperature is increasing. 
Therefore, we apply the filter condition in the select clause. 
But first, we obtain again a `PatternStream`.

```java
PatternStream<TemperatureWarning> alertPatternStream = CEP.pattern(
    warnings.keyBy("rackID"),
    alertPattern);
```

Again, we `keyBy` the warnings input stream by the `"rackID"` so that we generate our alerts for each rack individually. 
Next we apply the `flatSelect` method which will give us access to matching event sequences and allows us to output an arbitrary number of complex events. 
Thus, we will only generate a `TemperatureAlert` if and only if the temperature is increasing.

```java
DataStream<TemperatureAlert> alerts = alertPatternStream.flatSelect(
    (Map<String, TemperatureWarning> pattern, Collector<TemperatureAlert> out) -> {
        TemperatureWarning first = pattern.get("First Event");
        TemperatureWarning second = pattern.get("Second Event");

        if (first.getAverageTemperature() < second.getAverageTemperature()) {
            out.collect(new TemperatureAlert(first.getRackID()));
        }
    });
```

The `DataStream<TemperatureAlert> alerts` is the data stream of temperature alerts for each rack. 
Based on these alerts we can now adapt the workload or cooling for overheating racks.

The full source code for the presented example as well as an example data source which generates randomly monitoring events can be found in [this repository](https://github.com/tillrohrmann/cep-monitoring).

## Conclusion

In this blog post we have seen how easy it is to reason about event streams using Flink’s CEP library. 
Using the example of monitoring and alert generation for a data center, we have implemented a short program which notifies us when a rack is about to overheat and potentially to fail.

In the future, the Flink community will further extend the CEP library’s functionality and expressiveness. 
Next on the road map is support for a regular expression-like pattern specification, including Kleene star, lower and upper bounds, and negation. 
Furthermore, it is planned to allow the where-clause to access fields of previously matched events. 
This feature will allow to prune unpromising event sequences early.

<hr />

*Note:* The example code requires Flink 1.0.1 or higher.

