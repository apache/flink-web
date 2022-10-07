---
authors:
- andrey: null
  name: Andrey Zagrebin
categories: news
date: "2020-04-21T12:00:00Z"
excerpt: This post discusses the recent changes to the memory model of the Task Managers
  and configuration options for your Flink applications in Flink 1.10.
title: Memory Management Improvements with Apache Flink 1.10
---

Apache Flink 1.10 comes with significant changes to the memory model of the Task Managers and configuration options for your Flink applications. These recently-introduced changes make Flink more adaptable to all kinds of deployment environments (e.g. Kubernetes, Yarn, Mesos), providing strict control over its memory consumption. In this post, we describe Flink’s memory model, as it stands in Flink 1.10, how to set up and manage memory consumption of your Flink applications and the recent changes the community implemented in the latest Apache Flink release. 

## Introduction to Flink’s memory model

Having a clear understanding of Apache Flink’s memory model allows you to manage resources for the various workloads more efficiently. The following diagram illustrates the main memory components in Flink:

<center>
<img src="{{ site.baseurl }}/img/blog/2020-04-21-memory-management-improvements-flink-1.10/total-process-memory.svg" width="400px" alt="Flink: Total Process Memory"/>
<br/>
<i><small>Flink: Total Process Memory</small></i>
</center>
<br/>

The Task Manager process is a JVM process. On a high level, its memory consists of the *JVM Heap* and *Off-Heap* memory. These types of memory are consumed by Flink directly or by JVM for its specific purposes (i.e. metaspace etc.). There are two major memory consumers within Flink: the user code of job operator tasks and the framework itself consuming memory for internal data structures, network buffers, etc.

**Please note that** the user code has direct access to all memory types: *JVM Heap, Direct* and *Native memory*. Therefore, Flink cannot really control its allocation and usage. There are however two types of Off-Heap memory which are consumed by tasks and controlled explicitly by Flink:

- *Managed Memory* (Off-Heap)
- *Network Buffers*

The latter is part of the *JVM Direct Memory*, allocated for user record data exchange between operator tasks.

## How to set up Flink memory

With the latest release of Flink 1.10 and in order to provide better user experience, the framework comes with both high-level and fine-grained tuning of memory components. There are essentially three alternatives to setting up memory in Task Managers.

The first two — and simplest — alternatives are configuring one of the two following options for total memory available for the JVM process of the Task Manager:

- *Total Process Memory*: total memory consumed by the Flink Java application (including user code) and by the JVM to run the whole process.
- *Total Flink Memory*: only memory consumed by the Flink Java application, including user code but excluding memory allocated by JVM to run it

It is advisable to configure the *Total Flink Memory* for standalone deployments where explicitly declaring how much memory is given to Flink is a common practice, while the outer *JVM overhead* is of little interest. For the cases of deploying Flink in containerized environments (such as [Kubernetes]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/deployment/kubernetes.html), [Yarn]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/deployment/yarn_setup.html) or [Mesos]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/deployment/mesos.html)), the *Total Process Memory* option is recommended instead, because it becomes the size for the total memory of the requested container. Containerized environments usually strictly enforce this memory limit. 

If you want more fine-grained control over the size of *JVM Heap* and *Managed Memory* (Off-Heap), there is also a second alternative to configure both *[Task Heap]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_setup.html#task-operator-heap-memory)* and *[Managed Memory]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_setup.html#managed-memory)*. This alternative gives a clear separation between the heap memory and any other memory types.

In line with the community’s efforts to [unify batch and stream processing](https://flink.apache.org/news/2019/02/13/unified-batch-streaming-blink.html), this model works universally for both scenarios. It allows sharing the *JVM Heap* memory between the user code of operator tasks in any workload and the heap state backend in stream processing scenarios. In a similar way, the *Managed Memory* can be used for batch spilling and for the RocksDB state backend in streaming.

The remaining memory components are automatically adjusted either based on their default values or additionally configured parameters. Flink also checks the overall consistency. You can find more information about the different memory components in the corresponding [documentation]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_detail.html). Additionally, you can try different configuration options with the [configuration spreadsheet](https://docs.google.com/spreadsheets/d/1mJaMkMPfDJJ-w6nMXALYmTc4XxiV30P5U7DzgwLkSoE/edit#gid=0) of [FLIP-49](https://cwiki.apache.org/confluence/display/FLINK/FLIP-49%3A+Unified+Memory+Configuration+for+TaskExecutors) and check the corresponding results for your individual case.

If you are migrating from a Flink version older than 1.10, we suggest following the steps in the [migration guide]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_migration.html) of the Flink documentation.

