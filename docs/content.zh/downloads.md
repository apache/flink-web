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

Apache Flink® {{< param FlinkStableVersion >}} 是我们最新的稳定版本。

{{% flink_download "flink" %}}

## Apache Flink connectors

These are connectors that are released separately from the main Flink releases.

{{% flink_download "flink_connectors" %}}

## Apache Flink Stateful Functions

Apache Flink® Stateful Functions {{< param StateFunStableShortVersion >}} 是我们最新的稳定版本。

{{% flink_download "statefun" %}}

## Apache Flink ML

Apache Flink® ML {{< param FlinkMLStableShortVersion >}} 是我们最新的稳定版本。 

{{% flink_download "flink_ml" %}}

## Apache Flink Kubernetes Operator

Apache Flink® Kubernetes Operator {{< param FlinkKubernetesOperatorStableShortVersion >}} 是我们最新的稳定版本。

{{% flink_download "flink_kubernetes_operator" %}}

## Apache Flink Table Store (currently Apache Paimon(incubating))

Apache Flink® Table Store {{< param FlinkTableStoreStableShortVersion >}} 是其作为Flink子项目时，最后的发布版本。目前其已经成为[Apache Paimon(incubating)](https://paimon.apache.org/)项目。

{{% flink_download "flink_table_store" %}}

## 额外组件

其他不包含在 Flink 的主要发布的组件如下所示：

{{% flink_download "additional_components" %}}

## 验证哈希和签名

随着每次版本发布，我们还提供了包含 sha512 哈希的 `*.sha512` 文件和包含加密签名的 `*.asc` 文件。Apache 软件基金会有一个通用的[教程来验证哈希和签名](http://www.apache.org/info/verification.html)，你可以使用这些版本签名的 [KEYS](https://downloads.apache.org/flink/KEYS) 来校验它们。

## Maven 依赖

### Apache Flink

你只要将以下依赖项添加到  `pom.xml` 中，就能在项目中引入 Apache Flink 。这些依赖项包含了本地执行环境，因此支持本地测试。

- **Scala API**: 为了使用 Scala API，将 `flink-java` 的 artifact id 替换为 `flink-scala_2.12` ，同时将 `flink-streaming-java`  替换为 `flink-streaming-scala_2.12`。

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

用户可以在 `pom.xml` 中包含以下依赖来在项目中使用 Apache Flink Stateful Functions。

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

本地开发程序仅需要依赖 `statefun-sdk`。`statefun-flink-harness`  提供了在 IDE 中测试用户开发的程序的本地执行环境。

### Apache Flink ML

用户需要在 `pom.xml` 中添加如下依赖来使在项目中使用 Apache Flink ML。

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

高级用户可以根据使用场景来只包含最小集合的依赖：

- 依赖组件 `flink-ml-core` 来开发不使用迭代的自定义机器学习算法。
- 依赖组件 `flink-ml-core` 与 `flink-ml-iteration` 来开发使用迭代的自定义机器学习算法。
- 依赖组件 `flink-ml-lib` 来使用 Flink ML 提供的机器学习算法。

### Apache Flink Kubernetes Operator

You can add the following dependencies to your `pom.xml` to include Apache Flink Kubernetes Operator in your project.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-kubernetes-operator</artifactId>
  <version>{{< param FlinkKubernetesOperatorStableVersion >}}</version>
</dependency>
```

## 旧版本的更新策略

截至2017年3月，Flink 社区[决定](https://lists.apache.org/thread/qf4hot3gb1dgvh4csxv2317263b6omm4)使用 bugfix 来支持当前和之前的次要版本。如果 1.2.x 是当前的正式版本，则 1.1.y 是之前的次要支持版本。这两个版本都将收到关键问题的 bugfix。

As of March 2023, the Flink community [decided](https://lists.apache.org/thread/9w99mgx3nw5tc0v26wcvlyqxrcrkpzdz) that upon release of a new Flink minor version, the community will perform one final bugfix release for resolved critical/blocker issues in the Flink minor version losing support. If 1.16.1 is the current release and 1.15.4 is the latest previous patch version, once 1.17.0 is released we will create a 1.15.5 to flush out any resolved critical/blocker issues. 

请注意，社区始终愿意讨论旧版本的 bugfix 版本。请在 dev@flink.apache.org 邮件列表中与开发人员联系。

## 所有稳定版本

所有的 Flink 版本均可通过 [https://archive.apache.org/dist/flink/](https://archive.apache.org/dist/flink/) 获得，包括校验和加密签名。在撰写本文时，这包括以下版本：

{{% flink_archive "release_archive" %}}