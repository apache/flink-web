---
title: "Scalable Batch and Stream Data Processing"
layout: base
---

<div class="row">
  <div class="col-sm-12"><p class="lead" markdown="span">**Apache Flink** is an open source platform for distributed stream and batch data processing.</p></div>
</div>

<div class="row">
  <div class="col-md-6" markdown="1">

**Flink’s core** is a [streaming dataflow engine](features.html) that provides data distribution, communication, and fault tolerance for distributed computations over data streams.

Flink includes **several APIs** for creating applications that use the Flink engine:

1. [DataStream API]({{ site.docs-snapshot }}/apis/streaming/index.html) for unbounded streams embedded in Java and Scala, and
2. [DataSet API]({{ site.docs-snapshot }}/apis/batch/index.html) for static data embedded in Java, Scala, and Python,
3. [Table API]({{ site.docs-snapshot }}/apis/batch/libs/table.html) with a SQL-like expression language embedded in Java and Scala.

Flink also bundles **libraries for domain-specific use cases**:

1. [CEP]({{ site.docs-snapshot }}/apis/streaming/libs/cep.html), a complex event processing library,
2. [Machine Learning library]({{ site.docs-snapshot }}/apis/batch/libs/ml/index.html), and
3. [Gelly]({{ site.docs-snapshot }}/apis/batch/libs/gelly.html), a graph processing API and library.

You can **integrate** Flink easily with other well-known open source systems both for [data input and output](features.html#deployment-and-integration) as well as [deployment](features.html#deployment-and-integration).
  </div>
  <div class="col-md-6 stack text-center">
    <!-- https://docs.google.com/drawings/d/1XCNHsBDAq0fP-TSazE4CcrUinrC37JFiuXAoAEZZavE/ -->
    <img src="{{ site.baseurl }}/img/flink-stack-frontpage.png" alt="Apache Flink Stack" width="480px" height="280px">
  </div>
</div>

---

<div class="frontpage-tags">
  <div class="row">
    <div class="col-md-4 text-center">
      <h2><span class="glyphicon glyphicon-send"></span> <a href="features.html#streaming">Streaming First</a></h2>
      <p>High throughput and low latency stream processing with exactly-once guarantees.</p>
    </div>
    <div class="col-md-4 text-center">
      <h2><span class="glyphicon glyphicon-flash"></span> <a href="features.html#batch-on-streaming">Batch on Streaming</a></h2>
      <p>Batch processing applications run efficiently as special cases of stream processing applications.</p>
    </div>
    <div class="col-md-4 text-center">
      <h2><span class="glyphicon glyphicon-fire"></span> <a href="features.html#apis-and-libs">APIs, Libraries, and Ecosystem</a></h2>
      <p>DataSet, DataStream, and more. Integrated with the Apache Big Data stack.</p>
    </div>
  </div>
  <div class="row" style="margin-top: 1em">
    <div class="col-md-12"><p class="text-center"><strong>Check out the <a href="{{ site.baseurl }}/features.html">Features</a> page to get a tour of all major Flink features.</strong></p></div>
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

The documentation contains a [setup guide]({{ site.docs-snapshot }}/setup/building.html) for all deployment options.

The [programming guide]({{ site.docs-snapshot }}/apis/programming_guide.html) contains all information to get you started with writing and testing your Flink programs.

See our list of [third-party packages]({{ site.baseurl }}/community.html#third-party-packages) for Flink.

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
