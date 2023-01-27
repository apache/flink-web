---
authors:
- Zhilong Hong: null
  name: Zhilong Hong
- Zhu Zhu: null
  name: Zhu Zhu
- Daisy Tsang: null
  name: Daisy Tsang
- Till Rohrmann: null
  name: Till Rohrmann
  twitter: stsffap
date: "2022-01-04T08:00:00Z"
excerpt: Part one of this blog post briefly introduced the optimizations we’ve made
  to improve the performance of the scheduler; compared to Flink 1.12, the time cost
  and memory usage of scheduling large-scale jobs in Flink 1.14 is significantly reduced.
  In part two, we will elaborate on the details of these optimizations.
title: How We Improved Scheduler Performance for Large-scale Jobs - Part Two
---

[Part one](/2022/01/04/scheduler-performance-part-one) of this blog post briefly introduced the optimizations we’ve made to improve the performance of the scheduler; compared to Flink 1.12, the time cost and memory usage of scheduling large-scale jobs in Flink 1.14 is significantly reduced. In part two, we will elaborate on the details of these optimizations.

{% toc %}

# Reducing complexity with groups

A distribution pattern describes how consumer tasks are connected to producer tasks. Currently, there are two distribution patterns in Flink: pointwise and all-to-all. When the distribution pattern is pointwise between two vertices, the [computational complexity](https://en.wikipedia.org/wiki/Big_O_notation) of traversing all edges is O(n). When the distribution pattern is all-to-all, the complexity of traversing all edges is O(n<sup>2</sup>), which means that complexity increases rapidly when the scale goes up.

<center>
<br/>
<img src="{{< siteurl >}}/img/blog/2022-01-05-scheduler-performance/1-distribution-pattern.svg" width="75%"/>
<br/>
Fig. 1 - Two distribution patterns in Flink
</center>

<br/>
In Flink 1.12, the [ExecutionEdge]({{< param DocsBaseUrl >}}flink-docs-release-1.12/api/java/org/apache/flink/runtime/executiongraph/ExecutionEdge.html) class is used to store the information of connections between tasks. This means that for the all-to-all distribution pattern, there would be O(n<sup>2</sup>) ExecutionEdges, which would take up a lot of memory for large-scale jobs. For two [JobVertices]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/jobgraph/JobVertex.html) connected with an all-to-all edge and a parallelism of 10K, it would take more than 4 GiB memory to store 100M ExecutionEdges. Since there can be multiple all-to-all connections between vertices in production jobs, the amount of memory required would increase rapidly.

As we can see in Fig. 1, for two JobVertices connected with the all-to-all distribution pattern, all [IntermediateResultPartitions]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/executiongraph/IntermediateResultPartition.html) produced by upstream [ExecutionVertices]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/executiongraph/ExecutionVertex.html) are [isomorphic](https://en.wikipedia.org/wiki/Isomorphism), which means that the downstream ExecutionVertices they connect to are exactly the same. The downstream ExecutionVertices belonging to the same JobVertex are also isomorphic, as the upstream IntermediateResultPartitions they connect to are the same too. Since every [JobEdge]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/jobgraph/JobEdge.html) has exactly one distribution type, we can divide vertices and result partitions into groups according to the distribution type of the JobEdge.

For the all-to-all distribution pattern, since all downstream ExecutionVertices belonging to the same JobVertex are isomorphic and belong to a single group, all the result partitions they consume are connected to this group. This group is called [ConsumerVertexGroup]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/scheduler/strategy/ConsumerVertexGroup.html). Inversely, all the upstream result partitions are grouped into a single group, and all the consumer vertices are connected to this group. This group is called [ConsumedPartitionGroup]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/scheduler/strategy/ConsumedPartitionGroup.html).

The basic idea of our optimizations is to put all the vertices that consume the same result partitions into one ConsumerVertexGroup, and put all the result partitions with the same consumer vertices into one ConsumedPartitionGroup.

<center>
<br/>
<img src="{{< siteurl >}}/img/blog/2022-01-05-scheduler-performance/2-groups.svg" width="80%"/>
<br/>
Fig. 2 - How partitions and vertices are grouped w.r.t. distribution patterns
</center>

<br/>
When scheduling tasks, Flink needs to iterate over all the connections between result partitions and consumer vertices. In the past, since there were O(n<sup>2</sup>) edges in total, the overall complexity of the iteration was O(n<sup>2</sup>). Now ExecutionEdge is replaced with ConsumerVertexGroup and ConsumedPartitionGroup. As all the isomorphic result partitions are connected to the same downstream ConsumerVertexGroup, when the scheduler iterates over all the connections, it just needs to iterate over the group once. The computational complexity decreases from O(n<sup>2</sup>) to O(n).

For the pointwise distribution pattern, one ConsumedPartitionGroup is connected to one ConsumerVertexGroup point-to-point. The number of groups is the same as the number of ExecutionEdges. Thus, the computational complexity of iterating over the groups is still O(n).

