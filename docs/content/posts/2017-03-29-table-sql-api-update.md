---
author: Timo Walther
author-twitter: twalthr
categories: news
date: "2017-03-29T12:00:00Z"
excerpt: <p>Broadening the user base and unifying batch & streaming with relational
  APIs</p>
title: 'From Streams to Tables and Back Again: An Update on Flink''s Table & SQL API'
---
Stream processing can deliver a lot of value. Many organizations have recognized the benefit of managing large volumes of data in real-time, reacting quickly to trends, and providing customers with live services at scale. Streaming applications with well-defined business logic can deliver a competitive advantage.

Flink's [DataStream]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/datastream_api.html) abstraction is a powerful API which lets you flexibly define both basic and complex streaming pipelines. Additionally, it offers low-level operations such as [Async IO]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/stream/asyncio.html) and [ProcessFunctions]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/stream/process_function.html). However, many users do not need such a deep level of flexibility. They need an API which quickly solves 80% of their use cases where simple tasks can be defined using little code.

To deliver the power of stream processing to a broader set of users, the Apache Flink community is developing APIs that provide simpler abstractions and more concise syntax so that users can focus on their business logic instead of advanced streaming concepts. Along with other APIs (such as [CEP]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/libs/cep.html) for complex event processing on streams), Flink offers a relational API that aims to unify stream and batch processing: the [Table & SQL API]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/table_api.html), often referred to as the Table API.

Recently, contributors working for companies such as Alibaba, Huawei, data Artisans, and more decided to further develop the Table API. Over the past year, the Table API has been rewritten entirely. Since Flink 1.1, its core has been based on [Apache Calcite](http://calcite.apache.org/), which parses SQL and optimizes all relational queries. Today, the Table API can address a wide range of use cases in both batch and stream environments with unified semantics.

This blog post summarizes the current status of Flink’s Table API and showcases some of the recently-added features in Apache Flink. Among the features presented here are the unified access to batch and streaming data, data transformation, and window operators.
The following paragraphs are not only supposed to give you a general overview of the Table API, but also to illustrate the potential of relational APIs in the future.

Because the Table API is built on top of Flink’s core APIs, [DataStreams]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/datastream_api.html) and [DataSets]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/batch/index.html) can be converted to a Table and vice-versa without much overhead. Hereafter, we show how to create tables from different sources and specify programs that can be executed locally or in a distributed setting. In this post, we will use the Scala version of the Table API, but there is also a Java version as well as a SQL API with an equivalent set of features.

## Data Transformation and ETL

A common task in every data processing pipeline is importing data from one or multiple systems, applying some transformations to it, then exporting the data to another system. The Table API can help to manage these recurring tasks. For reading data, the API provides a set of ready-to-use `TableSources` such as a `CsvTableSource` and `KafkaTableSource`, however, it also allows the implementation of custom `TableSources` that can hide configuration specifics (e.g. watermark generation) from users who are less familiar with streaming concepts.

Let’s assume we have a CSV file that stores customer information. The values are delimited by a “\|”-character and contain a customer identifier, name, timestamp of the last update, and preferences encoded in a comma-separated key-value string:

    42|Bob Smith|2016-07-23 16:10:11|color=12,length=200,size=200

The following example illustrates how to read a CSV file and perform some data cleansing before converting it to a regular DataStream program.

```scala
// set up execution environment
val env = StreamExecutionEnvironment.getExecutionEnvironment
val tEnv = TableEnvironment.getTableEnvironment(env)

// configure table source
val customerSource = CsvTableSource.builder()
  .path("/path/to/customer_data.csv")
  .ignoreFirstLine()
  .fieldDelimiter("|")
  .field("id", Types.LONG)
  .field("name", Types.STRING)
  .field("last_update", Types.TIMESTAMP)
  .field("prefs", Types.STRING)
  .build()

// name your table source
tEnv.registerTableSource("customers", customerSource)

// define your table program
val table = tEnv
  .scan("customers")
  .filter('name.isNotNull && 'last_update > "2016-01-01 00:00:00".toTimestamp)
  .select('id, 'name.lowerCase(), 'prefs)

// convert it to a data stream
val ds = table.toDataStream[Row]

ds.print()
env.execute()
```

