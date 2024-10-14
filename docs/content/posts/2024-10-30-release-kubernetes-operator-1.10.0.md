---
title:  "Apache Flink Kubernetes Operator 1.10.0 Release Announcement"
date: "2024-10-25T18:00:00.000Z"
authors:
- mateczagany:
  name: "Mate Czagany"
- 1996fanrui:
  name: "Rui Fan"
  twitter: "1996fanrui"
aliases:
- /news/2024/10/30/release-kubernetes-operator-1.10.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.10.0!

The release includes several improvements to the autoscaler, and introduces a new Kubernetes custom resource called FlinkStateSnapshot to manage job snapshots.
The process of job upgrades has also been enhanced which makes it possible to now use the last-state upgrade mode with session jobs.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your experience with the
community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or
[JIRA](https://issues.apache.org/jira/browse/flink)! We're looking forward to your feedback!

## Highlights

### FlinkStateSnapshot

With this version comes also a new custom resource called FlinkStateSnapshot. 
This is used to describe savepoint or checkpoint for a Flink job. 
The savepoint/checkpoint fields found in FlinkDeployment and FlinkSessionJob status are therefore deprecated, and the operator will create new FlinkStateSnapshot resources for periodic, update and manual savepoints/checkpoints.

Users can also create new FlinkStateSnapshot resources, which will instruct the operator to trigger new checkpoint/savepoint.

This new feature is enabled by default, unless disabled by setting `kubernetes.operator.snapshot.resource.enabled` to false or if the FlinkStateSnapshot CRD was not found on the Kubernetes cluster.

You can read more about this feature [here](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.10/docs/custom-resource/snapshots/).


### Last-State Upgrade Mode

For deployments using last-state upgrade mode where HA metadata is not available, the operator will fallback to cancel the job via REST API and extract the last checkpoint info after cancellation if the job is healthy, making upgrades more robust.

This change makes it possible to finally use the last-state upgrade mode for session jobs as well.


### Autoscaler Delayed Scale Down

With the introduction of the configuration option `job.autoscaler.scale-down.interval`, the operator can now optimize multiple scale-down operations to a single one to prevent too many unnecessary downscales, thus improving job availability.
Please note that `job.autoscaler.scale-up.grace-period` has been removed with this change.


### Other Autoscaler Improvements
- Optimized cases where partitions or key groups cannot be evenly distributed to subtasks
- Introduced `autoscaler.standalone.jdbc.event-handler.ttl` to support cleaning up historical event handler records in JDBC event handler
- Autoscaler is now compatible with Flink 1.20


## Release Notes

The release notes can be found [here](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12354833).

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.8.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.10.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.10.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.10.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.10/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Angela Chen, Ferenc Csaky, Gyula Fora, Mate Czagany, Matyas Orhidi, Naresh Kumar Reddy Gaddam,
Roc Marshal, Rui Fan, Sam Barker, Yuepeng Pan, big face cat, chenyuzhi459, kartik-3513,
r-sidd, 阿洋

