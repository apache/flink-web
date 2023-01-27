---
authors:
- gyfora: null
  name: Gyula Fora
  twitter: GyulaFora
- name: Yang Wang
  wangyang0918: null
categories: news
date: "2022-06-05T08:00:00Z"
subtitle: Lifecycle management for Apache Flink deployments using native Kubernetes
  tooling
title: Apache Flink Kubernetes Operator 1.0.0 Release Announcement
---

In the last two months since our [initial preview release](https://flink.apache.org/news/2022/04/03/release-kubernetes-operator-0.1.0.html) the community has been hard at work to stabilize and improve the core Flink Kubernetes Operator logic.
We are now proud to announce the first production ready release of the operator project.

## Release Highlights

The Flink Kubernetes Operator 1.0.0 version brings numerous improvements and new features to almost every aspect of the operator.

 * New **v1beta1** API version & compatibility guarantees
 * Session Job Management support
 * Support for Flink 1.13, 1.14 and 1.15
 * Deployment recovery and rollback
 * New Operator metrics
 * Improved configuration management
 * Custom validators
 * Savepoint history and cleanup

### New API version and compatibility guarantees

The 1.0.0 release brings a new API version: **v1beta1**.

Don’t let the name confuse you, we consider v1beta1 the first production ready API release, and we will maintain backward compatibility for your applications going forward.

If you are already using the 0.1.0 preview release you can read about the upgrade process [here](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.0/docs/operations/upgrade/#upgrading-from-v1alpha1---v1beta1), or check our detailed [compatibility guarantees](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.0/docs/operations/compatibility/).

### Session Job Management

One of the most exciting new features of 1.0.0 is the introduction of the FlinkSessionJob resource. In contrast with the FlinkDeployment that allows us to manage Application and Session Clusters, the FlinkSessionJob allows users to manage Flink jobs on a running Session deployment.

This is extremely valuable in environments where users want to deploy Flink jobs quickly and iteratively and also allows cluster administrators to manage the session cluster independently of the running jobs.

Example:

```yaml
apiVersion: flink.apache.org/v1beta1
kind: FlinkSessionJob
metadata:
  name: basic-session-job-example
spec:
  deploymentName: basic-session-cluster
  job:
    jarURI: https://repo1.maven.org/maven2/org/apache/flink/flink-examples-streaming_2.12/1.15.0/flink-examples-streaming_2.12-1.15.0-TopSpeedWindowing.jar
    parallelism: 4
    upgradeMode: stateless
```

### Multi-version Flink support

The Flink Kubernetes Operator now supports the following Flink versions out-of-the box:

 * Flink 1.15 (Recommended)
 * Flink 1.14
 * Flink 1.13

Flink 1.15 comes with a set of features that allow deeper integration for the operator. We recommend using Flink 1.15 to get the best possible operational experience.

### Deployment Recovery and Rollbacks

We have added two new features to make Flink cluster operations smoother when using the operator.

Now the operator will try to recover Flink JobManager deployments that went missing for some reason. Maybe it was accidentally deleted by the user or another service in the cluster. As long as HA was enabled and the job did not fatally fail, the operator will try to restore the job from the latest available checkpoint.

We also added experimental support for application upgrade rollbacks. With this feature the operator will monitor new application upgrades and if they don’t become stable (healthy & running) within a configurable period, they will be rolled back to the latest stable specification previously deployed.

While this feature will likely see improvements and new settings in the coming versions, it already provides benefits in cases where we have a large number of jobs with strong uptime requirements where it’s better to roll back than be stuck in a failing state.

### Improved Operator Metrics

Beyond the existing JVM based system metrics, additional Operator specific metrics were added to the current release.

{:class="table table-bordered"}
| Scope     | Metrics                        | Description                                                                                                                                                 | Type  |
|-----------|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|-------|
| Namespace | FlinkDeployment.Count          | Number of managed FlinkDeployment instances per namespace                                                                                                   | Gauge |
| Namespace | FlinkDeployment.&lt;Status&gt;.Count | Number of managed FlinkDeployment resources per &lt;Status&gt; per namespace. &lt;Status&gt; can take values from: READY, DEPLOYED_NOT_READY, DEPLOYING, MISSING, ERROR | Gauge |
| Namespace | FlinkSessionJob.Count          | Number of managed FlinkSessionJob instances per namespace                                                                                                   | Gauge |

## What's Next?

Our intention is to advance further on the [Operator Maturity Model](https://operatorframework.io/operator-capabilities/) by adding more dynamic/automatic features

 * Standalone deployment mode support [FLIP-225](https://cwiki.apache.org/confluence/display/FLINK/FLIP-225%3A+Implement+standalone+mode+support+in+the+kubernetes+operator)
 * Auto-scaling using Horizontal Pod Autoscaler
 * Dynamic change of watched namespaces
 * Pluggable Status and Event reporters (Making it easier to integrate with proprietary control planes)
 * SQL jobs support

## Release Resources

The source artifacts and helm chart are now available on the updated [Downloads](https://flink.apache.org/downloads.html)
page of the Flink website.

The [official 1.0.0 release archive](https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.0.0/) doubles as a Helm repository that you can easily register locally:

{{< highlight bash >}}
$ helm repo add flink-kubernetes-operator-1.0.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.0.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.0.0/flink-kubernetes-operator --set webhook.create=false
{{< / highlight >}}

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation]({{< param DocsBaseUrl >}}flink-kubernetes-operator-docs-release-1.0/) and the
[release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12351500).
We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists)
or [JIRA](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20component%20%3D%20%22Kubernetes%20Operator%22).

## List of Contributors

The Apache Flink community would like to thank each and every one of the contributors that have made this release possible:

Aitozi, Biao Geng, ConradJam, Fuyao Li, Gyula Fora, Jaganathan Asokan, James Busche, liuzhuo, Márton Balassi, Matyas Orhidi, Nicholas Jiang, Ted Chang, Thomas Weise, Xin Hao, Yang Wang, Zili Chen
