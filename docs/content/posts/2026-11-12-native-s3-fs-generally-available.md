---
title:  "Flink 2.4: The Native S3 FileSystem Is Now the Recommended Choice"
date: "2026-11-12T08:00:00.000Z"
slug: "native-s3-fs-generally-available"
url: "/2026/11/12/native-s3-fs-generally-available/"
authors:
- gaborgsomogyi:
  name: "Gabor Somogyi"
- Samrat002:
  name: "Samrat Deb"
aliases:
- /news/2026/11/12/native-s3-fs-generally-available.html
---

In June, we [introduced `flink-s3-fs-native`](https://flink.apache.org/2026/06/26/announcing-native-s3-fs/), a new S3 filesystem for Apache Flink, built from the ground up on AWS SDK v2 and free of Hadoop. It shipped in Flink 2.3 as an experimental option, and we asked teams to put it through its paces.

They did. Since then, the community has focused on a single goal: making the native S3 filesystem rock solid in production. Teams moving real workloads off the Hadoop plugin told us what broke, and we fixed it. We hardened the code that protects your data, made checkpoints resilient to S3 throttling, and made S3 activity visible in Flink's metrics.

**With Flink 2.4, the native S3 filesystem is generally available and is the community's recommended way to use S3 with Flink.** The Hadoop and Presto plugins remain available as a fallback.


**At a glance**

| | |
|---|---|
| **[Production-ready](#from-experimental-to-recommended)** | Generally available in Flink 2.4 and recommended for new deployments |
| **[Reliable](#exactly-once-writes-you-can-rely-on)** | Hardened exactly-once file writes, and checkpoints that ride out S3 throttling |
| **[Observable](#see-what-s3-is-doing)** | S3 request, latency, throttling, and retry metrics, on by default |
| **[Platform-ready](#one-cluster-many-buckets)** | Separate credentials, regions, and encryption keys for each bucket, in one cluster |
| **[Lean and secure](#why-it-matters)** | One plugin for sinks and checkpoints, no Hadoop dependencies, built on AWS SDK v2 |
| **[Low-risk migration](#getting-started)** | No application code changes, and running `FileSink` jobs can move off the Hadoop plugin |


## Why It Matters

For years, running Flink on S3 meant choosing between two plugins: Hadoop for exactly-once file output, or Presto for faster checkpoints. Both pull in the Hadoop dependency tree and rely on AWS SDK v1. The native filesystem removes that trade-off:

- **One plugin to run and secure.** Exactly-once file sinks and checkpoints come from the same plugin, configured with one set of `s3.*` options.
- **A smaller attack surface.** Without the `hadoop-common` dependency tree, there are far fewer third-party libraries to patch and audit. The plugin JAR is about half the size of the Hadoop plugin's.
- **A supported foundation.** The native plugin is built entirely on AWS SDK v2. Both older plugins still rely on AWS SDK v1, which [reached end of support](https://aws.amazon.com/blogs/developer/the-aws-sdk-for-java-1-x-is-in-maintenance-mode-effective-july-31-2024/) on December 31, 2025.
- **Faster checkpoints.** In the [benchmark we published in June](https://flink.apache.org/2026/06/26/announcing-native-s3-fs/#performance), checkpoints took 48.8 seconds on average with the native plugin, compared with 90.1 seconds with the Presto plugin.


## From Experimental to Recommended

In June, we said that promoting the plugin would be a community decision, driven by feedback from production users. When the [proposal to promote it](https://lists.apache.org/thread/xlq7jly6kvxoz6zr9lmwn6bljlcn66vw) reached the dev@ mailing list, the response was clear: the plugin already runs in many production pipelines, and its feature set covers what Flink needs for both data processing and checkpointing. Matching every general-purpose tuning option of the Hadoop plugin was never the goal. The goal is a focused filesystem built for Flink's needs.

What this means for you:

- **New deployments** should start with `flink-s3-fs-native`.
- **Existing deployments** should plan their migration. It is a deployment change, and the [steps are short](#getting-started).
- **The Hadoop and Presto plugins stay available** as a fallback. They continue to receive critical fixes, but no new features. Any future deprecation will go through a separate community proposal and vote, with time for everyone to migrate.


## What's New in native s3 fs 

Flink 2.4 brings more than two dozen improvements and fixes to the native S3 filesystem. Here is what they mean in practice.

### Exactly-Once Writes You Can Rely On

Flink's `FileSink` writes files to S3 with exactly-once guarantees: no duplicates and no gaps, even when jobs fail and restart. For 2.4, we reviewed and tested every step of how the sink saves its progress, recovers, and commits files, and fixed the issues we found. The most important fix closes a case where data buffered at checkpoint time could be silently lost after a restore. Another lets jobs recover from a checkpoint even if a task was cancelled while writing. And if recovery data is ever missing or doesn't match the checkpoint, Flink now stops with a clear error instead of writing an incomplete file.

Temporary data now lives next to the files being written, so teams that restrict access by S3 prefix don't need to grant extra permissions.

### Checkpoints That Ride Out S3 Throttling

When many parallel tasks hit S3 at once, S3 asks clients to slow down. One team moving a job with about 1 TB of state off the Hadoop plugin saw checkpoints fail within seconds under that pressure, because the AWS SDK stopped retrying once its shared retry budget ran out. In Flink 2.4, throttled requests back off and retry up to your configured limit, as they do with the Hadoop plugin.

For large, highly parallel jobs, a new opt-in adaptive mode (`s3.retry.mode: adaptive`) goes a step further. It slows requests down automatically when S3 pushes back and speeds them up again as S3 recovers, so parallel writers settle at a rate the store accepts. In [single test runs](https://github.com/apache/flink/pull/29499) against a store deliberately configured for heavy throttling, adaptive mode cut throttled requests by about two-thirds and finished the write 15% sooner.

### See What S3 Is Doing

Diagnosing a slow checkpoint used to mean piecing together Flink logs and S3-side monitoring. Flink 2.4 reports S3 activity through Flink's metric system on every JobManager and TaskManager: how many requests each operation makes, how long they take, how often S3 throttles them, and how often they are retried. The metrics are on by default and flow into whatever monitoring system your Flink metric reporters feed, so you can spot throttling or slow S3 calls before they turn into failed checkpoints.

### One Cluster, Many Buckets

Platform teams often run one Flink cluster against several buckets: checkpoints in one AWS account, a data lake in another, an archive in a different region. Flink 2.4 lets you give each bucket its own credentials, IAM role, region, endpoint, and encryption settings in the cluster configuration (`s3.bucket.<bucket-name>.*`), with no custom credential code.

### Leaner, Faster, and More Secure

- **Fewer S3 requests.** Reads no longer open a new S3 request for every short jump within a file, and deleting a directory takes one delete request per 1,000 files instead of one per file.
- **Predictable memory during restores.** Restoring large state now streams each file through a small, fixed-size buffer.
- **Optional AWS CRT transport.** High-throughput workloads can switch to the AWS Common Runtime by adding one JAR and setting `s3.crt.enabled: true`.
- **Encryption context support.** An SSE-KMS encryption context lets KMS key policies require specific values on every upload. It now applies to all uploads; in Flink 2.3, the setting had no effect.
- **A complete, self-contained plugin.** Every dependency is now bundled inside the JAR, closing a packaging gap that could cause class-loading errors at runtime, and the AWS SDK is up to date.

### A Smooth Path Off the Hadoop Plugin

Switching filesystems is a deployment change: your application code stays the same, and existing checkpoints and savepoints remain readable. New in Flink 2.4, `FileSink` jobs with files in progress can switch directly, because the native plugin now restores sink state written by the Hadoop plugin. This path is one-way, so test the switch in a staging environment first.


## Battle-Tested

Promotion wasn't a formality. During this release cycle:

- **Production feedback drove the work.** Several fixes in this release came from teams migrating production-scale jobs, like the throttling issue above.
- **Tests run against a real S3 API.** A new integration test suite runs against [SeaweedFS](https://github.com/seaweedfs/seaweedfs), an open-source S3-compatible server. It covers file operations, exactly-once commits and recovery, metrics, and high-availability cluster runs.
- **Failure paths are tested, not just the happy path.** Tests cover recovery when data is missing or truncated, and retry behavior when S3 throttles requests.


## Getting Started

Moving to the native filesystem takes four steps:

1. **Install the plugin.** Copy the JAR from `opt/` to `plugins/`, and remove the old S3 plugin:

   ```bash
   mkdir -p plugins/s3-fs-native
   cp opt/flink-s3-fs-native-2.4.0.jar plugins/s3-fs-native/
   rm -rf plugins/s3-fs-hadoop   # or plugins/s3-fs-presto
   ```

   To keep the old plugin installed during a staged rollout, [raise the native plugin's priority](https://nightlies.apache.org/flink/flink-docs-release-2.4/docs/deployment/filesystems/s3/#using-multiple-s3-implementations) instead.
2. **Review your configuration.** Credentials and endpoint settings (`s3.access-key`, `s3.secret-key`, `s3.endpoint`) carry over unchanged. Hadoop-specific `fs.s3a.*` keys don't apply; find their native equivalents in the [configuration reference](https://github.com/apache/flink/tree/release-2.4/flink-filesystems/flink-s3-fs-native#configuration-options).
3. **Add a lifecycle rule.** On every bucket Flink writes to, add an S3 lifecycle rule that aborts incomplete multipart uploads. The native plugin never deletes an upload that a checkpoint might still need, so this rule keeps abandoned uploads from adding to your storage bill. Choose a retention period long enough for jobs to recover, including planned downtime; see [Cleaning Up Unfinished Uploads](https://nightlies.apache.org/flink/flink-docs-release-2.4/docs/deployment/filesystems/s3/#cleaning-up-unfinished-uploads).
4. **Test `FileSink` jobs in staging.** Moving sink state from the Hadoop plugin is one-way.


## What's Next

- **Faster writes for large files**, including multipart and parallel part uploads.
- **Smoother restores**, by scheduling downloads continuously instead of in fixed batches.
- **Stronger read consistency**, so a reopened read can't silently pick up a newer version of a file.
- **Beyond S3.** The community has accepted [FLIP-597](https://cwiki.apache.org/confluence/x/9gDuGQ), which brings the same Hadoop-free approach to other object stores, and proposals for [Azure](https://cwiki.apache.org/confluence/x/DQHuGQ) and [Google Cloud Storage](https://cwiki.apache.org/confluence/spaces/FLINK/pages/444334267/FLIP-603+FileSystems+GCS+SDK-native+filesystem) are under discussion.


## Get Involved

The native S3 filesystem is developed in the open as part of Apache Flink. Whether you're evaluating it, migrating, or already running it in production, we want to hear from you, especially about anything you rely on in the Hadoop or Presto plugin that's still missing.

- **Mailing lists:** `user@flink.apache.org` for questions and `dev@flink.apache.org` for development ([subscribe](https://flink.apache.org/community.html)). Please tag your posts with **`[flink-s3-fs-native]`**.
- **Bug reports and feature requests:** [JIRA](https://issues.apache.org/jira/browse/FLINK)
- **Code and reviews:** the [Flink GitHub repository](https://github.com/apache/flink)
