---
title:  "Apache Flink Kubernetes Operator 1.5.0 Release Announcement"
date: "2023-05-17T08:00:00.000Z"
authors:
- gyfora:
  name: "Gyula Fora"
  twitter: "GyulaFora"
aliases:
- /news/2023/05/17/release-kubernetes-operator-1.5.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.5.0! The release focuses on improvements to the job autoscaler that was introduced in the previous release and general operational hardening of the operator.  

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your feedback with the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)! We hope you like the new release and we’d be eager to learn about your experience with it.

## Autoscaler improvements

### Algorithm improvements and better scale down behaviour

The release contains important improvements to the core autoscaling logic. This includes improved stability of scaling decisions (leading to less parallelism oscillations) and better handling of slow or idle streams.

There are also some fixes related to output ratio computation and propagation that greatly improves the autoscaler on more complex streaming pipelines.

This version also introduces new metrics for tracking the number of scaling decisions and scaling errors together with some more Kubernetes events to improve the observability of the system.

### Improved default configuration

We have simplified and improved some default autoscaler configs for a better out-of-the-box user experience.

Some notable changes:

```
kubernetes.operator.job.autoscaler.metrics.window: 5m -> 10m
kubernetes.operator.job.autoscaler.target.utilization.boundary: 0.1 -> 0.4
kubernetes.operator.job.autoscaler.scale-up.grace-period: 10m -> 1h

kubernetes.operator.job.autoscaler.history.max.count: 1 -> 3
kubernetes.operator.job.autoscaler.scaling.effectiveness.detection.enabled: true -> false

kubernetes.operator.job.autoscaler.catch-up.duration: 10m -> 5m
kubernetes.operator.job.autoscaler.restart.time: 5m -> 3m
```

## CRD Changes

### Ephemeral storage support

Stateful streaming jobs often rely on ephemeral storage to store the working state of the pipeline. Previously it was only possible to change the ephemeral storage size through the pod template mechanism. The 1.5.0 release adds a new field to the task and jobmanager specification that allows configuring this similarly to other resources:

```
spec:
  ...
  taskManager:
    resource:
      memory: "2048m"
      cpu: 8
      ephemeralStorage: "10G"
```

Make sure you upgrade the CRD together with the operator deployment to be able to access this feature. For more details check the [docs](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-main/docs/operations/upgrade/)

## General operations

### Fabric8 and JOSDK version bump

The operator have been updated to use the latest Java Operator SDK and Fabric8 versions that contain important fixes for production environments.

### Health probe and canary resources

Previous operator versions already contained a rudimentary health probe to catch simple startup errors but did not have a good mechanism to catch errors that developed during the lifetime of the running operator.

The 1.5.0 version adds two significant improvements here:

 - Improved health probe to detect informer errors after startup
 - Introduce canary resources for detecting general operator problems

The new canary resource feature allows users to deploy special dummy resources (canaries) into selected namespaces. The operator health probe will then monitor that these resources are reconciled in a timely manner. This allows the operator health probe to catch any slowdowns, and other general reconciliation issues not covered otherwise.

Canary FlinkDeployment:

```
apiVersion: flink.apache.org/v1beta1
kind: FlinkDeployment
metadata:
  name: canary
  labels:
    "flink.apache.org/canary": "true"
```

## Release Resources
The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.5.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.5.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.5.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.5.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.5/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Gyula Fora, Marton Balassi, Mate Czagany, Maximilian Michels, Rafał Boniecki, Rodrigo Meneses, Tamir Sagi, Xin Hao, Xin Li, Zhanghao Chen, Zhenqiu Huang, Daren Wong, Gaurav Miglani, Peter Vary, Tan Kim, yangjf2019