The Table API comes with a large set of built-in functions that make it easy to specify  business logic using a language integrated query (LINQ) syntax. In the example above, we filter out customers with invalid names and only select those that updated their preferences recently. We convert names to lowercase for normalization. For debugging purposes, we convert the table into a DataStream and print it.

The `CsvTableSource` supports both batch and stream environments. If the programmer wants to execute the program above in a batch application, all he or she has to do is to replace the environment via `ExecutionEnvironment` and change the output conversion from `DataStream` to `DataSet`. The Table API program itself doesn’t change.

In the example, we converted the table program to a data stream of `Row` objects. However, we are not limited to row data types. The Table API supports all types from the underlying APIs such as Java and Scala Tuples, Case Classes, POJOs, or generic types that are serialized using Kryo. Let’s assume that we want to have regular object (POJO) with the following format instead of generic rows:

```scala
class Customer {
  var id: Int = _
  var name: String = _
  var update: Long = _
  var prefs: java.util.Properties = _
}
```
We can use the following table program to convert the CSV file into Customer objects. Flink takes care of creating objects and mapping fields for us.

```scala
val ds = tEnv
  .scan("customers")
  .select('id, 'name, 'last_update as 'update, parseProperties('prefs) as 'prefs)
  .toDataStream[Customer]
```

You might have noticed that the query above uses a function to parse the preferences field. Even though Flink’s Table API is shipped with a large set of built-in functions, is often necessary to define custom user-defined scalar functions. In the above example we use a user-defined function `parseProperties`. The following code snippet shows how easily we can implement a scalar function.

```scala
object parseProperties extends ScalarFunction {
  def eval(str: String): Properties = {
    val props = new Properties()
    str
      .split(",")
      .map(\_.split("="))
      .foreach(split => props.setProperty(split(0), split(1)))
    props
  }
}
```

Scalar functions can be used to deserialize, extract, or convert values (and more). By overwriting the `open()` method we can even have access to runtime information such as distributed cached files or metrics. Even the `open()` method is only called once during the runtime’s [task lifecycle]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/internals/task_lifecycle.html).

## Unified Windowing for Static and Streaming Data

Another very common task, especially when working with continuous data, is the definition of windows to split a stream into pieces of finite size, over which we can apply computations. At the moment, the Table API supports three types of windows: sliding windows, tumbling windows, and session windows (for general definitions of the different types of windows, we recommend [Flink’s documentation]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/windows.html)). All three window types work on [event or processing time]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/event_time.html). Session windows can be defined over time intervals, sliding and tumbling windows can be defined over time intervals or a number of rows.

Let’s assume that our customer data from the example above is an event stream of updates generated whenever the customer updated his or her preferences. We assume that events come from a TableSource that has assigned timestamps and watermarks. The definition of a window happens again in a LINQ-style fashion. The following example could be used to count the updates to the preferences during one day.

```scala
table
  .window(Tumble over 1.day on 'rowtime as 'w)
  .groupBy('id, 'w)
  .select('id, 'w.start as 'from, 'w.end as 'to, 'prefs.count as 'updates)
```

By using the `on()` parameter, we can specify whether the window is supposed to work on event-time or not. The Table API assumes that timestamps and watermarks are assigned correctly when using event-time. Elements with timestamps smaller than the last received watermark are dropped. Since the extraction of timestamps and generation of watermarks depends on the data source and requires some deeper knowledge of their origin, the TableSource or the upstream DataStream is usually responsible for assigning these properties.

The following code shows how to define other types of windows:

```scala
// using processing-time
table.window(Tumble over 100.rows as 'manyRowWindow)
// using event-time
table.window(Session withGap 15.minutes on 'rowtime as 'sessionWindow)
table.window(Slide over 1.day every 1.hour on 'rowtime as 'dailyWindow)
```

