---
author: Fabian Hüske
author-twitter: fhueske
date: "2015-05-11T10:00:00Z"
excerpt: |-
  <p>Nowadays, a lot of open-source systems for analyzing large data sets are implemented in Java or other JVM-based programming languages. The most well-known example is Apache Hadoop, but also newer frameworks such as Apache Spark, Apache Drill, and also Apache Flink run on JVMs. A common challenge that JVM-based data analysis engines face is to store large amounts of data in memory - both for caching and for efficient processing such as sorting and joining of data. Managing the JVM memory well makes the difference between a system that is hard to configure and has unpredictable reliability and performance and a system that behaves robustly with few configuration knobs.</p>
  <p>In this blog post we discuss how Apache Flink manages memory, talk about its custom data de/serialization stack, and show how it operates on binary data.</p>
title: Juggling with Bits and Bytes
---

## How Apache Flink operates on binary data

Nowadays, a lot of open-source systems for analyzing large data sets are implemented in Java or other JVM-based programming languages. The most well-known example is Apache Hadoop, but also newer frameworks such as Apache Spark, Apache Drill, and also Apache Flink run on JVMs. A common challenge that JVM-based data analysis engines face is to store large amounts of data in memory - both for caching and for efficient processing such as sorting and joining of data. Managing the JVM memory well makes the difference between a system that is hard to configure and has unpredictable reliability and performance and a system that behaves robustly with few configuration knobs.

In this blog post we discuss how Apache Flink manages memory, talk about its custom data de/serialization stack, and show how it operates on binary data.

## Data Objects? Let’s put them on the heap!

The most straight-forward approach to process lots of data in a JVM is to put it as objects on the heap and operate on these objects. Caching a data set as objects would be as simple as maintaining a list containing an object for each record. An in-memory sort would simply sort the list of objects.
However, this approach has a few notable drawbacks. First of all it is not trivial to watch and control heap memory usage when a lot of objects are created and invalidated constantly. Memory overallocation instantly kills the JVM with an `OutOfMemoryError`. Another aspect is garbage collection on multi-GB JVMs which are flooded with new objects. The overhead of garbage collection in such environments can easily reach 50% and more. Finally, Java objects come with a certain space overhead depending on the JVM and platform. For data sets with many small objects this can significantly reduce the effectively usable amount of memory. Given proficient system design and careful, use-case specific system parameter tuning, heap memory usage can be more or less controlled and `OutOfMemoryErrors` avoided. However, such setups are rather fragile especially if data characteristics or the execution environment change.

## What is Flink doing about that?

Apache Flink has its roots at a research project which aimed to combine the best technologies of MapReduce-based systems and parallel database systems. Coming from this background, Flink has always had its own way of processing data in-memory. Instead of putting lots of objects on the heap, Flink serializes objects into a fixed number of pre-allocated memory segments. Its DBMS-style sort and join algorithms operate as much as possible on this binary data to keep the de/serialization overhead at a minimum. If more data needs to be processed than can be kept in memory, Flink’s operators partially spill data to disk. In fact, a lot of Flink’s internal implementations look more like C/C++ rather than common Java. The following figure gives a high-level overview of how Flink stores data serialized in memory segments and spills to disk if necessary.

<center>
<img src="/img/blog/memory-mgmt.png" style="width:90%;margin:15px">
</center>

Flink’s style of active memory management and operating on binary data has several benefits: 

1. **Memory-safe execution & efficient out-of-core algorithms.** Due to the fixed amount of allocated memory segments, it is trivial to monitor remaining memory resources. In case of memory shortage, processing operators can efficiently write larger batches of memory segments to disk and later them read back. Consequently, `OutOfMemoryErrors` are effectively prevented.
2. **Reduced garbage collection pressure.** Because all long-lived data is in binary representation in Flink's managed memory, all data objects are short-lived or even mutable and can be reused. Short-lived objects can be more efficiently garbage-collected, which significantly reduces garbage collection pressure. Right now, the pre-allocated memory segments are long-lived objects on the JVM heap, but the Flink community is actively working on allocating off-heap memory for this purpose. This effort will result in much smaller JVM heaps and facilitate even faster garbage collection cycles.
3. **Space efficient data representation.** Java objects have a storage overhead which can be avoided if the data is stored in a binary representation.
4. **Efficient binary operations & cache sensitivity.** Binary data can be efficiently compared and operated on given a suitable binary representation. Furthermore, the binary representations can put related values, as well as hash codes, keys, and pointers, adjacently into memory. This gives data structures with usually more cache efficient access patterns.

