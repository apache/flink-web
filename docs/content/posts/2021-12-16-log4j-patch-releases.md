---
authors:
- chesnay: null
  name: Chesnay Schepler
categories: news
date: "2021-12-16T00:00:00Z"
title: Apache Flink Log4j emergency releases
---

The Apache Flink community has released emergency bugfix versions of Apache Flink for the 1.11, 1.12, 1.13 and 1.14 series.

These releases only include a version upgrade for Log4j to address [CVE-2021-44228](https://nvd.nist.gov/vuln/detail/CVE-2021-44228) and [CVE-2021-45046](https://nvd.nist.gov/vuln/detail/CVE-2021-45046).

We highly recommend all users to upgrade to the respective patch release.

You can find the source and binaries on the updated [Downloads page]({{< siteurl >}}/downloads.html), and Docker images in the [apache/flink](https://hub.docker.com/r/apache/flink) dockerhub repository.

<div class="alert alert-info" markdown="1">
We are publishing this announcement earlier than usual to give users access to the updated source/binary releases as soon as possible.

As a result of that certain artifacts are not yet available:

* Maven artifacts are currently being synced to Maven central and will become available over the next 24 hours.
* The 1.11.6/1.12.7 Python binaries will be published at a later date.

This post will be continously updated to reflect the latest state.
</div>

<div class="alert alert-info" markdown="1">
The newly released versions are:

* 1.14.2
* 1.13.5
* 1.12.7
* 1.11.6

To clarify and avoid confusion: The 1.14.1 / 1.13.4 / 1.12.6 / 1.11.5 releases, which were supposed to only contain a Log4j upgrade to 2.15.0, were _skipped_ because [CVE-2021-45046](https://nvd.nist.gov/vuln/detail/CVE-2021-45046) was discovered during the release publication. Some artifacts were published to Maven Central, but no source/binary releases nor Docker images are available for those versions.
</div>

