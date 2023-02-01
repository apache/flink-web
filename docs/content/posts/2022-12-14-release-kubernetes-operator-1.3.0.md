---
authors:
- morhidi: null
  name: Matyas Orhidi
  twitter: matyasorhidi
- gyfora: null
  name: Gyula Fora
  twitter: GyulaFora
date: "2022-12-14T08:00:00Z"
subtitle: Lifecycle management for Apache Flink deployments using native Kubernetes
  tooling
title: Apache Flink Kubernetes Operator 1.3.0 Release Announcement
---
The Flink community is happy to announce that the latest Flink Kubernetes Operator version went live today. Beyond the regular operator improvements and fixes the 1.3.0 version also integrates better with some popular infrastructure management tools like OLM and Argo CD. These improvements are clear indicators that the original intentions of the Flink community, namely to provide the de facto standard solution for managing Flink applications on Kubernetes is making steady progress to becoming a reality.

## Release Highlights
 * Upgrade to Fabric8 6.x.x and JOSDK 4.x.x
 * Restart unhealthy Flink clusters
 * Contribute the Flink Kubernetes Operator to OperatorHub
 * Publish flink-kubernetes-operator-api module separately

## Upgrade to Fabric8 6.x.x and JOSDK 4.x.x
Two important framework components were upgraded with the current operator release, the Fabric8 client to v6.2.0 and the JOSDK to v4.1.0. These upgrades among others contain important informer improvements that help lower or completely eliminate the occurrence of certain intermittent issues when the operator looses track of managed Custom Resources.

With the new JOSDK version, the operator now supports leader election and allows users to run standby operator replicas to reduce downtime due to operator failures. Read more about this in the [docs](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.3/docs/operations/configuration/#leader-election-and-high-availability).

## Restart unhealthy Flink clusters
Flink has its own [restart strategies](https://nightlies.apache.org/flink/flink-docs-master/docs/ops/state/task_failure_recovery/#restart-strategies) which are working fine in most of the cases, but there are certain circumstances when Flink can be stuck in restart loops often resulting in `OutOfMemoryError: Metaspace` type of state which the job cannot recover from. If the root cause is just a temporary outage of some external system, for example, the Flink job could be resurrected by simply performing a full restart on the application.

This restart can now be triggered by the operator itself. The operator can watch the actual retry count of a Flink job and restart it when too many restarts occurred in a defined amount of time window, for example:

```
kubernetes.operator.job.health-check.enabled: false
kubernetes.operator.job.restart-check.duration-window: 2m
kubernetes.operator.job.restart-check.threshold: 64
```

Operator is checking the retry count of a job in every defined interval. If there is a count value where the actual job retry count is bigger than the threshold and the timestamp is inside the grace period then the operator initiates a full job restart.

## Contribute the Flink Kubernetes Operator to OperatorHub
The Apache Flink Kubernetes Operator has been contributed to [OperatorHub.io](https://operatorhub.io/operator/flink-kubernetes-operator) by the Flink community. The OperatorHub.io aims to be a central location to find a wide array of operators that have been built by the community. An [OLM bundle generator](https://github.com/apache/flink-kubernetes-operator/tree/main/tools/olm) ensures that the resources required by OperatorHub.io are automatically derived from Helm charts.

## Publish flink-kubernetes-operator-api module separately
With the current operator release the Flink community introduces a more light-weight dependency model for interacting with the Flink Kubernetes Operator programmatically. We have refactored the existing operator modules, and introduced a new module, called `flink-kubernetes-operator-api` that contains the generated CRD classes and a minimal set of dependencies only to make the operator client as slim as possible.

## What's Next?
"One of the most challenging aspects of running an always-on streaming pipeline is the correct sizing of Flink deployments. … Clearly, it would be desirable to automatically adjust the resources for Flink deployments. This process is referred to as autoscaling."  - The Flink community is planning to propose an operator based vertex autoscaler. See [FLIP-271](https://cwiki.apache.org/confluence/display/FLINK/FLIP-271%3A+Autoscaling) for further details. Beyond the autoscaler, which is one of the most anticipated features of the operator, the community is continuing to improve the stability, operability, and usability of the Apache Flink Kubernetes Operator on every front.

## Release Resources
The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.3.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.3.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.3.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.3.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.3/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors
Chesnay Schepler, Clara Xiong, Denis Nuțiu, Gabor Somogyi, Gyula Fora, James Busche, Jeesmon Jacob, Marton Balassi, Matyas Orhidi, Maximilian Michels, Sriram Ganesh, Steven Zhang, Thomas Weise, Tony Garrard, Usamah Jassat, Xin Hao, Yaroslav Tkachenko, Zezae Oh, Zhenqiu Huang, Zhiming, clarax, darenwkt, jiangzho, judy.zhu, pvary, ted chang, tison, yangjf2019, zhou-jiang