## Other components

While configuring Flink’s memory, the size of different memory components can either be fixed with the value of the respective option or tuned using multiple options. Below we provide some more insight about the memory setup.

### Fractions of the Total Flink Memory

This method allows a proportional breakdown of the *Total Flink Memory* where the [Managed Memory]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_setup.html#managed-memory) (if not set explicitly) and [Network Buffers]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_detail.html#capped-fractionated-components) can take certain fractions of it. The remaining memory is then assigned to the [Task Heap]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_setup.html#task-operator-heap-memory) (if not set explicitly) and other fixed *JVM Heap* and *Off-Heap components*. The following picture represents an example of such a setup:

<center>
<img src="{{ site.baseurl }}/img/blog/2020-04-21-memory-management-improvements-flink-1.10/flink-memory-setup.svg" width="800px" alt="Flink: Example of Memory Setup"/>
<br/>
<i><small>Flink: Example of Memory Setup</small></i>
</center>
<br/>

**Please note that**

- Flink will verify that the size of the derived *Network Memory* is between its minimum and maximum value, otherwise Flink’s startup will fail. The maximum and minimum limits have default values which can be overwritten by the respective configuration options.
- In general, the configured fractions are treated by Flink as hints. Under certain scenarios, the derived value might not match the fraction. For example, if the *Total Flink Memory* and the *Task Heap* are configured to fixed values, the *Managed Memory* will get a certain fraction and the *Network Memory* will get the remaining memory which might not exactly match its fraction.

### More hints to control the container memory limit

The heap and direct memory usage are managed by the JVM. There are also many other possible sources of native memory consumption in Apache Flink or its user applications which are not managed by Flink or the JVM. Controlling their limits is often difficult which complicates debugging of potential memory leaks. If Flink’s process allocates too much memory in an unmanaged way, it can often result in killing Task Manager containers in containerized environments. In this case, it may be hard to understand which type of memory consumption has exceeded its limit. Flink 1.10 introduces some specific tuning options to clearly represent such components. Although Flink cannot always enforce strict limits and borders among them, the idea here is to explicitly plan the memory usage. Below we provide some examples of how memory setup can prevent containers exceeding their memory limit:

- [RocksDB state cannot grow too big]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_tuning.html#rocksdb-state-backend). The memory consumption of RocksDB state backend is accounted for in the *Managed Memory*. RocksDB respects its limit by default (only since Flink 1.10). You can increase the *Managed Memory* size to improve RocksDB’s performance or decrease it to save resources.

- [User code or its dependencies consume significant off-heap memory]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_setup.html#configure-off-heap-memory-direct-or-native). Tuning the *Task Off-Heap* option can assign additional direct or native memory to the user code or any of its dependencies. Flink cannot control native allocations but it sets the limit for *JVM Direct* memory allocations. The *Direct* memory limit is enforced by the JVM.

- [JVM metaspace requires additional memory]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_detail.html#jvm-parameters). If you encounter `OutOfMemoryError: Metaspace`, Flink provides an option to increase its limit and the JVM will ensure that it is not exceeded.

- [JVM requires more internal memory]({{site.DOCS_BASE_URL}}flink-docs-release-1.10/ops/memory/mem_detail.html#capped-fractionated-components). There is no direct control over certain types of JVM process allocations but Flink provides *JVM Overhead* options. The options allow declaring an additional amount of memory, anticipated for those allocations and not covered by other options.

## Conclusion

The latest Flink release (Flink 1.10) introduces some significant changes to Flink’s memory configuration, making it possible to manage your application memory and debug Flink significantly better than before. Future developments in this area also include adopting a similar memory model for the job manager process in [FLIP-116](https://cwiki.apache.org/confluence/display/FLINK/FLIP+116%3A+Unified+Memory+Configuration+for+Job+Managers), so stay tuned for more additions and features in upcoming releases. If you have any suggestions or questions for the community, we encourage you to sign up to the Apache Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) and become part of the discussion there.
