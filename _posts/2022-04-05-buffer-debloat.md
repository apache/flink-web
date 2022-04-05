---
layout: post
title: "Buffer debloating overview"
date: 2022-04-05 00:00:00
authors:
- akalashnikov:
  name: "Anton Kalashnikov"
excerpt: Apache Flink adjust buffer size automatically in order to keep a balance the high throughput and the memory usage  
---

## What is this article about?
One of the most important features of Flink is providing a streaming experience with maximum possible throughput and minimum possible overhead. 
What does it actually mean? Let’s take a look at an ideal scenario:

Suppose we have the job and environment that provide the one and constant processing time among all subtasks and zero delays(network, processing) and no connection issues. 
In this case, the job processing looks like this:

While the downstream is processing record1, record2 is sent via the network, and record3 is processed by the upstream.
As soon as the downstream has processed record1, record2 is ready to be processed, and so on.
As we see here, the subtasks are always busy which guarantees us the maximum throughput and at the same time,
It also doesn't use a lot of extra memory since it takes the record for processing as soon as it arrived.

Unfortunately, it is obviously not reachable conditions in real life since all operators have different processing times(due to different logic, different record size, etc.), 
and there are also different types of issues with the environment(network, server, software) that can lead to unpredictable delays.
As result, it is not trivial to support the maximum possible throughput. It is why Flink implements different approaches to level out different types of instabilities.

This article explains what is the buffer debloating feature and how it can help to reach the optimal balance between throughput and overhead.

But before we look at details let’s remember how Flink transfers the data between subtasks.


## Network stack

