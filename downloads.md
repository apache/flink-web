---
title: "Downloads"
---

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

## Latest stable release (v{{ site.FLINK_VERSION_STABLE }})

Apache Flink® {{ site.FLINK_VERSION_STABLE }} is our latest stable release.

You
[don't have to install Hadoop](faq.html#do-i-have-to-install-apache-hadoop-to-use-flink)
to use Flink, but if you plan to use Flink with data stored in Hadoop, pick the
version matching your installed Hadoop version. If you don't want to do this,
pick the Hadoop 1 version.

### Binaries

<table class="table table-striped">
<thead>
    <tr>
    <th></th> <th>Scala 2.10</th> <th>Scala 2.11</th>
    </tr>
</thead>
<tbody>
    <tr>
    <th>Hadoop® 1.2.1</th>
    <td><a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_1_STABLE }}" class="ga-track" id="download-hadoop1">Download</a></td>
    <td></td>
    </tr>

    <tr>
    <th>Hadoop® 2.3.0</th>
    <td><a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_STABLE }}" class="ga-track" id="download-hadoop2">Download</a></td>
    <td><a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_SCALA_211_STABLE }}" class="ga-track" id="download-hadoop2_211">Download</a></td>
    </tr>

    <tr>
    <th>Hadoop® 2.4.1</th>
    <td><a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_24_STABLE }}" class="ga-track" id="download-hadoop24">Download</a></td>
    <td><a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_24_SCALA_211_STABLE }}" class="ga-track" id="download-hadoop24_211">Download</a></td>
    </tr>

    <tr>
    <th>Hadoop® 2.6.0</th>
    <td><a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_26_STABLE }}" class="ga-track" id="download-hadoop26">Download</a></td>
    <td><a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_26_SCALA_211_STABLE }}" class="ga-track" id="download-hadoop26_211">Download</a></td>
    </tr>

    <tr>
    <th>Hadoop® 2.7.0</th>
    <td><a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_27_STABLE }}" class="ga-track" id="download-hadoop27">Download</a></td>
    <td><a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_27_SCALA_211_STABLE }}" class="ga-track" id="download-hadoop27_211">Download</a></td>
    </tr>

    </tr>
</tbody>
</table>

### Source

<div class="list-group">
  <!-- Source -->
  <a href="{{ site.FLINK_DOWNLOAD_URL_SOURCE }}" class="list-group-item ga-track" id="download-source">
    <h4><span class="glyphicon glyphicon-download" aria-hidden="true"></span> <strong>Apache Flink® {{ site.FLINK_VERSION_STABLE }}</strong> Source Release</h4>
    <p>Review the source code or build Flink on your own, using this package</p>
  </a>
</div>

## Maven Dependencies

You can add the following dependencies to your `pom.xml` to include Apache Flink in your project. These dependencies include a local execution environment and thus support local testing.

- **Hadoop 1**: If you want to interact with Hadoop 1, use `{{ site.FLINK_VERSION_HADOOP_1_STABLE }}` as the version.
- **Scala API**: To use the Scala API, replace the `flink-java` artifact id with `flink-scala_2.10` and `flink-streaming-java_2.10` with `flink-streaming-scala_2.10`. For Scala 2.11 dependencies, use the suffix `_2.11` instead of `_2.10`.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-streaming-java_2.10</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients_2.10</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
```

## All releases

- Flink 1.1.4 - 2016-12-21 ([Source](http://archive.apache.org/dist/flink/flink-1.1.4/flink-1.1.4-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-1.1.4/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/scala/index.html))
- Flink 1.1.3 - 2016-10-13 ([Source](http://archive.apache.org/dist/flink/flink-1.1.3/flink-1.1.3-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-1.1.3/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.1/api/scala/index.html))
- Flink 1.1.2 - 2016-09-05 ([Source](http://archive.apache.org/dist/flink/flink-1.1.2/flink-1.1.2-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-1.1.2/))
- Flink 1.1.1 - 2016-08-11 ([Source](http://archive.apache.org/dist/flink/flink-1.1.1/flink-1.1.1-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-1.1.1/))
- Flink 1.1.0 - 2016-08-08 ([Source](http://archive.apache.org/dist/flink/flink-1.1.0/flink-1.1.0-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-1.1.0/))
- Flink 1.0.3 - 2016-05-12 ([Source](http://archive.apache.org/dist/flink/flink-1.0.3/flink-1.0.3-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-1.0.3/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-1.0/api/scala/index.html))
- Flink 1.0.2 - 2016-04-23 ([Source](http://archive.apache.org/dist/flink/flink-1.0.2/flink-1.0.2-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-1.0.2/))
- Flink 1.0.1 - 2016-04-06 ([Source](http://archive.apache.org/dist/flink/flink-1.0.1/flink-1.0.1-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-1.0.1/))
- Flink 1.0.0 - 2016-03-08 ([Source](http://archive.apache.org/dist/flink/flink-1.0.0/flink-1.0.0-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-1.0.0/))
- Flink 0.10.2 - 2016-02-11 ([Source](http://archive.apache.org/dist/flink/flink-0.10.2/flink-0.10.2-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-0.10.2/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.10/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.10/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.10/api/scala/index.html))
- Flink 0.10.1 - 2015-11-27 ([Source](http://archive.apache.org/dist/flink/flink-0.10.1/flink-0.10.1-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-0.10.1/))
- Flink 0.10.0 - 2015-11-16 ([Source](http://archive.apache.org/dist/flink/flink-0.10.0/flink-0.10.0-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-0.10.0/))
- Flink 0.9.1 - 2015-09-01 ([Source](http://archive.apache.org/dist/flink/flink-0.9.1/flink-0.9.1-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-0.9.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.9/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.9/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.9/api/scala/index.html))
- Flink 0.9.0 - 2015-06-24 ([Source](http://archive.apache.org/dist/flink/flink-0.9.0/flink-0.9.0-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-0.9.0/))
- Flink 0.9.0-milestone-1 - 2015-04-13 ([Source](http://archive.apache.org/dist/flink/flink-0.9.0-milestone-1/flink-0.9.0-milestone-1-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-0.9.0-milestone-1/))
- Flink 0.8.1 - 2015-02-20 ([Source](http://archive.apache.org/dist/flink/flink-0.8.1/flink-0.8.1-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-0.8.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.1/api/scala/index.html))
- Flink 0.8.0 - 2015-01-22 ([Source](http://archive.apache.org/dist/flink/flink-0.8.0/flink-0.8.0-src.tgz), [Binaries](http://archive.apache.org/dist/flink/flink-0.8.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.0/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.0/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.0/api/scala/index.html))
- Flink 0.7.0-incubating - 2014-11-04 ([Source](http://archive.apache.org/dist/incubator/flink/flink-0.7.0-incubating/flink-0.7.0-incubating-src.tgz), [Binaries](http://archive.apache.org/dist/incubator/flink/flink-0.7.0-incubating/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.7/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.7/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.7/api/scala/index.html))
- Flink 0.6.1-incubating - 2014-09-26 ([Source](http://archive.apache.org/dist/incubator/flink/flink-0.6.1-incubating/flink-0.6.1-incubating-src.tgz), [Binaries](http://archive.apache.org/dist/incubator/flink/flink-0.6.1-incubating/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6.1/api/scala/index.html))
- Flink 0.6-incubating - 2014-08-26 ([Source](http://archive.apache.org/dist/incubator/flink/flink-0.6-incubating-src.tgz), [Binaries](http://archive.apache.org/dist/incubator/flink/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6/api/scala/index.html))

Previous Stratosphere releases are available on [Github](https://github.com/stratosphere/stratosphere/releases).