For the example job we mentioned above, replacing ExecutionEdges with the groups can effectively reduce the memory usage of [ExecutionGraph]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/executiongraph/ExecutionGraph.html) from more than 4 GiB to about 12 MiB. Based on the concept of groups, we further optimized several procedures, including job initialization, scheduling tasks, failover, and partition releasing. These procedures are all involved with traversing all consumer vertices for all the partitions. After the optimization, their overall computational complexity decreases from O(n<sup>2</sup>) to O(n).

# Optimizations related to task deployment

## The problem

In Flink 1.12, it takes a long time to deploy tasks for large-scale jobs if they contain all-to-all edges. Furthermore, a heartbeat timeout may happen during or after task deployment, which makes the cluster unstable.

Currently, task deployment includes the following steps:

1. A JobManager creates [TaskDeploymentDescriptors]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/deployment/TaskDeploymentDescriptor.html) for each task, which happens in the JobManager's main thread;
2. The JobManager serializes TaskDeploymentDescriptors asynchronously;
3. The JobManager ships serialized TaskDeploymentDescriptors to TaskManagers via RPC messages;
4. TaskManagers create new tasks based on the TaskDeploymentDescriptors and execute them.

A TaskDeploymentDescriptor (TDD) contains all the information required by TaskManagers to create a task. At the beginning of task deployment, a JobManager creates the TDDs for all tasks. Since this happens in the main thread, the JobManager cannot respond to any other requests. For large-scale jobs, the main thread may get blocked for a long time, heartbeat timeouts may happen, and a failover would be triggered.

A JobManager can become a bottleneck during task deployment since all descriptors are transmitted from it to all TaskManagers. For large-scale jobs, these temporary descriptors would require a lot of heap memory and cause frequent long-term garbage collection pauses.

Thus, we need to speed up the creation of the TDDs. Furthermore, if the size of descriptors can be reduced, then they will be transmitted faster, which leads to faster task deployments.

## The solution

### Cache ShuffleDescriptors

[ShuffleDescriptor]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/shuffle/ShuffleDescriptor.html)s are used to describe the information of result partitions that a task consumes and can be the largest part of a TaskDeploymentDescriptor. For an all-to-all edge, when the parallelisms of both upstream and downstream vertices are n, the number of ShuffleDescriptors for each downstream vertex is n, since they are connected to n upstream vertices. Thus, the total count of the ShuffleDescriptors for the vertices is n2.

However, the ShuffleDescriptors for the downstream vertices are all the same since they all consume the same upstream result partitions. Therefore, Flink doesn't need to create ShuffleDescriptors for each downstream vertex individually. Instead, it can create them once and cache them to be reused. This will decrease the overall complexity of creating TaskDeploymentDescriptors for tasks from O(n<sup>2</sup>) to O(n).

To decrease the size of RPC messages and reduce the transmission of replicated data over the network, the cached ShuffleDescriptors can be compressed. For the example job we mentioned above, if the parallelisms of vertices are both 10k, then each downstream vertex has 10k ShuffleDescriptors. After compression, the size of the serialized value would be reduced by 72%.

### Distribute ShuffleDescriptors via the blob server

A [blob](https://en.wikipedia.org/wiki/Binary_large_object) (binary large objects) is a collection of binary data used to store large files. Flink hosts a blob server to transport large-sized data between the JobManager and TaskManagers. When a JobManager decides to transmit a large file to TaskManagers, it would first store the file in the blob server (will also upload files to the distributed file system) and get a token representing the blob, called the blob key. It would then transmit the blob key instead of the blob file to TaskManagers. When TaskManagers get the blob key, they will retrieve the file from the distributed file system (DFS). The blobs are stored in the blob cache on TaskManagers so that they only need to retrieve the file once.

During task deployment, the JobManager is responsible for distributing the ShuffleDescriptors to TaskManagers via RPC messages. The messages will be garbage collected once they are sent. However, if the JobManager cannot send the messages as fast as they are created, these messages would take up a lot of space in heap memory and become a heavy burden for the garbage collector to deal with. There will be more long-term garbage collections that stop the world and slow down the task deployment.

To solve this problem, the blob server can be used to distribute large ShuffleDescriptors. The JobManager first sends ShuffleDescriptors to the blob server, which stores ShuffleDescriptors in the DFS. TaskManagers request ShuffleDescriptors from the DFS once they begin to process TaskDeploymentDescriptors. With this change, the JobManager doesn't need to keep all the copies of ShuffleDescriptors in heap memory until they are sent. Moreover, the frequency of garbage collections for large-scale jobs is significantly reduced. Also, task deployment will be faster since there will be no bottleneck during task deployment anymore, because the DFS provides multiple distributed nodes for TaskManagers to download the ShuffleDescriptors from.

<center>
<br/>
<img src="{{< siteurl >}}/img/blog/2022-01-05-scheduler-performance/3-how-shuffle-descriptors-are-distributed.svg" width="80%"/>
<br/>
Fig. 3 - How ShuffleDescriptors are distributed
</center>

<br/>
To avoid running out of space on the local disk, the cache will be cleared when the related partitions are no longer valid and a size limit is added for ShuffleDescriptors in the blob cache on TaskManagers. If the overall size exceeds the limit, the least recently used cached value will be removed. This ensures that the local disks on the JobManager and TaskManagers won't be filled up with ShuffleDescriptors, especially in session mode.

# Optimizations when building pipelined regions

In Flink, there are two types of data exchanges: pipelined and blocking. When using blocking data exchanges, result partitions are first fully produced and then consumed by the downstream vertices. The produced results are persisted and can be consumed multiple times. When using pipelined data exchanges, result partitions are produced and consumed concurrently. The produced results are not persisted and can be consumed only once.

Since the pipelined data stream is produced and consumed simultaneously, Flink needs to make sure that the vertices connected via pipelined data exchanges execute at the same time. These vertices form a [pipelined region]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/topology/PipelinedRegion.html). The pipelined region is the basic unit of scheduling and failover by default. During scheduling, all vertices in a pipelined region will be scheduled together, and all pipelined regions in the graph will be scheduled one by one topologically.