A detailed explanation of the network stack can be found in the earlier [Flink's Network Stack](https://flink.apache.org/2019/06/05/flink-network-stack.html) block post.

Here we just recall a couple of important things.

### Network buffer

Logically Flink’s unit of data is a record that is handled in each subtask but the overhead for sending a single record 
between subtasks is too high it’s why physically, Flink gather records into the network buffer 
which is the smallest unit of sending data to subtasks(link for subtask). 
In fact, it is not always true that the network buffer contains several records. 
Since the network buffer has statically configured size it depends on the size of records how many of them fit into the network buffer 
or even one record is split into several buffers.

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/blog/2022-03-28-buffer-debloat/network-buffer.gif"/>
</div>

<div class="alert alert-warning">
It is an imaginary example it is not how Flink really works. The picture just shows that the network buffer could work perfectly fine with ideal conditions.
</div>

But what if the processing time would be constantly changed for each subtask independently?.  

### Network buffer queue

The network buffer is a good tread off for keeping high throughput but it is not enough since 
the network buffer is the smallest unit of sending data and if the subtask can hold only one of them at one time 
it can lead to high idle time in case of delay with receiving the network buffer from upstream. 
To level out instability with the network or with handling data, Flink has a network buffer's queue(also known as in-flight data) in the input and output side of the process.

Conceptually, produced output records are compounded to the network buffer and as soon as 
it would be full(or timeout happens) it is put into the output network buffer queue. 
Then the network buffer is sent to the following subtask when the receiver side has space for the new buffer(link for credit?). 
At the same time, the received subtask takes the network buffer from the top of the network buffer queue 
and it can process records from it while the queue continues to receive new data from the upstream subtask.

As a result, the presence of in-flight data helps to level out instability with receiving data, 
more precisely it allows collecting data when receiving data is at a higher rate than it can process, 
and process this data as soon as the operator will be available.

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/blog/2022-03-28-buffer-debloat/network-buffer-queue.gif"/>
</div>

<div class="alert alert-warning">
It is highly abstracted example how Flink works. In reality, everything is more complex, for example, 
the buffer can be sent by timeout even if it isn't full and the queue contains two types of buffers - exclusive and floating which work differently on input and output side.
But in general, the picture shows that despite the different speeds of processing data at different times the downstream unlikely will be idling due to short instabilities since it has buffered data in the queue for processing.
</div>

Is it resolve all of our problems? Or is something else left?

## What else can go wrong?

Unfortunately, the approach above has a number of drawbacks. But before we dive into it let’s remember a couple of things. 
First, the meaning [backpressure](https://flink.apache.org/2021/07/07/backpressure.html) refers to the situation where a system is receiving data at a higher rate than it can process during a temporary load spike. 
Secondly, a couple of notices about [checkpoints](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#checkpointing):

- [Checkpoint's barriers](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#barriers) for aligned checkpoints travel to the next subtask along with other network buffers in the same priority.
- All in-flight data for [unaligned checkpoints](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#unaligned-checkpointing) should be stored along with operators' states.

Now, let’s try to answer the question - how much in-flight data should be configured? 
First, in-flight data is configured by the number of the network buffers and the size of this buffer.
Since the network buffer has a static size and this size can be only set in the configuration as well as the total number of buffers, 
the maximum total size of all buffers can not be changed in runtime. According to this, we can consider two scenarios:

1. Suppose we configure the in-flight data to a relatively large number. Then during the high backpressure, all queues reach maximum capacity. 
This means that in the case of high backpressure when all queues are full, the subtasks requires some time to handle all in-flight data. That leads:

  - to high unpredictable checkpoint time for aligned checkpoint(since as we mentioned above checkpoint's barriers stuck in the same queue along with other buffers).  
  - to large stored checkpoint size for unaligned checkpoint since it should store all in-flight data.
  
2. If we configure the in-flight data to a small number. Then in case of network/load volatility, 
the network buffer queue would be filled too fast when the subtask is busy and it would contain not enough data when the subtask is ready to process
which leads to a high idle time or in other words less throughput than possible.

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/blog/2022-03-28-buffer-debloat/checkpoint-barrier.png"/>
</div>

<div class="alert alert-info">
According to the picture, in case of network buffer size is large enough and Subtask B.1 is processing slow,
then the checkpoint barrier stuck in the network buffer queue for a while. But in case of small the network buffer size,
Subtask B.1 can process all buffers from the queue faster than Subtask A.1 produces the new network buffer and this network buffer 
would be transferred to Subtask B.1 which can lead to the idling of B.1 and as result to decreasing of the throughput.
</div>

In conclusion, the main problem is achieving the optimal size of the in-flight in order to have the highest throughput along with minimum overhead.

## What is the possible solution?

As we saw before, it is not possible to totally avoid in-flight data since it will lead to dramatically low throughput. 
It is why one of the ideas is to focus on the time for which in-flight data can be processed rather than the size of this data. 
For example, instead of configuring 1GB of in-flight data per subtask, 
it makes more sense to configure 1 second as the maximum expected time for processing all in-flight data on one subtask.
If we get back to our scenarios we will see that:

- In case of backpressure:
  - The checkpoint time for aligned checkpoint become more predictable since we know that every task holds in-flight data 
which can be processed for the configured time, rather than as in the past when it was impossible to predict 
how much time is required for processing configured in-flight data size(it depends on the speed of processing which is changing a lot during the time)  
  - The in-fligh for unaligned checkpoint decreases the size for the store since during the backpressure the processing time is decreasing which means that for conformity the configured processing time Flink should keep less in-flight data
- In case of zero backpressure:
  - Zero backpressure means that the processing time is low enough and Flink can store more in-flight data for keeping the configured processing time 
which makes the subtask prepared for possible instabilities.

Flink implements the feature of buffer debloating which automatically adjusts the size of the in-flight data depending on the current throughput 
which allows for keeping the processing time near the configured one.

## How does buffer debloating work?

Conceptually, Flink has two major parameters for configuring in-flight data - the size of the network buffer(the segment) 
and the number of maximum network buffers(managed by several real settings). 
The buffer debloating theoretically can change all of these parameters to reach the desirable total in-flight data size but currently, 
it is implemented only by changing the size of the network buffer.
First, the buffer debloat constantly calculates the current throughput of the subtask. 
Based on this throughput, and the number of the network buffers, and configured maximum processing time, 
the buffer debloat calculates the new network buffer size.
When the new buffer size is calculated, Flink smoothing the value in order to avoid  smooth spikes. 
As result, if the new buffer size is significantly different from the old one, the subtask propagates this new size to all upstreams of the gate for which the buffer size was calculated.

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/blog/2022-03-28-buffer-debloat/buffer-debloat.gif"/>
</div>
<div class="alert alert-info">
The picture shows that when the throughput is decreased the buffer size also decreased(but physical allocated memory stay the same). 
This is allows us to process all buffers for the same time as with higher throughput. But as soon as the throughput is increased again, 
the network buffer size will be increased as well which allows avoiding idling due to insufficient prepared buffers. 

The important notice here is that the buffer debloating has some gap in time between detection the new throughput and actual changing the network buffer size. 
It is why some specific cases can be handled worse than expected.
</div>

## Should I use it always?

The buffer debloat tries to predict the future load rate based on the current throughput. It can handle pretty well different types of spikes 
and provide predictable checkpoint times. But since the buffer debloat has inertia in making decisions about new buffer size 
it is always a risk that adaption for new conditions would be not fast enough which can lead to lower throughput than theoretically expected.
In any case, the buffer debloating can be used as a default option but if it was proven that it works not so well in certain cases, 
the feature can be disabled. The buffer debloating is especially helpful if you:

- Have the aligned checkpoint with volatile(or unexpectedly large) checkpoint time and want to do it more predictable
- Have the unaligned checkpoint with undesirable large checkpoint files and want to decrease the size of the files

Despite the buffer debloat working well enough in most cases and can be used as the solution by default, it is not perfect has a couple of [limitations](https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/memory/network_mem_tuning/#limitations):

### Buffer size and number of buffers

Currently, buffer debloating only caps at the maximal used buffer size. The actual buffer size and the number of buffers remain unchanged. 
This means that the debloating mechanism cannot reduce the memory usage of your job. 
You would have to manually reduce either the amount or the size of the buffers.

Furthermore, if you want to reduce the amount of buffered in-flight data below what buffer debloating currently allows, 
you might want to manually configure the number of buffers.

### High parallelism

Currently, the buffer debloating mechanism might not perform correctly with high parallelism (above ~200) using the default configuration. 
If you observe reduced throughput or higher than expected checkpointing times we suggest increasing the number of floating buffers (taskmanager.network.memory.floating-buffers-per-gate) 
from the default value to at least the number equal to the parallelism.

The actual value of parallelism from which the problem occurs is various from job to job but normally it should be more than a couple of hundreds.

## How I can adapt it for my scenario?

The most valuable advices for adapting Flink network to certain scenario can be found in [network memory tuning guide](https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/memory/network_mem_tuning).
Let's consider here a couple of things related to the buffer debloating.

If you have a varying load in your Job (i.e. sudden spikes of incoming records, periodically firing windowed aggregations or joins), you might need to adjust the following settings:

- taskmanager.network.memory.buffer-debloat.period - This is the minimum time period between buffer size recalculation. 
The shorter the period, the faster the reaction time of the debloating mechanism but the higher the CPU overhead for the necessary calculations.
- taskmanager.network.memory.buffer-debloat.samples - This adjusts the number of samples over which throughput measurements are averaged out. 
The frequency of the collected samples can be adjusted via taskmanager.network.memory.buffer-debloat.period. 
The fewer the samples, the faster the reaction time of the debloating mechanism, but a higher chance of a sudden spike 
or drop of the throughput which can cause the buffer debloating mechanism to miscalculate the optimal amount of in-flight data.
- taskmanager.network.memory.buffer-debloat.threshold-percentages - An optimization for preventing frequent buffer size changes 
(i.e. if the new size is not much different compared to the old size).

As was told above, the actual buffer size and the number of buffers remain unchanged but if it needs to be changed the detailed explanation how to do so can be found on [network memory tuning guide](https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/memory/network_mem_tuning/#the-number-of-in-flight-buffers).
