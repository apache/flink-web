---
authors:
- Yingjie Cao: null
  name: Yingjie Cao (Kevin)
- Daisy Tsang: null
  name: Daisy Tsang
date: "2021-10-26T00:00:00Z"
excerpt: Flink has implemented the sort-based blocking shuffle (FLIP-148) for batch
  data processing. In this blog post, we will take a close look at the design & implementation
  details and see what we can gain from it.
title: Sort-Based Blocking Shuffle Implementation in Flink - Part One
---

Part one of this blog post will explain the motivation behind introducing sort-based blocking shuffle, present benchmark results, and provide guidelines on how to use this new feature.

{% toc %}

# How data gets passed around between operators

Data shuffling is an important stage in batch processing applications and describes how data is sent from one operator to the next. In this phase, output data of the upstream operator will spill over to persistent storages like disk, then the downstream operator will read the corresponding data and process it. Blocking shuffle means that intermediate results from operator A are not sent immediately to operator B until operator A has completely finished.

The hash-based and sort-based blocking shuffle are two main blocking shuffle implementations widely adopted by existing distributed data processing frameworks:

1. **Hash-Based Approach:** The core idea behind the hash-based approach is to write data consumed by different consumer tasks to different files and each file can then serve as a natural boundary for the partitioned data.
2. **Sort-Based Approach:** The core idea behind the sort-based approach is to write all the produced data together first and then leverage sorting to cluster data belonging to different data partitions or even keys.

The sort-based blocking shuffle was introduced in Flink 1.12 and further optimized and made production-ready in 1.13 for both stability and performance. We hope you enjoy the improvements and any feedback is highly appreciated.

# Motivation behind the sort-based implementation

The hash-based blocking shuffle has been supported in Flink for a long time. However, compared to the sort-based approach, it can have several weaknesses:

