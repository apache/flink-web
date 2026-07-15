---
authors:
- sofie204: null
  name: Sophia Izokun
date: "2026-07-30T08:00:00Z"
excerpt: Flink Community Update for Q2 2026
title: Flink Community Update for Q2 2026
aliases:
- /news/2026/07/30/community-update.html
---

This is the Flink Community Update for Q2 2026, the first in a new quarterly format. Following a discussion with the dev community, the intention going forward is that these updates will appear quarterly rather than monthly, with the aim of highlighting higher-impact topics over a three-month window at a time.
This edition covers April through June 2026.

<!--more-->

Just like previous updates, we'll still cover releases, FLIPs, governance, and community announcements. However, we will begin with a few themes that stood out across the quarter.

The changes and updates to Flink this quarter were quite impactful, with Flink SQL closing several gaps with the DataStream API through changelog conversion, and materialized tables gaining in-place evolution. Flink Agents shipped a substantial 0.3.0 release spanning reusable skills, cross-language actions, reliability, and observability. The community also accepted an umbrella proposal defining a broader direction for AI-native, multimodal processing in Flink.

The previous update is available in the [Flink Community Update for April 2026](https://flink.apache.org/2026/04/13/flink-community-update-for-april-2026/).

## In this update

- [Release of Apache Flink 2.3.0](#release-of-apache-flink-230) — Flink SQL becomes more capable, a native S3 filesystem, and what to check before you upgrade
- [Flink Agents 0.3.0](#flink-agents-030) — the sub-project adopts the AI ecosystem's emerging standards on its road to 1.0
- [New releases](#new-releases) — the quarter's releases at a glance; Flink 2.3.0, Agents 0.3.0, Kubernetes Operator 1.15.0, and maintenance and connector releases across every supported line
- [Governance and Community](#governance-and-community) — four new committers, a new PMC member, eleven accepted FLIPs, and the StateFun sunset vote
- [Staying up to date](#staying-up-to-date) — where to find the community and how to give feedback on these updates

## Release of Apache Flink 2.3.0
[Flink 2.3.0 was announced](https://flink.apache.org/2026/06/25/apache-flink-2.3.0-release-announcement/) on June 25th 2026, the product of a release cycle that ran end to end in this quarter. The [release branch was cut](https://lists.apache.org/thread/sr0zlz8nc5fkcxd7bqmblfwdv3j4h6rx) on April 15, an [open call for release testing](https://lists.apache.org/thread/t7jj2qvl093mto7jt6z3zkqo3jyo8zno) went out five days later, and after four release candidates the [vote concluded](https://lists.apache.org/thread/bqxlj4fm9hdp868xs95qw504kg231m9m) on June 18. The announcement blog covers all fifteen FLIPs and here we pick out the changes we think matter most to the Flink community.

### Flink SQL becomes more capable
The [April community update](https://flink.apache.org/2026/04/13/flink-community-update-for-april-2026/) covered ongoing work around materialized tables, changelog conversion and process table functions. Several of those developments reached users as SQL updates with Flink 2.3.0 in June.

These updates show that Flink SQL is expanding into use cases that previously required the DataStream API or custom workarounds. At the same time, the updates also brought fixes and deliberate changes that show Flink SQL becoming more explicit about behavior that can affect correctness, state growth, or the results written to a sink.

#### Changelog conversion comes to SQL

For the first time, SQL users can convert retract or upsert streams into append form with the new `FROM_CHANGELOG` and `TO_CHANGELOG` operators [FLIP-564](https://cwiki.apache.org/confluence/spaces/FLINK/pages/406620639/FLIP-564+Support+FROM_CHANGELOG+and+TO_CHANGELOG+built-in+PTFs), a class of operation that previously meant dropping down to the DataStream API.

Worth knowing before you reach for it:
- 2.3 covers the basic use cases, with more (such as `PARTITION BY`,  `invalid_op_handling`,`produces_full_deletes`) planned to follow in 2.4.

#### Materialized tables can evolve with less re-processing

Until now, changing a materialized table's query definition meant
dropping and recreating it and reprocessing all the historical data
that came with it. 2.3 removes that requirement ([FLIP-557](https://cwiki.apache.org/confluence/spaces/FLINK/pages/399279094/FLIP-557+Granular+Control+over+Data+Reprocessing+in+Materialized+Table+Evolution) and
[FLIP-550](https://cwiki.apache.org/confluence/spaces/FLINK/pages/387648095/FLIP-550+Add+similar+support+for+CREATE+ALTER+operations+for+MATERIALIZED+TABLEs+as+for+TABLEs)) such that definitions can evolve in place, without the unnecessary recompute. For users of Flink whose teams pay a cloud bill as a result of that recompute, skipping unnecessary reprocessing is a direct saving.

### Upsert sinks stop guessing

When a query's upsert key differs from the sink's primary key, Flink
previously materialized state to resolve the conflict and that could result in a
source of unbounded state growth. 2.3 introduces an explicit
`ON CONFLICT` clause ([FLIP-558](https://cwiki.apache.org/confluence/spaces/FLINK/pages/399279158/FLIP-558+Improvements+to+SinkUpsertMaterializer+and+changelog+disorder)), and changes the default such that those queries now fail at planning time unless you state a conflict strategy. A query that planned fine on 2.2 can refuse to plan on 2.3 and that's a feature of the FLIP.

### Native S3 filesystem reduces the Hadoop dependency footprint

Flink 2.3.0 ships an [experimental native S3 Filesystem](https://cwiki.apache.org/confluence/spaces/FLINK/pages/396790457/FLIP-555+Flink+Native+S3+FileSystem) built on the AWS SDK v2 with no Hadoop dependencies. This shows how Flink is moving towards a more cloud native foundation. The project has published [benchmarks](https://cwiki.apache.org/confluence/spaces/FLINK/pages/406620396/Benchmarking+Native+S3+FileSystem+flink-s3-fs-native+vs+Presto+S3+flink-s3-fs-presto) comparing the native implementation with the existing Presto-based S3 filesystem.

It's important to note that the native filesystem is experimental in Flink 2.3.0. As such, users should review its documentation and limitations carefully before using it for production checkpoint, savepoint, or sink storage.

- [Documentation](https://nightlies.apache.org/flink/flink-docs-release-2.3/docs/deployment/filesystems/s3/)

### Before you upgrade

Two items in 2.3.0 deserve attention regardless of which features you
care about.

If you use mini-batch aggregation with `ONE_PHASE` aggregation, it would be worth reviewing the 2.3.0 upgrade.

Flink 2.3.0 fixes a bug where a batch containing only retractions could cause all remaining keys in the bundle to be silently dropped
([FLINK-35661](https://issues.apache.org/jira/browse/FLINK-35661) —
[details in the announcement](https://flink.apache.org/2026/06/25/apache-flink-2.3.0-release-announcement/#critical-bug-fix-minibatch-aggregation-record-loss)).
Silent data loss fixes are a valid reason to upgrade.

Watermark alignment was redesigned in [FLINK-37399](https://issues.apache.org/jira/browse/FLINK-37399) to remove a bottleneck that could limit how quickly jobs processed accumulated backlog. Starting in Flink 2.3, watermark alignment pauses sources a few seconds later than it did previously, which can modestly increase state size for windowed and temporal operators. Users who prefer the earlier behavior can set `pipeline.watermark-alignment.buffer-size` to `0`.

### Also in 2.3.0

**Applications and rescaling become visible in the Web UI**

A few more changes from the release worth knowing about, each covered
fully in the announcement:

Application-level lifecycle management
([FLIP-549](https://cwiki.apache.org/confluence/spaces/FLINK/pages/386272238/FLIP-549+Support+Application+Management) / [FLIP-560](https://cwiki.apache.org/confluence/spaces/FLINK/pages/404160740/FLIP-560+Application+Capability+Enhancement)) replaces the cluster-job model with a cluster–application–job hierarchy, visible in a new Applications view in the Web UI.

Rescaling gains a visible history with its own Web UI tab
([FLIP-487](https://cwiki.apache.org/confluence/spaces/FLINK/pages/327979197/FLIP-487+Show+history+of+rescales+in+Web+UI+for+AdaptiveScheduler#FLIP487:ShowhistoryofrescalesinWebUIforAdaptiveScheduler-RescaleOverviewUI) / [FLIP-495](https://cwiki.apache.org/confluence/spaces/FLINK/pages/334760525/FLIP-495+Support+AdaptiveScheduler+record+and+query+the+rescale+history)), so you can
see what the adaptive scheduler decided and when.

**Checkpoints can now be triggered during recovery**

([FLIP-547](https://cwiki.apache.org/confluence/spaces/FLINK/pages/384895569/FLIP-547+Support+checkpoint+during+recovery)) provides relief for large jobs recovering with unaligned checkpoints.

[//]: # (might not include the below)
[//]: # ()
[//]: # (Batch)

[//]: # (jobs gain adaptive partition selection &#40;[FLIP-339]&#40;[LINK: cwiki]&#41;,)

[//]: # (opt-in&#41;, and the OpenTelemetry metrics exporter learned compression)

[//]: # (and batching &#40;[FLIP-553]&#40;[LINK: cwiki]&#41;&#41;.)

## Flink Agents 0.3.0

The Flink Agents sub-project [released 0.3.0](https://flink.apache.org/2026/06/19/apache-flink-agents-0.3.0-release-announcement/) on June 19th 2026. The announcement blog contains the complete feature list. The pattern across this release is a project adopting the AI ecosystem's emerging standards rather than rolling its own.

### Reusable capabilities and declarative configuration

The Flink Agents 0.3.0 sub-project adds support for Agent Skills in both Python and Java. Agent Skills is the developing standard for packaging prompts, tools, and resources into reusable capabilities that an agent can discover and load when needed.

A new YAML API along with a published schema, allows models, prompts, tools, vector stores, and other resources to be declared separately from the Python or Java action logic that uses them.

The Schema enables IDE validation, autocompletion, and LLM assisted authoring.

The 0.3.0 release also supports long-term memory rebuilt on Mem0, replacing the previous
vector-store implementation.

The release also brings cross-language actions (Java actions inside Python agents and vice
versa) and a durable reconciler for recovering in-flight external side effects after failure recovery,

Observability also improved, agent event logs now appear in the Web UI by default.

Flink Agents 0.3.0 remains a preview
release, meaning that the APIs are experimental and can change incompatibly. For early adopters, the practical response is that the project has one more migration. The announcement's roadmap is direct about what comes next: 0.4 is planned as the last round of breaking changes and if that all goes smoothly then 1.0 will follow and a formal commitment to API compatibility from there.

The Agents sub-project is not moving in isolation. The community accepted
[FLIP-577](https://cwiki.apache.org/confluence/spaces/FLINK/pages/421957275/FLIP-577+AI-Native+Flink+%E2%80%94+An+Umbrella+Proposal+for+Multimodal+Data+Processing),
an umbrella proposal for AI-native, multimodal processing in core Flink, in May with concrete sub-proposals already appearing (more info found in FLIPs being discussed).

## New releases
### Apache Flink 2.3.0

Apache Flink 2.3.0 was released on June 25.

The release implements the full or core functionality of fifteen FLIPs and includes major work across Flink SQL, materialized tables, application management, runtime recovery, observability, and filesystem integration.

See the [complete release announcement](https://flink.apache.org/2026/06/25/apache-flink-2.3.0-release-announcement/) for all features, configuration details, compatibility notes, and contributors.

### Apache Flink Agents 0.3.0

[Apache Flink Agents 0.3.0](https://flink.apache.org/2026/06/19/apache-flink-agents-0.3.0-release-announcement/) was released on June 19.

The release adds Agent Skills, Mem0-based long-term memory, declarative YAML configuration, cross-language actions, durable reconciliation, expanded observability, and additional integrations.

Flink Agents 0.3.0 is a preview release with experimental APIs.

### Apache Flink Kubernetes Operator 1.15.0

[Apache Flink Kubernetes Operator 1.15.0](https://flink.apache.org/2026/05/26/apache-flink-kubernetes-operator-1.15.0-release-announcement/) was released on May 26.

Highlights include Kubernetes-native Conditions, Logback support, bundled metric reporters, expanded monitoring documentation, Flink 2.2 compatibility, and reliability fixes.

The theme of this release is the operator becoming a more standard Kubernetes citizen. Status is now reported through Kubernetes-native Conditions, so the tooling already used to read any other resource can read the operator's state too.

The accepted proposals pipeline points the same way. This quarter the community accepted composable parallelism alignment modes for the autoscaler ([FLIP-586](https://cwiki.apache.org/confluence/spaces/FLINK/pages/430408363/FLIP-586+Composable+Parallelism+Alignment+Modes+for+Flink+Autoscaler)), per-downstream-target throughput metrics ([FLIP-587](https://cwiki.apache.org/confluence/spaces/FLINK/pages/430408366/FLIP-587+Expose+per+downstream+target+numRecordsOut+metric)), pluggable storage for the HistoryServer ([FLIP-584](https://issues.apache.org/jira/browse/FLINK-39911)), job info on Source contexts ([FLIP-583](https://cwiki.apache.org/confluence/spaces/FLINK/pages/430407938/FLIP-583+Expose+JobInfo+on+Source+contexts)), and a supported CLI for managing stuck exactly once Kafka transactions [FLIP-572](https://cwiki.apache.org/confluence/spaces/FLINK/pages/406623328/FLIP-572+Introduce+Flink-Kafka+Transactions+Management+Tool). A stuck exactly-once Kafka transaction used to force a choice between a downstream outage and data loss at broker timeout, fixable only with knowledge of producer fencing,  FLIP-572 turns that improvised process into a supported tool.

### Maintenance and connector releases

The community also published maintenance releases across several supported Flink branches:

Apache Flink 1.20.4
Apache Flink 1.20.5
Apache Flink 2.0.2
Apache Flink 2.1.2
Apache Flink 2.1.3
Apache Flink 2.2.1

Connector releases included:

Apache Flink Connector AWS 6.0.1
Apache Flink Connector HTTP 1.0.0
Apache Flink Connector Kafka 5.0.0
Apache Flink Connector Pulsar 4.2.0

Current releases and download information are available from the Apache Flink downloads page.

## Governance and Community

### New Committers

The community welcomed four new committers this quarter:
- Gustavo de Morais
- Hao Li
- Peter Huang
- Wenjie Xie

### New PMC Member
We also welcomed a new PMC Member
- David Anderson, a Flink committer since 2020, joined the PMC in May.

Congratulations to all

### Stateful Functions Sub-Project Being Sunsetted

As flagged in the
[April update](https://flink.apache.org/2026/04/13/flink-community-update-for-april-2026/), [Stateful Functions](https://cwiki.apache.org/confluence/display/FLINK/FLIP-569%3A+Sunset+the+Stateful+Functions+%28StateFun%29+Sub-project)
(StateFun) is being sunsetted due to lack of activity. The [formal vote](https://lists.apache.org/thread/x2cfz4t0ov614vgxbp4gpbbnd2v2jwvf) (FLIP-569) opened in late May and remains open at the time of writing.

### FLIPs

Eleven FLIPs were accepted this quarter, two in April, two in May, and seven in June. Several are covered elsewhere in this update.

FLIP-577 with Flink Agents, and FLIP-572, FLIP-583, FLIP-584, FLIP-586, and FLIP-587 under operations.

The remaining FLIPs, for the record:

* [FLIP-574](https://cwiki.apache.org/confluence/spaces/FLINK/pages/421954023/FLIP-574+Metadata+Filter+Push-Down+for+Table+Sources): Metadata Filter Push-Down for Table
  Sources. (Jim Hughes)
  * Accepted April 21 with potential release of 2.4.0.
* [FLIP-568](https://cwiki.apache.org/confluence/spaces/FLINK/pages/406623034/FLIP-568+Strict+BYTES-to-STRING+CAST+with+UTF-8+Validation+Utilities):
  Strict BYTES-to-STRING CAST with UTF-8 Validation Utilities (Gustavo de Morais)
  * Accepted April 13, targeting 2.4.0. See Looking Ahead for why it matters.

* [FLIP-578](https://cwiki.apache.org/confluence/spaces/FLINK/pages/421958318/FLIP-578+In-place+Table+to+Materialized+Table+conversion?src=contextnavpagetreemode): In-place Table to Materialized Table
  conversion. (Gustavo de Morais)
  * Accepted June 3, targeting 2.4.
* [FLIP-579](https://cwiki.apache.org/confluence/spaces/FLINK/pages/421958523/FLIP-579+LATERAL+SNAPSHOT+Join): LATERAL SNAPSHOT Join. (Fabian Hueske)
  * Accepted June 11, no release assigned.

* [FLIP-576](https://cwiki.apache.org/confluence/spaces/FLINK/pages/421957173/FLIP-576+Filesystem-Plugin+Observability+flink-s3-fs-native): Filesystem-Plugin Observability.
  (Samrat Deb)
  * Accepted June 3, targeting 2.4.0.

### FLIPs being discussed

Several proposals were opened for discussion during the quarter and these proposals have not yet gone to a vote. They cluster around the same directions as the rest of this update:

**Table/SQL evolution**

* [FLIP-497](https://cwiki.apache.org/confluence/spaces/FLINK/pages/334760951/FLIP-497+Early+Fire+Support+for+Flink+SQL+Interval+Join): (Restarted) FLIP-497: Early Fire Support for Flink SQL Interval Join

**AI-native Flink**

* [FLIP-590](https://cwiki.apache.org/confluence/spaces/FLINK/pages/430408825/FLIP-590+Introduce+Multimodal+Data+Type+Vector+Tensor+and+Image): Introduce Multimodal data types: Vector, Tensor, and Image.
* [FLIP-589](https://cwiki.apache.org/confluence/spaces/FLINK/pages/430408808/FLIP-589+Introduce+FILE+Type+for+Byte-Content+References): Introduce FILE type for byte-content references.
* [FLIP-591](https://cwiki.apache.org/confluence/spaces/FLINK/pages/430409184/FLIP-591+Introducing+Python+DataFrame+API+in+PyFlink): Introducing Python DataFrame API for PyFlink.
* [FLIP-592](https://cwiki.apache.org/confluence/spaces/FLINK/pages/430409323/FLIP-592+First-Class+Accelerator+Resource+Support): First-Class Accelerator (GPU) Resource Support.

**Beyond-Hadoop filesystems**

* [FLIP-597](https://cwiki.apache.org/confluence/spaces/FLINK/pages/435028214/FLIP-597+Filesystems+Hadoop-less+Flink+filesystems): [Filesystems] Hadoop-less Flink filesystems.
* [FLIP-598](https://cwiki.apache.org/confluence/spaces/FLINK/pages/435028237/FLIP-598+Filesystems+Gen2+Datalake+SDK+Native+FileSystem+for+Azure):[Filesystems] Gen2 Datalake SDK Native FileSystem for Azure

**Operations and connectors**

* [FLIP-571](https://cwiki.apache.org/confluence/spaces/FLINK/pages/406623287/FLIP-571+Support+Dynamically+Updating+Checkpoint+Configuration+at+Runtime+via+REST+API): Support Dynamically Updating Checkpoint Configuration at Runtime via REST API
* [FLIP-573](https://cwiki.apache.org/confluence/spaces/FLINK/pages/421954004/FLIP-573+Kafka+Share+Groups+for+Queue-Like+Event+Processing+in+Flink+Connector+Kafka): Kafka Share Groups for Queue-Like Event Processing in Flink Connector Kafka
* [FLIP-599](https://cwiki.apache.org/confluence/spaces/FLINK/pages/438009922/FLIP-599+State+Catalog): State Catalog.
* [FLIP-582](https://cwiki.apache.org/confluence/spaces/FLINK/pages/430407883/FLIP-582+Support+RpcOperator+Service): Support RpcOperator Service

## Staying up to date

If you have ideas for what you would like to see in these blogs or there
is anything you think has been misrepresented, is wrong or missing, please
let us know via the dev list (detail below) or [Slack](https://flink.apache.org/how-to-contribute/getting-help/#slack)

There are many ways to remain up to date with the Apache Flink community,
including:

* Following this blog by subscribing to its [RSS feed](https://flink.apache.org/posts/index.xml)
* Subscribing to a Flink community mailing list, a couple of popular ones to highlight:
    * the [dev list](https://lists.apache.org/list.html?dev@flink.apache.org) for development related discussions
    * the [user list](https://lists.apache.org/list.html?user@flink.apache.org) for user support and questions.
* Joining the [Apache Flink Slack group](https://flink.apache.org/how-to-contribute/getting-help/#slack)
* Accessing a full comprehensive list of the [Flink community resources including meetups, repositories and more](https://flink.apache.org/what-is-flink/community/#community--project-info)
