---
title: "Downloads"
---

<script type="text/javascript">
$( document ).ready(function() {
  // Handler for .ready() called.
  $('.ga-track').on('click', function() {
    // we just use the element id for tracking with google analytics
    ga('send', 'event', 'button', 'click', $(this).attr('id'));
  });

});
</script>

{% toc %}

## Latest stable release (v{{ site.stable }})

Apache Flink {{ site.stable }} is our latest stable release.

You [don't have to install Hadoop](faq.html#do-i-have-to-install-apache-hadoop-to-use-flink) to use Flink, but if you plan to use Flink with data stored in Hadoop, pick the version matching your installed Hadoop version. If you don't want to do this, pick the Hadoop 1 version.

<div class="list-group">
  <!-- Hadoop 1 -->
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_1_STABLE }}" id="download-hadoop1" class="list-group-item ga-track">
    <h4><span class="glyphicon glyphicon-download" aria-hidden="true"></span> <strong>Flink {{ site.stable }}</strong> for Hadoop 1</h4>

    <p>Pick this package if you plan to use Flink with data stored in Hadoop 1.x.</p>
    <p>Also pick this version if you don't plan to use Flink with Hadoop at all.</p>
  </a>

  <!-- Hadoop 2.2 -->
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_STABLE }}" id="download-hadoop2" class="list-group-item ga-track">
    <h4><span class="glyphicon glyphicon-download" aria-hidden="true"></span> <strong>Flink {{ site.stable }}</strong> for Hadoop 2.2.0</h4>
    <p>Pick this package if you plan to install Flink use Flink with data stored in Hadoop 2.2.0 This version also supports YARN</p>
  </a>

  <!-- Hadoop 2.4 -->
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_24_STABLE }}" id="download-hadoop24" class="list-group-item ga-track">
    <h4><span class="glyphicon glyphicon-download" aria-hidden="true"></span> <strong>Flink {{ site.stable }}</strong> for Hadoop 2.4.1</h4>
    <p>Pick this package if you plan to install Flink use Flink with data stored in Hadoop 2.4.1 This version also supports YARN</p>
  </a>

  <!-- Hadoop 2.6 -->
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_26_STABLE }}" id="download-hadoop26" class="list-group-item ga-track">
    <h4><span class="glyphicon glyphicon-download" aria-hidden="true"></span> <strong>Flink {{ site.stable }}</strong> for Hadoop 2.6.0</h4>
    <p>Pick this package if you plan to install Flink use Flink with data stored in Hadoop 2.6.0 This version also supports YARN</p>
  </a>

  <!-- Hadoop 2.7 -->
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_27_STABLE }}" id="download-hadoop27" class="list-group-item ga-track">
    <h4><span class="glyphicon glyphicon-download" aria-hidden="true"></span> <strong>Flink {{ site.stable }}</strong> for Hadoop 2.7.0</h4>
    <p>Pick this package if you plan to install Flink use Flink with data stored in Hadoop 2.7.0 This version also supports YARN</p>
  </a>

  <!-- Source -->
  <a href="{{ site.FLINK_DOWNLOAD_URL_SOURCE }}" class="list-group-item ga-track" id="download-source">
    <h4><span class="glyphicon glyphicon-download" aria-hidden="true"></span> <strong>Flink {{ site.FLINK_VERSION_STABLE }}</strong> Source Release</h4>
    <p>Review the source code or build Flink on your own, using this package</p>
  </a>
</div>

## Maven Dependencies

You can add the following dependencies to your `pom.xml` to include Apache Flink in your project.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients</artifactId>
  <version>{{ site.FLINK_VERSION_STABLE }}</version>
</dependency>
```

These dependencies include a local execution environment and thus support local testing.

- **Hadoop 1**: If you want to interact with Hadoop 1, use `{{ site.FLINK_VERSION_HADOOP_1_STABLE }}` as the version.
- **Scala API**: To use the Scala API, replace the `flink-java` artifact id with `flink-scala`.

## All releases

- Flink 0.9.0 ([Jars](http://archive.apache.org/dist/flink/flink-0.9.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.9/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.9/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.9/api/scala/index.html))
- Flink 0.9.0-milestone-1 ([Jars](http://archive.apache.org/dist/flink/flink-0.9.0-milestone-1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.9/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.9/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.9/api/scala/index.html))
- Flink 0.8.1 ([Jars](http://archive.apache.org/dist/flink/flink-0.8.1/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.1/api/scala/index.html))
- Flink 0.8.0 ([Jars](http://archive.apache.org/dist/flink/flink-0.8.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.0/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.0/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.0/api/scala/index.html))
- Flink 0.7.0-incubating ([Jars](http://archive.apache.org/dist/incubator/flink/flink-0.7.0-incubating/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.7/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.7/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.7/api/scala/index.html))
- Flink 0.6.1-incubating ([Jars](http://archive.apache.org/dist/incubator/flink/flink-0.6.1-incubating/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6.1/api/scala/index.html))
- Flink 0.6-incubating ([Jars](http://archive.apache.org/dist/incubator/flink/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6/api/scala/index.html))
- Stratosphere 0.5.1 ([Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.5.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.5.1/api/scala/index.html))
- Stratosphere 0.5 ([Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.5/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.5/api/scala/index.html))
- Stratosphere 0.4 ([Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.4/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.4/api/scala/index.html))
