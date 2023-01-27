---
authors:
- gyfora: null
  name: Gyula Fora
  twitter: GyulaFora
categories: news
date: "2022-04-03T08:00:00Z"
subtitle: Lifecycle management for Apache Flink deployments using native Kubernetes
  tooling
title: Apache Flink Kubernetes Operator 0.1.0 Release Announcement
---

The Apache Flink Community is pleased to announce the preview release of the Apache Flink Kubernetes Operator (0.1.0)

The Flink Kubernetes Operator allows users to easily manage their Flink deployment lifecycle using native Kubernetes tooling.

The operator takes care of submitting, savepointing, upgrading and generally managing Flink jobs using the built-in Flink Kubernetes integration.
This way users do not have to use the Flink Clients (e.g. CLI) or interact with the Flink jobs manually, they only have to declare the desired deployment specification and the operator will take care of the rest. It also make it easier to integrate Flink job management with CI/CD tooling.

**Core Features**

 * Deploy and monitor Flink Application and Session deployments
 * Upgrade, suspend and delete Flink deployments
 * Full logging and metrics integration

<div style="line-height:60%;">
    <br>
</div>

<center>
	<figure>
	<img src="{{< siteurl >}}/img/blog/2022-04-03-release-kubernetes-operator-0.1.0/overview.svg" width="600px" alt="Overview 1"/>
	<br/><br/>
	</figure>
</center>

<div style="line-height:150%;">
    <br>
</div>

## Getting started

For a detailed [getting started guide]({{< param DocsBaseUrl >}}flink-kubernetes-operator-docs-release-0.1/docs/try-flink-kubernetes-operator/quick-start/) please check the documentation site.

## FlinkDeployment CR overview

When using the operator, users create `FlinkDeployment` objects to describe their Flink application and session clusters deployments.

A minimal application deployment yaml would look like this:

```yaml
apiVersion: flink.apache.org/v1alpha1
kind: FlinkDeployment
metadata:
  namespace: default
  name: basic-example
spec:
  image: flink:1.14
  flinkVersion: v1_14
  flinkConfiguration:
    taskmanager.numberOfTaskSlots: "2"
  serviceAccount: flink
  jobManager:
    replicas: 1
    resource:
      memory: "2048m"
      cpu: 1
  taskManager:
    resource:
      memory: "2048m"
      cpu: 1
  job:
    jarURI: local:///opt/flink/examples/streaming/StateMachineExample.jar
    parallelism: 2
    upgradeMode: stateless
```

Once applied to the cluster using `kubectl apply -f your-deployment.yaml` the operator will spin up the application cluster for you.
If you would like to upgrade or make changes to your application, you can simply modify the yaml and submit it again, the operator will execute the necessary steps (savepoint, shutdown, redeploy etc.) to upgrade your application.

To stop and delete your application cluster you can simply call `kubectl delete -f your-deployment.yaml`.

You can read more about the [job management features]({{< param DocsBaseUrl >}}flink-kubernetes-operator-docs-release-0.1/docs/custom-resource/job-management/) on the documentation site.

## What's Next?

The community is currently working on hardening the core operator logic, stabilizing the APIs and adding the remaining bits for making the Flink Kubernetes Operator production ready.

In the upcoming 1.0.0 release you can expect (at-least) the following additional features:

 * Support for Session Job deployments
 * Job upgrade rollback strategies
 * Pluggable validation logic
 * Operator deployment customization
 * Improvements based on feedback from the preview release

In the medium term you can also expect:

 * Support for standalone / reactive deployment modes
 * Support for other job types such as SQL or Python

Please give the preview release a try, share your feedback on the Flink mailing list and contribute to the project!

## Release Resources

The source artifacts and helm chart are now available on the updated [Downloads](https://flink.apache.org/downloads.html)
page of the Flink website.

The [official 0.1.0 release archive](https://archive.apache.org/dist/flink/flink-kubernetes-operator-0.1.0/) doubles as a Helm repository that you can easily register locally:

{{< highlight bash >}}
$ helm repo add flink-kubernetes-operator-0.1.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-0.1.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-0.1.0/flink-kubernetes-operator --set webhook.create=false
{{< / highlight >}}

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation]({{< param DocsBaseUrl >}}flink-kubernetes-operator-docs-release-0.1/) and the
[release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12351499).
We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists)
or [JIRA](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20component%20%3D%20%22Kubernetes%20Operator%22).

## List of Contributors

The Apache Flink community would like to thank each and every one of the contributors that have made this release possible:

Aitozi, Biao Geng, Gyula Fora, Hao Xin, Jaegu Kim, Jaganathan Asokan, Junfan Zhang, Marton Balassi, Matyas Orhidi, Nicholas Jiang, Sandor Kelemen, Thomas Weise, Yang Wang, 愚鲤
