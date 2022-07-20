---
layout: post
title:  "Apache Flink Kubernetes Operator 1.1.0 Release Announcement"
subtitle: "Lifecycle management for Apache Flink deployments using native Kubernetes tooling"
date: 2022-07-25T08:00:00.000Z
categories: news
authors:
- gyfora:
  name: "Gyula Fora"
  twitter: "GyulaFora"
- matyas:
  name: "Matyas Orhidi"

---

The community has continued to work hard on improving the Flink Kubernetes Operator capabilities since our [first production ready release](https://flink.apache.org/news/2022/06/05/release-kubernetes-operator-1.0.0.html) we launched about two months ago.

With the release of Flink Kubernetes Operator 1.1.0 we are proud to announce a number of exciting new features that improves the overall experience of managing Flink resources and the operator itself in production environments.

## Release Highlights

A non-exhaustive list of some of the more exciting features added in the release:

 * Kubernetes Events on application and job state changes
 * New operator metrics
 * Unified and more robust reconciliation flow
 * Periodic savepoint triggering
 * Custom Flink Resource Listeners
 * Dynamic watched namespaces
 * New built-in examples for submitting Flink SQL and Python jobs
 * Experimental autoscaling support

### Kubernetes Events for Application and Job State Changes

The operator now emits native Kubernetes Events on relevant Flink Deployment and Job changes. This includes status changes, custom resource specification changes, deployment failures, etc.

```
Events:
  Type    Reason         Age   From                  Message
  ----    ------         ----  ----                  -------
  Normal  Submit         53m   JobManagerDeployment  Starting deployment
  Normal  StatusChanged  52m   Job                   Job status changed from RECONCILING to CREATED
  Normal  StatusChanged  52m   Job                   Job status changed from CREATED to RUNNING
```

### New Operator Metrics

The first version of the operator only came with basic system level metrics to monitor the JVM process.

In 1.1.0 we have introduced a wide range of additional metrics related to lifecycle-management, Kubernetes API server access and the Java Operator SDK framework the operator itself is built on. These metrics allow operator administrators to get a comprehensive view of what’s happening in the environment.

For details check https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-main/docs/operations/metrics-logging/#metrics.

### Unified and more robust reconciliation flow

We have spent a considerable effort refactoring and streamlining the core reconciliation flow responsible for executing and tracking resource upgrades, savepoints, rollbacks and other operations.

In the process we made a number of important improvements to tolerate operator failures and temporary kubernetes API outages more gracefully, which is critical in production environments.

### Periodic Savepoints

By popular demand we have introduced periodic savepointing for applications and session jobs using a the following simple configuration option:

```
flinkConfiguration:
  ...
  kubernetes.operator.periodic.savepoint.interval: 6h
```

### Custom Flink Resource Listeners

The operator allows users to listen to events and status updates triggered for the Flink Resources managed by the operator.

This feature enables tighter integration with the user's own data platform. By implementing the `FlinkResourceListener` interface users can listen to both events and status updates per resource type (`FlinkDeployment` / `FlinkSessionJob`). The interface methods will be called after the respective events have been triggered by the system.

### New SQL and Python Job Examples

To demonstrate the power of the operator for all Flink use-cases, we have added examples showcasing how to deploy Flink SQL and Python jobs.

We have also added a nice little README for the examples to make it easier for you to find what you are looking for.

https://github.com/apache/flink-kubernetes-operator/tree/main/examples

### Dynamic watched namespaces

The operator can watch and manage custom resources in an arbitrary list of namespaces. The watched namespaces can be defined through the property `kubernetes.operator.watched.namespaces: ns1,ns2`. The list of watched namespaces can be changed anytime in the corresponding config map, however the operator ignores the changes unless dynamic watched namespaces is enabled. This is controlled by the property `kubernetes.operator.dynamic.namespaces.enabled: true`

### Experimental autoscaling support

In this version we have taken the first steps toward enabling Kubernetes native autoscaling integration for the operator. The FlinkDeployment CRD now exposes the `scale` subresource which allows us to create HPA policies directly in Kubernetes that will monitor the task manager pods.

This integration is still very much experimental but we are planning to build on top of this in the upcoming releases to provide a reliable scaling mechanism.

https://github.com/apache/flink-kubernetes-operator/tree/main/examples#horizontal-pod-autoscaler

## What’s Next?

We are continuing advancing on the Operator Maturity Model with an emphasis on more advanced scaling capabilities:

 * Standalone deployment mode support
 * Hardening of rollback mechanism and stability conditions
 * Scaling improvements

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.1.0 release by following our [quickstart guide](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.1/docs/try-flink-kubernetes-operator/quick-start/)

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.1/) and the [release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12351723). We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Aitozi, Biao Geng, Chethan, ConradJam, Dora Marsal, Gyula Fora, Hao Xin, Hector Miuler Malpica Gallegos, Jaganathan Asokan, Jeesmon Jacob, Jim Busche, Maksim Aniskov, Marton Balassi, Matyas Orhidi, Márton Balassi, Nicholas Jiang, Peng Yuan, Peter Vary, Thomas Weise, Xin Hao, Yang Wang
