---
title: "下载"
---

<hr />

<script type="text/javascript">
$( document ).ready(function() {
  // Handler for .ready() called.
  $('.ga-track').click( function () {
    console.log("tracking " + $(this).attr('id'))
    // we just use the element id for tracking with google analytics
    ga('send', 'event', 'button', 'click', $(this).attr('id'));
  });

});
</script>

{% toc %}

Apache Flink® {{ site.FLINK_VERSION_STABLE }} 是我们最新的稳定版本。

如果你计划将 Apache Flink 与 Apache Hadoop 一起使用（在 YARN 上运行 Flink ，连接到 HDFS ，连接到 HBase ，或使用一些基于
Hadoop 文件系统的 connector ），请查看 [Hadoop 集成]({{ site.DOCS_BASE_URL }}flink-docs-release-{{ site.FLINK_VERSION_STABLE_SHORT }}/zh/ops/deployment/hadoop.html)文档。

{% for flink_release in site.flink_releases %}

## {{ flink_release.binary_release.name }}

{% if flink_release.binary_release.scala_211 %}

<p>
<a href="{{ flink_release.binary_release.scala_211.url }}" class="ga-track" id="{{
 flink_release.binary_release.scala_211.id }}">{{ flink_release.binary_release.name }} for Scala 2.11</a> (<a href="
 {{ flink_release.binary_release.scala_211.asc_url }}">asc</a>, <a href="{{
 flink_release.binary_release.scala_211.sha512_url }}">sha512</a>)
</p>

{% endif %}

{% if flink_release.binary_release.scala_212 %}

<p>
<a href="{{ flink_release.binary_release.scala_212.url }}" class="ga-track" id="{{
 flink_release.binary_release.scala_212.id }}">{{ flink_release.binary_release.name }} for Scala 2.12</a> (<a href="
 {{ flink_release.binary_release.scala_212.asc_url }}">asc</a>, <a href="{{
 flink_release.binary_release.scala_212.sha512_url }}">sha512</a>)
</p>

{% endif %}

{% if flink_release.source_release %}
<p>
<a href="{{ flink_release.source_release.url }}" class="ga-track" id="{{
 flink_release.source_release.id }}">{{ flink_release.source_release.name }} Source Release</a>
 (<a href="{{ flink_release.source_release.asc_url }}">asc</a>, <a href="{{
 flink_release.source_release.sha512_url }}">sha512</a>)
</p>
{% endif %}

{% if flink_release.optional_components or flink_release.sql_components_url %}
#### 可选组件
{% endif %}

{% if flink_release.optional_components %}
{% assign components = flink_release.optional_components | | sort: 'name' %}
{% for component in components %}

{% if component.scala_dependent %}

{% if component.scala_211 %}
<p>
<a href="{{ component.scala_211.url }}" class="ga-track" id="{{
 component.scala_211.id }}">{{ component.name }} for Scala 2.11</a> (<a href="{{
 component.scala_211.asc_url }}">asc</a>, <a href="{{ component.scala_211.sha_url }}">sha1</a>)
</p>
{% endif %}

{% if component.scala_212 %}
<p>
<a href="{{ component.scala_212.url }}" class="ga-track" id="{{
 component.scala_212.id }}">{{ component.name }} for Scala 2.12</a> (<a href="{{
 component.scala_212.asc_url }}">asc</a>, <a href="{{ component.scala_212.sha_url }}">sha1</a>)
</p>
{% endif %}

{% else %}
<p>
<a href="{{ component.url }}" class="ga-track" id="{{
 component.id }}">{{ component.name }}</a> (<a href="{{ component.asc_url }}">asc</a>, <a href="{{ component.sha_url }}">sha1</a>)
</p>
{% endif %}

{% endfor %}

{% endif %}

{% if flink_release.sql_components_url != nil %}
<p>
<a href="{{ flink_release.sql_components_url }}" class="ga-track">SQL 组件下载页面</a>
</p>
{% endif %}

{% if flink_release.alternative_binaries %}
#### 其他替代执行包

{% assign alternatives = flink_release.alternative_binaries | | sort: 'name' %}
{% for alternative in alternatives %}

{% if alternative.scala_211 %}

<p>
<a href="{{ alternative.scala_211.url }}" class="ga-track" id="{{
 alternative.scala_211.id }}">{{ alternative.name }} for Scala 2.11</a> (<a href="{{
 alternative.scala_211.asc_url }}">asc</a>, <a href="{{ alternative.scala_211.sha_url }}">sha512</a>)
</p>

{% endif %}

{% if alternative.scala_212 %}

