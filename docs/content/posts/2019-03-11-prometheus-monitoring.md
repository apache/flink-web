---
authors:
- max: null
  name: Maximilian Bode, TNG Technology Consulting
  twitter: mxpbode
categories:
- features
date: "2019-03-11T12:00:00Z"
excerpt: This blog post describes how developers can leverage Apache Flink's built-in
  metrics system together with Prometheus to observe and monitor streaming applications
  in an effective way.
title: 'Flink and Prometheus: Cloud-native monitoring of streaming applications'
---

This blog post describes how developers can leverage Apache Flink's built-in [metrics system]({{ site.DOCS_BASE_URL }}flink-docs-release-1.7/monitoring/metrics.html) together with [Prometheus](https://prometheus.io/) to observe and monitor streaming applications in an effective way. This is a follow-up post from my [Flink Forward](https://flink-forward.org/) Berlin 2018 talk ([slides](https://www.slideshare.net/MaximilianBode1/monitoring-flink-with-prometheus), [video](https://www.ververica.com/flink-forward-berlin/resources/monitoring-flink-with-prometheus)). We will cover some basic Prometheus concepts and why it is a great fit for monitoring Apache Flink stream processing jobs. There is also an example to showcase how you can utilize Prometheus with Flink to gain insights into your applications and be alerted on potential degradations of your Flink jobs.

## Why Prometheus?

Prometheus is a metrics-based monitoring system that was originally created in 2012. The system is completely open-source (under the Apache License 2) with a vibrant community behind it and it has graduated from the Cloud Native Foundation last year – a sign of maturity, stability and production-readiness. As we mentioned, the system is based on metrics and it is designed to measure the overall health, behavior and performance of a service. Prometheus features a multi-dimensional data model as well as a flexible query language. It is designed for reliability and can easily be deployed in traditional or containerized environments. Some of the important Prometheus concepts are:

* **Metrics:** Prometheus defines metrics as floats of information that change in time. These time series have millisecond precision.

* **Labels** are the key-value pairs associated with time series that support Prometheus' flexible and powerful data model – in contrast to hierarchical data structures that one might experience with traditional metrics systems.

* **Scrape:** Prometheus is a pull-based system and fetches ("scrapes") metrics data from specified sources that expose HTTP endpoints with a text-based format.

* **PromQL** is Prometheus' [query language](https://prometheus.io/docs/prometheus/latest/querying/basics/). It can be used for both building dashboards and setting up alert rules that will trigger when specific conditions are met.

When considering metrics and monitoring systems for your Flink jobs, there are many [options]({{ site.DOCS_BASE_URL }}flink-docs-release-1.7/monitoring/metrics.html). Flink offers native support for exposing data to Prometheus via the `PrometheusReporter` configuration. Setting up this integration is very easy.