These properties of active memory management are very desirable in a data processing systems for large-scale data analytics but have a significant price tag attached. Active memory management and operating on binary data is not trivial to implement, i.e., using `java.util.HashMap` is much easier than implementing a spillable hash-table backed by byte arrays and a custom serialization stack. Of course Apache Flink is not the only JVM-based data processing system that operates on serialized binary data. Projects such as [Apache Drill](http://drill.apache.org/), [Apache Ignite (incubating)](http://ignite.incubator.apache.org/) or [Apache Geode (incubating)](http://projectgeode.org/) apply similar techniques and it was recently announced that also [Apache Spark](http://spark.apache.org/) will evolve into this direction with [Project Tungsten](https://databricks.com/blog/2015/04/28/project-tungsten-bringing-spark-closer-to-bare-metal.html). 

In the following we discuss in detail how Flink allocates memory, de/serializes objects, and operates on binary data. We will also show some performance numbers comparing processing objects on the heap and operating on binary data.


## How does Flink allocate memory?

A Flink worker, called TaskManager, is composed of several internal components such as an actor system for coordination with the Flink master, an IOManager that takes care of spilling data to disk and reading it back, and a MemoryManager that coordinates memory usage. In the context of this blog post, the MemoryManager is of most interest. 

The MemoryManager takes care of allocating, accounting, and distributing MemorySegments to data processing operators such as sort and join operators. A [MemorySegment](https://github.com/apache/flink/blob/release-0.9.0-milestone-1/flink-core/src/main/java/org/apache/flink/core/memory/MemorySegment.java) is Flink’s distribution unit of memory and is backed by a regular Java byte array (size is 32 KB by default). A MemorySegment provides very efficient write and read access to its backed byte array using Java’s unsafe methods. You can think of a MemorySegment as a custom-tailored version of Java’s NIO ByteBuffer. In order to operate on multiple MemorySegments like on a larger chunk of consecutive memory, Flink uses logical views that implement Java’s `java.io.DataOutput` and `java.io.DataInput` interfaces.

MemorySegments are allocated once at TaskManager start-up time and are destroyed when the TaskManager is shut down. Hence, they are reused and not garbage-collected over the whole lifetime of a TaskManager. After all internal data structures of a TaskManager have been initialized and all core services have been started, the MemoryManager starts creating MemorySegments. By default 70% of the JVM heap that is available after service initialization is allocated by the MemoryManager. It is also possible to configure an absolute amount of managed memory. The remaining JVM heap is used for objects that are instantiated during task processing, including objects created by user-defined functions. The following figure shows the memory distribution in the TaskManager JVM after startup.

<center>
<img src="/img/blog/memory-alloc.png" style="width:60%;margin:15px">
</center>

## How does Flink serialize objects?

The Java ecosystem offers several libraries to convert objects into a binary representation and back. Common alternatives are standard Java serialization, [Kryo](https://github.com/EsotericSoftware/kryo), [Apache Avro](http://avro.apache.org/), [Apache Thrift](http://thrift.apache.org/), or Google’s [Protobuf](https://github.com/google/protobuf). Flink includes its own custom serialization framework in order to control the binary representation of data. This is important because operating on binary data such as comparing or even manipulating binary data requires exact knowledge of the serialization layout. Further, configuring the serialization layout with respect to operations that are performed on binary data can yield a significant performance boost. Flink’s serialization stack also leverages the fact, that the type of the objects which are going through de/serialization are exactly known before a program is executed. 

Flink programs can process data represented as arbitrary Java or Scala objects. Before a program is optimized, the data types at each processing step of the program’s data flow need to be identified. For Java programs, Flink features a reflection-based type extraction component to analyze the return types of user-defined functions. Scala programs are analyzed with help of the Scala compiler. Flink represents each data type with a [TypeInformation](https://github.com/apache/flink/blob/release-0.9.0-milestone-1/flink-core/src/main/java/org/apache/flink/api/common/typeinfo/TypeInformation.java). Flink has TypeInformations for several kinds of data types, including:

* BasicTypeInfo: Any (boxed) Java primitive type or java.lang.String.
* BasicArrayTypeInfo: Any array of a (boxed) Java primitive type or java.lang.String.
* WritableTypeInfo: Any implementation of Hadoop’s Writable interface.
* TupleTypeInfo: Any Flink tuple (Tuple1 to Tuple25). Flink tuples are Java representations for fixed-length tuples with typed fields.
* CaseClassTypeInfo: Any Scala CaseClass (including Scala tuples).
* PojoTypeInfo: Any POJO (Java or Scala), i.e., an object with all fields either being public or accessible through getters and setter that follow the common naming conventions. 
* GenericTypeInfo: Any data type that cannot be identified as another type.

Each TypeInformation provides a serializer for the data type it represents. For example, a BasicTypeInfo returns a serializer that writes the respective primitive type, the serializer of a WritableTypeInfo delegates de/serialization to the write() and readFields() methods of the object implementing Hadoop’s Writable interface, and a GenericTypeInfo returns a serializer that delegates serialization to Kryo. Object serialization to a DataOutput which is backed by Flink MemorySegments goes automatically through Java’s efficient unsafe operations. For data types that can be used as keys, i.e., compared and hashed, the TypeInformation provides TypeComparators. TypeComparators compare and hash objects and can - depending on the concrete data type - also efficiently compare binary representations and extract fixed-length binary key prefixes. 

Tuple, Pojo, and CaseClass types are composite types, i.e., containers for one or more possibly nested data types. As such, their serializers and comparators are also composite and delegate the serialization and comparison of their member data types to the respective serializers and comparators. The following figure illustrates the serialization of a (nested) `Tuple3<Integer, Double, Person>` object where `Person` is a POJO and defined as follows:

```java
public class Person {
    public int id;
    public String name;
}
```

<center>
<img src="/img/blog/data-serialization.png" style="width:80%;margin:15px">
</center>

Flink’s type system can be easily extended by providing custom TypeInformations, Serializers, and Comparators to improve the performance of serializing and comparing custom data types. 

## How does Flink operate on binary data?

Similar to many other data processing APIs (including SQL), Flink’s APIs provide transformations to group, sort, and join data sets. These transformations operate on potentially very large data sets. Relational database systems feature very efficient algorithms for these purposes since several decades including external merge-sort, merge-join, and hybrid hash-join. Flink builds on this technology, but generalizes it to handle arbitrary objects using its custom serialization and comparison stack. In the following, we show how Flink operates with binary data by the example of Flink’s in-memory sort algorithm.

Flink assigns a memory budget to its data processing operators. Upon initialization, a sort algorithm requests its memory budget from the MemoryManager and receives a corresponding set of MemorySegments. The set of MemorySegments becomes the memory pool of a so-called sort buffer which collects the data that is be sorted. The following figure illustrates how data objects are serialized into the sort buffer. 

<center>
<img src="/img/blog/sorting-binary-data-1.png" style="width:90%;margin:15px">
</center>

The sort buffer is internally organized into two memory regions. The first region holds the full binary data of all objects. The second region contains pointers to the full binary object data and - depending on the key data type - fixed-length sort keys. When an object is added to the sort buffer, its binary data is appended to the first region, and a pointer (and possibly a key) is appended to the second region. The separation of actual data and pointers plus fixed-length keys is done for two purposes. It enables efficient swapping of fix-length entries (key+pointer) and also reduces the data that needs to be moved when sorting. If the sort key is a variable length data type such as a String, the fixed-length sort key must be a prefix key such as the first n characters of a String. Note, not all data types provide a fixed-length (prefix) sort key. When serializing objects into the sort buffer, both memory regions are extended with MemorySegments from the memory pool. Once the memory pool is empty and no more objects can be added, the sort buffer is completely filled and can be sorted. Flink’s sort buffer provides methods to compare and swap elements. This makes the actual sort algorithm pluggable. By default, Flink uses a Quicksort implementation which can fall back to HeapSort. 
The following figure shows how two objects are compared.

<center>
<img src="/img/blog/sorting-binary-data-2.png" style="width:80%;margin:15px">
</center>

The sort buffer compares two elements by comparing their binary fix-length sort keys. The comparison is successful if either done on a full key (not a prefix key) or if the binary prefix keys are not equal. If the prefix keys are equal (or the sort key data type does not provide a binary prefix key), the sort buffer follows the pointers to the actual object data, deserializes both objects and compares the objects. Depending on the result of the comparison, the sort algorithm decides whether to swap the compared elements or not. The sort buffer swaps two elements by moving their fix-length keys and pointers. The actual data is not moved. Once the sort algorithm finishes, the pointers in the sort buffer are correctly ordered. The following figure shows how the sorted data is returned from the sort buffer. 

<center>
<img src="/img/blog/sorting-binary-data-3.png" style="width:80%;margin:15px">
</center>

The sorted data is returned by sequentially reading the pointer region of the sort buffer, skipping the sort keys and following the sorted pointers to the actual data. This data is either deserialized and returned as objects or the binary representation is copied and written to disk in case of an external merge-sort (see this [blog post on joins in Flink](http://flink.apache.org/news/2015/03/13/peeking-into-Apache-Flinks-Engine-Room.html)).

## Show me numbers!

So, what does operating on binary data mean for performance? We’ll run a benchmark that sorts 10 million `Tuple2<Integer, String>` objects to find out. The values of the Integer field are sampled from a uniform distribution. The String field values have a length of 12 characters and are sampled from a long-tail distribution. The input data is provided by an iterator that returns a mutable object, i.e., the same tuple object instance is returned with different field values. Flink uses this technique when reading data from memory, network, or disk to avoid unnecessary object instantiations. The benchmarks are run in a JVM with 900 MB heap size which is approximately the required amount of memory to store and sort 10 million tuple objects on the heap without dying of an `OutOfMemoryError`. We sort the tuples on the Integer field and on the String field using three sorting methods:

1. **Object-on-heap.** The tuples are stored in a regular `java.util.ArrayList` with initial capacity set to 10 million entries and sorted using Java’s regular collection sort.
2. **Flink-serialized.** The tuple fields are serialized into a sort buffer of 600 MB size using Flink’s custom serializers, sorted as described above, and finally deserialized again. When sorting on the Integer field, the full Integer is used as sort key such that the sort happens entirely on binary data (no deserialization of objects required). For sorting on the String field a 8-byte prefix key is used and tuple objects are deserialized if the prefix keys are equal.
3. **Kryo-serialized.** The tuple fields are serialized into a sort buffer of 600 MB size using Kryo serialization and sorted without binary sort keys. This means that each pair-wise comparison requires two object to be deserialized.

All sort methods are implemented using a single thread. The reported times are averaged over ten runs. After each run, we call `System.gc()` to request a garbage collection run which does not go into measured execution time. The following figure shows the time to store the input data in memory, sort it, and read it back as objects. 

<center>
<img src="/img/blog/sort-benchmark.png" style="width:90%;margin:15px">
</center>

We see that Flink’s sort on binary data using its own serializers significantly outperforms the other two methods. Comparing to the object-on-heap method, we see that loading the data into memory is much faster. Since we actually collect the objects, there is no opportunity to reuse the object instances, but have to re-create every tuple. This is less efficient than Flink’s serializers (or Kryo serialization). On the other hand, reading objects from the heap comes for free compared to deserialization. In our benchmark, object cloning was more expensive than serialization and deserialization combined. Looking at the sorting time, we see that also sorting on the binary representation is faster than Java’s collection sort. Sorting data that was serialized using Kryo without binary sort key, is much slower than both other methods. This is due to the heavy deserialization overhead. Sorting the tuples on their String field is faster than sorting on the Integer field due to the long-tailed value distribution which significantly reduces the number of pair-wise comparisons. To get a better feeling of what is happening during sorting we monitored the executing JVM using VisualVM. The following screenshots show heap memory usage, garbage collection activity and CPU usage over the execution of 10 runs.

<table width="100%">
  <tr>
    <th></th>
    <th><center><b>Garbage Collection</b></center></th>
    <th><center><b>Memory Usage</b></center></th>
  </tr>
  <tr>
    <td><b>Object-on-Heap (int)</b></td>
    <td><img src="/img/blog/objHeap-int-gc.png" style="width:80%"></td>
    <td><img src="/img/blog/objHeap-int-mem.png" style="width:80%"></td>
  </tr>
  <tr>
    <td><b>Flink-Serialized (int)</b></td>
    <td><img src="/img/blog/flinkSer-int-gc.png" style="width:80%"></td>
    <td><img src="/img/blog/flinkSer-int-mem.png" style="width:80%"></td>
  </tr>
  <tr>
    <td><b>Kryo-Serialized (int)</b></td>
    <td><img src="/img/blog/kryoSer-int-gc.png" style="width:80%"></td>
    <td><img src="/img/blog/kryoSer-int-mem.png" style="width:80%"></td>
  </tr>
</table>

The experiments run single-threaded on an 8-core machine, so full utilization of one core only corresponds to a 12.5% overall utilization. The screenshots show that operating on binary data significantly reduces garbage collection activity. For the object-on-heap approach, the garbage collector runs in very short intervals while filling the sort buffer and causes a lot of CPU usage even for a single processing thread (sorting itself does not trigger the garbage collector). The JVM garbage collects with multiple parallel threads, explaining the high overall CPU utilization. On the other hand, the methods that operate on serialized data rarely trigger the garbage collector and have a much lower CPU utilization. In fact the garbage collector does not run at all if the tuples are sorted on the Integer field using the flink-serialized method because no objects need to be deserialized for pair-wise comparisons. The kryo-serialized method requires slightly more garbage collection since it does not use binary sort keys and deserializes two objects for each comparison.

The memory usage charts shows that the flink-serialized and kryo-serialized constantly occupy a high amount of memory (plus some objects for operation). This is due to the pre-allocation of MemorySegments. The actual memory usage is much lower, because the sort buffers are not completely filled. The following table shows the memory consumption of each method. 10 million records result in about 280 MB of binary data (object data plus pointers and sort keys) depending on the used serializer and presence and size of a binary sort key. Comparing this to the memory requirements of the object-on-heap approach we see that operating on binary data can significantly improve memory efficiency. In our benchmark more than twice as much data can be sorted in-memory if serialized into a sort buffer instead of holding it as objects on the heap.

<table width="100%">
  <tr>
  	<th>Occupied Memory</th>
    <th>Object-on-Heap</th>
    <th>Flink-Serialized</th>
    <th>Kryo-Serialized</th>
  </tr>
  <tr>
    <td><b>Sort on Integer</b></td>
    <td>approx. 700 MB (heap)</td>
    <td>277 MB (sort buffer)</td>
    <td>266 MB (sort buffer)</td>
  </tr>
  <tr>
    <td><b>Sort on String</b></td>
    <td>approx. 700 MB (heap)</td>
    <td>315 MB (sort buffer)</td>
    <td>266 MB (sort buffer)</td>
  </tr>
</table>

<br>

To summarize, the experiments verify the previously stated benefits of operating on binary data. 

## We’re not done yet!

Apache Flink features quite a bit of advanced techniques to safely and efficiently process huge amounts of data with limited memory resources. However, there are a few points that could make Flink even more efficient. The Flink community is working on moving the managed memory to off-heap memory. This will allow for smaller JVMs, lower garbage collection overhead, and also easier system configuration. With Flink’s Table API, the semantics of all operations such as aggregations and projections are known (in contrast to black-box user-defined functions). Hence we can generate code for Table API operations that directly operates on binary data. Further improvements include serialization layouts which are tailored towards the operations that are applied on the binary data and code generation for serializers and comparators. 

The groundwork (and a lot more) for operating on binary data is done but there is still some room for making Flink even better and faster. If you are crazy about performance and like to juggle with lot of bits and bytes, join the Flink community! 

## TL;DR; Give me three things to remember!

* Flink’s active memory management avoids nasty `OutOfMemoryErrors` that kill your JVMs and reduces garbage collection overhead.
* Flink features a highly efficient data de/serialization stack that facilitates operations on binary data and makes more data fit into memory.
* Flink’s DBMS-style operators operate natively on binary data yielding high performance in-memory and destage gracefully to disk if necessary.