<center>
<br/>
<img src="{{< siteurl >}}/img/blog/2022-01-05-scheduler-performance/4-pipelined-region.svg" width="90%"/>
<br/>
Fig. 4 - The LogicalPipelinedRegion and the SchedulingPipelinedRegion
</center>

<br/>
Currently, there are two types of pipelined regions in the scheduler: [LogicalPipelinedRegion]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/jobgraph/topology/LogicalPipelinedRegion.html) and [SchedulingPipelinedRegion]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/scheduler/strategy/SchedulingPipelinedRegion.html). The LogicalPipelinedRegion denotes the pipelined regions on the logical level. It consists of JobVertices and forms the [JobGraph]({{< param DocsBaseUrl >}}flink-docs-release-1.14/api/java/org/apache/flink/runtime/jobgraph/JobGraph.html). The SchedulingPipelinedRegion denotes the pipelined regions on the execution level. It consists of ExecutionVertices and forms the ExecutionGraph. Like ExecutionVertices are derived from a JobVertex, SchedulingPipelinedRegions are derived from a LogicalPipelinedRegion, as Fig. 4 shows.

During the construction of pipelined regions, a problem arises: There may be cyclic dependencies between pipelined regions. A pipelined region can be scheduled if and only if all its dependencies have finished. However, if there are two pipelined regions with cyclic dependencies between each other, there will be a scheduling [deadlock](https://en.wikipedia.org/wiki/Deadlock). They are both waiting for the other one to be scheduled first, and none of them can be scheduled. Therefore, [Tarjan's strongly connected components algorithm](https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm) is adopted to discover the cyclic dependencies between regions and merge them into one pipelined region. It will traverse all the edges in the topology. For the all-to-all distribution pattern, the number of edges is O(n<sup>2</sup>). Thus, the computational complexity of this algorithm is O(n<sup>2</sup>), and it significantly slows down the initialization of the scheduler.

<center>
<br/>
<img src="{{< siteurl >}}/img/blog/2022-01-05-scheduler-performance/5-scheduling-deadlock.svg" width="90%"/>
<br/>
Fig. 5 - The topology with scheduling deadlock
</center>

<br/>
To speed up the construction of pipelined regions, the relevance between the logical topology and the scheduling topology can be leveraged. Since a SchedulingPipelinedRegion is derived from just one LogicalPipelinedRegion, Flink traverses all LogicalPipelinedRegions and converts them into SchedulingPipelinedRegions one by one. The conversion varies based on the distribution patterns of edges that connect vertices in the LogicalPipelinedRegion.

If there are any all-to-all distribution patterns inside the region, the entire region can just be converted into one SchedulingPipelinedRegion directly. That's because for the all-to-all edge with the pipelined data exchange, all the regions connected to this edge must execute simultaneously, which means they are merged into one region. For the all-to-all edge with a blocking data exchange, it will introduce cyclic dependencies, as Fig. 5 shows. All the regions it connects must be merged into one region to avoid scheduling deadlock, as Fig. 6 shows. Since there's no need to use Tarjan's algorithm, the computational complexity in this case is O(n).

If there are only pointwise distribution patterns inside a region, Tarjan's strongly connected components algorithm is still used to ensure no cyclic dependencies. Since there are only pointwise distribution patterns, the number of edges in the topology is O(n), and the computational complexity of the algorithm will be O(n).

<center>
<br/>
<img src="{{< siteurl >}}/img/blog/2022-01-05-scheduler-performance/6-building-pipelined-region.svg" width="90%"/>
<br/>
Fig. 6 - How to convert a LogicalPipelinedRegion to ScheduledPipelinedRegions
</center>

<br/>
After the optimization, the overall computational complexity of building pipelined regions decreases from O(n<sup>2</sup>) to O(n). In our experiments, for the job which contains two vertices connected with a blocking all-to-all edge, when their parallelisms are both 10K, the time of building pipelined regions decreases by 99%, from 8,257 ms to 120 ms.

# Summary

All in all, we've done several optimizations to improve the scheduler’s performance for large-scale jobs in Flink 1.13 and 1.14. The optimizations involve procedures including job initialization, scheduling, task deployment, and failover. If you have any questions about them, please feel free to start a discussion in the dev mail list.
