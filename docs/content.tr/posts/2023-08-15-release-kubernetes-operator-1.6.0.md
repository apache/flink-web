---
title:  "Apache Flink Kubernetes Operator 1.6.0 Release Announcement"
date: "2023-08-15T08:00:00.000Z"
authors:
- gyfora:
  name: "Gyula Fora"
  twitter: "GyulaFora"
aliases:
- /news/2023/08/15/release-kubernetes-operator-1.6.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.6.0! The release features a large number of improvements all across the operator.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your feedback with the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)! We hope you like the new release and we’d be eager to learn about your experience with it.

## Highlights

### Improved and simplified rollback mechanism

Previously the rollback mechanism had some serious limitations always requiring the presence of HA metadata. This prevented rollbacks in many cases for instance when the new application terminally failed after the upgrade.

1.6.0 introduces several core improvements to the rollback mechanism to leverage the robust upgrade flow and cover a much wider range of failure scenarios.

### Experimental support for Flink 1.18 and in-place rescaling

Flink 1.18 introduces a new endpoint as part of [FLIP-291](https://issues.apache.org/jira/browse/FLINK-31316) allowing users to rescale operators (job vertexes) through the REST API. The operator now has built in support to apply vertex parallelism overrides through the rest api to reduce downtime.

This feature enables the autoscaler to execute very quick scale up/down actions when used with Flink 1.18.

In-place scaling is only available when the job uses the adaptive scheduler (`jobmanager.scheduler: adaptive`).

### Namespace and Flink Version specific config defaults

The operator now supports setting default configuration on a per-namespace and per-flink version level.
This allows users for example to set config defaults differently for Flink 1.18 (enable adaptive scheduler by default)

Or to use different reconciliation/operator settings for different namespaces.

Syntax:
```yaml
# Version Specific Defaults
kubernetes.operator.default-configuration.flink-version.v1_17.key: value

# Namespace Specific Defaults
kubernetes.operator.default-configuration.namespace.ns1.key: value
```

### JobManager startup probe for more robust upgrades

The operator now automatically applies a startup probe for the JobManager deployments allowing the reconciler to better detect startup failures. This further hardens the upgrade mechanism and drastically reduces the number of cases where manual intervention is necessary from users.

### Flink client upgrade to 1.17

We have upgraded the Flink client libraries used by the operator to the 1.17.1 release which helped simplify the build and packaging significantly due to the improvements in the `flink-kubernetes` module shading.

### General Autoscaler Improvements

The release also contains several improvements to the autoscaler module. This includes improved metrics tracking, better observability and less noisy logging.

We also reworked the way parallelism overrides are applied. Instead of changing the spec, parallelism overrides are now applied on the fly on top of the user provided spec. This allows us to seamlessly carry over the autoscaler settings even when the spec changes.

## Release Resources
The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.6.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.6.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.6.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.6.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.6/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Alexander Fedulov, ConradJam, Fangbin Sun, Gyula Fora, James Busche, Mate Czagany, Matyas Orhidi, Maximilian Michels, Nicolas Fraison, Oleksandr Nitavskyi, Tamir Sagi, Thomas, Xin Hao, Xingcan Cui, Daren Wong, Fabio Wanner, kenankule, llussy, yangjf2019,
