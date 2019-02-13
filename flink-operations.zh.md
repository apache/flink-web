---
title: "Apache Flink 是什么？"
---

<hr/>
<div class="row">
  <div class="col-sm-12" style="background-color: #f8f8f8;">
    <h2>
      <a href="{{ site.baseurl }}/flink-architecture.html">Architecture</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/flink-applications.html">Applications</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      Operations
    </h2>
  </div>
</div>
<hr/>

Apache Flink是针对有界（批处理）及无界（流处理）流的数据进行有状态计算的框架技术。当许多流计算应用被设计成（最小量故障的）可持续运行服务时，这就要求每一个流处理组件必须提供良好的故障恢复能力，也就意味着在他们持续运行过程中我们可以实时监控和维护他们的状态和生命周期。

Apache Flink非常注重流数据处理的可操作性。因此在这一小节中，我们详细解释flink故障恢复机制，并且介绍flink在管理和监督运行中的应用过程 中所体现出来的特点。

## 特点1：（持续稳定性）7*24小时稳定运行服务

在分布式系统中，服务故障是常有的事，为了保证服务能够7*24小时稳定运行，像Flink这样的流处理器故障恢复机制是必须要有的。显然这就意味着，它(这类流处理器)不仅要能在服务出现故障时候能够重启服务，而且还要当故障发生时，保证能够持久化服务内部各个组件的当前状态，只有这样才能保证在故障恢复时候，服务能够继续正常运行，好像故障就没有发生过一样。

Flink通过几下多种机制维护应用可持续运行及其一致性:

* **检查点的一致性**: Flink的故障恢复机制是通过建立分布式应用服务状态一致性检查点实现的，当有故障产生时，应用服务会重启后，再重新加载上一次成功备份的状态检查点信息。结合可重置的源数据流，从而保证无论什么情况下，源数据流只会流过一次*(exactly-once)*。 
* **经济高效的检查点服务**: 如果一个应用要维护一个TB级的状态信息，对此应用的状态建立检查点服务的资源开销是很高的，为了减小因检查点服务对应用的延迟性（SLAs服务等级协议）的影响，Flink采用异步及增量的方式构建检查点服务。
* **端到端的Exactly-Once(数据仅流过一次)**: Flink 通过向特定的存储系统提供流数据传输接收器的方式，即使在出现故障的状况下,也能保证数据只流过一次。
* **集成多种集群管理服务组件**: Flink已与多种集群管理服务紧密集成，如 [Hadoop YARN](https://hadoop.apache.org), [Mesos](https://mesos.apache.org), 以及 [Kubernetes](https://kubernetes.io)。当集群中某个流程任务失败后，一个新的流程服务会自动启动并替代它继续执行。 
* **内置的高可用性服务**: Flink内置了为解决单点故障问题的高可用性服务模块，此模块是基于[Apache ZooKeeper](https://zookeeper.apache.org),技术实现的，[Apache ZooKeeper](https://zookeeper.apache.org)是一种可靠的、交互式的、分布式协调服务组件。

## 特点2： Flink能够更方便的升级、迁移、挂起、恢复应用服务

强大的关键业务服务的流应用需要良好的运维服务--系统bugs需要修复和改善，业务新功能需要实现。然而升级一个有状态的流应用并不是简单的事情，因为在我们为了升级一个改进后版本而简单停止当前流应用并重启时，我们还不能丢失掉当前流应用的所处于的状态信息。

而Flink的 *Savepoints* 服务就是为解决升级服务过程中记录流应用状态信息及其相关难题而产生的一种唯一的、强大的组件。一个savePoint，就是一个应用服务状态的一致性快照，因此其与checkpoint组件的很相似，但是与checkpoint相比，savepoint服务需要手动触发启动，而且当流应用服务停止时候，它并不会自动删除。savepoint组件常被应用于启动一个已含有状态的流服务，并初始化其（备份时）状态。Savepoints组件有以下特点：

* **便于升级应用服务版本**: Savepoints组件常在应用版本升级使用，当前应用的新版本更新升级时，可以根据上一个版本程序的记录的savepoint组件内的服务状态信息来重启服务。它也可能会使用更早的Savepoints还原点来重启服务，以便于修复由于有缺陷的程序版本导致的不正确的程 序运行结果。
* **方便集群服务移植**: 通过使用Savepoints组件，流服务应用可以自由的在不同集群中迁移部署。
* **方便Flink版本升级**: 通过使用Savepoints组件，可以使应用服务在升级Flink时，更加安全便捷。
* **增加应用并行服务的扩展性**: Savepoints组件也常在增加或减少应用服务集群的并行度时使用。
* **便于A/B测试及假设分析场景对比结果**: 通过把同一应用在使用不同版本的应用程 序，基于同一个Savepoints还原点启动服务时，可以测试对比2个或多个版本程序的性能及服务质量。 
* **暂停和恢复服务**: 一个应用服务可以在新建一个SavePoint后再停止服务，以便于后面任何时间点再根据这个实时刷新的Savepoint还原点进行恢复服务。
* **归档服务**: Savepoint还提供还原点的归档服务，以便于用户能够指定时间点的Savepoints的服务数据进行重置应用服务的状态，进行恢复服务。

## 特点3：监控和控制应用服务

如其它应用服务一样，持续运行的流应用服务也需要监控及集成到一些基础设施资源管理服务中，例如一个组件的监控服务及日志服务等。监控服务有助于预测问题并提前做出反应，日志服务提供日志记录能够帮助追踪、调查、分析故障发生的根本原因。最后，便捷易用的访问控制应用服务运行的接口也是Flink的一个重要的亮点特征。

Flink与许多常见的日志记录和监视服务集成得很好，并提供了一个REST API来控制应用服务和查询应用信息。具体表现如下：

* **Web UI方式**: Flink提供了一个web UI来观察、监视和调试正在运行的应用服务。并且还可以执行或取消组件或任务的执行。
* **日志集成服务**:Flink实现了流行的slf4j日志接口，并与日志框架[log4j](https://logging.apache.org/log4j/2.x/)或[logback](https://logback.qos.ch/)集成。
* **度量服务**: Flink提供了一个复杂的度量系统来收集和报告系统和用户定义的度量指标信息。度量信息可以导出到多个报表组件服务，包括 [JMX](https://en.wikipedia.org/wiki/Java_Management_Extensions), Ganglia, [Graphite](https://graphiteapp.org/), [Prometheus](https://prometheus.io/), [StatsD](https://github.com/etsy/statsd), [Datadog](https://www.datadoghq.com/), 和 [Slf4j](https://www.slf4j.org/). 
* **标准的WEB REST API接口服务**: Flink提供多种REST API接口，有提交新应用程序、获取正在运行的应用程序的SavePoint服务信息、取消应用服务等接口。REST API还提供元数据信息和已采集的运行中或完成后的应用服务的指标信息。

<hr/>
<div class="row">
  <div class="col-sm-12" style="background-color: #f8f8f8;">
    <h2>
      <a href="{{ site.baseurl }}/flink-architecture.html">Architecture</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/flink-applications.html">Applications</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      Operations
    </h2>
  </div>
</div>
<hr/>
