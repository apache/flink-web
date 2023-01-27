---
authors:
- Zhilong Hong: null
  name: Zhilong Hong
- Zhu Zhu: null
  name: Zhu Zhu
- DaisyTsang: null
  name: Daisy Tsang
- Till Rohrmann: null
  name: Till Rohrmann
  twitter: stsffap
date: "2022-01-04T08:00:00Z"
excerpt: To improve the performance of the scheduler for large-scale jobs, several
  optimizations were introduced in Flink 1.13 and 1.14. In this blog post we'll take
  a look at them.
title: How We Improved Scheduler Performance for Large-scale Jobs - Part One
---

# Introduction

When scheduling large-scale jobs in Flink 1.12, a lot of time is required to initialize jobs and deploy tasks. The scheduler also requires a large amount of heap memory in order to store the execution topology and host temporary deployment descriptors. For example, for a job with a topology that contains two vertices connected with an all-to-all edge and a parallelism of 10k (which means there are 10k source tasks and 10k sink tasks and every source task is connected to all sink tasks), Flink’s JobManager would require 30 GiB of heap memory and more than 4 minutes to deploy all of the tasks.

Furthermore, task deployment may block the JobManager's main thread for a long time and the JobManager will not be able to respond to any other requests from TaskManagers. This could lead to heartbeat timeouts that trigger a failover. In the worst case, this will render the Flink cluster unusable because it cannot deploy the job.

To improve the performance of the scheduler for large-scale jobs, we've implemented several optimizations in Flink 1.13 and 1.14:

1. Introduce the concept of consuming groups to optimize procedures related to the complexity of topologies, including the initialization, scheduling, failover, and partition release. This also reduces the memory required to store the topology;
2. Introduce a cache to optimize task deployment, which makes the process faster and requires less memory;
3. Leverage characteristics of the logical topology and the scheduling topology to speed up the building of pipelined regions.

# Benchmarking Results

To estimate the effect of our optimizations, we conducted several experiments to compare the performance of Flink 1.12 (before the optimization) with Flink 1.14 (after the optimization). The job in our experiments contains two vertices connected with an all-to-all edge. The parallelisms of these vertices are both 10K. To make temporary deployment descriptors distributed via the blob server, we set the configuration [blob.offload.minsize]({{< param DocsBaseUrl >}}flink-docs-release-1.14/docs/deployment/config/#blob-offload-minsize) to 100 KiB (from default value 1 MiB). This configuration means that the blobs larger than the set value will be distributed via the blob server, and the size of deployment descriptors in our test job is about 270 KiB. The results of our experiments are illustrated below:

<center>
Table 1 - The comparison of time cost between Flink 1.12 and 1.14
<table width="95%" border="1">
  <thead>
    <tr>
      <th style="text-align: center">Procedure</th>
      <th style="text-align: center">1.12</th>
      <th style="text-align: center">1.14</th>
      <th style="text-align: center">Reduction(%)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align: center">Job Initialization</td>
      <td style="text-align: center">11,431ms</td>
      <td style="text-align: center">627ms</td>
      <td style="text-align: center">94.51%</td>
    </tr>
    <tr>
      <td style="text-align: center">Task Deployment</td>
      <td style="text-align: center">63,118ms</td>
      <td style="text-align: center">17,183ms</td>
      <td style="text-align: center">72.78%</td>
    </tr>
    <tr>
      <td style="text-align: center">Computing tasks to restart when failover</td>
      <td style="text-align: center">37,195ms</td>
      <td style="text-align: center">170ms</td>
      <td style="text-align: center">99.55%</td>
    </tr>
  </tbody>
</table>
</center>

<br/>
In addition to quicker speeds, the memory usage is significantly reduced. It requires 30 GiB heap memory for a JobManager to deploy the test job and keep it running stably with Flink 1.12, while the minimum heap memory required by the JobManager with Flink 1.14 is only 2 GiB.

There are also less occurrences of long-term garbage collection. When running the test job with Flink 1.12, a garbage collection that lasts more than 10 seconds occurs during both job initialization and task deployment. With Flink 1.14, since there is no long-term garbage collection, there is also a decreased risk of heartbeat timeouts, which creates better cluster stability.

In our experiment, it took more than 4 minutes for the large-scale job with Flink 1.12 to transition to running (excluding the time spent on allocating resources). With Flink 1.14, it took no more than 30 seconds (excluding the time spent on allocating resources). The time cost is reduced by 87%. Thus, for users who are running large-scale jobs for production and want better scheduling performance, please consider upgrading Flink to 1.14.

In [part two](/2022/01/04/scheduler-performance-part-two) of this blog post, we are going to talk about these improvements in detail.
