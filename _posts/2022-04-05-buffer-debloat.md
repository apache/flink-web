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
One of the most important features of Flink is providing a streaming experience with maximum possible throughput.
In other words, the main target to keep the operator always busy and avoid idleness.
The obvious way to achieve that is using buffers which collect records while incoming stream rate grater than processing speed and utilize them when necessary. This approach helps to handle temporal spikes in data flow
but it also brings complexity in terms of configuration of buffers since on the one hand,
then bigger buffer size then longer spike can be handled, but on the other hand, the memory has limited capacity and
it should be configured in optimal way.

This article explains how Flink can help to find good balance between the maximum throughput and the minimum memory usage.

## Network stack

A detailed explanation of the network stack can be found in the earlier [Flink's Network Stack](https://flink.apache.org/2019/06/05/flink-network-stack.html) block post.

Here we just recall a couple of important things which explains how they minimize idleness of operators.

### Network buffer

Logically Flink’s unit of data is a record that is handled in each subtask but the overhead for sending a single record 
between subtasks is too high it’s why physically, Flink buffers outbound records into so-called network buffers which are, 
roughly speaking, byte arrays of limited size and represent the smallest unit of data that is then sent via network. 
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

## How to minimize the memory usage?

As was described above, the high throughput can be reached when the in-flight data is configured to a high value 
at the same time memory is limited and it makes sense to configure it to the optimal size greater which the throughput won't be changed anyway. 
Obviously, this value can be found manually in experimental way but let's discuss how Flink can help with that.

Flink can be switched to focusing on the time for which in-flight data can be processed rather than the size of this data.
This Flink's feature is called buffer debloating that automatically adjusts the size of the in-flight data depending on the current throughput
which allows for keeping the processing time near the configured one.
For example, instead of configuring 1GB of in-flight data per subtask, 
it makes more sense to configure 1 second as the maximum expected time for processing all in-flight data on one subtask.
Then, the following behaviours will be observed:

- In case of [backpressure](https://flink.apache.org/2021/07/07/backpressure.html):
  - The checkpoint time for [aligned checkpoint](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#checkpointing) become more predictable since we know that every task holds in-flight data 
which can be processed for the configured time, which is important since [aligned checkpoint's barriers](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#barriers) travels along with other buffers in the same priority
  - The size of files on disk for [unaligned checkpoint](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#unaligned-checkpointing) 
is decreased since during the backpressure the processing time increases which means that for conformity the configured processing time Flink should keep less in-flight data
- In case of zero [backpressure](https://flink.apache.org/2021/07/07/backpressure.html):
  - Zero backpressure means that the processing time is low enough and Flink can store more in-flight data for keeping the configured processing time 
which makes the subtask prepared for possible instabilities.

## How does buffer debloating work?

Conceptually, Flink has two major parameters for configuring in-flight data - the size of the network buffer(the segment) 
and the number of maximum network buffers(managed by several real settings).
Currently, the buffer debloating manages the memory usage by adjusting only the size of the network buffer while the number of network buffers remains always the constant.

<div class="alert alert-info">
The buffer debloating doesn't change the actual buffer size but limits the usage of each buffer to some adaptable maximum. 
As a consequence, it does not reduce the actual heap memory usage but reduces the amount of data and, hence, comes with the mentioned benefits.
</div>

The buffer debloating process can be split into the following steps:
1. The buffer debloat constantly calculates the current throughput of the subtask. 
2. Based on this throughput, and the number of the network buffers, and configured maximum processing time, 
the buffer debloat calculates the new network buffer size.
3. When the new buffer size is calculated, Flink smoothing the value in order to avoid  smooth spikes. 
As result, if the new buffer size is significantly different from the old one, the subtask propagates this new size to all upstreams of the gate for which the buffer size was calculated.

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/blog/2022-03-28-buffer-debloat/buffer-debloat.gif"/>
</div>
<div class="alert alert-info">
The picture shows that when the throughput is decreased the buffer size also decreased(but physical allocated memory stay the same). 
This is allows us to process all buffers for the same time as with higher throughput. But as soon as the throughput is increased again, 
the network buffer size will be increased as well which allows avoiding idling due to insufficient prepared buffers. 

The important notice here is that the buffer debloating has some gap in time between detection the new throughput and actual changing the network buffer size.
</div>

## Should I use it always?

The buffer debloat tries to predict the future load rate based on the current throughput. It can handle pretty well different types of spikes 
and provide predictable [checkpoints](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#checkpointing) times. 
But since the buffer debloat has inertia in making decisions about new buffer size 
it is always a risk that adaption for new conditions would be not fast enough which can lead to lower throughput than theoretically expected.
In any case, the buffer debloating can be used as a default option but if it was proven that it works not so well in certain cases, 
the feature can be disabled. The buffer debloating is especially helpful if you:

- Have the [aligned checkpoint](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#checkpointing) with volatile(or unexpectedly large) checkpoint time and want to do it more predictable
- Have the [unaligned checkpoints](https://nightlies.apache.org/flink/flink-docs-master/docs/concepts/stateful-stream-processing/#unaligned-checkpointing) with undesirable large checkpoint files on disk and want to decrease the size of these files

Despite the buffer debloat working well enough in most cases and can be used as the solution by default, it is not perfect and it has a couple of [limitations](https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/memory/network_mem_tuning/#limitations):

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
