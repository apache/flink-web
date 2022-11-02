---
title: "Downloads"
---

<hr />

{% toc %}

Apache Flink® {{ site.FLINK_VERSION_STABLE }} is our latest stable release.

{% for flink_release in site.flink_releases %}

## {{ flink_release.binary_release.name }}

{% if flink_release.binary_release.scala_211 %}

<p>
<a href="{{ flink_release.binary_release.scala_211.url }}" id="{{ flink_release.binary_release.scala_211.id }}">{{ flink_release.binary_release.name }} for Scala 2.11</a> (<a href="{{ flink_release.binary_release.scala_211.asc_url }}">asc</a>, <a href="{{ flink_release.binary_release.scala_211.sha512_url }}">sha512</a>)
</p>

{% endif %}

{% if flink_release.binary_release.scala_212 %}

<p>
<a href="{{ flink_release.binary_release.scala_212.url }}" id="{{ flink_release.binary_release.scala_212.id }}">{{ flink_release.binary_release.name }} for Scala 2.12</a> (<a href="{{ flink_release.binary_release.scala_212.asc_url }}">asc</a>, <a href="{{ flink_release.binary_release.scala_212.sha512_url }}">sha512</a>)
</p>

{% endif %}

{% if flink_release.source_release %}
<p>
<a href="{{ flink_release.source_release.url }}" id="{{ flink_release.source_release.id }}">{{ flink_release.source_release.name }} Source Release</a>
(<a href="{{ flink_release.source_release.asc_url }}">asc</a>, <a href="{{ flink_release.source_release.sha512_url }}">sha512</a>)
</p>
{% endif %}

{% if flink_release.optional_components or flink_release.sql_components_url %}
#### Optional components
{% endif %}

{% if flink_release.optional_components %}
{% assign components = flink_release.optional_components | | sort: 'name' %}
{% for component in components %}

{% if component.scala_dependent %}

{% if component.scala_211 %}
<p>
<a href="{{ component.scala_211.url }}" id="{{ component.scala_211.id }}">{{ component.name }} for Scala 2.11</a> (<a href="{{ component.scala_211.asc_url }}">asc</a>, <a href="{{ component.scala_211.sha_url }}">sha1</a>)
</p>
{% endif %}

{% if component.scala_212 %}
<p>
<a href="{{ component.scala_212.url }}" id="{{ component.scala_212.id }}">{{ component.name }} for Scala 2.12</a> (<a href="{{ component.scala_212.asc_url }}">asc</a>, <a href="{{ component.scala_212.sha_url }}">sha1</a>)
</p>
{% endif %}

{% else %}
<p>
<a href="{{ component.url }}" id="{{ component.id }}">{{ component.name }}</a> (<a href="{{ component.asc_url }}">asc</a>, <a href="{{ component.sha_url }}">sha1</a>)
</p>
{% endif %}

{% endfor %}

{% endif %}

{% if flink_release.sql_components_url != nil %}
<p>
<a href="{{ flink_release.sql_components_url }}" class="ga-track">SQL components download page</a>
</p>
{% endif %}

{% if flink_release.alternative_binaries %}
#### Alternative Binaries

{% assign alternatives = flink_release.alternative_binaries | | sort: 'name' %}
{% for alternative in alternatives %}

{% if alternative.scala_211 %}

<p>
<a href="{{ alternative.scala_211.url }}" id="{{ alternative.scala_211.id }}">{{ alternative.name }} for Scala 2.11</a> (<a href="{{ alternative.scala_211.asc_url }}">asc</a>, <a href="{{ alternative.scala_211.sha_url }}">sha512</a>)
</p>

{% endif %}

{% if alternative.scala_212 %}

<p>
<a href="{{ alternative.scala_212.url }}" id="{{ alternative.scala_212.id }}">{{ alternative.name }} for Scala 2.12</a> (<a href="{{ alternative.scala_212.asc_url }}">asc</a>, <a href="{{ alternative.scala_212.sha_url }}">sha512</a>)
</p>

{% endif %}

{% endfor %}

{% endif %}

#### Release Notes

Please have a look at the [Release Notes for Flink {{ flink_release.version_short }}]({{ flink_release.release_notes_url }}) if you plan to upgrade your Flink setup from a previous version.

---

{% endfor %}

## Flink connectors

These connectors that are released separately from the main Flink releases.

{% for release in site.connector_releases %}

### {{ release.source_release.name }}

<p>
<a href="{{ release.source_release.url }}" id="{{ release.source_release.id }}">{{ release.source_release.name }} Source Release</a>
(<a href="{{ release.source_release.asc_url }}">asc</a>, <a href="{{ release.source_release.sha512_url }}">sha512</a>)
</p>
 
