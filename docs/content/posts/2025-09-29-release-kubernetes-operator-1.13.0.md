---
title:  "Apache Flink Kubernetes Operator 1.13.0 Release Announcement"
date: "2025-09-29T20:00:00.000Z"
authors:
- fcsaky:
  name: "Ferenc Csaky"
aliases:
- /news/2025/09/29/release-kubernetes-operator-1.13.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.13.0!
The version brings a number of important fixes and improvements to both core and autoscaler modules.

We encourage you to [download the release](https://flink.apache.org/downloads/#apache-flink-kubernetes-operator) and share your experience with the
community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or
[JIRA](https://issues.apache.org/jira/browse/flink)! We're looking forward to your feedback!

## Highlights

### Flink 2.1 Support

The Flink Kubernetes Operator and Autoscaler 1.13.0 brings support for Flink 2.1 version.

```yaml
apiVersion: flink.apache.org/v1beta1
kind: FlinkDeployment
metadata:
  name: basic-example
spec:
  image: flink:2.1
  flinkVersion: v2_1
  # ...
```

### Structured YAML Configuration Support

Starting with Flink Kubernetes Operator 1.13.0, it is possible to define the `flinkConfiguration` in a structured YAML format as well.
This feature operates independently of Flink’s core configuration handling and is therefore not affected by the defined Flink version.

```yaml
apiVersion: flink.apache.org/v1beta1
kind: FlinkDeployment
metadata:
  name: basic-example
spec:
  image: flink:2.1
  flinkVersion: v2_1
  flinkConfiguration:
    taskmanager:
      numberOfTaskSlots: "2"
    state:
      savepoints:
        dir: file:///flink-data/savepoints
      checkpoints:
        dir: file:///flink-data/checkpoints
    high-availability:
      type: kubernetes
      storageDir: file:///flink-data/ha
  # ...
```

### Bug Fixes and Stability Enhancements

- **Fixed Operator Upgrade Failures**: Fixes a bug where upgrading to operator v1.12 from a previous version may cause job failures.
- **Improved REST Exception Fetching**: For session jobs, this fixes intermittent "Failed to fetch job exceptions from REST API" errors.
- **Session Deletion Enhancement**: With a new configurable option, it is possible to delete sessions even if there are running jobs.
- **FlinkStateSnapshot CRD Compatibility Check**: Now FlinkStateSnapshots also covered with a compatibility check, just like FlinkDeployment and FlinkSessionJob CRDs.

## Release Notes

The full release notes can be found [here](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12355967).

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website.
You can easily try out the new features shipped in the official 1.13.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.13.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.13.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.13.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.13/) and the release notes.
We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Andrei Kaigorodov, Attila Mészáros, David Kornel, Ferenc Csaky, Gabor Somogyi, GuoYu, Gyula Fora, Kumar Mallikarjuna, Mate Czagany, Michał Fijołek, nishita-09, Santwana Verma, schongloo, Yi Chen
