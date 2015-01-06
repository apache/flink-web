---
title: "Downloads"
layout: simple
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


<p class="lead">Pick the <strong>Apache Flink</strong> package matching your Hadoop version.</p>

## Stable

Apache Flink {{ site.FLINK_VERSION_STABLE }} is our latest stable release.

<div class="list-group">
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_1_STABLE }}" id="download-hadoop1" class="list-group-item ga-track">
    <h4 class="list-group-item-heading">
      <i class="fa fa-download"></i> <strong>Flink {{ site.FLINK_VERSION_STABLE }}</strong> for Hadoop 1</h4>
    <p>Pick this package if you plan to use Flink with data stored in Hadoop 1.x.</p>
    <p>Also pick this version if you don't plan to use Flink with Hadoop at all.</p>
  </a>
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_STABLE }}" id="download-hadoop2" class="list-group-item ga-track">
  	<h4 class="list-group-item-heading"><i class="fa fa-download"></i> <strong>Flink {{ site.FLINK_VERSION_STABLE }}</strong> for Hadoop 2</h4>
  	<p>Pick this package if you plan to install Flink use Flink with data stored in Hadoop 2.x.</p>
  </a>
  <a href="{{ site.FLINK_DOWNLOAD_URL_YARN_STABLE }}" class="list-group-item ga-track" id="download-hadoop2-yarn">
  	<h4 class="list-group-item-heading"><i class="fa fa-download"></i> <strong>Flink {{ site.FLINK_VERSION_STABLE }}</strong> for YARN</h4>
  	<p>Pick this package if you plan to use Flink with Hadoop YARN.</p>
  </a>
  <a href="{{ site.FLINK_DOWNLOAD_URL_SOURCE }}" class="list-group-item ga-track" id="download-source">
    <h4 class="list-group-item-heading"><i class="fa fa-download"></i> <strong>Flink {{ site.FLINK_VERSION_STABLE }} Source Release</strong></h4>
    <p>Review the source code or build Flink on your own, using this package</p>
  </a>
</div>

The YARN package is not suited for installing Flink directly on a cluster. It contains the files required to deploy Flink on a Hadoop YARN cluster. 

### Maven Dependencies

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

- **Hadoop 2**: If you want to interact with Hadoop 2, use `{{ site.FLINK_VERSION_HADOOP_2_STABLE }}` as the version.
- **Scala API**: To use the Scala API, replace the `flink-java` artifact id with `flink-scala`.

## Latest 

Apache Flink `{{ site.FLINK_VERSION_LATEST }}` is our latest development version.

You can download a packaged version of our nightly builds, which include
the most recent development code. You can use them if you need a feature
before its release. Only builds that pass all tests are published here.

<div class="list-group">
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_1_LATEST }}" class="list-group-item ga-track" id="download-hadoop1-nightly">
    <h4 class="list-group-item-heading">
      <i class="fa fa-download"></i> <strong>Flink {{ site.FLINK_VERSION_LATEST }}</strong> for Hadoop 1</h4>
  </a>
  <a href="{{ site.FLINK_DOWNLOAD_URL_HADOOP_2_LATEST }}" class="list-group-item ga-track" id="download-hadoop2-nightly">
    <h4 class="list-group-item-heading"><i class="fa fa-download"></i> <strong>Flink {{ site.FLINK_VERSION_LATEST }}</strong> for Hadoop 2</h4>
  </a>
  <a href="{{ site.FLINK_DOWNLOAD_URL_YARN_LATEST }}" class="list-group-item ga-track" id="download-hadoop2-yarn-nightly">
    <h4 class="list-group-item-heading"><i class="fa fa-download"></i> <strong>Flink {{ site.FLINK_VERSION_LATEST }}</strong> for YARN</h4>
  </a>
</div>

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

You can now include Apache Flink as a Maven dependency (see above) with version `{{ site.FLINK_VERSION_LATEST }}` (or `{{ site.FLINK_VERSION_HADOOP_2_LATEST}}` for compatibility with Hadoop versions starting from 2.2.0).

## Checkout from Source

You can checkout Apache Flink {{ site.FLINK_VERSION_LATEST }} and build it on your own machine.

```bash
git clone {{ site.FLINK_GITHUB_URL }}
cd {{ site.FLINK_GITHUB_REPO_NAME }}
mvn clean package -DskipTests
```

Note: Flink does not build with Oracle JDK 6. It runs with Oracle JDK 6.

If you want to build for Hadoop 2, activate the build profile via `mvn clean package -DskipTests -Dhadoop.profile=2`.