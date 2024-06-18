---
title:  "Apache Flink CDC 3.1.1 Release Announcement"
date: "2024-06-18T08:00:00.000Z"
authors:
- renqs:
  name: "Qingsheng Ren"
  twitter: "renqstuite"
aliases:
- /news/2024/06/18/release-release-cdc-3.1.1.html
---
The Apache Flink Community is pleased to announce the first bug fix release of the Flink CDC 3.1 series.

The release contains fixes for several critical issues and improves compatibilities with Apache Flink. Below you will find a list of all bugfixes and improvements (excluding improvements to the build infrastructure and build stability). For a complete list of all changes see:
[JIRA](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12354763).

We highly recommend all users to upgrade to Flink CDC 3.1.1.

## Release Notes

### Bug
* [FLINK-34908] Mysql pipeline to doris and starrocks will lost precision for timestamp
* [FLINK-35149] Fix DataSinkTranslator#sinkTo ignoring pre-write topology if not TwoPhaseCommittingSink
* [FLINK-35294] Use source config to check if the filter should be applied in timestamp starting mode
* [FLINK-35301] Fix deadlock when loading driver classes
* [FLINK-35323] Only the schema of the first hit table is recorded when the source-table of the transformer hits multiple tables
* [FLINK-35415] CDC Fails to create sink with Flink 1.19
* [FLINK-35430] ZoneId is not passed to DebeziumJsonSerializationSchema
* [FLINK-35464] Flink CDC 3.1 breaks operator state compatiblity
* [FLINK-35540] flink-cdc-pipeline-connector-mysql lost table which database and table with the same name

### Documentation improvement
* [FLINK-35527] Polish quickstart guide & clean stale links in docs
* [FLINK-35545] Miss 3.1.0 version in snapshot flink-cdc doc version list

## Release Resources
The source artifacts and binaries are available on the [Downloads page]({{< relref "downloads" >}}) of the Flink website.

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-cdc-docs-release-3.1/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors
Hongshun Wang, Jiabao Sun, North Lin, Qingsheng Ren, Wink, Xin Gong, gongzhongqiang, joyCurry30, yux, yuxiqian
