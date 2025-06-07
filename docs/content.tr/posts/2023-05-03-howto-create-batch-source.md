---
title:  "Howto create a batch source with the new Source framework"
date: "2023-05-03T08:00:00.000Z"
authors:

- echauchot:
  name: "Etienne Chauchot"
  twitter: "echauchot"

---

## Introduction

The Flink community has
designed [a new Source framework](https://nightlies.apache.org/flink/flink-docs-release-1.16/docs/dev/datastream/sources/)
based
on [FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)
lately. Some connectors have migrated to this new framework. This article is a how-to for creating a
batch
source using this new framework. It was built while implementing
the [Flink batch source](https://github.com/apache/flink-connector-cassandra/commit/72e3bef1fb9ee6042955b5e9871a9f70a8837cca)
for [Cassandra](https://cassandra.apache.org/_/index.html).
If you are interested in contributing or migrating connectors, this blog post is for you!

## Implementing the source components

The source architecture is depicted in the diagrams below:

![](/img/blog/2023-05-03-howto-create-batch-source/source_components.svg)

![](/img/blog/2023-05-03-howto-create-batch-source/source_reader.svg)

### Source

[Example Cassandra Source](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/CassandraSource.java)

The source interface only does the "glue" between all the other components. Its role is to
instantiate all of them and to define the
source [Boundedness](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/Boundedness.html)
. We also do the source configuration
here along with user configuration validation.

### SourceReader

[Example Cassandra SourceReader](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/reader/CassandraSourceReader.java)

As shown in the graphic above, the instances of
the [SourceReader](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SourceReader.html) 
(which we will call simply readers
in the continuation of this article) run in parallel in task managers to read the actual data which
is divided into [Splits](#split-and-splitstate). Readers request splits from
the [SplitEnumerator](#splitenumerator-and-splitenumeratorstate) and the resulting splits are
assigned to them in return.

Flink provides
the [SourceReaderBase](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/SourceReaderBase.html)
implementation that takes care of all the threading. Flink also provides a useful extension to
this class for most
cases: [SingleThreadMultiplexSourceReaderBase](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/SingleThreadMultiplexSourceReaderBase.html)
. This class has the threading model already configured:
each [SplitReader](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/splitreader/SplitReader.html)
instance reads splits using one thread (but there are several SplitReader instances that live among
task
managers).

What we have left to do in the SourceReader class is:

* Provide a [SplitReader](#splitreader) supplier
* Create a [RecordEmitter](#recordemitter)
* Create the shared resources for the SplitReaders (sessions, etc...). As the SplitReader supplier
  is
  created in the SourceReader constructor in a super() call, using a SourceReader factory to create
  the shared resources and pass them to the supplier is a good idea.
* Implement [start()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SourceReader.html#start--):
here we should ask the enumerator for our first split
* Override [close()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/SourceReaderBase.html#close--)
in SourceReaderBase parent class to free up any created resources (the shared
resources for example)
* Implement [initializedState()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/SourceReaderBase.html#initializedState-SplitT-)
to create a mutable [SplitState](#split-and-splitstate) from a Split
* Implement [toSplitType()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/SourceReaderBase.html#toSplitType-java.lang.String-SplitStateT-)
to create a Split from the mutable SplitState
* Implement [onSplitFinished()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/SourceReaderBase.html#onSplitFinished-java.util.Map-):
here, as it is a batch source (finite data), we should ask the
Enumerator for next split

### Split and SplitState

[Example Cassandra Split](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/split/CassandraSplit.java)

The [SourceSplit](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SourceSplit.html)
represents a partition of the source data. What defines a split depends on the
backend we are reading from. It could be a _(partition start, partition end)_ tuple or an _(offset,
split size)_ tuple for example.

In any case, the Split object should be seen as an immutable object: any update to it should be done
on the
associated [SplitState](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/SourceReaderBase.html).
The split state is the one that will be stored inside the Flink
[checkpoints](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#checkpointing)
. A checkpoint may happen between 2 fetches for 1 split. So, if we're reading a split, we
must store in the split state the current state of the reading process. This current state needs to
be something serializable (because it will be part of a checkpoint) and something that the backend
source can resume from. That way, in case of failover, the reading could be resumed from where it
was left off. Thus we ensure there will be no duplicates or lost data.  
For example, if the records
reading order is deterministic in the backend, then the split state can store the number _n_ of
already read records to restart at _n+1_ after failover.

### SplitEnumerator and SplitEnumeratorState

[Example Cassandra SplitEnumerator](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/enumerator/CassandraSplitEnumerator.java)
and [SplitEnumeratorState](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/enumerator/CassandraEnumeratorState.java)

The [SplitEnumerator](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SplitEnumerator.html)
is responsible for creating the splits and serving them to the readers. Whenever
possible, it is preferable to generate the splits lazily, meaning that each time a reader asks the
enumerator for a split, the enumerator generates one on demand and assigns it to the reader. For
that we
implement [SplitEnumerator#handleSplitRequest()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SplitEnumerator.html#handleSplitRequest-int-java.lang.String-)
. Lazy splits generation is preferable to
splits discovery, in which we pre-generate all the splits and store them waiting to assign them to
the readers. Indeed, in some situations, the number of splits can be enormous and consume a lot a
memory which could be problematic in case of straggling readers. The framework offers the ability to
act upon reader registration by
implementing [addReader()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SplitEnumerator.html#addReader-int-)
but, as we do lazy splits generation, we
have nothing to do there. In some cases, generating a split is too costly, so we can pre-generate a
batch (not all) of splits to amortize this cost. The number/size of batched splits need to be taken
into account to avoid consuming too much memory.

Long story short, the tricky part of the source implementation is splitting the source data. The
good equilibrium to find is not to have too many splits (which could lead to too much memory
consumption) nor too few (which could lead to sub-optimal parallelism). One good way to meet this
equilibrium is to evaluate the size of the source data upfront and allow the user to specify the
maximum memory a split will take. That way they can configure this parameter accordingly to the
memory
available on the task managers. This parameter is optional so the source needs to provide a default
value. Also, the source needs to control that the user provided max-split-size is not too little
which would
lead to too many splits. The general rule of thumb is to let the user some freedom but protect him
from unwanted behavior.
For these safety measures, rigid thresholds
don't work well as the source may start to fail when the thresholds are suddenly exceeded.  
For example if we enforce that the number of splits is below twice the parallelism, if
the job is regularly run on a growing table, at some point there will be
more and more splits of max-split-size and the threshold will be exceeded. Of course, the size of
the source data needs to be evaluated without
reading the actual data. For the Cassandra connector it was
done [like this](https://echauchot.blogspot.com/2023/03/cassandra-evaluate-table-size-without.html).

Another important topic is state. If the job manager fails, the split enumerator needs to recover.
For that, as for the split, we need to provide a state for the enumerator that will be part of a
checkpoint. Upon recovery, the enumerator is reconstructed and
receives [an enumerator state](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SplitEnumerator.html)
for recovering its previous state. Upon checkpointing, the
enumerator returns its state when [SplitEnumerator#snapshotState()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SplitEnumerator.html#snapshotState-long-)
is called. The state
must contain everything needed to resume where the enumerator was left off after failover. In lazy
split generation scenario, the state will contain everything needed to generate the next split
whenever asked to. It can be for example the start offset of next split, split size, number of
splits still to generate etc... But the SplitEnumeratorState must also contain a list of splits, not
the list of discovered splits, but a list of splits to reassign. Indeed, whenever a reader fails, if
it was assigned splits after last checkpoint, then the checkpoint will not contain those splits.
Consequently, upon restoration, the reader won't have the splits assigned anymore. There is a
callback to deal with that
case: [addSplitsBack()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SplitEnumerator.html#addSplitsBack-java.util.List-int-)
. There, the splits that were assigned to the
failing reader, can be put back into the enumerator state for later re-assignment to readers. There
is no memory size risk here as the number of splits to reassign is pretty low.

The above topics are the more important regarding splitting. There are 2 methods left to implement:
the
usual [start()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SplitEnumerator.html#start--)
/[close()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SplitEnumerator.html#close--)
methods for resources creation/disposal. Regarding implementing start(),
the Flink connector framework
provides [enumeratorContext#callAsync()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/connector/source/SplitEnumeratorContext.html#callAsync-java.util.concurrent.Callable-java.util.function.BiConsumer-long-long-)
utility to run long processing
asynchronously such as splits preparation or splits discovery (if lazy splits generation is
impossible). Indeed, the start() method runs in the source coordinator thread, 
we don't want to block it for a long time.

### SplitReader

[Example Cassandra SplitReader](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/reader/CassandraSplitReader.java)

This class is responsible for reading the actual splits that it receives when the framework
calls [handleSplitsChanges()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/splitreader/SplitReader.html#handleSplitsChanges-org.apache.flink.connector.base.source.reader.splitreader.SplitsChange-)
. The main part of the split reader is
the [fetch()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/splitreader/SplitReader.html#fetch--)
implementation where we read all the splits received and return the read records as
a [RecordsBySplits](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/RecordsBySplits.html)
object. This object contains a map of the split ids to the belonging records and also the ids of the
finished splits. Important points need to be considered:

* The fetch call must be non-blocking. If any call in its code is synchronous and potentially long,
  an
  escape from the fetch() must be provided. When the framework
  calls [wakeUp()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/splitreader/SplitReader.html#wakeUp--)
  we should interrupt the
  fetch for example by setting an AtomicBoolean.
* Fetch call needs to be re-entrant: an already read split must not be re-read. We should remove it
  from the list of splits to read and add its id to the finished splits (along with empty splits) in
  the RecordsBySplits that we return.

It is totally fine for the implementer to exit the fetch() method early. Also a failure could
interrupt the fetch. In both cases the framework will call fetch() again later on. In that case, the
fetch method must resume the reading from where it was left off using the split state already
discussed. If resuming the read of a split is impossible because of backend constraints, then the
only solution is to read splits atomically (either not read the split at all, or read it entirely).
That way, in case of interrupted fetch, nothing will be output and the split could be read again
from the beginning at next fetch call leading to no duplicates. But if the split is read entirely,
there are points to consider:

* We should ensure that the total split content (records from the source) fits in memory for example
  by specifying a max split size in bytes (
  see [SplitEnumarator](#splitenumerator-and-splitenumeratorstate))
* The split state becomes useless, only a Split class is needed

### RecordEmitter

[Example Cassandra RecordEmitter](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/reader/CassandraRecordEmitter.java)

The SplitReader reads records in the form
of [an intermediary record format](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/splitreader/SplitReader.html)
that the implementer
provides for each record. It can be the raw format returned by the backend or any format allowing to
extract the actual record afterwards. This format is not the final output format expected by the
source. It contains anything needed to do the conversion to the record output format. We need to
implement [RecordEmitter#emitRecord()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/base/source/reader/RecordEmitter.html#emitRecord-E-org.apache.flink.api.connector.source.SourceOutput-SplitStateT-)
to do this conversion. A good pattern here is to initialize the
RecordEmitter with a mapping Function. The implementation must be idempotent. Indeed the method
maybe interrupted in the middle. In that case, the same set of records will be passed to the record
emitter again later.

### Serializers

[Example Cassandra SplitSerializer](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/split/CassandraSplitSerializer.java)
and [SplitEnumeratorStateSerializer](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/enumerator/CassandraEnumeratorStateSerializer.java)

We need to provide singleton serializers for:

* Split: splits are serialized when sending them from enumerator to reader, and when checkpointing
  the reader's current state
* SplitEnumeratorState:  the serializer is used for the result of the
  SplitEnumerator#snapshotState()

For both, we need to
implement [SimpleVersionedSerializer](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/core/io/SimpleVersionedSerializer.html)
. Care needs to be taken at some important points:

* Using Java serialization
  is [forbidden](https://flink.apache.org/contributing/code-style-and-quality-java.html#java-serialization)
  in Flink mainly for migration concerns. We should rather manually write the fields of the objects
  using ObjectOutputStream. When a class is not supported by the ObjectOutputStream (not String,
  Integer, Long...), we should write the size of the object in bytes as an Integer and then write
  the object converted to byte[]. Similar method is used to serialize collections. First write the
  number of elements of the collection, then serialize all the contained objects. Of course, for
  deserialization we do the exact same reading with the same order.
* There can be a lot of splits, so we should cache the OutputStream used in SplitSerializer. We can
  do so by using.

`  ThreadLocal<DataOutputSerializer> SERIALIZER_CACHE =
ThreadLocal.withInitial(() -> new DataOutputSerializer(64));`

The initial stream size depends on the size of a split.

## Testing the source

For the sake of concision of this article, testing the source will be the object of the next
article. Stay tuned !

## Conclusion

This article gathering the implementation field feedback was needed as the javadocs cannot cover all
the implementation details for high-performance and maintainable sources. I hope you enjoyed reading
and that it gave you the desire to contribute a new connector to the Flink project !