1. **Stability:** For batch jobs with high parallelism (tens of thousands of subtasks), the hash-based approach opens many files concurrently while writing or reading data, which can give high pressure to the file system (i.e. maintenance of too many file metas, exhaustion of inodes or file descriptors). We have encountered many stability issues when running large-scale batch jobs via the hash-based blocking shuffle.
2. **Performance:** For large-scale batch jobs, the hash-based approach can produce too many small files: for each data shuffle (or connection), the number of output files is (producer parallelism) * (consumer parallelism) and the average size of each file is (shuffle data size) / (number of files). The random IO caused by writing/reading these fragmented files can influence the shuffle performance a lot, especially on spinning disks. See the [benchmark results](#benchmark-results-on-stability-and-performance) section for more information.

By introducing the sort-based blocking shuffle implementation, fewer data files will be created and opened, and more sequential reads are done. As a result, better stability and performance can be achieved.

Moreover, the sort-based implementation can save network buffers for large-scale batch jobs. For the hash-based implementation, the network buffers needed for each output result partition are proportional to the consumers’ parallelism. For the sort-based implementation, the network memory consumption can be decoupled from the parallelism, which means that a fixed size of network memory can satisfy requests for all result partitions, though more network memory may lead to better performance.

# Benchmark results on stability and performance 

Aside from the problem of consuming too many file descriptors and inodes mentioned in the above section, the hash-based blocking shuffle also has a known issue of creating too many files which blocks the TaskExecutor’s main thread ([FLINK-21201](https://issues.apache.org/jira/browse/FLINK-21201)). In addition, some large-scale jobs like q78 and q80 of the tpc-ds benchmark failed to run on the hash-based blocking shuffle in our tests because of the “connection reset by peer” exception which is similar to the issue reported in [FLINK-19925](https://issues.apache.org/jira/browse/FLINK-19925) (reading shuffle data by Netty threads can influence network stability).


We ran the tpc-ds test suit (10T scale with 1050 max parallelism) for both the hash-based and the sort-based blocking shuffle. The results show that the sort-based shuffle can achieve 2-6 times more performance gain compared to the hash-based one on spinning disks. If we exclude the computation time, up to 10 times performance gain can be achieved for some jobs. Here are some performance results of our tests:

<center>
<table width="95%" border="1">
  <thead>
    <tr>
      <th style="text-align: center">Jobs</th>
      <th style="text-align: center">Time used for Sort-Shuffle (s)</th>
      <th style="text-align: center">Time used for Hash-Shuffle (s)</th>
      <th style="text-align: center">Speedup Factor</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align: center">q4.sql</td>
      <td style="text-align: center">986</td>
      <td style="text-align: center">5371</td>
      <td style="text-align: center">5.45</td>
    </tr>
    <tr>
      <td style="text-align: center">q11.sql</td>
      <td style="text-align: center">348</td>
      <td style="text-align: center">798</td>
      <td style="text-align: center">2.29</td>
    </tr>
    <tr>
      <td style="text-align: center">q14b.sql</td>
      <td style="text-align: center">883</td>
      <td style="text-align: center">2129</td>
      <td style="text-align: center">2.51</td>
    </tr>
    <tr>
      <td style="text-align: center">q17.sql</td>
      <td style="text-align: center">269</td>
      <td style="text-align: center">781</td>
      <td style="text-align: center">2.90</td>
    </tr>
    <tr>
      <td style="text-align: center">q23a.sql</td>
      <td style="text-align: center">418</td>
      <td style="text-align: center">1199</td>
      <td style="text-align: center">2.87</td>
    </tr>
    <tr>
      <td style="text-align: center">q23b.sql</td>
      <td style="text-align: center">376</td>
      <td style="text-align: center">843</td>
      <td style="text-align: center">2.24</td>
    </tr>
    <tr>
      <td style="text-align: center">q25.sql</td>
      <td style="text-align: center">413</td>
      <td style="text-align: center">873</td>
      <td style="text-align: center">2.11</td>
    </tr>
    <tr>
      <td style="text-align: center">q29.sql</td>
      <td style="text-align: center">354</td>
      <td style="text-align: center">1038</td>
      <td style="text-align: center">2.93</td>
    </tr>
    <tr>
      <td style="text-align: center">q31.sql</td>
      <td style="text-align: center">223</td>
      <td style="text-align: center">498</td>
      <td style="text-align: center">2.23</td>
    </tr>
    <tr>
      <td style="text-align: center">q50.sql</td>
      <td style="text-align: center">215</td>
      <td style="text-align: center">550</td>
      <td style="text-align: center">2.56</td>
    </tr>
    <tr>
      <td style="text-align: center">q64.sql</td>
      <td style="text-align: center">217</td>
      <td style="text-align: center">442</td>
      <td style="text-align: center">2.04</td>
    </tr>
    <tr>
      <td style="text-align: center">q74.sql</td>
      <td style="text-align: center">270</td>
      <td style="text-align: center">962</td>
      <td style="text-align: center">3.56</td>
    </tr>
    <tr>
      <td style="text-align: center">q75.sql</td>
      <td style="text-align: center">166</td>
      <td style="text-align: center">713</td>
      <td style="text-align: center">4.30</td>
    </tr>
    <tr>
      <td style="text-align: center">q93.sql</td>
      <td style="text-align: center">204</td>
      <td style="text-align: center">540</td>
      <td style="text-align: center">2.65</td>
    </tr>
  </tbody>
</table>
</center>

<br>
The throughput per disk of the new sort-based implementation can reach up to 160MB/s for both writing and reading on our testing nodes:

<center>
<table width="95%" border="1">
  <thead>
    <tr>
      <th style="text-align: center">Disk Name</th>
      <th style="text-align: center">Disk SDI</th>
      <th style="text-align: center">Disk SDJ</th>
      <th style="text-align: center">Disk SDK</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align: center">Writing Speed (MB/s)</td>
      <td style="text-align: center">189</td>
      <td style="text-align: center">173</td>
      <td style="text-align: center">186</td>
    </tr>
    <tr>
      <td style="text-align: center">Reading Speed (MB/s)</td>
      <td style="text-align: center">112</td>
      <td style="text-align: center">154</td>
      <td style="text-align: center">158</td>
    </tr>
  </tbody>
</table>
</center>

<br>
**Note:** The following table shows the settings for our test cluster. Because we have a large available memory size per node, those jobs of small shuffle size will exchange their shuffle data purely via memory (page cache). As a result, evident performance differences are seen only between those jobs which shuffle a large amount of data.

<center>
<table width="95%" border="1">
  <thead>
    <tr>
      <th style="text-align: center">Number of Nodes</th>
      <th style="text-align: center">Memory Size Per Node</th>
      <th style="text-align: center">Cores Per Node</th>
      <th style="text-align: center">Disks Per Node</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align: center">12</td>
      <td style="text-align: center">About 400G</td>
      <td style="text-align: center">96</td>
      <td style="text-align: center">3</td>
    </tr>
  </tbody>
</table>
</center>

# How to use this new feature

The sort-based blocking shuffle is introduced mainly for large-scale batch jobs but it also works well for batch jobs with low parallelism.

The sort-based blocking shuffle is not enabled by default. You can enable it by setting the [taskmanager.network.sort-shuffle.min-parallelism]({{< param DocsBaseUrl >}}flink-docs-release-1.14/docs/deployment/config/#taskmanager-network-sort-shuffle-min-parallelism) config option to a smaller value. This means that for parallelism smaller than this threshold, the hash-based blocking shuffle will be used, otherwise, the sort-based blocking shuffle will be used (it has no influence on streaming applications). Setting this option to 1 will disable the hash-based blocking shuffle.

For spinning disks and large-scale batch jobs, you should use the sort-based blocking shuffle. For low parallelism (several hundred processes or fewer) on solid state drives, both implementations should be fine.

There are several other config options that can have an impact on the performance of the sort-based blocking shuffle:

1. [taskmanager.network.blocking-shuffle.compression.enabled]({{< param DocsBaseUrl >}}flink-docs-release-1.14/docs/deployment/config/#taskmanager-network-blocking-shuffle-compression-enabled): This enables shuffle data compression, which can reduce both the network and the disk IO with some CPU overhead. It is recommended to enable shuffle data compression unless the data compression ratio is low. It works for both sort-based and hash-based blocking shuffle.

2. [taskmanager.network.sort-shuffle.min-buffers]({{< param DocsBaseUrl >}}flink-docs-release-1.14/docs/deployment/config/#taskmanager-network-sort-shuffle-min-buffers): This declares the minimum number of required network buffers that can be used as the in-memory sort-buffer per result partition for data caching and sorting. Increasing the value of this option may improve the blocking shuffle performance. Several hundreds of megabytes of memory is usually enough for large-scale batch jobs.

3. [taskmanager.memory.framework.off-heap.batch-shuffle.size]({{< param DocsBaseUrl >}}flink-docs-release-1.14/docs/deployment/config/#taskmanager-memory-framework-off-heap-batch-shuffle-size): This configuration defines the maximum memory size that can be used by data reading of the sort-based blocking shuffle per task manager. Increasing the value of this option may improve the shuffle read performance, and usually, several hundreds of megabytes of memory is enough for large-scale batch jobs. Because this memory is cut from the framework off-heap memory, you may also need to increase [taskmanager.memory.framework.off-heap.size]({{< param DocsBaseUrl >}}flink-docs-release-1.14/docs/deployment/config/#taskmanager-memory-framework-off-heap-size) before you increase this value.

For more information about blocking shuffle in Flink, please refer to the [official documentation]({{< param DocsBaseUrl >}}flink-docs-release-1.14/docs/ops/batch/blocking_shuffle/).

**Note:** From the optimization mechanism in [part two](/2021/10/26/sort-shuffle-part2), we can see that the IO scheduling relies on the concurrent data read requests of the downstream consumer tasks for more sequential reads. As a result, if the downstream consumer task is running one by one (for example, because of limited resources), the advantage brought by IO scheduling disappears, which can influence performance. We may further optimize this scenario in future versions.

# What's next?

For details on the design and implementation of this feature, please refer to the [second part](/2021/10/26/sort-shuffle-part2) of this blog!