---
title:  "Howto migrate a real-life batch pipeline from the DataSet API to the DataStream API"
date: "2023-04-12T08:00:00.000Z"
authors:

- echauchot:
  name: "Etienne Chauchot"
  twitter: "echauchot"
  aliases:
- /2023/04/12/2023-04-12-howto-migrate-to-datastream.html

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
is [this one](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDataset.java)
, it is a batch pipeline that implements the above query using the DataSet API
and [Row](https://javadoc.io/static/org.apache.flink/flink-core/1.16.0/org/apache/flink/types/Row.html)
as dataset element type.

## Migrating the DataSet pipeline to a DataStream pipeline

Instead of going through all of the code which is
available [here](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java)
 we will rather focus on some key areas of the migration. The code is based on the latest release
of Flink at the time this article was written: version 1.16.0.

DataStream is a unified API that allows to run pipelines in both batch and streaming modes. To
execute a DataStream pipeline in batch mode, it is not enough to set the execution mode in the Flink
execution environment, it is also needed to migrate some operations. Indeed, the DataStream API
semantics are the ones of a streaming pipeline. The arriving data is thus considered infinite. So,
compared to the DataSet API which operates on finite data, there are adaptations to be made on some
operations.

### [Setting the execution environment](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L92-L98)

We start by moving
from [ExecutionEnvironment](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/java/ExecutionEnvironment.html)
to [StreamExecutionEnvironment](https://javadoc.io/static/org.apache.flink/flink-streaming-java/1.16.0/org/apache/flink/streaming/api/environment/StreamExecutionEnvironment.html)
. Then, as the source in this pipeline is bounded, we can use either the default
streaming [execution mode](https://nightlies.apache.org/flink/flink-docs-master/docs/dev/datastream/execution_mode/)
or the batch mode. In batch mode the tasks of the job can be separated into stages that can be
executed one after another. In streaming mode all tasks need to be running all the time and records
are sent to downstream tasks as soon as they are available.

Here we keep the default streaming mode that gives good performance on this pipeline and that would
allow to run the same pipeline with no change on an unbounded source.

### Using the streaming sources and datasets

**
Sources**: [DataSource<T>](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/java/operators/DataSource.html)
becomes [DataStreamSource<T>](https://javadoc.io/static/org.apache.flink/flink-streaming-java/1.16.0/org/apache/flink/streaming/api/datastream/DataStreamSource.html)
after the call to _env.createInput()_.

**
Datasets**: [DataSet<T>](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/java/DataSet.html)
are
now [DataStream<T>](https://javadoc.io/static/org.apache.flink/flink-streaming-java/1.16.0/org/apache/flink/streaming/api/datastream/DataStream.html)
and subclasses.

### [Migrating the join operation](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L131-L137)

The DataStream join operator does not yet support aggregations in batch mode (
see [FLINK-22587](https://issues.apache.org/jira/browse/FLINK-22587) for details). Basically, the
problem is with the trigger of the
default [GlobalWindow](https://javadoc.io/static/org.apache.flink/flink-streaming-java/1.16.0/org/apache/flink/streaming/api/windowing/windows/GlobalWindow.html)
which never fires so the records are never output. We will workaround this problem by applying a
custom [EndOfStream](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L254-L295)
window. It is a window assigner that assigns all the records to a
single [TimeWindow](https://javadoc.io/static/org.apache.flink/flink-streaming-java/1.16.0/org/apache/flink/streaming/api/windowing/windows/TimeWindow.html)
. So, like for the GlobalWindow, all the records are assigned to the same window except that this
window's trigger is based on the end of the window (which is set to _Long.MAX_VALUE_). As we are on
a bounded source, at some point the watermark will advance to +INFINITY (Long.MAX_VALUE) and will
thus cross the end of the time window and consequently fire the trigger and output the records.

Now that we have a working triggering, we need to call a standard join with the  _Row::join_
function.

### [Migrating the group by and reduce (sum) operations](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L147-L170)

DataStream API has no
more [groupBy()](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/java/DataSet.html#groupBy-org.apache.flink.api.java.functions.KeySelector-)
method, we now use
the [keyBy()](https://javadoc.io/static/org.apache.flink/flink-streaming-java/1.16.0/org/apache/flink/streaming/api/datastream/DataStream.html#keyBy-org.apache.flink.api.java.functions.KeySelector-)
method. An aggregation downstream will be applied on elements with the same key exactly as
a [GroupReduceFunction](https://nightlies.apache.org/flink/flink-docs-release-1.12/api/java/org/apache/flink/api/common/functions/GroupReduceFunction.html)
would have done on a DataSet unless it will not materialize the collection of data. The summing
operation downstream is still done through
a [ReduceFunction](https://javadoc.io/static/org.apache.flink/flink-core/1.16.0/org/apache/flink/api/common/functions/ReduceFunction.html)
but this time the operator reduces the elements incrementally instead of receiving the rows as a
Collection. So we store in the reduced row the partially aggregated sum. Due to incremental reduce,
we also need to distinguish if we received an already reduced row (in that case, we read the
partially aggregated sum) or a fresh row (in that case we just read the corresponding price field).

### [Migrating the order by operation](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L172-L199)

The sort of the datastream is done by applying
a [KeyedProcessFunction](https://javadoc.io/static/org.apache.flink/flink-streaming-java/1.16.0/org/apache/flink/streaming/api/functions/KeyedProcessFunction.html)
.

But, as said above, the DataStream semantics are the ones of a streaming pipeline. The arriving data
is thus considered infinite. As such we need to "divide" the data to have output times. For that we
need to set a timer to output the resulting data. As we are in batch mode we work in processing
time (and not in event time)
and [set a timer to fire at Long.MAX_VALUE timestamp](https://github.com/echauchot/tpcds-benchmark-flink/blob/9c65e535bbd7f9c7f507e499c31c9280be2993ca/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L179)
meaning that the timer will fire at the end of the batch.

To sort the data, we store the incoming rows inside
a [ListState](https://javadoc.io/static/org.apache.flink/flink-core/1.16.0/org/apache/flink/api/common/state/ListState.html)
and sort them at output time, when the timer fires in
the [onTimer()](https://javadoc.io/static/org.apache.flink/flink-streaming-java/1.16.0/org/apache/flink/streaming/api/functions/KeyedProcessFunction.html#onTimer-long-org.apache.flink.streaming.api.functions.KeyedProcessFunction.OnTimerContext-org.apache.flink.util.Collector-)
callback.

Another thing: to be able to use Flink state, we need to key the datastream beforehand, even if there
is no group by key because Flink state is designed per-key. Thus, we key by a fake static key so
that there is a single state.

### [Migrating the limit operation](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L201-L204)

Like for the order by migration, here also we need to adapt to the streaming semantics in which we
don't have the whole data at hand. Once again, we use the state API. We apply a mapper that stores
the incoming rows into
a [ValueState](https://javadoc.io/static/org.apache.flink/flink-core/1.16.0/org/apache/flink/api/common/state/ValueState.html)
to count them and stop at the set limit. Here also we need to key by a static key to be able to use
the state API.
The code resides in
the [LimitMapper](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L232-L253)
class.

### [Migrating the sink operation](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkRowDatastream.java#L206-L217)

As with sources, there were big changes in sinks with recent versions of Flink. We now use
the [Sink interface](https://javadoc.io/static/org.apache.flink/flink-core/1.16.0/org/apache/flink/api/connector/sink2/Sink.html)
that requires
an [Encoder](https://javadoc.io/static/org.apache.flink/flink-core/1.16.0/org/apache/flink/api/common/serialization/Encoder.html)
. But the resulting code is very similar to the one using the DataSet API. It's only
that [Encoder#encode()](https://javadoc.io/static/org.apache.flink/flink-core/1.16.0/org/apache/flink/api/common/serialization/Encoder.html#encode-IN-java.io.OutputStream-)
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
the [Flink SQL/Table API](https://nightlies.apache.org/flink/flink-docs-master/docs/dev/table/overview/)
in
the [Query3ViaFlinkSQLCSV class](https://github.com/echauchot/tpcds-benchmark-flink/blob/master/src/main/java/org/example/tpcds/flink/Query3ViaFlinkSQLCSV.java)
.