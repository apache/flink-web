---
authors:
- Ingo Buerk: null
  name: Ingo Buerk
- Daisy Tsang: null
  name: Daisy Tsang
date: "2021-09-07T00:00:00Z"
title: 'Implementing a Custom Source Connector for Table API and SQL - Part One '
---

Part one of this tutorial will teach you how to build and run a custom source connector to be used with Table API and SQL, two high-level abstractions in Flink. The tutorial comes with a bundled [docker-compose](https://docs.docker.com/compose/) setup that lets you easily run the connector. You can then try it out with Flink’s SQL client.

{% toc %}

# Introduction

Apache Flink is a data processing engine that aims to keep [state](https://ci.apache.org/projects/flink/flink-docs-release-1.13/docs/ops/state/state_backends/) locally in order to do computations efficiently. However, Flink does not "own" the data but relies on external systems to ingest and persist data. Connecting to external data input (**sources**) and external data storage (**sinks**) is usually summarized under the term **connectors** in Flink.

Since connectors are such important components, Flink ships with [connectors for some popular systems](https://ci.apache.org/projects/flink/flink-docs-release-1.13/docs/connectors/table/overview/). But sometimes you may need to read in an uncommon data format and what Flink provides is not enough. This is why Flink also provides extension points for building custom connectors if you want to connect to a system that is not supported by an existing connector.

Once you have a source and a sink defined for Flink, you can use its declarative APIs (in the form of the [Table API and SQL](https://ci.apache.org/projects/flink/flink-docs-release-1.13/docs/dev/table/overview/)) to execute queries for data analysis.

The **Table API** provides more programmatic access while **SQL** is a more universal query language. It is named Table API because of its relational functions on tables: how to obtain a table, how to output a table, and how to perform query operations on the table.

In this two-part tutorial, you will explore some of these APIs and concepts by implementing your own custom source connector for reading in data from an email inbox. You will then use Flink to process emails through the [IMAP protocol](https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol).

Part one will focus on building a custom source connector and [part two](/2021/09/07/connector-table-sql-api-part2) will focus on integrating it.


# Prerequisites

This tutorial assumes that you have some familiarity with Java and objected-oriented programming.

You are encouraged to follow along with the code in this [repository](https://github.com/Airblader/blog-imap).

It would also be useful to have [docker-compose](https://docs.docker.com/compose/install/) installed on your system in order to use the script included in the repository that builds and runs the connector.


# Understand the infrastructure required for a connector

In order to create a connector which works with Flink, you need:

1. A _factory class_ (a blueprint for creating other objects from string properties) that tells Flink with which identifier (in this case, “imap”) our connector can be addressed, which configuration options it exposes, and how the connector can be instantiated. Since Flink uses the Java Service Provider Interface (SPI) to discover factories located in different modules, you will also need to add some configuration details.

2. The _table source_ object as a specific instance of the connector during the planning stage. It is responsible for back and forth communication with the optimizer during the planning stage and is like another factory for creating connector runtime implementation. There are also more advanced features, such as [abilities](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/connector/source/abilities/package-summary.html), that can be implemented to improve connector performance.

3. A _runtime implementation_ from the connector obtained during the planning stage. The runtime logic is implemented in Flink's core connector interfaces and does the actual work of producing rows of dynamic table data. The runtime instances are shipped to the Flink cluster.

Let us look at this sequence (factory class → table source → runtime implementation) in reverse order.

# Establish the runtime implementation of the connector

You first need to have a source connector which can be used in Flink's runtime system, defining how data goes in and how it can be executed in the cluster. There are a few different interfaces available for implementing the actual source of the data and have it be discoverable in Flink.

For complex connectors, you may want to implement the [Source interface](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/api/connector/source/Source.html) which gives you a lot of control. For simpler use cases, you can use the [SourceFunction interface](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/streaming/api/functions/source/SourceFunction.html). There are already a few different implementations of SourceFunction interfaces for common use cases such as the [FromElementsFunction](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/streaming/api/functions/source/FromElementsFunction.html) class and the [RichSourceFunction](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/streaming/api/functions/source/RichSourceFunction.html) class. You will use the latter.

<div class="note">
  <h5>Hint</h5>
  <p>The Source interface is the new abstraction whereas the SourceFunction interface is slowly phasing out.
     All connectors will eventually implement the Source interface.
  </p>
</div>

`RichSourceFunction` is a base class for implementing a data source that has access to context information and some lifecycle methods. There is a `run()` method inherited from the `SourceFunction` interface that you need to implement. It is invoked once and can be used to produce the data either once for a bounded result or within a loop for an unbounded stream.

For example, to create a bounded data source, you could implement this method so that it reads all existing emails and then closes. To create an unbounded source, you could only look at new emails coming in while the source is active. You can also combine these behaviors and expose them through configuration options.

When you first create the class and implement the interface, it should look something like this:

```java
import org.apache.flink.streaming.api.functions.source.RichSourceFunction;
import org.apache.flink.table.data.RowData;

public class ImapSource extends RichSourceFunction<RowData> {
  @Override
  public void run(SourceContext<RowData> ctx) throws Exception {}

  @Override
  public void cancel() {}
}
```

Note that internal data structures (`RowData`) are used because that is required by the table runtime.

In the `run()` method, you get access to a [context](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/streaming/api/functions/source/SourceFunction.SourceContext.html) object inherited from the SourceFunction interface, which is a bridge to Flink and allows you to output data. Since the source does not produce any data yet, the next step is to make it produce some static data in order to test that the data flows correctly:

```java
import org.apache.flink.streaming.api.functions.source.RichSourceFunction;
import org.apache.flink.table.data.GenericRowData;
import org.apache.flink.table.data.RowData;
import org.apache.flink.table.data.StringData;

public class ImapSource extends RichSourceFunction<RowData> {
  @Override
  public void run(SourceContext<RowData> ctx) throws Exception {
      ctx.collect(GenericRowData.of(
          StringData.fromString("Subject 1"),
          StringData.fromString("Hello, World!")
      ));
  }

  @Override
  public void cancel(){}
}
```

You do not need to implement the `cancel()` method yet because the source finishes instantly.

# Create and configure a dynamic table source for the data stream

[Dynamic tables](https://ci.apache.org/projects/flink/flink-docs-release-1.13/docs/dev/table/concepts/dynamic_tables/) are the core concept of Flink’s Table API and SQL support for streaming data and, like its name suggests, change over time. You can imagine a data stream being logically converted into a table that is constantly changing. For this tutorial, the emails that will be read in will be interpreted as a (source) table that is queryable. It can be viewed as a specific instance of a connector class.

You will now implement a [DynamicTableSource](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/connector/source/DynamicTableSource.html) interface. There are two types of dynamic table sources: [ScanTableSource](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/connector/source/ScanTableSource.html) and [LookupTableSource](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/connector/source/LookupTableSource.html). Scan sources read the entire table on the external system while lookup sources look for specific rows based on keys. The former will fit the use case of this tutorial.

This is what a scan table source implementation would look like:

```java
import org.apache.flink.table.connector.ChangelogMode;
import org.apache.flink.table.connector.source.DynamicTableSource;
import org.apache.flink.table.connector.source.ScanTableSource;
import org.apache.flink.table.connector.source.SourceFunctionProvider;

public class ImapTableSource implements ScanTableSource {
  @Override
  public ChangelogMode getChangelogMode() {
    return ChangelogMode.insertOnly();
  }

  @Override
  public ScanRuntimeProvider getScanRuntimeProvider(ScanContext ctx) {
    boolean bounded = true;
    final ImapSource source = new ImapSource();
    return SourceFunctionProvider.of(source, bounded);
  }

  @Override
  public DynamicTableSource copy() {
    return new ImapTableSource();
  }

  @Override
  public String asSummaryString() {
    return "IMAP Table Source";
  }
}
```

[ChangelogMode](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/connector/ChangelogMode.html) informs Flink of expected changes that the planner can expect during runtime. For example, whether the source produces only new rows, also updates to existing ones, or whether it can remove previously produced rows. Our source will only produce (`insertOnly()`) new rows.

[ScanRuntimeProvider](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/connector/source/ScanTableSource.ScanRuntimeProvider.html) allows Flink to create the actual runtime implementation you established previously (for reading the data). Flink even provides utilities like [SourceFunctionProvider](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/connector/source/SourceFunctionProvider.html) to wrap it into an instance of [SourceFunction](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/streaming/api/functions/source/SourceFunction.html), which is one of the base runtime interfaces.

You will also need to indicate whether the source is bounded or not. Currently, this is the case but you will have to change this later.

# Create a factory class for the connector so it can be discovered by Flink

You now have a working source connector, but in order to use it in Table API or SQL, it needs to be discoverable by Flink. You also need to define how the connector is addressable from a SQL statement when creating a source table.

You need to implement a [Factory](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/factories/Factory.html), which is a base interface that creates object instances from a list of key-value pairs in Flink's Table API and SQL.  A factory is uniquely identified by its class name and `factoryIdentifier()`.  For this tutorial, you will implement the more specific [DynamicTableSourceFactory](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/factories/DynamicTableSourceFactory.html), which allows you to configure a dynamic table connector as well as create `DynamicTableSource` instances.

```java
import java.util.HashSet;
import java.util.Set;
import org.apache.flink.configuration.ConfigOption;
import org.apache.flink.table.connector.source.DynamicTableSource;
import org.apache.flink.table.factories.DynamicTableSourceFactory;
import org.apache.flink.table.factories.FactoryUtil;

public class ImapTableSourceFactory implements DynamicTableSourceFactory {
  @Override
  public String factoryIdentifier() {
    return "imap";
  }

  @Override
  public Set<ConfigOption<?>> requiredOptions() {
    return new HashSet<>();
  }

  @Override
  public Set<ConfigOption<?>> optionalOptions() {
    return new HashSet<>();
  }

  @Override
  public DynamicTableSource createDynamicTableSource(Context ctx) {
    final FactoryUtil.TableFactoryHelper factoryHelper = FactoryUtil.createTableFactoryHelper(this, ctx);
    factoryHelper.validate();

    return new ImapTableSource();
  }
}
```

There are currently no configuration options but they can be added and also validated within the `createDynamicTableSource()` function. There is a small helper utility, [TableFactoryHelper](https://ci.apache.org/projects/flink/flink-docs-release-1.13/api/java/org/apache/flink/table/factories/FactoryUtil.TableFactoryHelper.html), that Flink offers which ensures that required options are set and that no unknown options are provided.

Finally, you need to register your factory for Java's Service Provider Interfaces (SPI). Classes that implement this interface can be discovered and should be added to this file `src/main/resources/META-INF/services/org.apache.flink.table.factories.Factory` with the fully classified class name of your factory:

```java
// if you created your class in the package org.example.acme, it should be named the following:
org.example.acme.ImapTableSourceFactory
```

# Test the custom connector

You should now have a working source connector. If you are following along with the provided repository, you can test it by running:

```sh
$ cd testing/
$ ./build_and_run.sh
```

This builds the connector, starts a Flink cluster, a [test email server](https://greenmail-mail-test.github.io/greenmail/) (which you will need later), and the [SQL client](https://ci.apache.org/projects/flink/flink-docs-release-1.13/docs/dev/table/sqlclient/) (which is bundled in the regular Flink distribution) for you. If successful, you should see the SQL CLI:

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/blog/2021-09-07-connector-table-sql-api/flink-sql-client.png" alt="Flink SQL Client"/>
	<p class="align-center">Flink SQL Client</p>
</div>

You can now create a table (with a "subject" column and a "content" column) with your connector by executing the following statement with the SQL client:

```sql
CREATE TABLE T (subject STRING, content STRING) WITH ('connector' = 'imap');

SELECT * FROM T;
```

Note that the schema must be exactly as written since it is currently hardcoded into the connector.

You should be able to see the static data you provided in your source connector earlier, which would be "Subject 1" and "Hello, World!".

Now that you have a working connector, the next step is to make it do something more useful than returning static data.


# Summary

In this tutorial, you looked into the infrastructure required for a connector and configured its runtime implementation to define how it should be executed in a cluster. You also defined a dynamic table source that reads the entire stream-converted table from the external source, made the connector discoverable by Flink through creating a factory class for it, and then tested it.

# Next Steps

In [part two](/2021/09/07/connector-table-sql-api-part2), you will integrate this connector with an email inbox through the IMAP protocol.
