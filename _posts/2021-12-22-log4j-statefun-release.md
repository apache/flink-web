---
layout: post
title:  "Apache Flink StateFun Log4j emergency release"
date:   2021-12-22 00:00:00
categories: news
authors:
- igal:
  name: "Igal Shilman"
- seth:
  name: "Seth Wiesman"

---

The Apache Flink community has released an emergency bugfix version of Apache Flink Stateful Function 3.1.1.

This release include a version upgrade of Apache Flink to 1.13.5, for log4j to address [CVE-2021-44228](https://nvd.nist.gov/vuln/detail/CVE-2021-44228) and [CVE-2021-45046](https://nvd.nist.gov/vuln/detail/CVE-2021-45046).

We highly recommend all users to upgrade to the latest patch release.

You can find the source and binaries on the updated [Downloads page]({{ site.baseurl }}/downloads.html), and Docker images in the [apache/flink-statefun](https://hub.docker.com/r/apache/flink-statefun) dockerhub repository.
