---
title: "Apache Flink 是什么？"
---

<hr/>
<div class="row">
  <div class="col-sm-12" style="background-color: #f8f8f8;">
    <h2>
      架构 &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/zh/flink-applications.html">应用</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/zh/flink-operations.html">运维</a>
    </h2>
  </div>
</div>
<hr/>

Apache Flink 是一个用于对无界和有界数据流进行状态计算的框架和分布式引擎。Flink 能在所有常见集群环境中运行，并能以内存速度和任意规模进行计算。

接下来，我们来介绍一下 Flink 架构中的重要方面

<!--
<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/flink-home-graphic-update3.png" width="800px" />
</div>
-->

## 处理无界和有界数据

任何类型的数据都可以形成一种事件流。 信用卡交易，传感器测量值，机器日志或者网站和移动应用程序上的用户交互记录，所有这些数据都形成一种流。

数据可以被作为 *无界* 或者 *有界* 流来处理 

1. **无界流** 有始无终. 它们会无休止地产生数据。 无界流的数据必须连续处理，即数据被摄取后需要立刻处理。因为输入是无界的，在任何时候输入都不会完成，我们不能等到所有数据都到达再处理. 处理无界数据通常要求以特定顺序摄取事件，例如事件发生的顺序，以便能够推断结果的完整性。

2. **有界流** 有始有终。有界流可以在摄取所有数据后再进行计算。有界流所有数据可以被排序，所以并不需要有序摄取。有界流处理通常被称为批处理

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/bounded-unbounded.png" width="600px" />
</div>

**Apache Flink 擅长处理无界和有界数据集** 精确的时间控制和状态化使得 Flink 的运行时(runtime)能够运行任何处理无界流的应用。有界流则由一些专为固定大小数据集特殊设计的算法和数据结构进行内部处理，产生了出色的性能。

浏览一些基于 Flink 的 [用例]({{ site.baseurl }}/zh/usecases.html) 来加深理解。

## 部署应用到任意地方

Apache Flink 是一个分布式系统，它需要计算资源来执行提交的程序。Flink 集成了所有常见的集群资源管理器，例如 [Hadoop YARN](https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/YARN.html)、 [Apache Mesos](https://mesos.apache.org) 和 [Kubernetes](https://kubernetes.io/)，但同时也可以作为独立集群运行。

Flink 能够很好地运作在上述资源管理器中。 因为通过 resource-manager-specific 部署模式， Flink 可以采用与当前资源管理器相适应的方式进行交互。

部署 Flink 应用程序时，Flink会根据应用程序配置的并行度自动鉴定所需资源，并从资源管理器申请。 如果发生故障，Flink 将会请求新资源替换发生故障的容器。 采用REST接口调用的方式作为提交或控制应用程序的通信， 降低了 Flink 在各种环境中的集成难度。

<!-- Add this section once library deployment mode is supported. -->
<!--

Flink 提供了两种应用程序部署模式，即 *框架模式* 和 *库模式*

* 在 **框架部署模式** 中，客户端将 Flink 应用程序提交到一个 运行中的 Flink 服务中，由该服务负责执行提交的应用程序。在查询引擎系统和数据库系统等众多大数据处理框架中，这是一种很通用的部署方式。

* 在 **库部署模式中**，Flink 应用程序与 Flink 主可执行程序一起打包成 (Docker) 映像。另一个独立于作业的映像包含可执行的 Flink 工作程序。当从作业映像启动容器时，将启动 Flink 主进程并自动加载嵌入的应用程序。从工作镜像启动的容器，引导 Flink 工作进程自动连接到主进程。容器管理器（比如 Kubernetes）监控正在运行的容器并自动重启失败的容器。在着中国模式下，你不需要在集群中安装和维护 Flink 服务。只需将 Flink 作为库打包到应用程序中。这种模型在部署微服务时非常流行。

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/deployment-modes.png" width="600px" />
</div>

-->

## 运行任意规模应用

Flink 旨在任意规模上运行有状态流式应用。应用程序变为数千个分布在集群中并发运行的任务，所以应用程序能够充分利用无尽的 CPU、内存、磁盘和网络 IO。而且 Flink 很容易维护非常大的应用程序状态。其异步和增量的检查点算法对处理延迟产生最小的影响，同时保证精确一次状态的一致性。

Flink 用户报告了其生产环境中一些[令人印象深刻的扩展性数字]({{ site.baseurl }}/zh/poweredby.html)

* 处理**每天处理数万亿的事件**,
* 维护**几TB大小的状态**, 和
* 运行**数以千计的应用**.

## 利用内存性能

有状态的 Flink 程序针对本地状态访问进行了优化。任务的状态始终保留在内存中，如果状态大小超过可用内存，则会保存在能高效访问的磁盘数据结构中。任务通过访问本地（通常在内存中）状态来进行所有的计算，所以只产生很低的处理延迟。Flink 通过定期和异步地对本地状态进行持久化存储来保证故障场景下精确一次的状态一致性。
<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/local-state.png" width="600px" />
</div>

<hr/>
<div class="row">
  <div class="col-sm-12" style="background-color: #f8f8f8;">
    <h2>
      架构 &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/zh/flink-applications.html">应用</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/zh/flink-operations.html">运维</a>
    </h2>
  </div>
</div>
<hr/>
