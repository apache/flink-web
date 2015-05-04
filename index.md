---
title: "Apache Flink"
layout: base
---

<div class="row">
  <div class="col-sm-12"><p class="lead" markdown="span">**Apache Flink** is an open source platform for *real-time* data analysis.</p></div>
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
  <div class="col-sm-6 stack text-center" markdown="1">
![Apache Flink Stack]({{ site.baseurl }}/img/flink-stack.png "Apache Flink Stack")
  </div>
</div>

---

<div class="row">
  <div class="col-sm-5" markdown="1">
## Getting Started

Download the **latest stable release** and run Flink on your machine, cluster, or cloud:

<div class="text-center download-button"><a href="downloads.html" class="btn btn-primary" markdown="1">**Download Apache Flink {{ site.stable }}**</a></div>

The documentation contains a [setup guide]({{ site.docs-snapshot }}/setup) for all deployment options.

Start writing Flink programs by adding Flink to your **Maven dependencies**:

{% highlight xml %}
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-java</artifactId>
  <version>{{ site.stable }}</version>
</dependency>

<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-clients</artifactId>
  <version>{{ site.stable }}</version>
</dependency>
{% endhighlight %}

The [programming guide]({{ site.docs-snapshot }}/apis) contains all information to get you started with writing and testing your Flink programs.

**Check out the [documentation]({{ site.docs-snapshot }}) for the next steps.**
  </div>

  <div class="col-sm-7" markdown="1">
## Latest blog posts

<ul class="list-group">
{% for post in site.posts limit:5 %}  
      <li class="list-group-item"><span>{{ post.date | date_to_string }}</span> &raquo;
        <a href="{{ site.baseurl }}/{{ post.url }}">{{ post.title }}</a>
      </li>
{% endfor %}
</ul>

**Check out [the blog](blog/) for all posts.**

---

## Community

You can post questions to the Flink [community]() on various channels. Pick the one, which suits you best:

<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> **User mailing list**. Subscribe to the mailing list by sending an empty email to user-subscribe@flink.apache.org. Once the subscription is confirmed, you can send questions to user@flink.apache.org. There is also a [searchable archive](http://apache-flink-user-mailing-list-archive.2336050.n4.nabble.com) if you want to search for existing questions.

<span class="glyphicon glyphicon-search" aria-hidden="true"></span> **Stack Overflow**. Post your questions to [Stack Overflow](http://stackoverflow.com/questions/ask/?tags=flink) and tag them with [#flink](http://stackoverflow.com/questions/ask/?tags=flink). Flink committers are watching this tag and are happy to help with answers.

<span class="glyphicon glyphicon-comment" aria-hidden="true"></span> **IRC chat**. The IRC channel **#flink** at irc.freenode.org is dedicated to Apache Flink. Join the channel and chat with the Flink community. You can use a [web-based IRC client](http://webchat.freenode.net/?channels=flink) for this.

**Check out [the community page](community.html) for all community-related information. If you want to contribute, make sure to have a look at the [contribution guide](how-to-contribute.html).**
</div>
</div>