<p>
<a href="{{ alternative.scala_212.url }}" class="ga-track" id="{{
 alternative.scala_212.id }}">{{ alternative.name }} for Scala 2.12</a> (<a href="{{
 alternative.scala_212.asc_url }}">asc</a>, <a href="{{ alternative.scala_212.sha_url }}">sha512</a>)
</p>

{% endif %}

{% endfor %}

{% endif %}

#### 发布说明

如果你计划从以前的版本升级 Flink，请查看 [Flink {{ flink_release.version_short }} 的发布说明]({{ site.DOCS_BASE_URL }}
flink-docs-release-{{ flink_release.version_short }}/release-notes/flink-{{ flink_release.version_short }}.html)。

{% endfor %}

## 额外组件

其他不包含在 Flink 的主要发布的组件如下所示：

{% for additional_component in site.component_releases %}

<p>
<a href="{{ additional_component.url }}" class="ga-track" id="{{ additional_component.id }}">{{ additional_component.name }}</a>
(<a href="{{ additional_component.asc_url }}">asc</a>, <a href="{{ additional_component.sha512_url }}">sha512</a>)
</p>

{% endfor %}

## 验证哈希和签名

随着每次版本发布，我们还提供了包含 sha512 哈希的 `*.sha512` 文件和包含加密签名的 `*.asc` 文件。Apache 软件基金会有一个通用的[教程来验证哈希和签名](http://www.apache.org/info/verification.html)，你可以使用这些版本签名的 [KEYS](https://downloads.apache.org/flink/KEYS) 来校验它们。

## Maven 依赖

你只要将以下依赖项添加到 `pom.xml` 中，就能在项目中引入 Apache Flink 。这些依赖项包含了本地执行环境，因此支持本地测试。

- **Scala API**: 为了使用 Scala API，将 `flink-java` 的 artifact id 替换为 `flink-scala_2.11`，同时将 `flink-streaming-java_2.11` 替换为 `flink-streaming-scala_2.11`。

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-streaming-java_2.11</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients_2.11</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
```

## 旧版本的更新策略
截至2017年3月，Flink 社区[决定](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Time-based-releases-in-Flink-tp15386p15394.html)使用 bugfix 来支持当前和之前的次要版本。如果 1.2.x 是当前的正式版本，则 1.1.y 是之前的次要支持版本。这两个版本都将收到关键问题的  bugfix。

请注意，社区始终愿意讨论旧版本的 bugfix 版本。请在 dev@flink.apache.org 邮件列表中与开发人员联系。

## 所有稳定版本
所有的 Flink 版本均可通过 [https://archive.apache.org/dist/flink/](https://archive.apache.org/dist/flink/) 获得，包括校验和加密签名。在撰写本文时，这包括以下版本：

### Flink
{% assign flink_releases = site.release_archive.flink %}
<ul>
{% for flink_release in flink_releases %}
<li>
{% if flink_release.version_short %}
Flink {{ flink_release.version_long }} - {{ flink_release.release_date }}
(<a href="https://archive.apache.org/dist/flink/flink-{{ flink_release.version_long }}/flink-{{ flink_release.version_long }}-src.tgz">Source</a>,
<a href="https://archive.apache.org/dist/flink/flink-{{ flink_release.version_long }}">Binaries</a>,
<a href="{{ site.DOCS_BASE_URL }}flink-docs-release-{{ flink_release.version_short }}">Docs</a>,
<a href="{{ site.DOCS_BASE_URL }}flink-docs-release-{{ flink_release.version_short }}/api/java">Javadocs</a>,
<a href="{{ site.DOCS_BASE_URL }}flink-docs-release-{{ flink_release.version_short }}/api/scala/index.html">Scaladocs</a>)
{% else %}
Flink {{ flink_release.version_long }} - {{ flink_release.release_date }}
(<a href="https://archive.apache.org/dist/flink/flink-{{ flink_release.version_long }}/flink-{{ flink_release.version_long }}-src.tgz">Source</a>,
<a href="https://archive.apache.org/dist/flink/flink-{{ flink_release.version_long }}">Binaries</a>)
{% endif %}
</li>
{% endfor %}
</ul>

### Flink-shaded
{% assign shaded_releases = site.release_archive.flink_shaded | sort: 'release_date' | reverse %}
<ul>
{% for shaded_release in shaded_releases %}
<li>Flink-shaded {{ shaded_release.version }} - {{ shaded_release.release_date }} (<a href="https://archive.apache.org/dist/flink/flink-shaded-{{ shaded_release.version }}/flink-shaded-{{ shaded_release.version }}-src.tgz">Source</a>)</li>
{% endfor %}
</ul>