Prometheus is a great choice as usually Flink jobs are not running in isolation but in a greater context of microservices. For making metrics available to Prometheus from other parts of a larger system, there are two options: There exist [libraries for all major languages](https://prometheus.io/docs/instrumenting/clientlibs/) to instrument other applications. Additionally, there is a wide variety of [exporters](https://prometheus.io/docs/instrumenting/exporters/), which are tools that expose metrics of third-party systems (like databases or Apache Kafka) as Prometheus metrics.

## Prometheus and Flink in Action

We have provided a [GitHub repository](https://github.com/mbode/flink-prometheus-example) that demonstrates the integration described above. To have a look, clone the repository, make sure [Docker](https://docs.docker.com/install/) is installed and run: 

```
./gradlew composeUp
```

This builds a Flink job using the build tool [Gradle](https://gradle.org/) and starts up a local environment based on [Docker Compose](https://docs.docker.com/compose/) running the job in a [Flink job cluster]({{ site.DOCS_BASE_URL }}flink-docs-release-1.7/ops/deployment/docker.html#flink-job-cluster) (reachable at [http://localhost:8081](http://localhost:8081/)) as well as a Prometheus instance ([http://localhost:9090](http://localhost:9090/)).

<center>
<img src="{{< siteurl >}}/img/blog/2019-03-11-prometheus-monitoring/prometheusexamplejob.png" width="600px" alt="PrometheusExampleJob in Flink Web UI"/>
<br/>
<i><small>Job graph and custom metric for example job in Flink web interface.</small></i>
</center>
<br/>

The `PrometheusExampleJob` has three operators: Random numbers up to 10,000 are generated, then a map counts the events and creates a histogram of the values passed through. Finally, the events are discarded without further output. The very simple code below is from the second operator. It illustrates how easy it is to add custom metrics relevant to your business logic into your Flink job.

```java
class FlinkMetricsExposingMapFunction extends RichMapFunction<Integer, Integer> {
  private transient Counter eventCounter;

  @Override
  public void open(Configuration parameters) {
    eventCounter = getRuntimeContext().getMetricGroup().counter("events");
  }

  @Override
  public Integer map(Integer value) {
    eventCounter.inc();
    return value;
  }
}
```
<center><i><small>Excerpt from <a href="https://github.com/mbode/flink-prometheus-example/blob/master/src/main/java/com/github/mbode/flink_prometheus_example/FlinkMetricsExposingMapFunction.java">FlinkMetricsExposingMapFunction.java</a> demonstrating custom Flink metric.</small></i></center>

## Configuring Prometheus with Flink

To start monitoring Flink with Prometheus, the following steps are necessary:

1. Make the `PrometheusReporter` jar available to the classpath of the Flink cluster (it comes with the Flink distribution):

        cp /opt/flink/opt/flink-metrics-prometheus-1.7.2.jar /opt/flink/lib

2. [Configure the reporter]({{ site.DOCS_BASE_URL }}flink-docs-release-1.7/monitoring/metrics.html#reporter) in Flink's _flink-conf.yaml_. All job managers and task managers will expose the metrics on the configured port.

        metrics.reporters: prom
        metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
        metrics.reporter.prom.port: 9999

3. Prometheus needs to know where to scrape metrics. In a static scenario, you can simply [configure Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration/) in _prometheus.yml_ with the following:

        scrape_configs:
        - job_name: 'flink'
          static_configs:
          - targets: ['job-cluster:9999', 'taskmanager1:9999', 'taskmanager2:9999']

    In more dynamic scenarios we recommend using Prometheus' service discovery support for different platforms such as Kubernetes, AWS EC2 and more.

Both custom metrics are now available in Prometheus:

<center>
<img src="{{< siteurl >}}/img/blog/2019-03-11-prometheus-monitoring/prometheus.png" width="600px" alt="Prometheus web UI with example metric"/>
<br/>
<i><small>Example metric in Prometheus web UI.</small></i>
</center>
<br/>

More technical metrics from the Flink cluster (like checkpoint sizes or duration, Kafka offsets or resource consumption) are also available. If you are interested, you can check out the HTTP endpoints exposing all Prometheus metrics for the job managers and the two task managers on [http://localhost:9249](http://localhost:9249/metrics), [http://localhost:9250](http://localhost:9250/metrics) and [http://localhost:9251](http://localhost:9251/metrics), respectively.

To test Prometheus' alerting feature, kill one of the Flink task managers via

```
docker kill taskmanager1
```

Our Flink job can recover from this partial failure via the mechanism of [Checkpointing]({{ site.DOCS_BASE_URL }}flink-docs-release-1.7/dev/stream/state/checkpointing.html). Nevertheless, after roughly one minute (as configured in the alert rule) the following alert will fire:

<center>
<img src="{{< siteurl >}}/img/blog/2019-03-11-prometheus-monitoring/prometheusalerts.png" width="600px" alt="Prometheus web UI with example alert"/>
<br/>
<i><small>Example alert in Prometheus web UI.</small></i>
</center>
<br/>

In real-world situations alerts like this one can be routed through a component called [Alertmanager](https://prometheus.io/docs/alerting/alertmanager/) and be grouped into notifications to systems like email, PagerDuty or Slack.

Go ahead and play around with the setup, and check out the [Grafana](https://grafana.com/grafana) instance reachable at [http://localhost:3000](http://localhost:3000/) (credentials _admin:flink_) for visualizing Prometheus metrics. If there are any questions or problems, feel free to [create an issue](https://github.com/mbode/flink-prometheus-example/issues). Once finished, do not forget to tear down the setup via

```
./gradlew composeDown
```
<br/>

## Conclusion

Using Prometheus together with Flink provides an easy way for effective monitoring and alerting of your Flink jobs. Both projects have exciting and vibrant communities behind them with new developments and additions scheduled for upcoming releases. We encourage you to try the two technologies together as it has immensely improved our insights into Flink jobs running in production.