Since batch is just a special case of streaming (where a batch happens to have a defined start and end point), it is also possible to apply all of these windows in a batch execution environment. Without any modification of the table program itself, we can run the code on a DataSet given that we specified a column named “rowtime”. This is particularly interesting if we want to compute exact results from time-to-time, so that late events that are heavily out-of-order can be included in the computation.

At the moment, the Table API only supports so-called “group windows” that also exist in the DataStream API. Other windows such as SQL’s OVER clause windows are in development and [planned for Flink 1.3](https://cwiki.apache.org/confluence/display/FLINK/FLIP-11%3A+Table+API+Stream+Aggregations).

In order to demonstrate the expressiveness and capabilities of the API, here’s a snippet with a more advanced example of an exponentially decaying moving average over a sliding window of one hour which returns aggregated results every second. The table program weighs recent orders more heavily than older orders. This example is borrowed from [Apache Calcite](https://calcite.apache.org/docs/stream.html#hopping-windows) and shows what will be possible in future Flink releases for both the Table API and SQL.

```scala
table
  .window(Slide over 1.hour every 1.second as 'w)
  .groupBy('productId, 'w)
  .select(
    'w.end,
    'productId,
    ('unitPrice * ('rowtime - 'w.start).exp() / 1.hour).sum / (('rowtime - 'w.start).exp() / 1.hour).sum)
```

## User-defined Table Functions

[User-defined table functions]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/dev/table_api.html#user-defined-table-functions) were added in Flink 1.2. These can be quite useful for table columns containing non-atomic values which need to be extracted and mapped to separate fields before processing. Table functions take an arbitrary number of scalar values and allow for returning an arbitrary number of rows as output instead of a single value, similar to a flatMap function in the DataStream or DataSet API. The output of a table function can then be joined with the original row in the table by using either a left-outer join or cross join.

Using the previously-mentioned customer table, let’s assume we want to produce a table that contains the color and size preferences as separate columns. The table program would look like this:

```scala
// create an instance of the table function
val extractPrefs = new PropertiesExtractor()

// derive rows and join them with original row
table
  .join(extractPrefs('prefs) as ('color, 'size))
  .select('id, 'username, 'color, 'size)
```

The `PropertiesExtractor` is a user-defined table function that extracts the color and size. We are not interested in customers that haven’t set these preferences and thus don’t emit anything if both properties are not present in the string value. Since we are using a (cross) join in the program, customers without a result on the right side of the join will be filtered out.

```scala
class PropertiesExtractor extends TableFunction[Row] {
  def eval(prefs: String): Unit = {
    // split string into (key, value) pairs
    val pairs = prefs
      .split(",")
      .map { kv =>
        val split = kv.split("=")
        (split(0), split(1))
      }

    val color = pairs.find(\_.\_1 == "color").map(\_.\_2)
    val size = pairs.find(\_.\_1 == "size").map(\_.\_2)

    // emit a row if color and size are specified
    (color, size) match {
      case (Some(c), Some(s)) => collect(Row.of(c, s))
      case _ => // skip
    }
  }

  override def getResultType = new RowTypeInfo(Types.STRING, Types.STRING)
}
```

## Conclusion

There is significant interest in making streaming more accessible and easier to use. Flink’s Table API development is happening quickly, and we believe that soon, you will be able to implement large batch or streaming pipelines using purely relational APIs or even convert existing Flink jobs to table programs. The Table API is already a very useful tool since you can work around limitations and missing features at any time by switching back-and-forth between the DataSet/DataStream abstraction to the Table abstraction.

Contributions like support of Apache Hive UDFs, external catalogs, more TableSources, additional windows, and more operators will make the Table API an even more useful tool. Particularly, the upcoming introduction of Dynamic Tables, which is worth a blog post of its own, shows that even in 2017, new relational APIs open the door to a number of possibilities.

Try it out, or even better, join the design discussions on the [mailing lists](http://flink.apache.org/community.html#mailing-lists) and [JIRA](https://issues.apache.org/jira/browse/FLINK/?selectedTab=com.atlassian.jira.jira-projects-plugin:summary-panel) and start contributing!
