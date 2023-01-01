---
layout: post
title:  "Apache Flink Kubernetes Operator 1.3.1 Release Announcement"
subtitle: "Lifecycle management for Apache Flink deployments using native Kubernetes tooling"
date: 2023-01-10T08:00:00.000Z
categories: news
authors:
- gyfora:
  name: "Gyula Fora"
  twitter: "GyulaFora"
---
The Apache Flink Community is pleased to announce the first bug fix release of the Flink Kubernetes Operator 1.3 series.

The release contains fixes for several critical issues and some major stability improvements for the application upgrade mechanism.

We highly recommend all users to upgrade to Flink Kubernetes Operator 1.3.1.

## Release Notes

### Bug
 * [FLINK-30329] - flink-kubernetes-operator helm chart does not work with dynamic config because of use of volumeMount subPath
 * [FLINK-30361] - Cluster deleted and created back while updating replicas
 * [FLINK-30406] - Jobmanager Deployment error without HA metadata should not lead to unrecoverable error
 * [FLINK-30437] - State incompatibility issue might cause state loss
 * [FLINK-30527] - Last-state suspend followed by flinkVersion change may lead to state loss
 * [FLINK-30528] - Job may be stuck in upgrade loop when last-state fallback is disabled and deployment is missing

### Improvement
 * [FLINK-28875] - Add FlinkSessionJobControllerTest
 * [FLINK-30408] - Add unit test for HA metadata check logic

## Release Resources
The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.3.1 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.3.1 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.3.1/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.3.1/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.3/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors
Gyula Fora, Andrew Otto, Swathi Chandrashekar, Peter Vary
