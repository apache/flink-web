---
title:  "Apache Flink Kubernetes Operator 1.7.0 Release Announcement"
date: "2023-11-22T08:00:00.000Z"
authors:
- gyfora:
  name: "Gyula Fora"
  twitter: "GyulaFora"
- 1996fanrui:
  name: "Rui Fan"
  twitter: "1996fanrui"
aliases:
- /news/2023/11/22/release-kubernetes-operator-1.7.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.7.0! The release introduces a large number of improvements to the autoscaler, including a complete decoupling from Kubernetes to support more Flink environments in the future. It's important to call out that the release explicitly drops support for Flink 1.13 and 1.14 as agreed by the community.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your feedback with the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)! We hope you like the new release and we’d be eager to learn about your experience with it.

## Flink Version Support Policy Change

Previously the operator only added more and more supported Flink versions without a policy to remove support for these in the future. This resulted in a lot of legacy codepaths already in the core logic.

To keep technical debt at reasonable levels, the community decided to adopt a new Flink version support policy for the operator.

{{< hint danger >}}
Starting from 1.7.0 the operator will only support the last 4 Flink minor versions corresponding to the date of the operator release.
For 1.7.0 this translates to: 1.18, 1.17, 1.16, 1.15
{{< /hint >}}

The operator will simply ignore changes made to resources with unsupported Flink versions. This also means that resources with unsupported versions are not possible to delete once the operator is upgraded. To temporarily work around this, users can upgrade the Flink version of the resource before deleting it.

## Highlights

### Decoupled Autoscaler Module

Starting from 1.7.0, the autoscaler logic is decoupled from Kubernetes and the Flink Kubernetes Operator.
The `flink-autoscaler` module now does not contain any Kubernetes related dependencies but defines a set of generic interfaces that are implemented by the operator.

As part of the decoupling effort, we released the initial version of the `Standalone Autoscaler` which serves as a limited alternative for anyone not using the Flink Kubernetes Operator currently. It supports scaling a single Flink cluster that can be any type, including: `Flink Standalone Cluster`, `MiniCluster`, `Flink YARN session cluster`, `Flink YARN application cluster`.

The Standalone Autoscaler runs as a separate Java Process. Please read the [Autoscaler Standalone](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.7/docs/custom-resource/autoscaler/#autoscaler-standalone) section for setup instructions. The standalone autoscaler is limited to Flink version 1.18.

To benefit from the best possible integration we recommend using the autoscaler as part of the Flink Kubernetes Operator. The standalone autoscaler is not planned to replace this either now or in the future.

To align with the new structure the autoscaler related configs will lose the `kubernetes.operator.` prefix going forward:

```
# Old / Deprecated keys
# kubernetes.operator.job.autoscaler.enabled
# kubernetes.operator.job.autoscaler.metrics.window

# New Keys
job.autoscaler.enabled
job.autoscaler.metrics.window
```

Visit the [Extensibility of Autoscaler](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.7/docs/custom-resource/autoscaler/#extensibility-of-autoscaler) doc page to get more information.

### Improved source metric tracking

Flink currently reports incorrectly low business metrics for sources that spend too much time fetching / polling input (for example IO bound sources).
This lead to the autoscaler not scaling sources that were actually running beyond their capacity.

To tackle this problem, we introduced a new mechanism in the autoscaler to automatically detect cases when the sources are running at full capacity (and backlog is building up). In these situations we switch to a new way to compute the maximum capacity (true processing rate) of the affected source vertices that is much more accurate in these cases. We refer to this mechanism currently as "observed true processing rate", this feature is enabled by default and should not need any custom configuration.

### Savepoint triggering improvements

To provide more flexibility to users, periodic savepoint triggering now supports configuring the trigger schedule using a Cron expression in Quartz format. You can find detailed info on the syntax [here](http://www.quartz-scheduler.org/documentation/quartz-2.3.0/tutorials/crontrigger.html).

### Operator Rate Limiter

A small but operationally important change is that the operator now enables rate limiting for resource events by default. This helps work around some corner cases where the operator was previously overloading the API server on error loops.

The rate limiter is now enabled by default with the following config:

```
kubernetes.operator.rate-limiter.limit: 5
kubernetes.operator.rate-limiter.refresh-period: 15 s
```

### Java 17 and 21 support

The operator can now be built and executed on Java 17 and 21 and we have enabled integration testing for these versions as well.

At the moment we are not releasing new operator docker images by the different Java versions, these need to be built and bundled by the users.
The official Kubernetes Operator image remains on Java 11.

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.7.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.7.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.7.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.7.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.7/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Alexander Fedulov, Clara Xiong, Daren Wong, Dongwoo Kim, Gabor Somogyi, Gyula Fora, Manan Mangal, Maximilian Michels, Nicolas Fraison, Peter Huang, Praneeth Ramesh, Rui Fan, Sergey Nuyanzin, SteNicholas, Zhanghao, Zhenqiu Huang, mehdid93
