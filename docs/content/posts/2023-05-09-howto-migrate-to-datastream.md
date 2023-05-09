---
title:  "Howto migrate a real-life batch pipeline from the DataSet API to the DataStream API"
date: "2023-05-09T08:00:00.000Z"
authors:

- echauchot:
  name: "Etienne Chauchot"
  twitter: "echauchot"

---

## Introduction

The Flink community has been deprecating the DataSet API since version 1.12 as part of the work on
[FLIP-131: Consolidate the user-facing Dataflow SDKs/APIs (and deprecate the DataSet API)](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=158866741)
.
This blog article illustrates the migration of a real-life batch DataSet pipeline to a batch
DataStream pipeline.
All the code presented in this article is available in
the [tpcds-benchmark-flink repo](https://github.com/echauchot/tpcds-benchmark-flink).
The use case shown here is extracted from a broader work comparing Flink performances of different
APIs
by implementing [TPCDS](https://www.tpc.org/tpcds/) queries using these APIs.

## What is TPCDS?

TPC-DS is a decision support benchmark that models several generally applicable aspects of a
decision support system. The purpose of TPCDS benchmarks is to provide relevant, objective
performance data of Big Data engines to industry users.

## Chosen TPCDS query

The chosen query for this article is **Query3**  because it contains all the more common analytics
operators (filter, join, aggregation, group by, order by, limit). It represents an analytic query on
store sales. Its SQL code is presented here:

`SELECT dt.d_year, item.i_brand_id brand_id, item.i_brand brand,SUM(ss_ext_sales_price) sum_agg
FROM  date_dim dt, store_sales, item
WHERE dt.d_date_sk = store_sales.ss_sold_date_sk
AND store_sales.ss_item_sk = item.i_item_sk
AND item.i_manufact_id = 128
AND dt.d_moy=11
GROUP BY dt.d_year, item.i_brand, item.i_brand_id
ORDER BY dt.d_year, sum_agg desc, brand_id
LIMIT 100`

## The initial DataSet pipeline

The pipeline we are migrating
is [this](https://github.com/echauchot/tpcds-benchmark-flink/blob/4273a3bc45d6e4fbdd5fa531fe48f85b8d0a9d3f/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDataset.java)
batch pipeline that implements the above query using the DataSet API
and [Row](https://nightlies.apache.org/flink/flink-docs-release-1.16/api/java/org/apache/flink/types/Row.html)
as dataset element type.

## Migrating the DataSet pipeline to a DataStream pipeline

Instead of going through all of the code which is
available [here](https://github.com/echauchot/tpcds-benchmark-flink/blob/4273a3bc45d6e4fbdd5fa531fe48f85b8d0a9d3f/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java)
we will rather focus on some key areas of the migration. The code is based on the latest release
of Flink at the time this article was written: version 1.16.0.

DataStream is a unified API that allows to run pipelines in both batch and streaming modes. To
execute a DataStream pipeline in batch mode, it is not enough to set the execution mode in the Flink
execution environment, it is also needed to migrate some operations. Indeed, the DataStream API
semantics are the ones of a streaming pipeline. The arriving data is thus considered infinite. So,
compared to the DataSet API which operates on finite data, there are adaptations to be made on some
operations.

### [Setting the execution environment](https://github.com/echauchot/tpcds-benchmark-flink/blob/4273a3bc45d6e4fbdd5fa531fe48f85b8d0a9d3f/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L90-L96)

We start by moving
from [ExecutionEnvironment](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/java/ExecutionEnvironment.html)
to [StreamExecutionEnvironment](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/streaming/api/environment/StreamExecutionEnvironment.html)
. Then, as the source in this pipeline is bounded, we can use either the default
streaming [execution mode](https://nightlies.apache.org/flink/flink-docs-release-1.16/docs/dev/datastream/execution_mode//)
or the batch mode. In batch mode the tasks of the job can be separated into stages that can be
executed one after another. In streaming mode all tasks need to be running all the time and records
are sent to downstream tasks as soon as they are available.

Here we keep the default streaming mode that gives good performance on this pipeline and that would
allow to run the same pipeline with no change on an unbounded source.

### Using the streaming sources and datasets

**Sources**: [DataSource<T>](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/java/operators/DataSource.html)
becomes [DataStreamSource<T>](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/streaming/api/datastream/DataStreamSource.html)
after the call to _env.createInput()_.

**Datasets**: [DataSet<T>](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/java/DataSet.html)
are
now [DataStream<T>](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/streaming/api/datastream/DataStream.html)
and subclasses.

### [Migrating the join operation](https://github.com/echauchot/tpcds-benchmark-flink/blob/4273a3bc45d6e4fbdd5fa531fe48f85b8d0a9d3f/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L129-L135)

The DataStream join operator does not yet support aggregations in batch mode (
see [FLINK-22587](https://issues.apache.org/jira/browse/FLINK-22587) for details). Basically, the
problem is with the trigger of the
default [GlobalWindow](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/streaming/api/windowing/windows/GlobalWindow.html)
which never fires so the records are never output. We will workaround this problem by applying a
custom [EndOfStream](https://github.com/echauchot/tpcds-benchmark-flink/blob/9589c7c74e7152badee8400d775b4af7a998e487/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L246-L280)
window. It is a window assigner that assigns all the records to a
single [TimeWindow](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/streaming/api/windowing/windows/TimeWindow.html)
. So, like for the GlobalWindow, all the records are assigned to the same window except that this
window's trigger is based on the end of the window (which is set to _Long.MAX_VALUE_). As we are on
a bounded source, at some point the watermark will advance to +INFINITY (Long.MAX_VALUE) and will
thus cross the end of the time window and consequently fire the trigger and output the records.

Now that we have a working triggering, we need to call a standard join with the  _Row::join_
function.

### [Migrating the group by and reduce (sum) operations](https://github.com/echauchot/tpcds-benchmark-flink/blob/9589c7c74e7152badee8400d775b4af7a998e487/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L145-L169)

DataStream API has no
more [groupBy()](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/java/DataSet.html#groupBy-org.apache.flink.api.java.functions.KeySelector-)
method, we now use
the [keyBy()](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/streaming/api/datastream/DataStream.html#keyBy-org.apache.flink.api.java.functions.KeySelector-)
method. An aggregation downstream will be applied on elements with the same key exactly as
a [GroupReduceFunction](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/common/functions/GroupReduceFunction.html)
would have done on a DataSet except it will not need to materialize the collection of data. Indeed, the following
operator is a reducer: the summing operation downstream is still done through
a [ReduceFunction](https://nightlies.apache.org/flink/flink-docs-release-1.16/api/java/org/apache/flink/api/common/functions/ReduceFunction.html)
but this time the operator reduces the elements incrementally instead of receiving the rows as a
Collection. To make the sum we store in the reduced row the partially aggregated sum. Due to incremental reduce,
we also need to distinguish if we received an already reduced row (in that case, we read the
partially aggregated sum) or a fresh row (in that case we just read the corresponding price field).
Also, please note that, as in the join case, we need to specify windowing for the aggregation.

### [Migrating the order by operation](https://github.com/echauchot/tpcds-benchmark-flink/blob/9589c7c74e7152badee8400d775b4af7a998e487/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L171-L211)

The sort of the datastream is done by applying
a [KeyedProcessFunction](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/streaming/api/functions/KeyedProcessFunction.html)
.

But, as said above, the DataStream semantics are the ones of a streaming pipeline. The arriving data
is thus considered infinite. As such we need to "divide" the data to have output times. For that we
need to set a timer to output the resulting data. We [set a timer to fire at the end of the EndOfStream window](https://github.com/echauchot/tpcds-benchmark-flink/blob/9589c7c74e7152badee8400d775b4af7a998e487/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L188)
meaning that the timer will fire at the end of the batch.

To sort the data, we store the incoming rows inside
a [ListState](https://nightlies.apache.org/flink/flink-docs-release-1.16/api/java/org/apache/flink/api/common/state/ListState.html)
and sort them at output time, when the timer fires in
the [onTimer()](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/streaming/api/functions/KeyedProcessFunction.html#onTimer-long-org.apache.flink.streaming.api.functions.KeyedProcessFunction.OnTimerContext-org.apache.flink.util.Collector-)
callback.

Another thing: to be able to use Flink state, we need to key the datastream beforehand, even if
there
is no group by key because Flink state is designed per-key. Thus, we key by a fake static key so
that there is a single state.

### [Migrating the limit operation](https://github.com/echauchot/tpcds-benchmark-flink/blob/9589c7c74e7152badee8400d775b4af7a998e487/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L213-L223)

As all the elements of the DataStream were keyed by the same "0" key, they are kept in the same "
group". So we can implement the SQL LIMIT with
a [ProcessFunction](https://nightlies.apache.org/flink/flink-docs-release-1.16/api/java/org/apache/flink/streaming/api/functions/ProcessFunction.html)
with a counter that will output only the first 100 elements.

### [Migrating the sink operation](https://github.com/echauchot/tpcds-benchmark-flink/blob/9589c7c74e7152badee8400d775b4af7a998e487/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L225-L236)

As with sources, there were big changes in sinks with recent versions of Flink. We now use
the [Sink interface](https://nightlies.apache.org/flink/flink-docs-release-1.16/api/java/org/apache/flink/api/connector/sink2/Sink.html)
that requires
an [Encoder](https://nightlies.apache.org/flink/flink-docs-release-1.16/api/java/org/apache/flink/api/common/serialization/Encoder.html)
. But the resulting code is very similar to the one using the DataSet API. It's only
that [Encoder#encode()](https://nightlies.apache.org/flink/flink-docs-release-1.16/api/java/org/apache/flink/api/common/serialization/Encoder.html#encode-IN-java.io.OutputStream-)
method writes bytes
when [TextOutputFormat.TextFormatter#format()](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/java/io/TextOutputFormat.TextFormatter.html#format-IN-)
wrote Strings.

## Conclusion

As you saw for the migration of the join operation, the new unified DataStream API has some
limitations left in batch mode. In addition, the order by and limit resulting code is quite manual
and requires the help of the Flink state API for the migration. For all these reasons, the Flink
community recommends to use Flink SQL for batch pipelines. It results in much simpler code, good
performance and out-of-the-box analytics capabilities. You could find the equivalent Query3 code
that uses
the [Flink SQL/Table API](https://nightlies.apache.org/flink/flink-docs-release-1.16/docs/dev/table/overview/)
in
the [Query3ViaFlinkSQLCSV class](https://github.com/echauchot/tpcds-benchmark-flink/blob/9589c7c74e7152badee8400d775b4af7a998e487/src/main/java/org/example/tpcds/flink/Query3ViaFlinkSQLCSV.java)
.