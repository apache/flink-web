---
authors:
- martijnvisser: null
  name: Martijn Visser
  twitter: MartijnVisser82
date: "2023-09-19T08:00:00Z"
title: Stateful Functions 3.3.0 Release Announcement
---

The Apache Flink community is excited to announce the release of Stateful Functions 3.3.0! 

Stateful Functions is a cross-platform stack for building Stateful Serverless applications, making it radically simpler to develop scalable, consistent, and elastic distributed applications.
This new release upgrades the Flink runtime to 1.16.2.

The binary distribution and source artifacts are now available on the updated [Downloads]({{< relref "downloads" >}})
page of the Flink website, and the most recent Java SDK, Python SDK,, GoLang SDK and JavaScript SDK distributions are available on [Maven](https://search.maven.org/artifact/org.apache.flink/statefun-sdk-java/3.3.0/jar), [PyPI](https://pypi.org/project/apache-flink-statefun/), [Github](https://github.com/apache/flink-statefun/tree/statefun-sdk-go/v3.3.0), and [npm](https://www.npmjs.com/package/apache-flink-statefun) respectively.
You can also find official StateFun Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-statefun).

For more details, check the complete [release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12351276)
and the [updated documentation](https://nightlies.apache.org/flink/flink-statefun-docs-release-3.3/).
We encourage you to download the release and share your feedback with the community through the [Flink mailing lists]({{< relref "community" >}}#mailing-lists)
or [JIRA](https://issues.apache.org/jira/browse/FLINK)!

## New Features

### Upgraded Flink dependency to 1.16.2

Stateful Functions 3.3.0 runtime uses Flink 1.16.2 underneath.
This means that Stateful Functions benefits from the latest improvements and stabilisations that went into Flink.
For more information see [Flink's release announcement](https://flink.apache.org/2023/05/25/apache-flink-1.16.2-release-announcement/).

## Release Notes

Please review the [release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12350540)
for a detailed list of changes and new features if you plan to upgrade your setup to Stateful Functions 3.3.0.

## List of Contributors

Till Rohrmann, Mingmin Xu, Igal Shilman, Martijn Visser, Chesnay Schepler, SiddiqueAhmad, Galen Warren, Seth Wiesman, FilKarnicki, Tzu-Li (Gordon) Tai

If you’d like to get involved, we’re always [looking for new contributors](https://github.com/apache/flink-statefun#contributing).
