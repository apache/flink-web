---
author: Matthias J. Sax
author-twitter: MatthiasJSax
date: "2015-12-11T10:00:00Z"
excerpt: In this blog post, we describe Flink's compatibility package for <a href="https://storm.apache.org">Apache
  Storm</a> that allows to embed Spouts (sources) and Bolts (operators) in a regular
  Flink streaming job. Furthermore, the compatibility package provides a Storm compatible
  API in order to execute whole Storm topologies with (almost) no code adaption.
title: 'Storm Compatibility in Apache Flink: How to run existing Storm topologies
  on Flink'
---

[Apache Storm](https://storm.apache.org) was one of the first distributed and scalable stream processing systems available in the open source space offering (near) real-time tuple-by-tuple processing semantics.
Initially released by the developers at Backtype in 2011 under the Eclipse open-source license, it became popular very quickly.
Only shortly afterwards, Twitter acquired Backtype.
Since then, Storm has been growing in popularity, is used in production at many big companies, and is the de-facto industry standard for big data stream processing.
In 2013, Storm entered the Apache incubator program, followed by its graduation to top-level in 2014.

Apache Flink is a stream processing engine that improves upon older technologies like Storm in several dimensions,
including [strong consistency guarantees]({{< param DocsBaseUrl >}}flink-docs-master/internals/stream_checkpointing.html) ("exactly once"),
a higher level [DataStream API]({{< param DocsBaseUrl >}}flink-docs-master/apis/streaming_guide.html),
support for [event time and a rich windowing system](http://flink.apache.org/news/2015/12/04/Introducing-windows.html),
as well as [superior throughput with competitive low latency](https://data-artisans.com/high-throughput-low-latency-and-exactly-once-stream-processing-with-apache-flink/).

While Flink offers several technical benefits over Storm, an existing investment on a codebase of applications developed for Storm often makes it difficult to switch engines.
For these reasons, as part of the Flink 0.10 release, Flink ships with a Storm compatibility package that allows users to:

* Run **unmodified** Storm topologies using Apache Flink benefiting from superior performance.
* **Embed** Storm code (spouts and bolts) as operators inside Flink DataStream programs.

Only minor code changes are required in order to submit the program to Flink instead of Storm.
This minimizes the work for developers to run existing Storm topologies while leveraging Apache Flink’s fast and robust execution engine.

We note that the Storm compatibility package is continuously improving and does not cover the full spectrum of Storm’s API.
However, it is powerful enough to cover many use cases.

## Executing Storm topologies with Flink

<center>
<img src="/img/blog/flink-storm.png" style="height:200px;margin:15px">
</center>

The easiest way to use the Storm compatibility package is by executing a whole Storm topology in Flink.
For this, you only need to replace the dependency `storm-core` by `flink-storm` in your Storm project and **change two lines of code** in your original Storm program.

The following example shows a simple Storm-Word-Count-Program that can be executed in Flink.
First, the program is assembled the Storm way without any code change to Spouts, Bolts, or the topology itself.

```java
// assemble topology, the Storm way
TopologyBuilder builder = new TopologyBuilder();
builder.setSpout("source", new StormFileSpout(inputFilePath));
builder.setBolt("tokenizer", new StormBoltTokenizer())
       .shuffleGrouping("source");
builder.setBolt("counter", new StormBoltCounter())
       .fieldsGrouping("tokenizer", new Fields("word"));
builder.setBolt("sink", new StormBoltFileSink(outputFilePath))
       .shuffleGrouping("counter");
```

In order to execute the topology, we need to translate it to a `FlinkTopology` and submit it to a local or remote Flink cluster, very similar to submitting the application to a Storm cluster.<sup><a href="#fn1" id="ref1">1</a></sup>

```java
// transform Storm topology to Flink program
// replaces: StormTopology topology = builder.createTopology();
FlinkTopology topology = FlinkTopology.createTopology(builder);

Config conf = new Config();
if(runLocal) {
	// use FlinkLocalCluster instead of LocalCluster
	FlinkLocalCluster cluster = FlinkLocalCluster.getLocalCluster();
	cluster.submitTopology("WordCount", conf, topology);
} else {
	// use FlinkSubmitter instead of StormSubmitter
	FlinkSubmitter.submitTopology("WordCount", conf, topology);
}
```

As a shorter Flink-style alternative that replaces the Storm-style submission code, you can also use context-based job execution:

```java
// transform Storm topology to Flink program (as above)
FlinkTopology topology = FlinkTopology.createTopology(builder);

// executes locally by default or remotely if submitted with Flink's command-line client
topology.execute()
```

After the code is packaged in a jar file (e.g., `StormWordCount.jar`), it can be easily submitted to Flink via

```
bin/flink run StormWordCount.jar
```

The used Spouts and Bolts as well as the topology assemble code is not changed at all!
Only the translation and submission step have to be changed to the Storm-API compatible Flink pendants.
This allows for minimal code changes and easy adaption to Flink.

### Embedding Spouts and Bolts in Flink programs

It is also possible to use Spouts and Bolts within a regular Flink DataStream program.
The compatibility package provides wrapper classes for Spouts and Bolts which are implemented as a Flink `SourceFunction` and `StreamOperator` respectively.
Those wrappers automatically translate incoming Flink POJO and `TupleXX` records into Storm's `Tuple` type and emitted `Values` back into either POJOs or `TupleXX` types for further processing by Flink operators.
As Storm is type agnostic, it is required to specify the output type of embedded Spouts/Bolts manually to get a fully typed Flink streaming program.

```java
// use regular Flink streaming environment
StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

// use Spout as source
DataStream<Tuple1<String>> source = 
  env.addSource(// Flink provided wrapper including original Spout
                new SpoutWrapper<String>(new FileSpout(localFilePath)), 
                // specify output type manually
                TypeExtractor.getForObject(new Tuple1<String>("")));
// FileSpout cannot be parallelized
DataStream<Tuple1<String>> text = source.setParallelism(1);

// further processing with Flink
DataStream<Tuple2<String,Integer> tokens = text.flatMap(new Tokenizer()).keyBy(0);

// use Bolt for counting
DataStream<Tuple2<String,Integer> counts =
  tokens.transform("Counter",
                   // specify output type manually
                   TypeExtractor.getForObject(new Tuple2<String,Integer>("",0))
                   // Flink provided wrapper including original Bolt
                   new BoltWrapper<String,Tuple2<String,Integer>>(new BoltCounter()));

// write result to file via Flink sink
counts.writeAsText(outputPath);

// start Flink job
env.execute("WordCount with Spout source and Bolt counter");
```

Although some boilerplate code is needed (we plan to address this soon!), the actual embedded Spout and Bolt code can be used unmodified.
We also note that the resulting program is fully typed, and type errors will be found by Flink's type extractor even if the original Spouts and Bolts are not.

## Outlook

The Storm compatibility package is currently in beta and undergoes continuous development.
We are currently working on providing consistency guarantees for stateful Bolts.
Furthermore, we want to provide a better API integration for embedded Spouts and Bolts by providing a "StormExecutionEnvironment" as a special extension of Flink's `StreamExecutionEnvironment`.
We are also investigating the integration of Storm's higher-level programming API Trident.

## Summary

Flink's compatibility package for Storm allows using unmodified Spouts and Bolts within Flink.
This enables you to even embed third-party Spouts and Bolts where the source code is not available.
While you can embed Spouts/Bolts in a Flink program and mix-and-match them with Flink operators, running whole topologies is the easiest way to get started and can be achieved with almost no code changes.

If you want to try out Flink's Storm compatibility package checkout our [Documentation]({{< param DocsBaseUrl >}}flink-docs-master/apis/streaming/storm_compatibility.html).

<hr />

<sup id="fn1">1. We confess, there are three lines changed compared to a Storm project <img class="emoji" style="width:16px;height:16px;align:absmiddle" src="/img/blog/smirk.png">---because the example covers local *and* remote execution. <a href="#ref1" title="Back to text.">↩</a></sup>

