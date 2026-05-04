---
title:  "Apache Flink Kubernetes Operator 1.15.0 Release Announcement"
date: "2026-05-26T08:00:00.000Z"
authors:
- gyfora:
  name: "Gyula Fora"
aliases:
- /news/2026/05/04/release-kubernetes-operator-1.15.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.15.0!

This release brings **Kubernetes-native Conditions** to `FlinkDeployment`, **Logback logging support**, bundled metric reporters, Flink 2.2 compatibility, and a number of important reliability fixes across session jobs, savepoints, and the mutating webhook.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your experience with the
community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or
[JIRA](https://issues.apache.org/jira/browse/flink)! We're looking forward to your feedback!

## Highlights

### Kubernetes Conditions in FlinkDeployment Status

The operator now exposes a standard Kubernetes
[Condition](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-conditions) in the `status` field of
`FlinkDeployment` resources. The `Running` condition gives tooling a consistent, machine-readable signal of whether
the deployment is up and running, directly usable with `kubectl wait`, GitOps controllers, and any tool that speaks
Kubernetes conditions.

For example, to wait until a deployment is running:

```shell
kubectl wait flinkdeployment/my-job --for=condition=Running --timeout=120s
```

### Logback Logging Support

The operator now supports **Logback** as an alternative logging framework alongside the existing Log4j2 default.
The active framework is selected at install time via the new `logging.framework` Helm value:

```shell
helm install flink-operator helm/flink-kubernetes-operator --set logging.framework=logback
```

Both `logback-operator.xml` and `logback-console.xml` configuration files are bundled in the Helm chart and can be
customized the same way as the existing Log4j2 properties files. This is particularly useful for organizations that
standardize on Logback or rely on Logback-specific appenders and integrations.

### Bundled Metric Reporters and Expanded Metrics Documentation

The operator Helm chart now bundles the `flink-metrics-dropwizard` reporter out of the box, removing the need for users to add the JAR manually when integrating with monitoring stacks that consume Dropwizard metrics.

The operator metrics documentation has also been substantially reworked: it now explains how operator-scoped metric identifiers are built, documents the `kubernetes.operator.metrics.*` prefix for operator-scoped reporter configuration, and walks through an end-to-end Prometheus monitoring setup. Most importantly, every metric the operator exposes is now documented in one place, with dedicated sections covering `FlinkDeployment` / `FlinkSessionJob` lifecycle and `JobStatus` tracking, `FlinkBlueGreenDeployment`, `FlinkStateSnapshot`, and autoscaler metrics, each with a clear explanation of what the metric measures and when it's emitted, so users finally have a complete picture of what's available out of the box.  

### Flink 2.2 Compatibility

Operator 1.15.0 is fully validated against Apache Flink 2.2. The supported Flink version matrix is:

**2.2.x, 2.1.x, 2.0.x, 1.20.x, 1.19.x**

## Notable Bug Fixes

### Savepoint and State Management

- Fixed a race condition where a savepoint or last-state upgrade could lose job state when the JobManager was slow to
  start.
- Fixed an issue where savepoint history entries were removed from the status before the savepoint file was
  successfully disposed, which could leave orphaned savepoint files on the filesystem.
- Terminal (FINISHED / FAILED) jobs are no longer erroneously restarted by the cluster/job health check, eliminating
  unexpected job restarts after intentional completion.

### Session Job Reliability

- Added a new configuration option to cancel a running session job when the `FlinkSessionJob` resource is deleted,
  rather than blocking on the finalizer indefinitely.
- Improved the session job deletion flow so that cleanup proceeds correctly even when the session cluster is
  temporarily unreachable.
- Fixed a bug where `FlinkSessionJob` deletion could get stuck behind a finalizer that was never cleared.
- Fixed missing `ownerReferences` on JobManager Deployments recreated during session cluster recovery, ensuring
  proper garbage collection.

## Release Notes

The release notes can be found [here](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12356676).

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.15.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.15.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.15.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.15.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.15/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

The Apache Flink community would like to thank all contributors who made this release possible:

Andrea Cosentino, David Radley, Dennis-Mircea Ciupitu, Ferenc Csaky, Gabor Somogyi, GuoYu, Gyula Fora, Harshit Gupta, jennifer-xiong25, Krzysztof Adrian Palka, Michał Kozal, Prashant Khanal, Purushottam Sinha, Sergio Chong, wangxinglong, wangxinglong02
