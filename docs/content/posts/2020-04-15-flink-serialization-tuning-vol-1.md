---
authors:
- Nico Kruber: null
  name: Nico Kruber
date: "2020-04-15T08:00:00Z"
excerpt: Serialization is a crucial element of your Flink job. This article is the
  first in a series of posts that will highlight Flink’s serialization stack, and
  looks at the different ways Flink can serialize your data types.
title: 'Flink Serialization Tuning Vol. 1: Choosing your Serializer — if you can'
---

Almost every Flink job has to exchange data between its operators and since these records may not only be sent to another instance in the same JVM but instead to a separate process, records need to be serialized to bytes first. Similarly, Flink’s off-heap state-backend is based on a local embedded RocksDB instance which is implemented in native C++ code and thus also needs transformation into bytes on every state access. Wire and state serialization alone can easily cost a lot of your job’s performance if not executed correctly and thus, whenever you look into the profiler output of your Flink job, you will most likely see serialization in the top places for using CPU cycles.

Since serialization is so crucial to your Flink job, we would like to highlight Flink’s serialization stack in a series of blog posts starting with looking at the different ways Flink can serialize your data types.

{% toc %}

# Recap: Flink Serialization

Flink handles [data types and serialization]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/types_serialization.html) with its own type descriptors, generic type extraction, and type serialization framework. We recommend reading through the [documentation]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/types_serialization.html) first in order to be able to follow the arguments we present below. In essence, Flink tries to infer information about your job’s data types for wire and state serialization, and to be able to use grouping, joining, and aggregation operations by referring to individual field names, e.g. 
`stream.keyBy(“ruleId”)` or 
`dataSet.join(another).where("name").equalTo("personName")`. It also allows optimizations in the serialization format as well as reducing unnecessary de/serializations (mainly in certain Batch operations as well as in the SQL/Table APIs).


# Choice of Serializer

Apache Flink's out-of-the-box serialization can be roughly divided into the following groups:

- **Flink-provided special serializers** for basic types (Java primitives and their boxed form), arrays, composite types (tuples, Scala case classes, Rows), and a few auxiliary types (Option, Either, Lists, Maps, …),

- **POJOs**; a public, standalone class with a public no-argument constructor and all non-static, non-transient fields in the class hierarchy either public or with a public getter- and a setter-method; see [POJO Rules]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/types_serialization.html#rules-for-pojo-types),

