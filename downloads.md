---
title: "Downloads"
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

Apache Flink® {{ site.FLINK_VERSION_STABLE }} is our latest stable release.

If you plan to use Apache Flink together with Apache Hadoop (run Flink
on YARN, connect to HDFS, connect to HBase, or use some Hadoop-based
file system connector), please check out the [Hadoop Integration]({{ site.DOCS_BASE_URL }}flink-docs-release-{{ site.FLINK_VERSION_STABLE_SHORT }}/ops/deployment/hadoop.html) documentation.

{% for flink_release in site.flink_releases %}

## {{ flink_release.binary_release.name }}

{% if flink_release.binary_release.scala_211 %}

<p>
<a href="{{ flink_release.binary_release.scala_211.url }}" class="ga-track" id="{{ flink_release.binary_release.scala_211.id }}">{{ flink_release.binary_release.name }} for Scala 2.11</a> (<a href="{{ flink_release.binary_release.scala_211.asc_url }}">asc</a>, <a href="{{ flink_release.binary_release.scala_211.sha512_url }}">sha512</a>)
</p>

{% endif %}

{% if flink_release.binary_release.scala_212 %}

<p>
<a href="{{ flink_release.binary_release.scala_212.url }}" class="ga-track" id="{{ flink_release.binary_release.scala_212.id }}">{{ flink_release.binary_release.name }} for Scala 2.12</a> (<a href="{{ flink_release.binary_release.scala_212.asc_url }}">asc</a>, <a href="{{ flink_release.binary_release.scala_212.sha512_url }}">sha512</a>)
</p>

{% endif %}

{% if flink_release.source_release %}
<p>
<a href="{{ flink_release.source_release.url }}" class="ga-track" id="{{ flink_release.source_release.id }}">{{ flink_release.source_release.name }} Source Release</a>
(<a href="{{ flink_release.source_release.asc_url }}">asc</a>, <a href="{{ flink_release.source_release.sha512_url }}">sha512</a>)
</p>
{% endif %}

{% if flink_release.optional_components %}
#### Optional components

{% assign components = flink_release.optional_components | | sort: 'name' %}
{% for component in components %}

{% if component.scala_dependent %}

{% if component.scala_211 %}
<p>
<a href="{{ component.scala_211.url }}" class="ga-track" id="{{ component.scala_211.id }}">{{ component.name }} for Scala 2.11</a> (<a href="{{ component.scala_211.asc_url }}">asc</a>, <a href="{{ component.scala_211.sha_url }}">sha1</a>)
</p>
{% endif %}

{% if component.scala_212 %}
<p>
<a href="{{ component.scala_212.url }}" class="ga-track" id="{{ component.scala_212.id }}">{{ component.name }} for Scala 2.12</a> (<a href="{{ component.scala_212.asc_url }}">asc</a>, <a href="{{ component.scala_212.sha_url }}">sha1</a>)
</p>
{% endif %}

{% else %}
<p>
<a href="{{ component.url }}" class="ga-track" id="{{ component.id }}">{{ component.name }}</a> (<a href="{{ component.asc_url }}">asc</a>, <a href="{{ component.sha_url }}">sha1</a>)
</p>
{% endif %}

{% endfor %}

{% endif %}

{% if flink_release.alternative_binaries %}
#### Alternative Binaries

{% assign alternatives = flink_release.alternative_binaries | | sort: 'name' %}
{% for alternative in alternatives %}

{% if alternative.scala_211 %}

<p>
<a href="{{ alternative.scala_211.url }}" class="ga-track" id="{{ alternative.scala_211.id }}">{{ alternative.name }} for Scala 2.11</a> (<a href="{{ alternative.scala_211.asc_url }}">asc</a>, <a href="{{ alternative.scala_211.sha_url }}">sha512</a>)
</p>

{% endif %}

{% if alternative.scala_212 %}

<p>
<a href="{{ alternative.scala_212.url }}" class="ga-track" id="{{ alternative.scala_212.id }}">{{ alternative.name }} for Scala 2.12</a> (<a href="{{ alternative.scala_212.asc_url }}">asc</a>, <a href="{{ alternative.scala_212.sha_url }}">sha512</a>)
</p>

{% endif %}

{% endfor %}

{% endif %}

#### Release Notes

Please have a look at the [Release Notes for Flink {{ flink_release.version_short }}]({{ site.DOCS_BASE_URL }}flink-docs-release-{{ flink_release.version_short }}/release-notes/flink-{{ flink_release.version_short }}.html) if you plan to upgrade your Flink setup from a previous version.

---

{% endfor %}

## Additional Components

These are components that the Flink project develops which are not part of the
main Flink release:

{% for additional_component in site.component_releases %}

<p>
<a href="{{ additional_component.url }}" class="ga-track" id="{{ additional_component.id }}">{{ additional_component.name }}</a>
(<a href="{{ additional_component.asc_url }}">asc</a>, <a href="{{ additional_component.sha512_url }}">sha512</a>)
</p>

{% endfor %}

## Verifying Hashes and Signatures

Along with our releases, we also provide sha512 hashes in `*.sha512` files and cryptographic signatures in `*.asc` files. The Apache Software Foundation has an extensive [tutorial to verify hashes and signatures](http://www.apache.org/info/verification.html) which you can follow by using any of these release-signing [KEYS](https://www.apache.org/dist/flink/KEYS).

## Maven Dependencies

You can add the following dependencies to your `pom.xml` to include Apache Flink in your project. These dependencies include a local execution environment and thus support local testing.

- **Scala API**: To use the Scala API, replace the `flink-java` artifact id with `flink-scala_2.11` and `flink-streaming-java_2.11` with `flink-streaming-scala_2.11`.

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

### Flink-shaded
{% assign shaded_releases = site.release_archive.flink_shaded | sort: 'release_date' | reverse %} 
<ul>
{% for shaded_release in shaded_releases %}
<li>Flink-shaded {{ shaded_release.version }} - {{ shaded_release.release_date }} (<a href="https://archive.apache.org/dist/flink/flink-shaded-{{ shaded_release.version }}/flink-shaded-{{ shaded_release.version }}-src.tgz">Source</a>)</li>
{% endfor %}
</ul>

