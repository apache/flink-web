---
title:  "Apache Flink Kubernetes Operator 1.11.0 Release Announcement"
date: "2025-03-03T18:00:00.000Z"
authors:
- gyfora:
  name: "Gyula Fora"
aliases:
- /news/2025/03/03/release-kubernetes-operator-1.11.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.11.0!
The version brings a number of important fixes and improvements to both core and autoscaler modules.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your experience with the
community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or
[JIRA](https://issues.apache.org/jira/browse/flink)! We're looking forward to your feedback!

## Highlights

### Flink 2.0 Preview Support

The Flink Kubernetes Operator and Autoscaler 1.11.0 brings support for Flink 2.0 preview version. 
This should help users to try out and verify the latest features in Flink planned for the 2.0 release.

```yaml
apiVersion: flink.apache.org/v1beta1
kind: FlinkDeployment
metadata:
  name: basic-example
spec:
  image: flink:2.0
  flinkVersion: v2_0
...
```

Make sure to update the operator CRD to be able to deploy Flink 2.0 pipelines.

***The support for Flink 2.0 in the operator and autoscaler is also in a preview state 
and will be finalized after the official Flink 2.0.0 release***

### Flink Operator Core

#### More flexible Flink version based configs

Default configs can now be defined for multiple versions at the same time using the following syntax:
```properties
# Set config for Flink 1.18 and larger
kubernetes.operator.default-configuration.flink-version.v1_18+.key: value
```

#### Extended lifecycle states

Two new lifecycle states (`DELETING` and `DELETED`) have been added to ensure that the operator correctly tracks the entire
lifecycle of applications.

This is especially useful when implementing a custom resource listener.

#### Bug fixes for batch applications

The version contains a number of important fixes for managing batch applications to avoid some annoying errors.

### Autoscaler improvements

The autoscaler module received a number of important tweaks, improvements and bugfixes.

#### Improved Target Utilization Configs

We improved and simplified how target utilization and utilization boundaries can be configured for more flexibility.
Instead of specifying the target and boundary you can now explicitly set:

```
job.autoscaler.utilization.target: 0.7
job.autoscaler.utilization.min: 0.5
job.autoscaler.utilization.max: 1.0
```

The old configs remain functional but are deprecated now.

#### Other notable changes

 - More robust scale down logic to reduce fluctuations [FLINK-36535](https://issues.apache.org/jira/browse/FLINK-36535)
 - `autoscalerResetNonce` in Kubernetes JobSpec allows easy reset of the autoscaler state and parallelism overrides
 - Publish metrics during stabilization period to reduce metric gaps

## Release Notes

The full release notes can be found [here]( https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12355186).

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.11.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.11.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.11.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.11.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.11/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Alan Zhang, Anupam Aggarwal, Dao Thanh Tung, Gunnar Morling, Gyula Fora, Keith Wall, Luca Castelli, Luke Chen, Matyas Orhidi, Maximilian Michels, Rui Fan, Sam Barker, Shuyi Chen, Thomas Cooper, big face cat, dsaisharath, fqaiser94, huyuanfeng, mateczagany, sharath1709, timsn, yangjf2019
