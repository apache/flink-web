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

  <!-- Hadoop 2 -->
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_STABLE }}" id="download-hadoop2" class="list-group-item ga-track">
    <h4><span class="glyphicon glyphicon-download" aria-hidden="true"></span> <strong>Flink {{ site.stable }}</strong> for Hadoop 2</h4>
    <p>Pick this package if you plan to install Flink use Flink with data stored in Hadoop 2.x.</p>
  </a>

  <!-- YARN -->
  <a href="{{ site.FLINK_DOWNLOAD_URL_YARN_STABLE }}" class="list-group-item ga-track" id="download-hadoop2-yarn">
    <h4><span class="glyphicon glyphicon-download" aria-hidden="true"></span> <strong>Flink {{ site.stable }}</strong> for YARN</h4>
    <p>Pick this package if you plan to use Flink with Hadoop YARN.</p>
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

## Preview release

This **milestone release** is a preview of the upcoming {{site.FLINK_VERSION_LATEST_SHORT}} release. Check out the [announcement]({{ site.baseurl }}/news/2015/04/13/release-0.9.0-milestone1.html) for all the details.

- **Hadoop 1**: <a href="http://www.apache.org/dyn/closer.cgi/flink/flink-0.9.0-milestone-1/flink-0.9.0-milestone-1-bin-hadoop1.tgz" id="download-hadoop1-preview" class="ga-track">flink-0.9.0-milestone-1-bin-hadoop1.tgz</a>
- **Hadoop 2 and YARN**: <a href="http://www.apache.org/dyn/closer.cgi/flink/flink-0.9.0-milestone-1/flink-0.9.0-milestone-1-bin-hadoop2.tgz" id="download-hadoop2-preview" class="ga-track">flink-0.9.0-milestone-1-bin-hadoop2.tgz</a>
- **Source**. <a href="http://www.apache.org/dyn/closer.cgi/flink/flink-0.9.0-milestone-1/flink-0.9.0-milestone-1-src.tgz" class="ga-track" id="download-source-preview">flink-0.9.0-milestone-1-src.tgz</a>

You can add the following dependencies to your `pom.xml` to include Apache Flink in your project.

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>0.9.0-milestone-1</version>
</dependency>
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients</artifactId>
  <version>0.9.0-milestone-1</version>
</dependency>
```

- **Hadoop 1**: If you want to interact with Hadoop 1, use `0.9.0-milestone-1-hadoop1` as the version.
- **Scala API**: To use the Scala API, replace the `flink-java` artifact id with `flink-scala`.

## Snapshot

Apache Flink `{{ site.FLINK_VERSION_LATEST }}` is our latest development version.

You can download a packaged version of our nightly builds, which include
the most recent development code. You can use them if you need a feature
before its release. Only builds that pass all tests are published here.

- **Hadoop 1**: <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_1_LATEST }}" class="ga-track" id="download-hadoop1-nightly">{{ site.FLINK_DOWNLOAD_URL_HADOOP_1_LATEST | split:'/' | last }}</a>
- **Hadoop 2 and YARN**: <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_LATEST }}" class="ga-track" id="download-hadoop2-nightly">{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_LATEST | split:'/' | last }}</a>

Add the **Apache Snapshot repository** to your Maven `pom.xml`:

```xml
<repositories>
  <repository>
    <id>apache.snapshots</id>
    <name>Apache Development Snapshot Repository</name>
    <url>https://repository.apache.org/content/repositories/snapshots/</url>
    <releases><enabled>false</enabled></releases>
    <snapshots><enabled>true</enabled></snapshots>
  </repository>
</repositories>
```

You can now include Apache Flink as a Maven dependency (see above) with version `{{ site.FLINK_VERSION_LATEST }}` (or `{{ site.FLINK_VERSION_HADOOP_1_LATEST}}` for compatibility with old Hadoop versions (1.x)).

## Build from Source

You can checkout Apache Flink {{ site.FLINK_VERSION_LATEST }} and build it on your own machine.

```bash
git clone {{ site.FLINK_GITHUB_URL }}
cd {{ site.FLINK_GITHUB_REPO_NAME }}
mvn clean package -DskipTests
```

Note: Flink does not build with Oracle JDK 6. It runs with Oracle JDK 6.

If you want to build for Hadoop 1, activate the build profile via `mvn clean package -DskipTests -Dhadoop.profile=1`.

## All releases

- Flink 0.8.0 ([Jars](http://archive.apache.org/dist/flink/flink-0.8.0/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.0/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.0/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.8.0/api/scala/index.html))
- Flink 0.7.0-incubating ([Jars](http://archive.apache.org/dist/incubator/flink/flink-0.7.0-incubating/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.7/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.7/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.7/api/scala/index.html))
- Flink 0.6.1-incubating ([Jars](http://archive.apache.org/dist/incubator/flink/flink-0.6.1-incubating/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6.1/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6.1/api/scala/index.html))
- Flink 0.6-incubating ([Jars](http://archive.apache.org/dist/incubator/flink/), [Docs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6/), [Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.6/api/scala/index.html))
- Stratosphere 0.5.1 ([Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.5.1/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.5.1/api/scala/index.html))
- Stratosphere 0.5 ([Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.5/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.5/api/scala/index.html))
- Stratosphere 0.4 ([Javadocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.4/api/java), [ScalaDocs]({{site.DOCS_BASE_URL}}flink-docs-release-0.4/api/scala/index.html))