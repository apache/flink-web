---
authors:
- gyfora: null
  name: Gyula Fora
  twitter: GyulaFora
date: "2022-10-07T08:00:00Z"
subtitle: Lifecycle management for Apache Flink deployments using native Kubernetes
  tooling
title: Apache Flink Kubernetes Operator 1.2.0 Release Announcement
---

We are proud to announce the latest stable release of the operator. The 1.2.0 release adds support for the Standalone Kubernetes deployment mode and includes several improvements to the core logic.

## Release Highlights

 * Standalone deployment mode support
 * Improved upgrade flow
 * Readiness and liveness probes
 * Flexible job jar handling

## Standalone deployment mode support

Until now the operator relied exclusively on Flink’s built-in Native Kubernetes integration to deploy and manage Flink clusters. When using the Native deployment mode the Flink cluster communicates directly with Kubernetes to allocate/deallocate TaskManager resources on the fly. While this leads to a very simple deployment model, in some environments it also means higher security exposure as the user code running on the Flink cluster may gain the same Kubernetes access privileges.

Flink Kubernetes Operator 1.2.0 brings Standalone mode support for FlinkDeployment resources.

When using the standalone mode, the operator itself sets up the Job and TaskManager resources for the Flink cluster. Flink processes then run without any need for Kubernetes access. In fact in this mode the Flink cluster itself is unaware that it is running in a Kubernetes environment. If unknown or external code is being executed on the Flink cluster then Standalone mode adds another layer of security.

**The default deployment mode is Native. Native deployment mode remains the recommended mode for standard operator use and when running your own Flink jobs.**

The deployment mode can be set using the `mode` field in the deployment spec.

```yaml
apiVersion: flink.apache.org/v1beta1
kind: FlinkDeployment
...
spec:
  ...
  mode: native/standalone
```

## Improved upgrade flow
There have been a number of important changes that improve the job submission and upgrade flow. The operator now distinguishes configuration & spec changes that do not require the redeployment of the Flink cluster resources (such as setting a new periodic savepoint interval). These improvements now avoid unnecessary job downtime in many cases.

Leveraging the standalone deployment mode the operator now also supports rescaling jobs directly using Flink’s reactive scheduler. When changing the parallelism of an application FlinkDeployment with `mode: standalone` set and  `scheduler-mode: reactive` in the `flinkConfiguration` the operator will simply increase the number of TaskManagers to match the new parallelism and let Flink do the scaling automatically (reactively). Same as with the reactive scaling itself, this is considered to be an experimental feature.

There are also some important fixes to problems that might occur when switching between Flink versions or using the stateless upgrade mode.

## Readiness and Liveness probes

From an operational perspective it is very important to be able to determine the health of the Kubernetes Operator process. The operator now exposes a health endpoint by default together with a liveness and readiness probe.

## Flexible job jar handling

The 1.2.0 release now makes the jobSpec.jarURI parameter optional to allow users to run jobs using dependencies that are already bundled in the Flink classpath.

This can be especially valuable in session deployments when multiple jobs, reusing the same artifacts, are deployed with different configurations.

## Release Resources

The source artifacts and helm chart are now available on the updated Downloads page of the Flink website.

```
$ helm repo add flink-kubernetes-operator-1.2.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.2.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.2.0/flink-kubernetes-operator --set webhook.create=false
You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).
```

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.2/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Aitozi, Avocadomaster, ConradJam, Dylan Meissner, Gabor Somogyi, Gaurav Miglani, Gyula Fora, Jeesmon Jacob, Joao Ubaldo, Marton Balassi, Matyas Orhidi, Maximilian Michels, Nicholas Jiang, Peter Huang, Robson Roberto Souza Peixoto, Thomas Weise, Tim, Usamah Jassat, Xin Hao, Yaroslav Tkachenko
