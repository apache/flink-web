---
title: "Scalable Batch and Stream Data Processing"
layout: base
---

<div class="row">
  <div class="col-sm-12"><p class="lead" markdown="span">**Apache Flink** is an open source platform for scalable batch and stream data processing.</p></div>
</div>

<div class="row">
  <div class="col-sm-6" markdown="1">

**Flink’s core** is a [streaming dataflow engine](features.html#unified-stream-amp-batch-processing) that provides data distribution, communication, and fault tolerance for distributed computations over data streams.

Flink includes **several APIs** for creating applications that use the Flink engine:

1. [DataSet API](features.html#dataset-api) for static data embedded in Java, Scala, and Python,
2. [DataStream API](features.html#datastream-api) for unbounded streams embedded in Java and Scala, and
3. [Table API](features.html#table-api) with a SQL-like expression language embedded in Java and Scala.

Flink also bundles **libraries for domain-specific use cases**:

1. [Machine Learning library](features.html#machine-learning-library), and
2. [Gelly](features.html#graph-api-amp-library-gelly), a graph processing API and library.

You can **integrate** Flink easily with other well-known open source systems both for [data input and output](features.html#deployment-and-integration) as well as [deployment](features.html#deployment-and-integration).

**Check out the [features](features.html) page to get a tour of all major Flink features.**
  </div>
  <div class="col-sm-6 stack text-center">
    <img src="{{ site.baseurl }}/img/flink-stack-small.png" alt="Apache Flink Stack" width="385px" height="300px">
  </div>
</div>

---

<div class="frontpage-tags">
  <div class="row">
    <div class="col-md-4 text-center">
       <h2><span class="glyphicon glyphicon-flash"></span> <a href="features.html#fast">Fast</a></h2>
      <p>State-of-the art performance exploiting in-memory processing and data streaming.</p>
    </div>
    <div class="col-md-4 text-center">
      <h2><span class="glyphicon glyphicon-plane"></span> <a href="features.html#reliable-and-scalable">Reliable</a></h2>
      <p>Flink is designed to perform very well even when the cluster's memory runs out.</p>
    </div>
    <div class="col-md-4 text-center">
      <h2><span class="glyphicon glyphicon-cutlery"></span> <a href="features.html#expressive">Expressive</a></h2>
      <p>Write beautiful, type-safe code in Java and Scala. Execute it on a cluster.</p>
    </div>
  </div>

  <div class="row">
    <div class="col-md-4 text-center">
      <h2><span class="glyphicon glyphicon-send"></span> <a href="features.html#easy-to-use">Easy to use</a></h2>
      <p>Few configuration parameters required. Cost-based optimizer built in.</p>
    </div>
    <div class="col-md-4 text-center">
      <h2><span class="glyphicon glyphicon-sort"></span> <a href="features.html#reliable-and-scalable">Scalable</a></h2>
      <p>Tested on clusters of 100s of machines, Google Compute Engine, and Amazon EC2.</p>
    </div>
    <div class="col-md-4 text-center">
      <h2><span class="glyphicon glyphicon-refresh"></span> <a href="features.html#hadoop">Hadoop-compatible</a></h2>
      <p>Flink runs on YARN and HDFS and has a Hadoop compatibility package.</p>
    </div>
  </div>
</div>

---

<div class="row">
  <div class="col-sm-6" markdown="1">
## Getting Started

Download the **latest stable release** and run Flink on your machine, cluster, or cloud:

<div class="text-center download-button">
  <a href="downloads.html" class="btn btn-primary" markdown="1">**Download** Apache Flink {{ site.stable }}</a>
  <a href="{{ site.github }}" class="btn btn-info" markdown="1">Apache Flink on **GitHub**</a>
</div>

The documentation contains a [setup guide]({{ site.docs-snapshot }}/setup) for all deployment options.

The [programming guide]({{ site.docs-snapshot }}/apis) contains all information to get you started with writing and testing your Flink programs.

**Check out the [documentation]({{ site.docs-snapshot }}) for the next steps.**

  </div>
  <div class="col-sm-6" markdown="1" style="padding-bottom:1em">
## Latest blog posts

<ul class="list-group">
{% for post in site.posts limit:5 %}  
      <li class="list-group-item"><span>{{ post.date | date_to_string }}</span> &raquo;
        <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a>
      </li>
{% endfor %}
</ul>

**Check out [the blog](blog/) for all posts.**
  </div>
</div>

<div class="row">
  <div class="col-sm-6" markdown="1">
## Community

You can post questions to the Flink [community]() on various channels. Pick the one, which suits you best:

- <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> **User mailing list**. Subscribe to the mailing list by sending an empty email to user-subscribe@flink.apache.org. Once the subscription is confirmed, you can send questions to user@flink.apache.org.

- <span class="glyphicon glyphicon-search" aria-hidden="true"></span> **Stack Overflow**. Post your questions to [Stack Overflow](http://stackoverflow.com/questions/ask/?tags=flink) and tag them with [#flink](http://stackoverflow.com/questions/ask/?tags=flink).

- <span class="glyphicon glyphicon-comment" aria-hidden="true"></span> **IRC chat**. The IRC channel **#flink** at irc.freenode.org is dedicated to Apache Flink. Join the channel and chat with the Flink community.

**Check out [the community page](community.html) for all community-related information. If you want to contribute, make sure to have a look at the [contribution guide](how-to-contribute.html).**
  </div>

  <div class="col-sm-6 text-center">
   <a class="twitter-timeline" href="https://twitter.com/ApacheFlink" data-widget-id="598498380973735936">Tweets by @ApacheFlink</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
  </div>
</div>