- **Generic types**; user-defined data types that are not recognized as a POJO and then serialized via [Kryo](https://github.com/EsotericSoftware/kryo).

Alternatively, you can also register [custom serializers]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/custom_serializers.html) for user-defined data types. This includes writing your own serializers or integrating other serialization systems like [Google Protobuf](https://developers.google.com/protocol-buffers/) or [Apache Thrift](https://thrift.apache.org/) via [Kryo](https://github.com/EsotericSoftware/kryo). Overall, this gives quite a number of different options of serializing user-defined data types and we will elaborate seven of them in the sections below.


## PojoSerializer

As outlined above, if your data type is not covered by a specialized serializer but follows the [POJO Rules]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/types_serialization.html#rules-for-pojo-types), it will be serialized with the [PojoSerializer](https://github.com/apache/flink/blob/release-1.10.0/flink-core/src/main/java/org/apache/flink/api/java/typeutils/runtime/PojoSerializer.java) which uses Java reflection to access an object’s fields. It is fast, generic, Flink-specific, and supports [state schema evolution]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/stream/state/schema_evolution.html) out of the box. If a composite data type cannot be serialized as a POJO, you will find the following message (or similar) in your cluster logs:

> 15:45:51,460 INFO  org.apache.flink.api.java.typeutils.TypeExtractor             - Class … cannot be used as a POJO type because not all fields are valid POJO fields, and must be processed as GenericType. Please read the Flink documentation on "Data Types & Serialization" for details of the effect on performance.


This means, that the PojoSerializer will not be used, but instead Flink will fall back to Kryo for serialization (see below). We will have a more detailed look into a few (more) situations that can lead to unexpected Kryo fallbacks in the second part of this blog post series.


## Tuple Data Types

Flink comes with a predefined set of tuple types which all have a fixed length and contain a set of strongly-typed fields of potentially different types. There are implementations for `Tuple0`, `Tuple1<T0>`, …, `Tuple25<T0, T1, ..., T24>` and they may serve as easy-to-use wrappers that spare the creation of POJOs for each and every combination of objects you need to pass between computations. With the exception of `Tuple0`, these are serialized and deserialized with the [TupleSerializer](https://github.com/apache/flink/blob/release-1.10.0/flink-core/src/main/java/org/apache/flink/api/java/typeutils/runtime/TupleSerializer.java) and the according fields’ serializers. Since tuple classes are completely under the control of Flink, both actions can be performed without reflection by accessing the appropriate fields directly. This certainly is a (performance) advantage when working with tuples instead of POJOs. Tuples, however, are not as flexible and certainly less descriptive in code.


<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
 Since `Tuple0` does not contain any data and therefore is probably a bit special anyway, it will use a special serializer implementation: [Tuple0Serializer](https://github.com/apache/flink/blob/release-1.10.0/flink-core/src/main/java/org/apache/flink/api/java/typeutils/runtime/Tuple0Serializer.java).
</div>

## Row Data Types

Row types are mainly used by the Table and SQL APIs of Flink. A `Row` groups an arbitrary number of objects together similar to the tuples above. These fields are not strongly typed and may all be of different types. Because field types are missing, Flink’s type extraction cannot automatically extract type information and users of a `Row` need to manually tell Flink about the row's field types. The [RowSerializer](https://github.com/apache/flink/blob/release-1.10.0/flink-core/src/main/java/org/apache/flink/api/java/typeutils/runtime/RowSerializer.java) will then make use of these types for efficient serialization.

Row type information can be provided in two ways:

- you can have your source or operator implement `ResultTypeQueryable<Row>`:

```java
public static class RowSource implements SourceFunction<Row>, ResultTypeQueryable<Row> {
  // ...

  @Override
  public TypeInformation<Row> getProducedType() {
    return Types.ROW(Types.INT, Types.STRING, Types.OBJECT_ARRAY(Types.STRING));
  }
}
```

- you can provide the types when building the job graph by using `SingleOutputStreamOperator#returns()`

```java
DataStream<Row> sourceStream =
    env.addSource(new RowSource())
        .returns(Types.ROW(Types.INT, Types.STRING, Types.OBJECT_ARRAY(Types.STRING)));
```

<div class="alert alert-warning" markdown="1">
<span class="label label-warning" style="display: inline-block"><span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span> Warning</span>
If you fail to provide the type information for a `Row`, Flink identifies that `Row` is not a valid POJO type according to the rules above and falls back to Kryo serialization (see below) which you will also see in the logs as:

`13:10:11,148 INFO  org.apache.flink.api.java.typeutils.TypeExtractor             - Class class org.apache.flink.types.Row cannot be used as a POJO type because not all fields are valid POJO fields, and must be processed as GenericType. Please read the Flink documentation on "Data Types & Serialization" for details of the effect on performance.`
</div>

## Avro

Flink offers built-in support for the [Apache Avro](http://avro.apache.org/) serialization framework (currently using version 1.8.2) by adding the `org.apache.flink:flink-avro` dependency into your job. Flink’s [AvroSerializer](https://github.com/apache/flink/blob/release-1.10.0/flink-formats/flink-avro/src/main/java/org/apache/flink/formats/avro/typeutils/AvroSerializer.java) can then use Avro’s specific, generic, and reflective data serialization and make use of Avro’s performance and flexibility, especially in terms of [evolving the schema](https://avro.apache.org/docs/current/spec.html#Schema+Resolution) when the classes change over time.

### Avro Specific

Avro specific records will be automatically detected by checking that the given type’s type hierarchy contains the `SpecificRecordBase` class. You can either specify your concrete Avro type, or—if you want to be more generic and allow different types in your operator—use the `SpecificRecordBase` type (or a subtype) in your user functions, in `ResultTypeQueryable#getProducedType()`, or in `SingleOutputStreamOperator#returns()`. Since specific records use generated Java code, they are strongly typed and allow direct access to the fields via known getters and setters.

<div class="alert alert-warning" markdown="1">
<span class="label label-warning" style="display: inline-block"><span class="glyphicon glyphicon-warning-sign" aria-hidden="true"></span> Warning</span> If you specify the Flink type as `SpecificRecord` and not `SpecificRecordBase`, Flink will not see this as an Avro type. Instead, it will use Kryo to de/serialize any objects which may be considerably slower. 
</div>

### Avro Generic

Avro’s `GenericRecord` types cannot, unfortunately, be used automatically since they require the user to [specify a schema](https://avro.apache.org/docs/1.8.2/gettingstartedjava.html#Serializing+and+deserializing+without+code+generation) (either manually or by retrieving it from some schema registry). With that schema, you can provide the right type information by either of the following options just like for the Row Types above:

- implement `ResultTypeQueryable<GenericRecord>`:

```java
public static class AvroGenericSource implements SourceFunction<GenericRecord>, ResultTypeQueryable<GenericRecord> {
  private final GenericRecordAvroTypeInfo producedType;

  public AvroGenericSource(Schema schema) {
    this.producedType = new GenericRecordAvroTypeInfo(schema);
  }
  
  @Override
  public TypeInformation<GenericRecord> getProducedType() {
    return producedType;
  }
}
```
- provide type information when building the job graph by using `SingleOutputStreamOperator#returns()`

```java
DataStream<GenericRecord> sourceStream =
    env.addSource(new AvroGenericSource())
        .returns(new GenericRecordAvroTypeInfo(schema));
```
Without this type information, Flink will fall back to Kryo for serialization which would serialize the schema into every record, over and over again. As a result, the serialized form will be bigger and more costly to create.

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
 Since Avro’s `Schema` class is not serializable, it can not be sent around as is. You can work around this by converting it to a String and parsing it back when needed. If you only do this once on initialization, there is practically no difference to sending it directly.
</div>

### Avro Reflect

The third way of using Avro is to exchange Flink’s PojoSerializer (for POJOs according to the rules above) for Avro’s reflection-based serializer. This can be enabled by calling

```java
env.getConfig().enableForceAvro();
```

## Kryo

Any class or object which does not fall into the categories above or is covered by a Flink-provided special serializer is de/serialized with a fallback to [Kryo](https://github.com/EsotericSoftware/kryo) (currently version 2.24.0) which is a powerful and generic serialization framework in Java. Flink calls such a type a *generic type* and you may stumble upon `GenericTypeInfo` when debugging code. If you are using Kryo serialization, make sure to register your types with kryo:

```java
env.getConfig().registerKryoType(MyCustomType.class);
```
Registering types adds them to an internal map of classes to tags so that, during serialization, Kryo does not have to add the fully qualified class names as a prefix into the serialized form. Instead, Kryo uses these (integer) tags to identify the underlying classes and reduce serialization overhead.

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
Flink will store Kryo serializer mappings from type registrations in its checkpoints and savepoints and will retain them across job (re)starts.
</div>

### Disabling Kryo

If desired, you can disable the Kryo fallback, i.e. the ability to serialize generic types, by calling

```java
env.getConfig().disableGenericTypes();
```

This is mostly useful for finding out where these fallbacks are applied and replacing them with better serializers. If your job has any generic types with this configuration, it will fail with

> Exception in thread "main" java.lang.UnsupportedOperationException: Generic types have been disabled in the ExecutionConfig and type … is treated as a generic type.

If you cannot immediately see from the type where it is being used, this log message also gives you a stacktrace that can be used to set breakpoints and find out more details in your IDE.


## Apache Thrift (via Kryo)

In addition to the variants above, Flink also allows you to [register other type serialization frameworks]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/custom_serializers.html#register-a-custom-serializer-for-your-flink-program) with Kryo. After adding the appropriate dependencies from the [documentation]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/custom_serializers.html#register-a-custom-serializer-for-your-flink-program) (`com.twitter:chill-thrift` and `org.apache.thrift:libthrift`), you can use [Apache Thrift](https://thrift.apache.org/) like the following:

```java
env.getConfig().addDefaultKryoSerializer(MyCustomType.class, TBaseSerializer.class);
```

This only works if generic types are not disabled and `MyCustomType` is a Thrift-generated data type. If the data type is not generated by Thrift, Flink will fail at runtime with an exception like this:

> java.lang.ClassCastException: class MyCustomType cannot be cast to class org.apache.thrift.TBase (MyCustomType and org.apache.thrift.TBase are in unnamed module of loader 'app')

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
Please note that `TBaseSerializer` can be registered as a default Kryo serializer as above (and as specified in [its documentation](https://github.com/twitter/chill/blob/v0.7.6/chill-thrift/src/main/java/com/twitter/chill/thrift/TBaseSerializer.java)) or via `registerTypeWithKryoSerializer`. In practice, we found both ways working. We also saw no difference between registering Thrift classes in addition to the call above. Both may be different in your scenario.
</div>

## Protobuf (via Kryo)

In a way similar to Apache Thrift, [Google Protobuf](https://developers.google.com/protocol-buffers/) may be [registered as a custom serializer]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/custom_serializers.html#register-a-custom-serializer-for-your-flink-program) after adding the right dependencies (`com.twitter:chill-protobuf` and `com.google.protobuf:protobuf-java`):

```java
env.getConfig().registerTypeWithKryoSerializer(MyCustomType.class, ProtobufSerializer.class);
```
This will work as long as generic types have not been disabled (this would disable Kryo for good). If `MyCustomType` is not a Protobuf-generated class, your Flink job will fail at runtime with the following exception:

> java.lang.ClassCastException: class `MyCustomType` cannot be cast to class com.google.protobuf.Message (`MyCustomType` and com.google.protobuf.Message are in unnamed module of loader 'app')

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
Please note that `ProtobufSerializer` can be registered as a default Kryo serializer (as specified in the [Protobuf documentation](https://github.com/twitter/chill/blob/v0.7.6/chill-thrift/src/main/java/com/twitter/chill/thrift/TBaseSerializer.java)) or via `registerTypeWithKryoSerializer` (as presented here). In practice, we found both ways working. We also saw no difference between registering your Protobuf classes in addition to the call above. Both may be different in your scenario.
</div>

# State Schema Evolution

Before taking a closer look at the performance of each of the serializers described above, we would like to emphasize that performance is not everything that counts inside a real-world Flink job. Types for storing state, for example, should be able to evolve their schema (add/remove/change fields) throughout the lifetime of the job without losing previous state. This is what Flink calls [State Schema Evolution]({{< param DocsBaseUrl >}}flink-docs-stable/dev/stream/state/schema_evolution.html). Currently, as of Flink 1.10, there are only two serializers that support out-of-the-box schema evolution: POJO and Avro. For anything else, if you want to change the state schema, you will have to either implement your own [custom serializers]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/stream/state/custom_serialization.html) or use the [State Processor API]({{< param DocsBaseUrl >}}flink-docs-release-1.10/dev/libs/state_processor_api.html) to modify your state for the new code.

# Performance Comparison

With so many options for serialization, it is actually not easy to make the right choice. We already saw some technical advantages and disadvantages of each of them outlined above. Since serializers are at the core of your Flink jobs and usually also sit on the hot path (per record invocations), let us actually take a deeper look into their performance with the help of the Flink benchmarks project at [https://github.com/dataArtisans/flink-benchmarks](https://github.com/dataArtisans/flink-benchmarks). This project adds a few micro-benchmarks on top of Flink (some more low-level than others) to track performance regressions and improvements. Flink’s continuous benchmarks for monitoring the serialization stack’s performance are implemented in [SerializationFrameworkMiniBenchmarks.java](https://github.com/dataArtisans/flink-benchmarks/blob/master/src/main/java/org/apache/flink/benchmark/SerializationFrameworkMiniBenchmarks.java). This is only a subset of all available serialization benchmarks though and you will find the complete set in [SerializationFrameworkAllBenchmarks.java](https://github.com/dataArtisans/flink-benchmarks/blob/master/src/main/java/org/apache/flink/benchmark/full/SerializationFrameworkAllBenchmarks.java). All of these use the same definition of a small POJO that may cover average use cases. Essentially (without constructors, getters, and setters), these are the data types that it uses for evaluating performance:

```java
public class MyPojo {
  public int id;
  private String name;
  private String[] operationNames;
  private MyOperation[] operations;
  private int otherId1;
  private int otherId2;
  private int otherId3;
  private Object someObject;
}
public class MyOperation {
  int id;
  protected String name;
}
```

This is mapped to tuples, rows, Avro specific records, Thrift and Protobuf representations appropriately and sent through a simple Flink job at parallelism 4 where the data type is used during network communication like this:

```java
env.setParallelism(4);
env.addSource(new PojoSource(RECORDS_PER_INVOCATION, 10))
    .rebalance()
    .addSink(new DiscardingSink<>());
```
After running this through the [jmh](http://openjdk.java.net/projects/code-tools/jmh/) micro-benchmarks defined in [SerializationFrameworkAllBenchmarks.java](https://github.com/dataArtisans/flink-benchmarks/blob/master/src/main/java/org/apache/flink/benchmark/full/SerializationFrameworkAllBenchmarks.java), I retrieved the following performance results for Flink 1.10 on my machine (in number of operations per millisecond):
<br>

<center>
<img src="/img/blog/2020-04-15-flink-serialization-performance-results.svg" width="800px" alt="Communication between the Flink operator and the Python execution environment"/>
</center>
<br>

A few takeaways from these numbers:

- The default fallback from POJO to Kryo reduces performance by 75%.<br>
  Registering types with Kryo significantly improves its performance with only 64% fewer operations than by using a POJO.

- Avro GenericRecord and SpecificRecord are roughly serialized at the same speed.

- Avro Reflect serialization is even slower than Kryo default (-45%).

- Tuples are the fastest, closely followed by Rows. Both leverage fast specialized serialization code based on direct access without Java reflection.

- Using a (nested) Tuple instead of a POJO may speed up your job by 42% (but is less flexible!).
 Having code-generation for the PojoSerializer ([FLINK-3599](https://jira.apache.org/jira/browse/FLINK-3599)) may actually close that gap (or at least move closer to the RowSerializer). If you feel like giving the implementation a go, please give the Flink community a note and we will see whether we can make that happen.

- If you cannot use POJOs, try to define your data type with one of the serialization frameworks that generate specific code for it: Protobuf, Avro, Thrift (in that order, performance-wise).

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span> As with all benchmarks, please bear in mind that these numbers only give a hint on Flink’s serializer performance in a specific scenario. They may be different with your data types but the rough classification is probably the same. If you want to be sure, please verify the results with your data types. You should be able to copy from `SerializationFrameworkAllBenchmarks.java` to set up your own micro-benchmarks or integrate different serialization benchmarks into your own tooling.
</div>

# Conclusion

In the sections above, we looked at how Flink performs serialization for different sorts of data types and elaborated the technical advantages and disadvantages. For data types used in Flink state, you probably want to leverage either POJO or Avro types which, currently, are the only ones supporting state evolution out of the box and allow your stateful application to develop over time. POJOs are usually faster in the de/serialization while Avro may support more flexible schema evolution and may integrate better with external systems. Please note, however, that you can use different serializers for external vs. internal components or even state vs. network communication.

The fastest de/serialization is achieved with Flink’s internal tuple and row serializers which can access these types' fields directly without going via reflection. With roughly 30% decreased throughput as compared to tuples, Protobuf and POJO types do not perform too badly on their own and are more flexible and maintainable. Avro (specific and generic) records as well as Thrift data types further reduce performance by 20% and 30%, respectively. You definitely want to avoid Kryo as that reduces throughput further by around 50% and more!

The next article in this series will use this finding as a starting point to look into a few common pitfalls and obstacles of avoiding Kryo, how to get the most out of the PojoSerializer, and a few more tuning techniques with respect to serialization. Stay tuned for more.
