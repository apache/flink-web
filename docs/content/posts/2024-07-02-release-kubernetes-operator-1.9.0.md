---
title:  "Apache Flink Kubernetes Operator 1.9.0 Release Announcement"
date: "2024-07-02T18:00:00.000Z"
authors:
- gyfora:
  name: "Gyula Fora"
  twitter: "GyulaFora"
- mateczagany:
  name: "Mate Czagany"
aliases:
- /news/2024/07/02/release-kubernetes-operator-1.9.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.9.0!

The release includes many improvements to the autoscaler and standalone autoscaler, as well as memory optimizations to the operator. 
There was also a lot of progress made to translate documentation to Chinese.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your experience with the
community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or
[JIRA](https://issues.apache.org/jira/browse/flink)! We're looking forward to your feedback!

## Highlights

### Operator Optimizations

Many improvements and fixes are included in this release to reduce overall memory usage of the operator including the introduction of jemalloc as the default memory allocator to reduce memory fragmentation.


### Operator HA

Thanks to an upgrade to JOSDK 4.8.3, a bug was eliminated where changing watched namespaces in a HA setup would result in unpredictable behaviour.


### Autoscaler CPU And Memory Quotas

The user can now set CPU and memory quotas that the autoscaler will respect and won't scale beyond that.
You can use this feature using the config options `job.autoscaler.quota.cpu` and `job.autoscaler.quota.memory`.


### Autoscaler Improvements

There were several improvements for autoscaling:
- Pulsar partitions taken into account when calculating vertex max parallelism
- Memory tuning will scale JVM metaspace before heap to fix OOM due to too little metaspace memory


### Standalone Autoscaler Improvements

There were numerous improvements for the Standalone Autoscaler component, such as:
- Usage of HikariPool for JDBC connections to reduce database pressure
- Memory leak fixes
- Improved error handling
- Support setting autoscaler options at standalone level
- Fix autoscaling when tasks are not running


### Chinese Documentation

There has been a lot of efforts to translate the Flink Kubernetes Operator documentation into Chinese in this release. 
Many of the pages are translated, such as the overview, architecture and pod templates page. 
We hope that this will help Chinese users to adopt the product more easily in the future and attract more people.


## Release Notes

The release notes can be found [here](https://issues.apache.org/jira/secure/ReleaseNote.jspa?version=12354417&styleName=&projectId=12315522).

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.8.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.9.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.9.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.9.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.9/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Alexander Fedulov, Anupam Aggarwal, Cancai Cai, ConradJam, Ferenc Csaky, Gabor Somogyi, Gyula Fora,
Marton Balassi, Matt Braymer-Hayes, Maximilian Michels, Márton Balassi, Naci Simsek, Rui Fan,
Sergey Nuyanzin, Xin Hao, Yarden Shoham, caicancai, chenyuzhi459, gengbiao.gb, luismacosta,
nicolas.fraison@datadoghq.com, soulzz, timsn, wenbingshen, zhou-jiang
