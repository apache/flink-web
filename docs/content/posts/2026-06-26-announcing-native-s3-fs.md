---
title:  "Introducing Flink's Native S3 FileSystem: Built for Performance, Designed for Production"
date: "2026-06-26T08:00:00.000Z"
slug: "announcing-native-s3-fs"
url: "/2026/06/26/announcing-native-s3-fs/"
authors:
- gaborgsomogyi:
  name: "Gabor Somogyi"
- Samrat002:
  name: "Samrat Deb"
aliases:
- /news/2026/06/26/announcing-native-s3-fs.html
---

Apache Flink relies on the underlying filesystem for much of its work: reading and writing application data, materializing streaming sinks, and storing checkpoints and savepoints for recovery. For years, S3 support in Flink meant choosing between two Hadoop-based plugins, each with its own trade-offs and configuration quirks. With Flink 2.3, there is a better option.

Today we're introducing `flink-s3-fs-native`, a ground-up, Hadoop-free S3 filesystem built specifically for Flink. It ships as an [experimental opt-in plugin](#availability-and-roadmap) in Flink 2.3, is already running in production at scale at major technology companies, and delivers measurable, reproducible performance gains.


**At a glance**

| | |
|---|---|
| **[~2x faster checkpoints](#performance)** | 48.8 s average vs 90.1 s with the Presto plugin; up to 4.5x at small state sizes |
| **Drop-in replacement** | Swap the JAR, keep your existing `flink-conf.yaml`, restart your cluster |
| **No Hadoop dependency** | ~13 MB JAR vs ~30–93 MB; no CVE triage on Hadoop transitive dependencies |
| **[AWS SDK v2](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/home.html)** | Async-first I/O; [AWS SDK v1 reached end-of-support on December 31, 2025](https://aws.amazon.com/blogs/developer/the-aws-sdk-for-java-1-x-is-in-maintenance-mode-effective-july-31-2024/) |
| **One plugin for everything** | Exactly-once sinks and fast checkpoints — no trade-offs, no compromises |


## Two Plugins, One Filesystem, and No Good Answer

If you've configured S3 for Flink before, you likely know that Flink ships two S3 filesystem plugins, and both register on the same `s3://` scheme. Only one can be active at a time. Choosing between them has been a source of confusion for years. Even once one has been chosen, its use still [perplexes](https://rmoff.net/2024/08/06/troubleshooting-flink-sql-s3-problems/) many end-users because of the similarly-named but different configurations required.

The **Hadoop plugin** wraps Hadoop's S3A client. It supports `RecoverableWriter`, which enables exactly-once sinks. Unfortunately it pulls in the full `hadoop-common` dependency tree and AWS SDK v1. Configuration uses Hadoop-native keys (`fs.s3a.*`) mirrored to Flink-style keys (`s3.*`) through a compatibility layer.

The **Presto plugin** was historically recommended for checkpointing because of its faster read path. But it does not support `RecoverableWriter`, which means exactly-once file sinks don't work with it. It carries known [bugs around directory deletion](https://github.com/prestodb/presto/issues/17416) that require Flink-side workarounds. It also depends on `hadoop-common` and AWS SDK v1 under the hood.

Both share a common base layer that adapts a Hadoop `FileSystem` into a Flink `FileSystem`. This adaptation layer adds indirection, limits Flink-specific optimizations, and ties the implementation to Hadoop's configuration model and SDK lifecycle.

As a result, you could have exactly-once sinks or a lighter read path, but not both. In addition, you are carrying Hadoop dependency challenges.

**The native plugin removes the trade-off entirely.**

---

## Why This Matters Beyond Engineering

The decision to replace the S3 plugin is not just a performance choice. It has direct operational and financial consequences.

**Security and compliance teams** have long carried the burden of triaging CVEs in `hadoop-common`'s transitive dependency tree. That tree is large, changes frequently, and generates a steady stream of vulnerability disclosures unrelated to S3 or Flink. Removing it sharply reduces that toil. Fewer dependencies mean fewer CVEs, fewer emergency patch cycles, and fewer security review gates for new deployments.

**Platform and infrastructure teams** running multi-tenant Flink clusters benefit from a clean, unified `s3.*` configuration namespace. The native plugin's configuration model is designed for Flink. No Hadoop-style key mirroring, no adapter translation layer, no debugging sessions caused by settings silently not propagating.

**Risk and compliance teams** should note that the AWS SDK for Java 1.x has been in [maintenance mode since July 31, 2024](https://aws.amazon.com/blogs/developer/the-aws-sdk-for-java-1-x-is-in-maintenance-mode-effective-july-31-2024/) and reached **end-of-support on December 31, 2025**, after which it receives no further updates or releases. The foundation that both existing plugins depend on has therefore reached end-of-life, which means no new features and a winding-down stream of bug and security fixes. Continuing to operate on SDK v1 is an accumulating technical and compliance liability. The native plugin is built entirely on [AWS SDK v2](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/home.html).

**Operations teams** benefit from faster checkpoints in two concrete ways:
- Shorter checkpoint windows mean less CPU time spent on state serialization and more capacity for actual data processing.
- Tighter recovery windows mean less data to replay after a failure. This directly improves recovery SLAs at scale.

The benefit is not limited to operations teams. Any application using exactly-once semantics sees lower end-to-end latency when checkpoints complete faster, since record visibility downstream is gated on checkpoint completion.

## One Stop Solution: Native S3 Filesystem

| Feature | flink-s3-fs-hadoop | flink-s3-fs-presto | flink-s3-fs-native |
|---|---|---|---|
| Exactly-once FileSink | ✓ | ✗ | ✓ |
| RecoverableWriter | ✓ | ✗ | ✓ |
| Checkpointing | ✓ | ✓ | ✓ |
| AWS SDK v2 | ✗ | ✗ | ✓ |
| No Hadoop dependency | ✗ | ✗ | ✓ |
| SSE-KMS encryption | ✓ | ✓ | ✓ |
| SSE-KMS encryption context | ✗ | ✗ | ✓ |
| Non-blocking NIO async I/O | ✗ | ✗ | ✓ |
| JAR size | ~30 MB | ~93 MB | ~13 MB |

### Feature highlights

**No Hadoop dependency tree.** No `hadoop-common`, no `aws-java-sdk` v1, no class-shading conflicts. This also drops the transitive baggage that rides along with `hadoop-common` and is unrelated to S3 access — libraries such as Jackson, Guava, protobuf, Jetty, and the Kerberos/Zookeeper stack — each a recurring source of CVE triage and version conflicts. The native shaded JAR weighs ~13 MB, which is less than half the size of the Hadoop plugin (30 MB) and 7x lighter than the Presto plugin (93 MB).

**Async-first I/O.** Reads and writes use AWS SDK v2's `S3TransferManager`, backed by Netty NIO multiplexed connections that avoid the thread-per-request bottleneck of the existing plugins. Bulk state restore runs as batched concurrent transfers with connection-pool-aware concurrency control. This is the same mechanism that replaces the need for external tools like `s5cmd`.

**Exactly-once recoverable writes.** `NativeS3RecoverableWriter` uses S3 multipart uploads to provide exactly-once semantics for Flink's sink connectors and checkpoint metadata. Uploads are resumable on failure. The writer can recover an in-progress multipart upload and continue from the last committed part.

**Per-bucket configuration.** A single Flink cluster will be able to access multiple S3 buckets with distinct credentials, regions, endpoints, and encryption policies, configured via `s3.bucket.<bucket-name>.<property>`. This is planned for Flink 2.4.

**Server-side encryption.** All three S3 plugins support SSE-S3 and SSE-KMS. What the native plugin adds is **encryption context**: custom key-value metadata attached to KMS operations that enables fine-grained IAM policy conditions.

**Entropy injection for checkpoint sharding.** A configurable substring in checkpoint paths is replaced with random characters at write time, distributing checkpoint objects across S3's internal partitions and avoiding hot-key throttling at high checkpoint frequencies.

**Production-grade lifecycle management.** Every component follows an async close lifecycle with configurable timeouts.

## Performance

Benchmarks from production-scale testing show clear, measurable gains over the Presto plugin.

### Test environment

The benchmark ran on Amazon EKS (ap-south-1) with a Flink 2.1.1 cluster composed of 1 JobManager (2 GB memory, 1 core) and 2 TaskManagers (6 GB memory, 1.5 cores, 4 task slots each) for a total parallelism of 8. The workload targeted 20 GB of RocksDB state with full, non-incremental checkpoints every 60 seconds in EXACTLY_ONCE mode. The test ran for approximately 77 minutes. Configurations for both plugins were identical except for the plugin JAR itself. These results reflect this specific environment and workload; your own numbers will vary with object-size distribution, parallelism, region, and cluster sizing. The full workload configuration and methodology are documented in the [Native S3 Benchmark report](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=406620396) so you can reproduce the benchmark in your own environment.

### Summary results

| Metric | flink-s3-fs-presto | flink-s3-fs-native |
|---|---|---|
| Average throughput | ~92 MB/s | ~200 MB/s (2.17x) |
| Average checkpoint duration | 90.1 s | 48.8 s (1.85x faster) |
| P90 checkpoint duration | 155.0 s | 72.5 s (2.14x faster) |
| P99 checkpoint duration | 165.3 s | 76.7 s (2.15x faster) |
| Checkpoints completed (same window) | 40 | 78 (1.95x more) |
| Avg storage per checkpoint | 415 MB | 312 MB (25% smaller) |

### Throughput

| State size range | flink-s3-fs-presto | flink-s3-fs-native | Speedup |
|---|---|---|---|
| 0–2 GB | 79 MB/s | 362 MB/s | 4.58x |
| 2–4 GB | 85 MB/s | 285 MB/s | 3.35x |
| 4–6 GB | 84 MB/s | 173 MB/s | 2.06x |
| 6–8 GB | 86 MB/s | 165 MB/s | 1.92x |
| 8–10 GB | 91 MB/s | 180 MB/s | 1.98x |
| 10–12 GB | 93 MB/s | 193 MB/s | 2.08x |
| 12–14 GB | 93 MB/s | 198 MB/s | 2.13x |
| 14–16 GB | 94 MB/s | 203 MB/s | 2.16x |

The performance gains are consistent across all state sizes and remain above 2x as state grows.

### What faster checkpoints mean for your operations

1. **Lower CPU overhead.** Shorter checkpoint windows reduce the CPU time spent on state serialization and S3 I/O, freeing capacity for actual data processing.
2. **Higher checkpoint frequency.** With faster uploads, you can checkpoint more often without impacting pipeline throughput. This directly reduces the volume of data that must be reprocessed after a failure.
3. **Tighter recovery SLAs.** The async bulk download path during state restore and the faster checkpoint write path are independent gains.

Full benchmark methodology and raw data are published in the [Native S3 Benchmark report](https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=406620396).


## Smooth Migration Path

Whether you're on the Hadoop or Presto plugin, switching to `flink-s3-fs-native` requires **no application code changes**. Migration is a deployment-level operation:

```bash
# 1. Remove your existing plugin
rm -rf plugins/flink-s3-fs-hadoop/   # or plugins/flink-s3-fs-presto/

# 2. Add the native plugin
mkdir -p plugins/flink-s3-fs-native
cp opt/flink-s3-fs-native-*.jar plugins/flink-s3-fs-native/

# 3. Review flink-conf.yaml
#    The native plugin uses clean s3.* keys.
#    Hadoop-specific keys (fs.s3a.*, presto.s3.*) are no longer needed.

# 4. Restart your cluster
```

Existing checkpoints and savepoints on S3 remain fully readable. The native filesystem is read/write compatible with data written by either the Hadoop or Presto plugins.

**Configuration simplification example:**

```yaml
# Before (Hadoop plugin)
fs.s3a.access.key: ...
fs.s3a.secret.key: ...
fs.s3a.connection.maximum: 100

# After (Native plugin) — same keys, cleaner namespace
s3.access-key: ...
s3.secret-key: ...
s3.connection.maximum: 100
```

**A note on s5cmd.** Users of `s5cmd` for bulk state downloads should be aware that the native plugin does not use `s5cmd`. Instead, it relies on `S3TransferManager`'s async concurrent transfer engine, which demonstrated superior throughput in our benchmarks. No external binary dependency is required.

**Run both plugins side by side.** Packaging both a legacy plugin JAR and the native JAR in `plugins/` is fully supported and safe. When both register for the same scheme, a configurable `priority` selects which factory wins; by default the Hadoop plugin takes precedence, but you can override this to choose the native plugin instead. Flink will not crash, and there is no data loss risk from a misconfigured migration. Because the native filesystem is read/write compatible with data written by the Hadoop and Presto plugins in both directions, rolling back is as simple as flipping the priority back — making this a deliberate control for staged migration rather than just a safety net.

For the full configuration reference, see the [S3 FileSystem documentation](https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/filesystems/s3/).


## Availability and Roadmap

**Flink 2.3** : `flink-s3-fs-native` is available as an experimental opt-in plugin. Experimental means it is feature-complete and production-proven at major technology companies, but the community is actively collecting feedback and hardening edge cases before promoting it to the default. We encourage teams to deploy it in staging and production and share their experience. The existing `flink-s3-fs-hadoop` and `flink-s3-fs-presto` plugins are now effectively in maintenance mode: they continue to receive critical bug and security fixes, but no new feature development is planned for them.

**Flink 2.4** : Additional features and bug fixes are planned, including:

- **Per-bucket configuration** : A single Flink cluster will be able to access multiple S3 buckets with distinct credentials, regions, endpoints, and encryption policies via `s3.bucket.<bucket-name>.<property>`, without custom credential injection hacks.
- **AWS CRT client support** : Enabling the `S3CrtAsyncClient` for additional multipart and HTTP/2 optimizations. The benchmark results above were achieved *without* this; CRT support will push performance further.
- **Enhanced observability** : S3 operation metrics (latency, retry counts, throughput) exposed through Flink's metric system, giving platform teams visibility into S3 I/O behavior.
- **Stream-based S3 read/write** : Improving memory efficiency for large object operations.

**Phase 2: Recommended default.** Promotion to the recommended default is a community decision taken on the [dev@ mailing list](https://flink.apache.org/community.html). The signals we will look for are sustained adoption feedback from production users and no unresolved Blocker or Critical issues in JIRA against the native plugin across at least one full release cycle. Once that bar is met, the native plugin will become the recommended default for new Flink installations, and documentation, quickstarts, and tutorials will be updated accordingly.

**Phase 3: Formal deprecation.** Once the native plugin is the recommended default, the Hadoop and Presto plugins will be formally deprecated through the community process (a FLIP and `dev@` vote), with a defined support window before removal.


## Get Involved

`flink-s3-fs-native` is part of Apache Flink and is developed in the open. The module lives at `flink-filesystems/flink-s3-fs-native` in the [Flink repository](https://github.com/apache/flink).

The migration is safe and requires minimal deployment changes. If your team is already evaluating or running this in production, we want to hear from you. When posting to the mailing lists, please use the subject tag **`[flink-s3-fs-native]`** so maintainers can find and triage your feedback quickly. Your input directly shapes the path from experimental to default.

- **Mailing lists:** subscribe to `user@flink.apache.org` (usage questions) or `dev@flink.apache.org` (development discussion) via [flink.apache.org/community.html](https://flink.apache.org/community.html), and tag posts with **`[flink-s3-fs-native]`**
- **Bug reports and feature requests:** [JIRA (FLINK project)](https://issues.apache.org/jira/browse/FLINK)
- **Contributions:** Pull requests welcome via the [Flink GitHub repository](https://github.com/apache/flink)