This connector is compatible with these Apache Flink versions:
{% for flink_version in release.source_release.flink_versions %}
* {{ flink_version }}.x
{% endfor %}

{% endfor %}

---

Apache Flink® Stateful Functions {{ site.FLINK_STATEFUN_VERSION_STABLE }} is the latest stable release for the [Stateful Functions](https://flink.apache.org/stateful-functions.html) component.

{% for flink_statefun_release in site.flink_statefun_releases %}

## {{ flink_statefun_release.source_release.name }}

<p>
<a href="{{ flink_statefun_release.source_release.url }}" id="{{ flink_statefun_release.source_release.id }}">{{ flink_statefun_release.source_release.name }} Source Release</a>
(<a href="{{ flink_statefun_release.source_release.asc_url }}">asc</a>, <a href="{{ flink_statefun_release.source_release.sha512_url }}">sha512</a>)
</p>

This version is compatible with Apache Flink version {{ flink_statefun_release.source_release.flink_version }}.

---

{% endfor %}

Apache Flink® ML {{ site.FLINK_ML_VERSION_STABLE }} is the latest stable release for machine learning.

{% for flink_ml_release in site.flink_ml_releases %}

## {{ flink_ml_release.source_release.name }}

<p>
<a href="{{ flink_ml_release.source_release.url }}" id="{{ flink_ml_release.source_release.id }}">{{ flink_ml_release.source_release.name }} Source Release</a>
(<a href="{{ flink_ml_release.source_release.asc_url }}">asc</a>, <a href="{{ flink_ml_release.source_release.sha512_url }}">sha512</a>)
</p>

This version is compatible with Apache Flink version {{ flink_ml_release.source_release.flink_version }}.

---

{% endfor %}

Apache Flink® Kubernetes Operator {{ site.FLINK_KUBERNETES_OPERATOR_VERSION_STABLE }} is the latest stable release for the [Flink Kubernetes Operator](https://github.com/apache/flink-kubernetes-operator).

{% for flink_kubernetes_operator_release in site.flink_kubernetes_operator_releases %}

## {{ flink_kubernetes_operator_release.source_release.name }}

<p>
<a href="{{ flink_kubernetes_operator_release.source_release.url }}" id="{{ flink_kubernetes_operator_release.source_release.id }}">{{ flink_kubernetes_operator_release.source_release.name }} Source Release</a>
(<a href="{{ flink_kubernetes_operator_release.source_release.asc_url }}">asc</a>, <a href="{{ flink_kubernetes_operator_release.source_release.sha512_url }}">sha512</a>)
</p>
<p>
<a href="{{ flink_kubernetes_operator_release.helm_release.url }}" id="{{ flink_kubernetes_operator_release.helm_release.id }}">{{ flink_kubernetes_operator_release.helm_release.name }} Helm Chart Release</a>
(<a href="{{ flink_kubernetes_operator_release.helm_release.asc_url }}">asc</a>, <a href="{{ flink_kubernetes_operator_release.helm_release.sha512_url }}">sha512</a>)
</p>

This version is compatible with Apache Flink version {{ flink_kubernetes_operator_release.source_release.flink_version }}.

---

{% endfor %}

Apache Flink® Table Store {{ site.FLINK_TABLE_STORE_VERSION_STABLE }} is the latest stable release for the [Flink Table Store](https://github.com/apache/flink-table-store).

{% for flink_table_store_release in site.flink_table_store_releases %}

## {{ flink_table_store_release.source_release.name }}

<p>
<a href="{{ flink_table_store_release.source_release.url }}" id="{{ flink_table_store_release.source_release.id }}">{{ flink_table_store_release.source_release.name }} Source Release</a>
(<a href="{{ flink_table_store_release.source_release.asc_url }}">asc</a>, <a href="{{ flink_table_store_release.source_release.sha512_url }}">sha512</a>)
</p>
<p>
<a href="{{ flink_table_store_release.binaries_release.url }}" id="{{ flink_table_store_release.binaries_release.id }}">{{ flink_table_store_release.binaries_release.name }} Binaries Release</a>
(<a href="{{ flink_table_store_release.binaries_release.asc_url }}">asc</a>, <a href="{{ flink_table_store_release.binaries_release.sha512_url }}">sha512</a>)
</p>

This version is compatible with Apache Flink version {{ flink_table_store_release.source_release.flink_version }}.

---

{% endfor %}

## Additional Components

These are components that the Flink project develops which are not part of the
main Flink release:

{% for additional_component in site.component_releases %}

<p>
<a href="{{ additional_component.url }}" id="{{ additional_component.id }}">{{ additional_component.name }}</a>
(<a href="{{ additional_component.asc_url }}">asc</a>, {% if additional_component.sha512_url %}<a href="{{ additional_component.sha512_url }}">sha512</a> {% else %} <a href="{{ additional_component.sha_url }}">sha1</a>{% endif %})
</p>

{% endfor %}

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
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-streaming-java</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
```

### Apache Flink Stateful Functions

You can add the following dependencies to your `pom.xml` to include Apache Flink Stateful Functions in your project.

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

### Apache Flink ML

You can add the following dependencies to your `pom.xml` to include Apache Flink ML in your project.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-core</artifactId>
  <version>{{ site.FLINK_ML_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-iteration</artifactId>
  <version>{{ site.FLINK_ML_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-ml-lib</artifactId>
  <version>{{ site.FLINK_ML_VERSION_STABLE }}</version>
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
  <version>{{ site.FLINK_KUBERNETES_OPERATOR_VERSION_STABLE }}</version>
</dependency>
```

## Update Policy for old releases

As of March 2017, the Flink community [decided](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Time-based-releases-in-Flink-tp15386p15394.html) to support the current and previous minor release with bugfixes. If 1.2.x is the current release, 1.1.y is the previous minor supported release. Both versions will receive bugfixes for critical issues.

Note that the community is always open to discussing bugfix releases for even older versions. Please get in touch with the developers for that on the dev@flink.apache.org mailing list.


## All stable releases

All Flink releases are available via [https://archive.apache.org/dist/flink/](https://archive.apache.org/dist/flink/) including checksums and cryptographic signatures. At the time of writing, this includes the following versions:

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

### Flink Connectors

These connectors that are released separately from the main Flink releases.

<ul>
{% for release in site.release_archive.connectors %}
<li>
{{ release.name }} {{ release.version }} - {{ release.release_date }}
(<a href="https://archive.apache.org/dist/flink/flink-connector-${{connector}}-{{ release.version }}/flink-connector-${{connector}}-{{ release.version }}-src.tgz">Source</a>)
</li>
{% endfor %}
</ul>

### Flink-StateFun
{% assign flink_statefun_releases = site.release_archive.flink_statefun %}
<ul>
{% for flink_statefun_release in flink_statefun_releases %}
<li>
Flink Stateful Functions {{ flink_statefun_release.version_long }} - {{ flink_statefun_release.release_date }}
(<a href="https://archive.apache.org/dist/flink/flink-statefun-{{ flink_statefun_release.version_long }}/flink-statefun-{{ flink_statefun_release.version_long }}-src.tgz">Source</a>,
<a href="{{ site.DOCS_BASE_URL }}flink-statefun-docs-release-{{ flink_statefun_release.version_short }}">Docs</a>,
<a href="{{ site.DOCS_BASE_URL }}flink-statefun-docs-release-{{ flink_statefun_release.version_short }}/api/java">Javadocs</a>)
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

### Flink-Kubernetes-Operator
{% assign flink_kubernetes_operator_releases = site.release_archive.flink_kubernetes_operator %}
<ul>
{% for flink_kubernetes_operator_release in flink_kubernetes_operator_releases %}
<li>
Flink Kubernetes Operator {{ flink_kubernetes_operator_release.version_long }} - {{ flink_kubernetes_operator_release.release_date }}
(<a href="https://archive.apache.org/dist/flink/flink-kubernetes-operator-{{ flink_kubernetes_operator_release.version_long }}/flink-kubernetes-operator-{{ flink_kubernetes_operator_release.version_long }}-src.tgz">Source</a>, <a href="https://archive.apache.org/dist/flink/flink-kubernetes-operator-{{ flink_kubernetes_operator_release.version_long }}/flink-kubernetes-operator-{{ flink_kubernetes_operator_release.version_long }}-helm.tgz">Helm Chart</a>)
</li>
{% endfor %}
</ul>

### Flink-Table-Store
{% assign flink_table_store_releases = site.release_archive.flink_table_store %}
<ul>
{% for flink_table_store_release in flink_table_store_releases %}
<li>
Flink Table Store {{ flink_table_store_release.version_long }} - {{ flink_table_store_release.release_date }}
(<a href="https://archive.apache.org/dist/flink/flink-table-store-{{ flink_table_store_release.version_long }}/flink-table-store-{{ flink_table_store_release.version_long }}-src.tgz">Source</a>, <a href="https://repo.maven.apache.org/maven2/org/apache/flink/flink-table-store-dist/{{ flink_table_store_release.version_long }}/flink-table-store-dist-{{ flink_table_store_release.version_long }}.jar">Binaries</a>)
</li>
{% endfor %}
</ul>
