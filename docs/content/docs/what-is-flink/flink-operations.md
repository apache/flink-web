---
title: Operations
bookCollapseSection: false
weight: 3
---

# What is Apache Flink? — Operations

Apache Flink is a framework for stateful computations over unbounded and bounded data streams. Since many streaming applications are designed to run continuously with minimal downtime, a stream processor must provide excellent failure recovery, as well as, tooling to monitor and maintain applications while they are running.

Apache Flink puts a strong focus on the operational aspects of stream processing. Here, we explain Flink's failure recovery mechanism and present its features to manage and supervise running applications.

## Run Your Applications Non-Stop 24/7

Machine and process failures are ubiquitous in distributed systems. A distributed stream processors like Flink must recover from failures in order to be able to run streaming applications 24/7. Obviously, this does not only mean to restart an application after a failure but also to ensure that its internal state remains consistent, such that the application can continue processing as if the failure had never happened.

Flink provides several features to ensure that applications keep running and remain consistent:

* **Consistent Checkpoints**: Flink's recovery mechanism is based on consistent checkpoints of an application's state. In case of a failure, the application is restarted and its state is loaded from the latest checkpoint. In combination with resettable stream sources, this feature can guarantee *exactly-once state consistency*.
* **Efficient Checkpoints**: Checkpointing the state of an application can be quite expensive if the application maintains terabytes of state. Flink's can perform asynchronous and incremental checkpoints, in order to keep the impact of checkpoints on the application's latency SLAs very small.
* **End-to-End Exactly-Once**: Flink features transactional sinks for specific storage systems that guarantee that data is only written out exactly once, even in case of failures.
* **Integration with Cluster Managers**: Flink is tightly integrated with cluster managers, such as [Hadoop YARN](https://hadoop.apache.org) or [Kubernetes](https://kubernetes.io). When a process fails, a new process is automatically started to take over its work.
* **High-Availability Setup**: Flink feature a high-availability mode that eliminates all single-points-of-failure. The HA-mode is based on [Apache ZooKeeper](https://zookeeper.apache.org), a battle-proven service for reliable distributed coordination.

## Update, Migrate, Suspend, and Resume Your Applications

Streaming applications that power business-critical services need to be maintained. Bugs need to be fixed and improvements or new features need to be implemented. However, updating a stateful streaming application is not trivial. Often one cannot simply stop the applications and restart a fixed or improved version because one cannot afford to lose the state of the application.

Flink's *Savepoints* are a unique and powerful feature that solves the issue of updating stateful applications and many other related challenges. A savepoint is a consistent snapshot of an application's state and therefore very similar to a checkpoint. However in contrast to checkpoints, savepoints need to be manually triggered and are not automatically removed when an application is stopped. A savepoint can be used to start a state-compatible application and initialize its state. Savepoints enable the following features:

* **Application Evolution**: Savepoints can be used to evolve applications. A fixed or improved version of an application can be restarted from a savepoint that was taken from a previous version of the application. It is also possible to start the application from an earlier point in time (given such a savepoint exists) to repair incorrect results produced by the flawed version.
* **Cluster Migration**: Using savepoints, applications can be migrated (or cloned) to different clusters.
* **Flink Version Updates**: An application can be migrated to run on a new Flink version using a savepoint.
* **Application Scaling**: Savepoints can be used to increase or decrease the parallelism of an application.
* **A/B Tests and What-If Scenarios**: The performance or quality of two (or more) different versions of an application can be compared by starting all versions from the same savepoint.
* **Pause and Resume**: An application can be paused by taking a savepoint and stopping it. At any later point in time, the application can be resumed from the savepoint.
* **Archiving**: Savepoints can be archived to be able to reset the state of an application to an earlier point in time.

## Monitor and Control Your Applications

Just like any other service, continuously running streaming applications need to be supervised and integrated into the operations infrastructure, i.e., monitoring and logging services, of an organization. Monitoring helps to anticipate problems and react ahead of time. Logging enables root-cause analysis to investigate failures. Finally, easily accessible interfaces to control running applications are an important feature.

Flink integrates nicely with many common logging and monitoring services and provides a REST API to control applications and query information.

* **Web UI**: Flink features a web UI to inspect, monitor, and debug running applications. It can also be used to submit executions for execution or cancel them.
* **Logging**: Flink implements the popular slf4j logging interface and integrates with the logging frameworks [log4j](https://logging.apache.org/log4j/2.x/) or [logback](https://logback.qos.ch/).
* **Metrics**: Flink features a sophisticated metrics system to collect and report system and user-defined metrics. Metrics can be exported to several reporters, including [JMX](https://en.wikipedia.org/wiki/Java_Management_Extensions), Ganglia, [Graphite](https://graphiteapp.org/), [Prometheus](https://prometheus.io/), [StatsD](https://github.com/etsy/statsd), [Datadog](https://www.datadoghq.com/), and [Slf4j](https://www.slf4j.org/).
* **REST API**: Flink exposes a REST API to submit a new application, take a savepoint of a running application, or cancel an application. The REST API also exposes meta data and collected metrics of running or completed applications.
