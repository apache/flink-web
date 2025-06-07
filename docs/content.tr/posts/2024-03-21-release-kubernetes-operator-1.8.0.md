---
title:  "Apache Flink Kubernetes Operator 1.8.0 Release Announcement"
date: "2024-03-21T18:00:00.000Z"
authors:
- mxm:
  name: "Maximilian Michels"
  twitter: "stadtlegende"
- gyfora:
  name: "Gyula Fora"
  twitter: "GyulaFora"
- 1996fanrui:
  name: "Rui Fan"
  twitter: "1996fanrui"
aliases:
- /news/2024/03/21/release-kubernetes-operator-1.8.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.8.0!

The release includes many improvements to the operator core, the autoscaler, and introduces new features
like TaskManager memory auto-tuning.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your experience with the
community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or
[JIRA](https://issues.apache.org/jira/browse/flink)! We're looking forward to your feedback!

## Highlights

### Flink Autotuning

We're excited to announce our latest addition to the autoscaling module: Flink Autotuning.

Flink Autotuning complements Flink Autoscaling by auto-adjusting critical settings of the Flink configuration.
For this release, we support auto-configuring Flink memory which is a huge source of pain for users. Flink has
various memory pools (e.g. heap memory, network memory, state backend memory, JVM metaspace) which all need to be
assigned fractions of the available memory upfront in order for a Flink job to run properly.

Assigning too little memory results in pipeline failures, which is why most users end up assigning way too much memory.
Based on our experience, we've seen that heap memory is at least 50% over-provisioned, even after using Flink Autoscaling.
The reason is that Flink Autoscaling is primarily CPU-driven to optimize pipeline throughput, but doesn't change the
ratio between CPU/Memory on the containers.

Resource savings are nice to have, but the real power of Flink Autotuning is the reduced time to production.

With Flink Autoscaling and Flink Autotuning, all users need to do is set a max memory size for the TaskManagers, just
like they would normally configure TaskManager memory. Flink Autotuning then automatically adjusts the various memory
pools and brings down the total container memory size. It does that by observing the actual max memory usage on the
TaskMangers or by calculating the exact number of network buffers required for the job topology. The adjustments are
made together with Flink Autoscaling, so there is no extra downtime involved.

Flink Autotuning can be enabled by setting:

```
# Autoscaling needs to be enabled
job.autoscaler.enabled: true
# Turn on Autotuning
job.autoscaler.memory.tuning.enabled: true
```

For future releases, we are planning to auto-tune more aspects of the Flink configuration, e.g. the number of task slots.

Another area for improvement is how managed memory is auto-configured. If no managed memory is used, e.g. the heap-based
state backend is used, managed memory will be set to zero which helps save a lot of memory. If managed memory is used,
e.g. via RocksDB, the configured managed memory will be kept constant because Flink currently lacks metrics to 
accurately measure the usage of managed memory. Nevertheless, users already benefit from the resource savings and 
optimizations for heap, metaspace, and network memory. RocksDB users can solely focus their attention on configuring
managed memory. For RocksDB, we also added an option to add all saved memory to the managed memory. This is beneficial
when running with  RocksDB to maximize the in-memory performance.

### Improved Accuracy of Autoscaling Metrics

So far, Flink Autoscaling relied on sampling scaling metrics within the current metric window. The resulting accuracy
depended on the number of samples and the sampling interval. For this release, whenever possible, we use Flink's
accumulated metrics which provide cumulative counters of metrics like records processed or time spent processing.
This allows us to derive the exact metric value for the window.

For example, to calculate the average records processed per time unite, we measure the accumulated number of records
processed once at the start of the metric window, e.g. 1000 records. Then we measure a second time when the metric
window closes, e.g. 1500. By subtracting the former from the latter, we can calculate the exact amount of records
processed: 1500-1000 = 500. We can then divide by the metric window duration to get the average number of records
processed.

### Rescale time estimation

We now measure the actual required restart time for applying autoscaling decisions. Previously, users had to manually
configure the estimated maximum restart time via `job.autoscaler.restart.time`. If the new feature is enabled, this
setting is now only used for the first scaling. After the first scaling, the actual restart time has been observed
and will be taken into account for future scalings.

This feature can be enabled via:

```
job.autoscaler.restart.time-tracking.enabled: true
```

For the next release we are thinking to enable it by default.

### Autoscaling for Session Cluster Jobs

Autoscaling used to be an application / job cluster only feature. Now it is also supported for session clusters.

### Improved Standalone Autoscaler

Since 1.7.0, Flink Autoscaling is now also available in a standalone module without the need to run on top of Kubernetes.

We merged notable improvements to the standalone autoscaler:

- The control loop now supports multiple thread
- We implemented a JdbcAutoScalerStateStore for storing state via JDBC-supported databases
- We implemented a JdbcAutoScalerEventHandler for emitting events to JDBC-supported databases

### Savepoint Trigger Nonce

A common request is to support a streamlined, user-friendly way of redeploying from a target savepoint. Previously this
was only possible by deleting the CR and recreating it with initialSavepointPath. A big downside of this approach is a
loss of savepoint/checkpoint history in the status that some platforms may need, resulting in non-cleaned up savepoints.

We introduced a `savepointRedeployNonce` field in the job spec similar to other action trigger nonces.

If the nonce changes to a new non-null value the job will be redeployed from the path specified in the
initialSavepointPath (or empty state If the path is empty).

### Cluster Shutdown and Resource Cleanup Improvements

We improved the shutdown behavior and added better and more consistent logging. We now scale down the JobManager
replicas to zero before removing the JobManager deployment. This ensures that the TaskManager shutdown is clean
because the owner reference to the JobManager deployment is not removed immediately which gives TaskManagers time
to shut down.

### Custom Flink Resource Mutator

Users already had the ability to provide custom resource validators to the operator. With this release, we added
support for custom mutators. See the [docs](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.8/docs/operations/plugins/#custom-flink-resource-mutators).

### Smaller Operator image

Through build optimizations, we were able to reduce the size of the Docker image by 20%.

### Experimental Features

#### Cluster Resource Capacity Check

The operator can automatically check if sufficient resources are available for an autoscaling decision. The information
is retrieved from the Kubernetes cluster based on the available node metrics and the maximum node size of the Kubernetes
Cluster Autoscaler.

The feature can be turned on by setting this configuration value:

```
kubernetes.operator.cluster.resource-view.refresh-interval: 5 min
```

## Release Notes

The release notes can be found [here](https://issues.apache.org/jira/secure/ReleaseNote.jspa?version=12353866&projectId=12315522).

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.8.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.8.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.8.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.8.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.8/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

1996fanrui, Alexander Fedulov, AncyRominus, Caican Cai, Cancai Cai, ConradJam, Domenic Bove, Dominik Dębowczyk,
Gabor Somogyi, Guillaume Vauvert, Gyula Fora, Hao Xin, Jerry Wang, Justin Chen, Máté Czagány, Maximilian Michels,
Peter Huang, Rui Fan, Ryan van Huuksloot, Samrat, Tony Garrard, Yang-LI-CS, ensctom, fengfei02, flashJd, Nicolas Fraison
