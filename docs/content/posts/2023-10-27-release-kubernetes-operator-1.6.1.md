---
title:  "Apache Flink Kubernetes Operator 1.6.1 Release Announcement"
date: "2023-10-27T08:00:00.000Z"
authors:
- 1996fanrui:
  name: "Rui Fan"
  twitter: "1996fanrui"
aliases:
- /news/2023/10/27/release-kubernetes-operator-1.6.1.html
---
The Apache Flink Community is pleased to announce the first bug fix release of the Flink Kubernetes Operator 1.6 series.

The release contains fixes for several critical issues, and some doc improvements for the autoscaler.

We highly recommend all users to upgrade to Flink Kubernetes Operator 1.6.1.

## Release Notes

### Bug
 * [FLINK-32890] Correct HA patch check for zookeeper metadata store
 * [FLINK-33011] Never accidentally delete HA metadata for last state deployments

### Documentation improvement
 * [FLINK-32868][docs] Document the need to backport FLINK-30213 for using autoscaler with older version Flinks
 * [docs][autoscaler] Autoscaler docs and default config improvement

## Release Resources
The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.6.1 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.6.1 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.6.1/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.6.1/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.6/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors
Gyula Fora, Nicolas Fraison, Zhanghao
