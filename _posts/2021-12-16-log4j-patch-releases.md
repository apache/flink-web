---
layout: post
title:  "Apache Flink Log4j emergency releases"
date:   2021-12-16 00:00:00
categories: news
authors:
- chesnay:
  name: "Chesnay Schepler"

---

The Apache Flink community has released emergency bugfix versions of Apache Flink for the 1.11, 1.12, 1.13 and 1.14 series.

These releases include a version upgrade for Log4j to address [CVE-2021-44228](https://nvd.nist.gov/vuln/detail/CVE-2021-44228).

We highly recommend all users to upgrade to the respective patch release.

Updated Maven dependencies:

1.14:

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>1.14.2</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-streaming-java_2.11</artifactId>
  <version>1.14.2</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients_2.11</artifactId>
  <version>1.14.2</version>
</dependency>
```

1.13:

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>1.13.5</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-streaming-java_2.11</artifactId>
  <version>1.13.5</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients_2.11</artifactId>
  <version>1.13.5</version>
</dependency>
```

1.12:

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>1.12.7</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-streaming-java_2.11</artifactId>
  <version>1.12.7</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients_2.11</artifactId>
  <version>1.12.7</version>
</dependency>
```

1.11:

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>1.11.6</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-streaming-java_2.11</artifactId>
  <version>1.11.6</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients_2.11</artifactId>
  <version>1.11.6</version>
</dependency>
```

You can find the binaries on the updated [Downloads page]({{ site.baseurl }}/downloads.html).
