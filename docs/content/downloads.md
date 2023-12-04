---
title: Downloads
bookCollapseSection: false
weight: 5
menu_weight: 2
---
<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

# Apache Flink® Downloads

## Apache Flink

Apache Flink® {{< param FlinkStableVersion >}} is the latest stable release.

{{% flink_download "flink" %}}

## Apache Flink connectors

These are connectors that are released separately from the main Flink releases.

{{% flink_download "flink_connectors" %}}

## Apache Flink Stateful Functions

Apache Flink® Stateful Functions {{< param StateFunStableShortVersion >}} is the latest stable release.

{{% flink_download "statefun" %}}

## Apache Flink ML

Apache Flink® ML {{< param FlinkMLStableShortVersion >}} is the latest stable release. 

{{% flink_download "flink_ml" %}}

## Apache Flink Kubernetes Operator

Apache Flink® Kubernetes Operator {{< param FlinkKubernetesOperatorStableShortVersion >}} is the latest stable release.

{{% flink_download "flink_kubernetes_operator" %}}

## Apache Flink Table Store (currently Apache Paimon(incubating))

Apache Flink® Table Store {{< param FlinkTableStoreStableShortVersion >}}  is the last release when it's still a sub-project of Flink, it has joined as [Apache Paimon(incubating)](https://paimon.apache.org/) currently.

Please refer to [Paimon-downloads](https://paimon.apache.org/docs/master/project/download/) to get the latest jars.

## Additional Components

These are components that the Flink project develops which are not part of the main Flink release:

{{% flink_download "additional_components" %}}

## Verifying Hashes and Signatures

Along with our releases, we also provide sha512 hashes in `*.sha512` files and cryptographic signatures in `*.asc` files. The Apache Software Foundation has an extensive [tutorial to verify hashes and signatures](http://www.apache.org/info/verification.html) which you can follow by using any of these release-signing [KEYS](https://downloads.apache.org/flink/KEYS).

## Maven Dependencies

### Apache Flink

You can add the following dependencies to your `pom.xml` to include Apache Flink in your project. These dependencies include a local execution environment and thus support local testing.

- **Scala API**: To use the Scala API, replace the `flink-java` artifact id with `flink-scala_2.12` and `flink-streaming-java` with `flink-streaming-scala_2.12`.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>{{< param FlinkStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-streaming-java</artifactId>
  <version>{{< param FlinkStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients</artifactId>
  <version>{{< param FlinkStableVersion >}}</version>
</dependency>
```

### Apache Flink Stateful Functions

You can add the following dependencies to your `pom.xml` to include Apache Flink Stateful Functions in your project.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>statefun-sdk</artifactId>
  <version>{{< param StateFunStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>statefun-flink-harness</artifactId>
  <version>{{< param StateFunStableVersion >}}</version>
</dependency>
```

The `statefun-sdk` dependency is the only one you will need to start developing applications.
The `statefun-flink-harness` dependency includes a local execution environment that allows you to locally test your application in an IDE.

### Apache Flink ML

You can add the following dependencies to your `pom.xml` to include Apache Flink ML in your project.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-core</artifactId>
  <version>{{< param FlinkMLStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-iteration</artifactId>
  <version>{{< param FlinkMLStableVersion >}}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-lib</artifactId>
  <version>{{< param FlinkMLStableVersion >}}</version>
</dependency>
```

Advanced users could only import a minimal set of Flink ML dependencies for their target use-cases:

- Use artifact `flink-ml-core` in order to develop custom ML algorithms.
- Use artifacts `flink-ml-core` and `flink-ml-iteration` in order to develop custom ML algorithms which require iteration.
- Use artifact `flink-ml-lib` in order to use the off-the-shelf ML algorithms from Flink ML.

### Apache Flink Kubernetes Operator

You can add the following dependencies to your `pom.xml` to include Apache Flink Kubernetes Operator in your project.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-kubernetes-operator</artifactId>
  <version>{{< param FlinkKubernetesOperatorStableVersion >}}</version>
</dependency>
```

## Update Policy for old releases

As of March 2017, the Flink community [decided](https://lists.apache.org/thread/qf4hot3gb1dgvh4csxv2317263b6omm4) to support the current and previous minor release with bugfixes. If 1.2.x is the current release, 1.1.y is the previous minor supported release. Both versions will receive bugfixes for critical issues.

As of March 2023, the Flink community [decided](https://lists.apache.org/thread/9w99mgx3nw5tc0v26wcvlyqxrcrkpzdz) that upon release of a new Flink minor version, the community will perform one final bugfix release for resolved critical/blocker issues in the Flink minor version losing support. If 1.16.1 is the current release and 1.15.4 is the latest previous patch version, once 1.17.0 is released we will create a 1.15.5 to flush out any resolved critical/blocker issues. 

Note that the community is always open to discussing bugfix releases for even older versions. Please get in touch with the developers for that on the dev@flink.apache.org mailing list.

## All stable releases

All Flink releases are available via [https://archive.apache.org/dist/flink/](https://archive.apache.org/dist/flink/) including checksums and cryptographic signatures. At the time of writing, this includes the following versions:

{{% flink_archive "release_archive" %}}