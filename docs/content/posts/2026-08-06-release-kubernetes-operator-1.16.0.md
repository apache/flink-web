---
title:  "Apache Flink Kubernetes Operator 1.16.0 Release Announcement"
date: "2026-08-06T08:00:00.000Z"
authors:
- gyfora:
  name: "Gyula Fora"
aliases:
- /news/2026/08/06/release-kubernetes-operator-1.16.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.16.0!

This release centers on **extensibility and documentation**: a completely restructured documentation site, a new default for autoscaler parallelism alignment, a trio of pluggable autoscaler SPIs (custom evaluators, scaling executors, and alignment modes), Kubernetes-native pod `ResourceRequirements`, and a range of Blue/Green, session job, savepoint reliability, and security hardening fixes.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your experience with the community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/flink)! We're looking forward to your feedback!

## Highlights

### Restructured Documentation

The operator documentation has been comprehensively reorganized and expanded for better navigability and coverage. The site is now grouped into clear top-level areas: Concepts (architecture, autoscaling, lifecycle management, and a glossary), Deployment (installation, configuration, compatibility, security, leader election, and Helm topics such as cert-manager and RBAC), a consolidated Custom Resource reference, Operations, and a brand new Internals section that documents how the operator actually works under the hood, covering the controller flow, the autoscaler, the admission webhook, and operator startup.

Beyond moving pages around, large parts of the content were rewritten and gaps were filled, so users and contributors now have a single, coherent map of the operator, from first install through to its internal design.

### New Default for Autoscaler Parallelism Alignment

The way the autoscaler aligns a computed target parallelism to the number of key groups or source partitions has a new default. Alignment is now driven by `job.autoscaler.scaling.parallelism-alignment.mode`, which defaults to `BALANCED`, replacing the previous `job.autoscaler.scaling.key-group.partitions.adjust.mode` default of `EVENLY_SPREAD`.

Two differences are visible in day-to-day scaling:

- A scale is no longer blocked. The previous default kept the vertex at its current parallelism and emitted a `ScalingLimited` event whenever no aligned parallelism preserved the scaling direction. `BALANCED` falls back to the computed target instead, so a scaling decision is applied rather than vetoed.
- Mild skew is tolerated to avoid over-provisioning. `EVENLY_SPREAD` snaps to an exact divisor of the key group or partition count, while `BALANCED` takes the first parallelism that reduces per-subtask load. With 128 key groups and a computed target of 24, the old default moved to 32 where the new one settles at 26.

The previous behavior is still available. The deprecated `scaling.key-group.partitions.adjust.mode` key continues to select the original blocking modes unchanged, `EVENLY_SPREAD` is also offered as a built-in mode under the new key, and `OFF` disables alignment entirely.

### Autoscaler Extensibility: Pluggable Evaluators, Scaling Executors, and Alignment Modes

The autoscaler becomes extensible through three new plugin SPIs, all discovered via the standard plugin mechanism and each configurable per named instance. Together they let you customize the autoscaler without forking it:

- Custom Evaluator plugin ([FLIP-514](https://cwiki.apache.org/confluence/spaces/FLINK/pages/345377351/FLIP-514+Custom+Evaluator+plugin+for+Flink+Autoscaler)): inject custom scaling-metric evaluation logic into the evaluation pipeline, augmenting or overriding how the autoscaler interprets the collected metrics before a scaling decision is made.
- Scaling Executor Plugin SPI ([FLIP-575](https://cwiki.apache.org/confluence/spaces/FLINK/pages/421956875/FLIP-575+Scaling+Executor+Plugin+SPI+for+Flink+Autoscaler)): hook into the point where scaling decisions are applied, so a plugin can veto, gate, or adjust a proposed rescale (for example to enforce organization-specific policies) before it is executed.
- Composable Parallelism Alignment Modes ([FLIP-586](https://cwiki.apache.org/confluence/spaces/FLINK/pages/430408363/FLIP-586+Composable+Parallelism+Alignment+Modes+for+Flink+Autoscaler)): make the alignment strategy itself pluggable, so a custom mode can be discovered as a plugin alongside the built-in modes described above.

Each plugin receives its own prefix-stripped, per-instance configuration, keeping custom extensions cleanly isolated from the core autoscaler configuration.

### Kubernetes-native Pod Resource Requirements

TaskManager and JobManager pod resources can now be expressed using standard Kubernetes [`ResourceRequirements`](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/), replacing the operator's previous custom `resource` (cpu/memory) fields. This brings requests and limits, ephemeral storage, and extended resources (such as GPUs) into line with native Kubernetes semantics.

### Operator Configuration is Always Mounted as `config.yaml`

The Helm chart now renders a single `config.yaml` key in the operator ConfigMap and always mounts it under that name ([FLINK-39791](https://issues.apache.org/jira/browse/FLINK-39791)). Previously the template rendered both a `config.yaml` and a `flink-conf.yaml` key, and Flink's `GlobalConfiguration` prefers `flink-conf.yaml` when both are present, so a `defaultConfiguration.config.yaml` block in `values.yaml` was silently ignored.

Two points are worth checking when upgrading:

- Both `defaultConfiguration.config.yaml` and `defaultConfiguration.flink-conf.yaml` are still accepted in `values.yaml`, and `config.yaml` takes precedence when both are set. The resolved configuration is mounted as `config.yaml` either way, which is the file name Flink 2.0 requires.
- Dynamic configuration updates made by editing the ConfigMap directly with `kubectl edit` or `kubectl patch` now belong under the `config.yaml` key.

When overriding through `config.yaml`, prefer the nested YAML form. A flat, dotted-key override of a key that the chart already ships would be a duplicate key under Flink's strict YAML parser and fail at operator startup.

### Runtime Configuration of Running Jobs

The operator now reads a running job's effective configuration back from the cluster, through the JobManager configuration, job execution, and checkpoint config REST endpoints, and layers it over the spec-derived observed configuration.

A spec is a request rather than a record of what a job ended up running with, since a job's main method can change settings programmatically and those take precedence over anything the operator submitted. The runtime configuration is fetched once per job id, cached per resource, and skipped for jobs in a globally terminal state. Keys in the operator's own namespaces are dropped from a job's global parameters, so a job cannot change how the operator manages it by declaring a matching parameter.

### Dependency and Toolchain Updates

The operator is upgraded to **Java Operator SDK 5.5.0**, and the Helm chart CI and end-to-end tests now run on **Helm 4**.

The logging stack moved to **SLF4J 2.0.x with Logback 1.5.x**, clearing the CVEs that had no fix available on the end-of-life Logback 1.2 line. SLF4J 2.x resolves its provider through the `ServiceLoader` mechanism rather than `StaticLoggerBinder`, so the previous restriction against replacing the bundled logging JARs no longer applies.

### Supported Flink Versions

Operator 1.16.0 supports the following Flink version matrix:

**2.3.x, 2.2.x, 2.1.x, 2.0.x, 1.20.x, 1.19.x**

## Notable Bug Fixes

### Blue/Green Deployments

- The Blue/Green transition now finalizes immediately after the previous deployment is deleted, instead of deferring to a later reconciliation, closing a window where a not-ready blip could roll the transition back onto an already-deleted deployment.
- Fixed a bug where, after an aborted transition, the next deploy would delete the previous (Blue) deployment immediately instead of honoring the configured deletion delay.

### Session Jobs

- A fast-running `FlinkSessionJob` now correctly reflects the actual state of the job rather than getting stuck at a stale state.
- A `FlinkSessionJob`'s lifecycle state no longer remains `UPGRADING` after it has been suspended successfully.

### Savepoints and Snapshots

- Redeploying from a savepoint now works for an already suspended job, which previously failed because a suspended job no longer has a job id to cancel.
- `FlinkStateSnapshot`-triggered savepoints now honor the referenced `FlinkSessionJob`'s `state.savepoints.dir`.
- Fixed `FlinkStateSnapshot` with the default `backoffLimit=-1` so it means unlimited retries as documented, instead of failing immediately on the first error.
- Fixed an NPE during `FlinkStateSnapshot` cleanup when the status was null, which could permanently block custom resource and namespace deletion.

### Cluster Upgrades and Configuration

- `AbstractFlinkService.deleteBlocking()` no longer swallows `KubernetesClientTimeoutException`, which previously let an upgrade proceed on top of a still-running cluster.
- The operator now serializes managed-deployment config in the target Flink version's YAML dialect, fixing Flink 1.x deployments when the operator itself runs on the standard `config.yaml`.

### Autoscaler Accuracy and Security

- Source vertices are no longer scaled beyond their partition count, where the extra subtasks are assigned no split and sit idle along with anything chained onto the source.
- Corrected the expected processing rate computation and aligned the busy-time `TRUE_PROCESSING_RATE` numerator estimator with the busy-time aggregator for more accurate scaling decisions.
- The autoscaler Flink REST client timeout is no longer silently overridden by the operator client timeout.
- Bumped log4j, Jackson, and Beam to retire known CVEs.

### Security Hardening

This release also hardens the operator against untrusted input reaching it through session job specs and autoscaler state:

- The `jarURI` of a `FlinkSessionJob` is now validated against a scheme allowlist (`https` only by default, configurable via `kubernetes.operator.user.artifacts.allowed-schemes`), and hosts resolving to internal addresses are rejected. Extend the allowlist if you fetch artifacts over plain `http` or schemes like `s3`.
- Artifact downloads now enforce a connect timeout, a total time budget, and a size cap, so a slow or oversized download can no longer pin a reconcile thread.
- Decompressing autoscaler state read from the ConfigMap is now size-bounded, so a corrupted or malicious entry can no longer exhaust operator memory.
- Memory tuning now only applies the config override keys it writes itself, so a tampered state ConfigMap cannot inject arbitrary Flink configuration into a managed deployment.
- Kafka and Pulsar partition metric names are now parsed without regular expressions, so a job cannot craft names that stall the autoscaler on pathological matching.

## Release Notes

The release notes can be found [here](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12356946).

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.16.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.16.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.16.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.16.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.16/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

The Apache Flink community would like to thank all contributors who made this release possible:

Aleksandr Savonin, Attila Mészáros, Breno Ferreira, Dale Lane, Dennis-Mircea Ciupitu, Devika Sudheer, Farooq Qaiser, Gerk Elznik, Gyula Fora, Lucas Gameiro, lrsb, Marc Demierre, Mate Czagany, Milind L, Nihar Rao, Nishita Pattanayak, Pavel Zeger, Pradeepta Choudhury, Purushottam Sinha, Santwana Verma
