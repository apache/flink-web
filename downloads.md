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
file system connector) then select the download that bundles the
matching Hadoop version, download the optional pre-bundled Hadoop that
matches your version and place it in the `lib` folder of Flink, or
[export your
HADOOP_CLASSPATH](https://ci.apache.org/projects/flink/flink-docs-stable/ops/deployment/hadoop.html).

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

{% if additional_component.source_release %}
{% assign source_release = additional_component.source_release %}
<p>
<a href="{{ source_release.url }}" class="ga-track" id="{{ source_release.id }}">{{ source_release.name }}</a>
(<a href="{{ source_release.asc_url }}">asc</a>, <a href="{{ source_release.sha512_url }}">sha512</a>)
</p>
{% endif %}

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
- Flink 1.9.0 - 2019-08-22 ([Source](https://archive.apache.org/dist/flink/flink-1.9.0/flink-1.9.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.9.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.9/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.9/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.9/api/scala/index.html))
- Flink 1.8.1 - 2019-07-02 ([Source](https://archive.apache.org/dist/flink/flink-1.8.1/flink-1.8.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.8.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.8/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.8/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.8/api/scala/index.html))
- Flink 1.8.0 - 2019-04-09 ([Source](https://archive.apache.org/dist/flink/flink-1.8.0/flink-1.8.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.8.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.8/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.8/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.8/api/scala/index.html))
- Flink 1.7.2 - 2019-02-15 ([Source](https://archive.apache.org/dist/flink/flink-1.7.2/flink-1.7.2-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.7.2/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.7/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.7/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.7/api/scala/index.html))
- Flink 1.7.1 - 2018-12-21 ([Source](https://archive.apache.org/dist/flink/flink-1.7.1/flink-1.7.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.7.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.7/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.7/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.7/api/scala/index.html))
- Flink 1.7.0 - 2018-11-30 ([Source](https://archive.apache.org/dist/flink/flink-1.7.0/flink-1.7.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.7.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.7/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.7/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.7/api/scala/index.html))
- Flink 1.6.4 - 2019-02-25 ([Source](https://archive.apache.org/dist/flink/flink-1.6.4/flink-1.6.4-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.6.4/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/scala/index.html))
- Flink 1.6.3 - 2018-12-22 ([Source](https://archive.apache.org/dist/flink/flink-1.6.3/flink-1.6.3-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.6.3/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/scala/index.html))
- Flink 1.6.2 - 2018-10-29 ([Source](https://archive.apache.org/dist/flink/flink-1.6.2/flink-1.6.2-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.6.2/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/scala/index.html))
- Flink 1.6.1 - 2018-09-19 ([Source](https://archive.apache.org/dist/flink/flink-1.6.1/flink-1.6.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.6.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/scala/index.html))
- Flink 1.6.0 - 2018-08-08 ([Source](https://archive.apache.org/dist/flink/flink-1.6.0/flink-1.6.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.6.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.6/api/scala/index.html))
- Flink 1.5.6 - 2018-12-21 ([Source](https://archive.apache.org/dist/flink/flink-1.5.6/flink-1.5.6-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.5.6/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/scala/index.html))
- Flink 1.5.5 - 2018-10-29 ([Source](https://archive.apache.org/dist/flink/flink-1.5.5/flink-1.5.5-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.5.5/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/scala/index.html))
- Flink 1.5.4 - 2018-09-19 ([Source](https://archive.apache.org/dist/flink/flink-1.5.4/flink-1.5.4-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.5.4/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/scala/index.html))
- Flink 1.5.3 - 2018-08-21 ([Source](https://archive.apache.org/dist/flink/flink-1.5.3/flink-1.5.3-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.5.3/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/scala/index.html))
- Flink 1.5.2 - 2018-07-31 ([Source](https://archive.apache.org/dist/flink/flink-1.5.2/flink-1.5.2-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.5.2/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/scala/index.html))
- Flink 1.5.1 - 2018-07-12 ([Source](https://archive.apache.org/dist/flink/flink-1.5.1/flink-1.5.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.5.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/scala/index.html))
- Flink 1.5.0 - 2018-05-25 ([Source](https://archive.apache.org/dist/flink/flink-1.5.0/flink-1.5.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.5.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.5/api/scala/index.html))
- Flink 1.4.2 - 2018-03-08 ([Source](https://archive.apache.org/dist/flink/flink-1.4.2/flink-1.4.2-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.4.2/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.4/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.4/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.4/api/scala/index.html))
- Flink 1.4.1 - 2018-02-15 ([Source](https://archive.apache.org/dist/flink/flink-1.4.1/flink-1.4.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.4.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.4/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.4/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.4/api/scala/index.html))
- Flink 1.4.0 - 2017-11-29 ([Source](https://archive.apache.org/dist/flink/flink-1.4.0/flink-1.4.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.4.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.4/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.4/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.4/api/scala/index.html))
- Flink 1.3.3 - 2018-03-15 ([Source](https://archive.apache.org/dist/flink/flink-1.3.3/flink-1.3.3-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.3.3/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/api/scala/index.html))
- Flink 1.3.2 - 2017-08-05 ([Source](https://archive.apache.org/dist/flink/flink-1.3.2/flink-1.3.2-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.3.2/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/api/scala/index.html))
- Flink 1.3.1 - 2017-06-23 ([Source](https://archive.apache.org/dist/flink/flink-1.3.1/flink-1.3.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.3.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/api/scala/index.html))
- Flink 1.3.0 - 2017-06-01 ([Source](https://archive.apache.org/dist/flink/flink-1.3.0/flink-1.3.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.3.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.3/api/scala/index.html))
- Flink 1.2.1 - 2017-04-26 ([Source](https://archive.apache.org/dist/flink/flink-1.2.1/flink-1.2.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.2.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/api/scala/index.html))
- Flink 1.2.0 - 2017-02-06 ([Source](https://archive.apache.org/dist/flink/flink-1.2.0/flink-1.2.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.2.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.2/api/scala/index.html))
- Flink 1.1.5 - 2017-03-22 ([Source](https://archive.apache.org/dist/flink/flink-1.1.5/flink-1.1.5-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.1.5/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/scala/index.html))
- Flink 1.1.4 - 2016-12-21 ([Source](https://archive.apache.org/dist/flink/flink-1.1.4/flink-1.1.4-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.1.4/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/scala/index.html))
- Flink 1.1.3 - 2016-10-13 ([Source](https://archive.apache.org/dist/flink/flink-1.1.3/flink-1.1.3-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.1.3/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/scala/index.html))
- Flink 1.1.2 - 2016-09-05 ([Source](https://archive.apache.org/dist/flink/flink-1.1.2/flink-1.1.2-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.1.2/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/scala/index.html))
- Flink 1.1.1 - 2016-08-11 ([Source](https://archive.apache.org/dist/flink/flink-1.1.1/flink-1.1.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.1.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/scala/index.html))
- Flink 1.1.0 - 2016-08-08 ([Source](https://archive.apache.org/dist/flink/flink-1.1.0/flink-1.1.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.1.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/scala/index.html))
- Flink 1.0.3 - 2016-05-12 ([Source](https://archive.apache.org/dist/flink/flink-1.0.3/flink-1.0.3-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.0.3/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/scala/index.html))
- Flink 1.0.2 - 2016-04-23 ([Source](https://archive.apache.org/dist/flink/flink-1.0.2/flink-1.0.2-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.0.2/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/scala/index.html))
- Flink 1.0.1 - 2016-04-06 ([Source](https://archive.apache.org/dist/flink/flink-1.0.1/flink-1.0.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.0.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/scala/index.html))
- Flink 1.0.0 - 2016-03-08 ([Source](https://archive.apache.org/dist/flink/flink-1.0.0/flink-1.0.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-1.0.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/scala/index.html))
- Flink 0.10.2 - 2016-02-11 ([Source](https://archive.apache.org/dist/flink/flink-0.10.2/flink-0.10.2-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-0.10.2/))
- Flink 0.10.1 - 2015-11-27 ([Source](https://archive.apache.org/dist/flink/flink-0.10.1/flink-0.10.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-0.10.1/))
- Flink 0.10.0 - 2015-11-16 ([Source](https://archive.apache.org/dist/flink/flink-0.10.0/flink-0.10.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-0.10.0/))
- Flink 0.9.1 - 2015-09-01 ([Source](https://archive.apache.org/dist/flink/flink-0.9.1/flink-0.9.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-0.9.1/))
- Flink 0.9.0 - 2015-06-24 ([Source](https://archive.apache.org/dist/flink/flink-0.9.0/flink-0.9.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-0.9.0/))
- Flink 0.9.0-milestone-1 - 2015-04-13 ([Source](https://archive.apache.org/dist/flink/flink-0.9.0-milestone-1/flink-0.9.0-milestone-1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-0.9.0-milestone-1/))
- Flink 0.8.1 - 2015-02-20 ([Source](https://archive.apache.org/dist/flink/flink-0.8.1/flink-0.8.1-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-0.8.1/))
- Flink 0.8.0 - 2015-01-22 ([Source](https://archive.apache.org/dist/flink/flink-0.8.0/flink-0.8.0-src.tgz), [Binaries](https://archive.apache.org/dist/flink/flink-0.8.0/))
- Flink 0.7.0-incubating - 2014-11-04 ([Source](https://archive.apache.org/dist/incubator/flink/flink-0.7.0-incubating/flink-0.7.0-incubating-src.tgz), [Binaries](https://archive.apache.org/dist/incubator/flink/flink-0.7.0-incubating/))
- Flink 0.6.1-incubating - 2014-09-26 ([Source](https://archive.apache.org/dist/incubator/flink/flink-0.6.1-incubating/flink-0.6.1-incubating-src.tgz), [Binaries](https://archive.apache.org/dist/incubator/flink/flink-0.6.1-incubating/))
- Flink 0.6-incubating - 2014-08-26 ([Source](https://archive.apache.org/dist/incubator/flink/flink-0.6-incubating-src.tgz), [Binaries](https://archive.apache.org/dist/incubator/flink/))

### Flink-shaded
- Flink-shaded 8.0 - 2019-08-28 ([Source](https://archive.apache.org/dist/flink/flink-shaded-8.0/flink-shaded-8.0-src.tgz))
- Flink-shaded 7.0 - 2019-05-30 ([Source](https://archive.apache.org/dist/flink/flink-shaded-7.0/flink-shaded-7.0-src.tgz))
- Flink-shaded 6.0 - 2019-02-12 ([Source](https://archive.apache.org/dist/flink/flink-shaded-6.0/flink-shaded-6.0-src.tgz))
- Flink-shaded 5.0 - 2018-10-15 ([Source](https://archive.apache.org/dist/flink/flink-shaded-5.0/flink-shaded-5.0-src.tgz))
- Flink-shaded 4.0 - 2018-06-06 ([Source](https://archive.apache.org/dist/flink/flink-shaded-4.0/flink-shaded-4.0-src.tgz))
- Flink-shaded 3.0 - 2018-02-28 ([Source](https://archive.apache.org/dist/flink/flink-shaded-3.0/flink-shaded-3.0-src.tgz))
- Flink-shaded 2.0 - 2017-10-30 ([Source](https://archive.apache.org/dist/flink/flink-shaded-2.0/flink-shaded-2.0-src.tgz))
- Flink-shaded 1.0 - 2017-07-27 ([Source](https://archive.apache.org/dist/flink/flink-shaded-1.0/flink-shaded-1.0-src.tgz))


