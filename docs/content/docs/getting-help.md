---
title: Getting Help
bold: true
bookCollapseSection: false
weight: 11
---
<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

# Getting Help

## Having a Question?

The Apache Flink community answers many user questions every day. You can search for answers and advice in the archives or reach out to the community for help and guidance.

### User Mailing List

Many Flink users, contributors, and committers are subscribed to Flink's user mailing list. The user mailing list is a very good place to ask for help.

Before posting to the mailing list, you can search the mailing list archives for email threads that discuss issues related to yours on the following websites.

- [Apache Mailing List Archive](https://lists.apache.org/list.html?user@flink.apache.org)

If you'd like to post to the mailing list, you need to

1. subscribe to the mailing list by sending an email to `user-subscribe@flink.apache.org`,
2. confirm the subscription by replying to the confirmation email, and
3. send your email to `user@flink.apache.org`.

Please note that you won't receive a respose to your mail if you are not subscribed.

### Slack

You can join the [Apache Flink community on Slack.](https://join.slack.com/t/apache-flink/shared_invite/zt-1llkzbgyt-K2nNGGg88rfsDGLkT09Qzg)
After creating an account in Slack, don't forget to introduce yourself in #introductions.
Due to Slack limitations the invite link expires after 100 invites. If it is expired, please reach out to the [Dev mailing list]({{< ref "docs/community" >}}#mailing-lists).
Any existing Slack member can also invite anyone else to join.

### Stack Overflow

Many members of the Flink community are active on [Stack Overflow](https://stackoverflow.com). You can search for questions and answers or post your questions using the [\[apache-flink\]](https://stackoverflow.com/questions/tagged/apache-flink) tag.

## Found a Bug?

If you observe an unexpected behavior that might be caused by a bug, you can search for reported bugs or file a bug report in [Flink's JIRA](https://issues.apache.org/jira/browse/FLINK).

If you are unsure whether the unexpected behavior happend due to a bug or not, please post a question to the [user mailing list]({{< ref "docs/community" >}}#user-mailing-list).

## Got an Error Message?

Identifying the cause for an error message can be challenging. In the following, we list the most common error messages and explain how to handle them.

### I have a NotSerializableException.

Flink uses Java serialization to distribute copies of the application logic (the functions and operations you implement,
as well as the program configuration, etc.) to the parallel worker processes.
Because of that, all functions that you pass to the API must be serializable, as defined by
[java.io.Serializable](http://docs.oracle.com/javase/8/docs/api/java/io/Serializable.html).

If your function is an anonymous inner class, consider the following:

- make the function a standalone class, or a static inner class.
- use a Java 8 lambda function.

Is your function is already a static class, check the fields that you assign when you create
an instance of the class. One of the fields most likely holds a non-serializable type.

- In Java, use a `RichFunction` and initialize the problematic fields in the `open()` method.
- In Scala, you can often simply use “lazy val” to defer initialization until the distributed execution happens. This may come at a minor performance cost. You can naturally also use a `RichFunction` in Scala.

### Using the Scala API, I get an error about implicit values and evidence parameters.

This error means that the implicit value for the type information could not be provided.
Make sure that you have an `import org.apache.flink.streaming.api.scala._` (DataStream API) or an
`import org.apache.flink.api.scala._` (DataSet API) statement in your code.

If you are using Flink operations inside functions or classes that take
generic parameters, then a TypeInformation must be available for that parameter.
This can be achieved by using a context bound:

~~~scala
def myFunction[T: TypeInformation](input: DataSet[T]): DataSet[Seq[T]] = {
  input.reduceGroup( i => i.toSeq )
}
~~~

See [Type Extraction and Serialization]({{ site.docs-snapshot }}/dev/types_serialization.html) for
an in-depth discussion of how Flink handles types.

### I see a ClassCastException: X cannot be cast to X.

When you see an exception in the style `com.foo.X` cannot be cast to `com.foo.X` (or cannot be assigned to `com.foo.X`), it means that
multiple versions of the class `com.foo.X` have been loaded by different class loaders, and types of that class are attempted to be assigned to each other.

The reason for that can be:

- Class duplication through `child-first` classloading. That is an intended mechanism to allow users to use different versions of the same
  dependencies that Flink uses. However, if different copies of these classes move between Flink's core and the user application code, such an exception
  can occur. To verify that this is the reason, try setting `classloader.resolve-order: parent-first` in the configuration.
  If that makes the error disappear, please write to the mailing list to check if that may be a bug.

- Caching of classes from different execution attempts, for example by utilities like Guava’s Interners, or Avro's Schema cache.
  Try to not use interners, or reduce the scope of the interner/cache to make sure a new cache is created whenever a new task
  execution is started.

### I have an AbstractMethodError or NoSuchFieldError.

Such errors typically indicate a mix-up in some dependency version. That means a different version of a dependency (a library)
is loaded during the execution compared to the version that code was compiled against.

From Flink 1.4.0 on, dependencies in your application JAR file may have different versions compared to dependencies used
by Flink's core, or other dependencies in the classpath (for example from Hadoop). That requires `child-first` classloading
to be activated, which is the default.

If you see these problems in Flink 1.4+, one of the following may be true:

- You have a dependency version conflict within your application code. Make sure all your dependency versions are consistent.
- You are conflicting with a library that Flink cannot support via `child-first` classloading. Currently these are the
  Scala standard library classes, as well as Flink's own classes, logging APIs, and any Hadoop core classes.


### My DataStream application produces no output, even though events are going in.

If your DataStream application uses *Event Time*, check that your watermarks get updated. If no watermarks are produced,
event time windows might never trigger, and the application would produce no results.

You can check in Flink's web UI (watermarks section) whether watermarks are making progress.

### I see an exception reporting "Insufficient number of network buffers".

If you run Flink with a very high parallelism, you may need to increase the number of network buffers.

By default, Flink takes 10% of the JVM heap size for network buffers, with a minimum of 64MB and a maximum of 1GB.
You can adjust all these values via `taskmanager.network.memory.fraction`, `taskmanager.network.memory.min`, and
`taskmanager.network.memory.max`.

Please refer to the [Configuration Reference](https://nightlies.apache.org/flink/flink-docs-stable/docs/deployment/) for details.

### My job fails with various exceptions from the HDFS/Hadoop code. What can I do?

The most common cause for that is that the Hadoop version in Flink's classpath is different than the
Hadoop version of the cluster you want to connect to (HDFS / YARN).

The easiest way to fix that is to pick a Hadoop-free Flink version and simply export the Hadoop path and
classpath from the cluster.
