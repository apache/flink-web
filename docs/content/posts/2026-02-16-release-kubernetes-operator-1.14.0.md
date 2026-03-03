---
title:  "Apache Flink Kubernetes Operator 1.14.0 Release Announcement"
date: "2026-02-15T18:00:00.000Z"
authors:
- schongloo:
  name: "Sergio Chong Loo / Daniel Rossos"
aliases:
- /news/2026/02/16/release-kubernetes-operator-1.14.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.14.0!

This release introduces a major new capability for production deployments: **native Blue/Green deployment support**. Deploy stateful streaming applications without interruption with automated Blue/Green deployments directly in your Kubernetes clusters.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your experience with the
community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or
[JIRA](https://issues.apache.org/jira/browse/flink)! We're looking forward to your feedback!

## Highlights

### Blue/Green Deployments for Flink in Kubernetes

This new deployment strategy allows you to minimize risk and downtime when updating your streaming applications by maintaining two identical production environments.

For Flink applications, Blue/Green deployments are particularly valuable for stateful streaming applications that require:

- **Zero-downtime upgrades**: Continuous data processing without interruption
- **State preservation**: Maintaining application state across deployments through savepoints
- **Safe rollback capability**: Quick reversion to the previous version if issues arise
- **Validation before traffic switch**: Ensuring the new deployment is running stable before it becomes active

The following diagrams illustrate how Blue/Green deployments work with the Flink Kubernetes Operator:

<div style="text-align: center; margin: 20px 0;">
  <img src="/img/blog/2026-02-16-release-kubernetes-operator-1.14.0/blue-green-diagram-1.png" alt="Blue/Green deployment flow" style="max-width: 100%; height: auto;" />
</div>

<div style="text-align: center; margin: 20px 0;">
  <img src="/img/blog/2026-02-16-release-kubernetes-operator-1.14.0/blue-green-diagram-2.png" alt="Blue/Green deployment architecture" style="max-width: 100%; height: auto;" />
</div>

#### Getting Started with Blue/Green Deployments

Converting an existing `FlinkDeployment` to use Blue/Green deployments requires minimal changes to your resource definition. The following diagram illustrates the three key modifications needed:

<div style="text-align: center; margin: 20px 0;">
  <img src="/img/blog/2026-02-16-release-kubernetes-operator-1.14.0/blue-green-modifications.png" alt="Key modifications for Blue/Green deployment" style="max-width: 100%; height: auto;" />
</div>

The new `FlinkBlueGreenDeployment` custom resource provides a declarative way to manage Blue/Green deployments. Simply define your desired Flink application configuration in the `spec.template` section, and the operator handles the rest—including savepoint management, deployment coordination, and traffic switching.

#### Example Scenarios

To help you understand how Blue/Green deployments behave in different situations, we've prepared baseline `FlinkBlueGreenDeployment` specifications that you can use to explore three common scenarios. [This example](https://github.com/apache/flink-kubernetes-operator/blob/main/e2e-tests/data/bluegreen-ingress.yaml), as well as any of the `bluegreen-*.yaml` specs in that location, is as great starting point.

By modifying the spec and reapplying (via `kubectl apply` or editing the CR directly with `kubectl edit`), you can observe the different behaviors:

**1. Triggering Blue-Green Transition**

Modify the `spec.template.spec.flinkConfiguration.taskmanager.numberOfTaskSlots` field to trigger a Blue-Green transition. You'll see:
- A new "green" FlinkDeployment spins up alongside the existing "blue" deployment
- Once the green deployment reaches a ready state, traffic switches over
- The previous "blue" FlinkDeployment is gracefully terminated
- The ingress automatically switches from blue to green service

**2. In-Place Modification**

Not all changes require a full Blue-Green transition. Modify the `spec.template.spec.flinkConfiguration.kubernetes.operator.savepoint.history.max.age` value to see an in-place update:
- No Blue-Green transition occurs
- The active FlinkDeployment picks up the configuration change directly
- Suitable for non-critical configuration updates

**3. Suspend and Resume**

Control your Flink job's lifecycle by modifying `spec.template.spec.job.state` between `suspended` and `running`:
- Setting to `suspended` gracefully suspends the running FlinkDeployment
- The FlinkBlueGreenDeployment enters a suspended state
- Changing back to `running` restarts the Flink pipeline from the last savepoint

## Release Notes

The release notes can be found [here](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12356278).

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.14.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.14.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.14.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.14.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.14/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

The Apache Flink community would like to thank all contributors who made this release possible:

Arda Kuyumcu, Attila Mészáros, big face cat, Daniel Rossos, Ferenc Csaky, Gyula Fora, James Kan, Maksim Aniskov, Martijn Visser, Maximilian Michels, wang377
