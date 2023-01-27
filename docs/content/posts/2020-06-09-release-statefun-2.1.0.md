---
authors:
- morsapaes: null
  name: Marta Paes
  twitter: morsapaes
categories: news
date: "2020-06-09T08:00:00Z"
title: Stateful Functions 2.1.0 Release Announcement
---

The Apache Flink community is happy to announce the release of Stateful Functions (StateFun) 2.1.0! This release introduces new features around state expiration and performance improvements for co-located deployments, as well as other important changes that improve the stability and testability of the project. As the community around StateFun grows, the release cycle will follow this pattern of smaller and more frequent releases to incorporate user feedback and allow for faster iteration.

The binary distribution and source artifacts are now available on the updated [Downloads](https://flink.apache.org/downloads.html) page of the Flink website, and the most recent Python SDK distribution is available on [PyPI](https://pypi.org/project/apache-flink-statefun/). For more details, check the complete [release changelog](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12347861) and the [updated documentation]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.1/). We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists) or [JIRA](https://issues.apache.org/jira/browse/FLINK-18016?jql=project%20%3D%20FLINK%20AND%20component%20%3D%20%22Stateful%20Functions%22%20ORDER%20BY%20priority%20DESC%2C%20updated%20DESC)!

{% toc %}


## New Features and Improvements

### Support for State Time-To-Live (TTL)

Being able to define state expiration and a state cleanup strategy is a useful feature for stateful applications — for example, to keep state size from growing indefinitely or to work with sensitive data. In previous StateFun versions, users could implement this behavior manually using [delayed messages]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.0/sdk/java.html#sending-delayed-messages) as state expiration callbacks. For StateFun 2.1, the community has worked on enabling users to configure any persisted state to expire and be purged after a given duration (i.e. the state time-to-live) ([FLINK-17644](https://issues.apache.org/jira/browse/FLINK-17644), [FLINK-17875](https://issues.apache.org/jira/browse/FLINK-17875)).

Persisted state can be configured to expire after the last _write_ operation (``AFTER_WRITE``) or after the last _read or write_ operation (``AFTER_READ_AND_WRITE``). For the [Java SDK]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.1/sdk/java.html#state-expiration), users can configure State TTL in the definition of their persisted fields:

```java
@Persisted
PersistedValue<Integer> table = PersistedValue.of(
    "my-value",
    Integer.class,
    Expiration.expireAfterWriting(Duration.ofHours(1)));
```

For [remote functions]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.1/concepts/distributed_architecture.html#remote-functions) using e.g. the Python SDK, users can configure State TTL in their ``module.yaml``:

```
functions:
  - function:
     states:
       - name: xxxx
         expireAfter: 5min # optional key
```

<div class="alert alert-info">
	<b>Note:</b>
	The state expiration mode for remote functions is currently restricted to AFTER_READ_AND_WRITE, and the actual TTL being set is the longest duration across all registered state, not for each individual state entry. This is planned to be improved in upcoming releases (<a href="https://issues.apache.org/jira/browse/FLINK-17954">FLINK-17954</a>).
</div>

### Improved Performance with UNIX Domain Sockets (UDS)

Stateful functions can be [deployed in multiple ways]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.1/concepts/distributed_architecture.html#deployment-styles-for-functions), even within the same application. For deployments where functions are [co-located]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.1/concepts/distributed_architecture.html#co-located-functions) with the Flink StateFun workers, it’s common to use Kubernetes to deploy pods consisting of a Flink StateFun container and the function sidecar container, communicating via the pod-local network. To improve the performance of such deployments, StateFun 2.1 allows using [Unix Domain Sockets](https://troydhanson.github.io/network/Unix_domain_sockets.html) (UDS) to communicate between containers in the same pod (i.e. the same machine) ([FLINK-17611](https://issues.apache.org/jira/browse/FLINK-17611)), which drastically reduces the overhead of going through the network stack.

Users can [enable transport via UDS]({{< param DocsBaseUrl >}}flink-statefun-docs-master/sdk/modules.html#defining-functions) in a remote module by specifying the following in their ``module.yaml``:

```
functions:
  - function:
     spec:
       - endpoint: http(s)+unix://<socket-file-path>/<serve-url-path>
```

## Important Changes

* [[FLINK-17712](https://issues.apache.org/jira/browse/FLINK-17712)] The Flink version in StateFun 2.1 has been upgraded to 1.10.1, the most recent patch version.

* [[FLINK-17533](https://issues.apache.org/jira/browse/FLINK-17533)] StateFun 2.1 now supports concurrent checkpoints, which means applications will no longer fail on savepoints that are triggered concurrently to a checkpoint.

* [[FLINK-16928](https://issues.apache.org/jira/browse/FLINK-16928)] StateFun 2.0 was using the Flink legacy scheduler due to a [bug in Flink 1.10](https://issues.apache.org/jira/browse/FLINK-16927). In 2.1, this change is reverted to using the new Flink scheduler again.

* [[FLINK-17516](https://issues.apache.org/jira/browse/FLINK-17516)] The coverage for end-to-end StateFun tests has been extended to also include exactly-once semantics verification (with failure recovery).

## Release Notes

Please review the [release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12347861) for a detailed list of changes and new features if you plan to upgrade your setup to Stateful Functions 2.1.

## List of Contributors

The Apache Flink community would like to thank all contributors that have made this release possible:

abc863377, Authuir, Chesnay Schepler, Congxian Qiu, David Anderson, Dian Fu, Francesco Guardiani, Igal Shilman, Marta Paes Moreira, Patrick Wiener, Rafi Aroch, Seth Wiesman, Stephan Ewen, Tzu-Li (Gordon) Tai

If you’d like to get involved, we’re always [looking for new contributors](https://github.com/apache/flink-statefun#contributing) — especially around SDKs for other languages like Go, Rust or Javascript.