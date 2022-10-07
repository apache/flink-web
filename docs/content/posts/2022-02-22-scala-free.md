---
authors:
- name: Seth Wiesman
  sjwiesman: null
  twitter: sjwiesman
date: "2022-02-22T00:00:00Z"
excerpt: Apache Flink's runtime is now Scala free, allowing users to leverage any
  Scala version in their user code - including Scala 3!
title: Scala Free in One Fifteen
---

Flink 1.15 is right around the corner, and among the many improvements is a Scala free classpath.
Users can now leverage the Java API from any Scala version, including Scala 3!

<figure style="margin-left:auto;margin-right:auto;display:block;padding-top: 20px;padding-bottom:20px;width:75%;">
  <img src="{{ site.baseurl }}/img/blog/2022-02-22-scala-free/flink-scala-3.jpeg">
  <figcaption style="padding-top: 10px;text-align:center"><b>Fig.1</b> Flink 1.15 Scala 3 Example</figcaption>
</figure>

This blog will discuss what has historically made supporting multiple Scala versions so complex, how we achieved this milestone, and the future of Scala in Apache Flink. 

<div class="alert alert-info">
<b>TLDR</b>: All Scala dependencies are now isolated to the <code>flink-scala</code> jar. 
To remove Scala from the user-code classpath, remove this jar from the lib directory of the Flink distribution.

<br><br>

<div class="highlight"><pre><code class="language-bash"><span class="nv">$ </span>rm flink-dist/lib/flink-scala*</code></pre></div>

</div>

{% toc %}

## The Classpath and Scala

If you have worked with a JVM-based application, you have probably heard the term classpath.
The classpath defines where the JVM will search for a given classfile when it needs to be loaded.
There may only be one instance of a classfile on each classpath, forcing any dependency Flink exposes onto users.
That is why the Flink community works hard to keep our classpath "clean" - or free of unnecessary dependencies.
We achieve this through a combination of [shaded dependencies](https://github.com/apache/flink-shaded), [child first class loading](https://nightlies.apache.org/flink/flink-docs-stable/docs/ops/debugging/debugging_classloading/#inverted-class-loading-and-classloader-resolution-order), and a [plugins abstraction](https://nightlies.apache.org/flink/flink-docs-stable/docs/deployment/filesystems/plugins/) for optional components.

The Apache Flink runtime is primarily written in Java but contains critical components that forced Scala on the default classpath.
And because Scala does not maintain binary compatibility across minor releases, this historically required cross-building components for all versions of Scala.
But due to many reasons - [breaking changes in the compiler](https://github.com/scala/scala/releases/tag/v2.12.8), [a new standard library](https://www.scala-lang.org/news/2.13.0), and [a reworked macro system](https://docs.scala-lang.org/scala3/guides/macros/macros.html) - this was easier said than done.

## Hiding Scala 

As mentioned above, Flink uses Scala in a few key components; Mesos integration, the serialization stack, RPC, and the table planner. 
Instead of removing these dependencies or finding ways to cross-build them, the community hid Scala.
It still exists in the codebase but no longer leaks into the user code classloader.

In 1.14, we took our first steps in hiding Scala from our users.
We dropped the support for Apache Mesos, partially implemented in Scala, which Kubernetes very much eclipsed in terms of adoption.
Next, we isolated our RPC system into a dedicated classloader, including Akka.
With these changes, the runtime itself no longer relied on Scala (hence why flink-runtime lost its Scala suffix), but Scala was still ever-present in the API layer.

These changes, and the ease with which we implemented them, started to make people wonder what else might be possible.
After all, we isolated Akka in less than a month, a task stuck in the backlog for years, thought to be too time-consuming. 

The next logical step was to decouple the DataStream / DataSet Java APIs from Scala.
This primarily entailed the few cleanups of some [test](https://issues.apache.org/jira/browse/FLINK-23967) [classes](https://issues.apache.org/jira/browse/FLINK-23968) but also the identifying of code paths that are only relevant for the Scala API. 
These paths were then migrated into the Scala API modules and only used if required.

For example, the [Kryo serializer](https://issues.apache.org/jira/browse/FLINK-24017), which we always extended to support certain Scala types, now only includes them if an application uses the Scala APIs. 

Finally, it was time to tackle the Table API, specifically the table planner, which contains 378,655 lines of Scala code at the time of writing.
The table planner provides parsing, planning, and optimization of SQL and Table API queries into highly optimized Java code.
It is the most extensive Scala codebase in Flink and it cannot be ported easily to Java.
Using what we learned from building dedicated classloaders for the RPC stack and conditional classloading for the serializers, we hid the planner behind an abstraction that does not expose any of its internals, including Scala. 

## The Future of Scala in Apache Flink 

While most of these changes happened behind the scenes, they resulted in one very user-facing change: removing many scala suffixes. You can find a list of all dependencies that lost their Scala suffix at the end of this post[^1][^2]. 

Additionally, changes to the Table API required several changes to the packaging and the distribution, which some power users relying on the planner internals might need to adapt to[^3].

Going forward, Flink will continue to support Scala packages for the DataStream and Table APIs compiled against Scala 2.12 while the Java API is now unlocked for users to leverage components from any Scala version.
We are already seeing new Scala 3 wrappers pop up in the community are excited to see how users leverage these tools in their streaming pipelines[^4][^5][^6]!

<hr>

[^1]: flink-cep, flink-clients, flink-connector-elasticsearch-base, flink-connector-elasticsearch6, flink-connector-elasticsearch7, flink-connector-gcp-pubsub, flink-connector-hbase-1.4, flink-connector-hbase-2.2, flink-connector-hbase-base, flink-connector-jdbc, flink-connector-kafka, flink-connector-kinesis, flink-connector-nifi, flink-connector-pulsar, flink-connector-rabbitmq, flink-connector-testing, flink-connector-twitter, flink-connector-wikiedits, flink-container, flink-dstl-dfs, flink-gelly, flink-hadoop-bulk, flink-kubernetes, flink-runtime-web, flink-sql-connector-elasticsearch6, flink-sql-connector-elasticsearch7, flink-sql-connector-hbase-1.4, flink-sql-connector-hbase-2.2, flink-sql-connector-kafka, flink-sql-connector-kinesis, flink-sql-connector-rabbitmq, flink-state-processor-api, flink-statebackend-rocksdb, flink-streaming-java, flink-table-api-java-bridge, flink-test-utils, flink-yarn, flink-table-runtime, flink-table-api-java-bridge
[^2]: https://nightlies.apache.org/flink/flink-docs-master/docs/dev/configuration/overview/#which-dependencies-do-you-need 
[^3]: https://nightlies.apache.org/flink/flink-docs-master/docs/dev/configuration/advanced/#anatomy-of-table-dependencies
[^4]: https://github.com/ariskk/flink4s 
[^5]: https://github.com/findify/flink-adt 
[^6]: https://github.com/sjwiesman/flink-scala-3 