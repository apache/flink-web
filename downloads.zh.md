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

---

{% endfor %}

Apache Flink® Stateful Functions {{ site.FLINK_STATEFUN_VERSION_STABLE }} 是 [Stateful Functions](https://flink.apache.org/stateful-functions.html) 组件的最新稳定版本.

{% for flink_statefun_release in site.flink_statefun_releases %}

## {{ flink_statefun_release.source_release.name }}

<p>
<a href="{{ flink_statefun_release.source_release.url }}" class="ga-track" id="{{ flink_statefun_release.source_release.id }}">{{ flink_statefun_release.source_release.name }} Source Release</a>
(<a href="{{ flink_statefun_release.source_release.asc_url }}">asc</a>, <a href="{{ flink_statefun_release.source_release.sha512_url }}">sha512</a>)
</p>

这个版本和 Apache Flink 版本 {{ flink_statefun_release.source_release.flink_version }} 兼容。

---

{% endfor %}

Apache Flink® ML {{ site.FLINK_ML_VERSION_STABLE }} 是机器学习库的最新稳定版本。

{% for flink_ml_release in site.flink_ml_releases %}

## {{ flink_ml_release.source_release.name }}

<p>
<a href="{{ flink_ml_release.source_release.url }}" class="ga-track" id="{{ flink_ml_release.source_release.id }}">{{ flink_ml_release.source_release.name }} Source Release</a>
(<a href="{{ flink_ml_release.source_release.asc_url }}">asc</a>, <a href="{{ flink_ml_release.source_release.sha512_url }}">sha512</a>)
</p>

这个版本和 Apache Flink 版本 {{ flink_ml_release.source_release.flink_version }} 兼容。

---

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

### Apache Flink

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

### Apache Flink Stateful Functions

用户可以在 `pom.xml` 中包含以下依赖来在项目中使用 Apache Flink Stateful Function。

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>statefun-sdk</artifactId>
  <version>{{ site.FLINK_STATEFUN_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>statefun-flink-harness</artifactId>
  <version>{{ site.FLINK_STATEFUN_VERSION_STABLE }}</version>
</dependency>
```

The `statefun-sdk` dependency is the only one you will need to start developing applications.
The `statefun-flink-harness` dependency includes a local execution environment that allows you to locally test your application in an IDE.

本地开发程序仅需要依赖 `statefun-sdk`。`statefun-flink-harness` 提供了在 IDE 中测试用户开发的程序的本地执行环境。


### Apache Flink ML

用户需要在 `pom.xml` 中添加如下依赖来使在项目中使用 Apache Flink ML。

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-core_2.12</artifactId>
  <version>{{ site.FLINK_ML_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-iteration_2.12</artifactId>
  <version>{{ site.FLINK_ML_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-lib_2.12</artifactId>
  <version>{{ site.FLINK_ML_VERSION_STABLE }}</version>
</dependency>
```

高级用户可以根据使用场景来只包含最小集合的依赖：

- 依赖组件 `flink-ml-core_2.12` 来开发不使用迭代的自定义机器学习算法。
- 依赖组件 `flink-ml-core_2.12` 与 `flink-ml-iteration_2.12` 来开发使用迭代的自定义机器学习算法。
- 依赖组件 `flink-ml-lib_2.12` 来使用 Flink ML 提供的机器学习算法。

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

### Flink-ML
{% assign flink_ml_releases = site.release_archive.flink_ml %}
<ul>
{% for flink_ml_release in flink_ml_releases %}
<li>
Flink ML {{ flink_ml_release.version_long }} - {{ flink_ml_release.release_date }}
(<a href="https://archive.apache.org/dist/flink/flink-ml-{{ flink_ml_release.version_long }}/flink-ml-{{ flink_ml_release.version_long }}-src.tgz">Source</a>)
</li>
{% endfor %}
</ul>
