---
authors:
- name: Stephan Ewen
  stephan: null
  twitter: stephanewen
categories: news
date: "2020-04-07T08:00:00Z"
subtitle: Making the Stream Processor for Event-driven Applications what the Database
  was to CRUD Applications
title: Stateful Functions 2.0 - An Event-driven Database on Apache Flink
---

Today, we are announcing the release of Stateful Functions (StateFun) 2.0 — the first release of Stateful Functions as part of the Apache Flink project.
This release marks a big milestone: Stateful Functions 2.0 is not only an API update, but the **first version of an event-driven database** that is built on Apache Flink.

Stateful Functions 2.0 makes it possible to combine StateFun’s powerful approach to state and composition with the elasticity, rapid scaling/scale-to-zero and rolling upgrade capabilities of FaaS implementations like AWS Lambda and modern resource orchestration frameworks like Kubernetes. 

With these features, Stateful Functions 2.0 addresses [two of the most cited shortcomings](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2019/EECS-2019-3.pdf) of many FaaS setups today: consistent state and efficient messaging between functions.

{% toc %}


## An Event-driven Database

When Stateful Functions joined Apache Flink at the beginning of this year, the project had started as a library on top of Flink to build general-purpose event-driven applications. Users would implement _functions_ that receive and send messages, and maintain state in persistent variables. Flink provided the runtime with efficient exactly-once state and messaging. Stateful Functions 1.0 was a FaaS-inspired mix between stream processing and actor programming — on steroids.

<div style="line-height:60%;">
    <br>
</div>

<center>
	<figure>
	<img src="{{< siteurl >}}/img/blog/2020-04-07-release-statefun-2.0.0/image2.png" width="600px" alt="Statefun 1"/>
	<br/><br/>
	<figcaption><i><b>Fig.1:</b> A ride-sharing app as a Stateful Functions example.</i></figcaption>
	</figure>
</center>

<div style="line-height:150%;">
    <br>
</div>

In version 2.0, Stateful Functions now physically decouples the functions from Flink and the JVM, to invoke them through simple services. That makes it possible to execute functions on a FaaS platform, a Kubernetes deployment or behind a (micro) service. 

Flink invokes the functions through a service endpoint via HTTP or gRPC based on incoming events, and supplies state access. The system makes sure that only one invocation per entity (`type`+`ID`) is ongoing at any point in time, thus guaranteeing consistency through isolation.
By supplying state access as part of the function invocation, the functions themselves behave like stateless applications and can be managed with the same simplicity and benefits: rapid scalability, scale-to-zero, rolling/zero-downtime upgrades and so on.

<center>
	<figure>
	<img src="{{< siteurl >}}/img/blog/2020-04-07-release-statefun-2.0.0/image5.png" width="600px" alt="Statefun 2"/>
	<br/><br/>
	<figcaption><i><b>Fig.2:</b> In Stateful Functions 2.0, functions are stateless and state access is part of the function invocation.</i></figcaption>
	</figure>
</center>

<div style="line-height:150%;">
    <br>
</div>

The functions can be implemented in any programming language that can handle HTTP requests or bring up a gRPC server. The [StateFun project](https://github.com/apache/flink-statefun) includes a very slim SDK for Python, taking requests and dispatching them to annotated functions. We aim to provide similar SDKs for other languages, such as Go, JavaScript or Rust. Users do not need to write any Flink code (or JVM code) at all; data ingresses/egresses and function endpoints can be defined in a compact YAML spec.

<div style="line-height:60%;">
    <br>
</div>

<div class="row">
  <div class="col-lg-6">
    <div class="text-center">
      <figure>
		<img src="{{< siteurl >}}/img/blog/2020-04-07-release-statefun-2.0.0/image3.png" width="600px" alt="Statefun 3"/>
		<br/><br/>
		<figcaption><i><b>Fig.3:</b> A module declaring a remote endpoint and a function type.</i></figcaption>
	  </figure>
    </div>
  </div>
  <div class="col-lg-6">
    <div class="text-center">
      <figure>
      	<div style="line-height:540%;">
    		<br>
		</div>
		<img src="{{< siteurl >}}/img/blog/2020-04-07-release-statefun-2.0.0/image10.png" width="600px" alt="Statefun 4"/>
		<br/><br/>
		<figcaption><i><b>Fig.4:</b> A Python implementation of a simple classifier function.</i></figcaption>
	  </figure>
    </div>
  </div>
</div>

<div style="line-height:150%;">
    <br>
</div>

The Flink processes (and the JVM) are not executing any user-code at all — though this is possible, for performance reasons (see [Embedded Functions](#embedded-functions)). Rather than running application-specific dataflows, Flink here stores the state of the functions and provides the dynamic messaging plane through which functions message each other, carefully dispatching messages/invocations to the event-driven functions/services to maintain consistency guarantees.

> _Effectively, Flink takes the role of the database, but tailored towards event-driven functions and services. 
> It integrates state storage with the messaging between (and the invocations of) functions and services. 
> Because of this, Stateful Functions 2.0 can be thought of as an “Event-driven Database” on Apache Flink._

## “Event-driven Database” vs. “Request/Response Database”

In the case of a traditional database or key/value store (let’s call them request/response databases), the application issues queries to the database (e.g. SQL via JDBC, GET/PUT via HTTP). In contrast, an event-driven database like StateFun **_inverts_** that relationship between database and application: the database invokes the functions/services based on arriving messages. This fits very naturally with FaaS and many event-driven application architectures.

<div style="line-height:60%;">
    <br>
</div>

<center>
	<figure>
	<img src="{{< siteurl >}}/img/blog/2020-04-07-release-statefun-2.0.0/image7.png" width="600px" alt="Statefun 5"/>
	<br/><br/>
	<figcaption><i><b>Fig.5:</b> Stateful Functions 2.0 inverts the relationship between database and application.</i></figcaption>
	</figure>
</center>

<div style="line-height:150%;">
    <br>
</div>

In the case of applications built on request/response databases, the database is responsible only for the state. Communication between different functions/services is a separate concern handled within the application layer. In contrast to that, an event-driven database takes care of both state storage and message transport, in a tightly integrated manner.

Similar to [Actor Programming](https://www.brianstorti.com/the-actor-model/), Stateful Functions uses the idea of _addressable entities_ - here, the entity is a function ``type`` with an invocation scoped to an ``ID``. These addressable entities own the state and are the targets of messages. Different to actor systems is that the application logic is external and the addressable entities are not physical objects in memory (i.e. actors), but rows in Flink's managed state, together with the entities’ mailboxes.

### State and Consistency

Besides matching the needs of serverless applications and FaaS well, the event-driven database approach also helps with simplifying consistent state management.

Consider the example below, with two entities of an application — for example two microservices (_Service 1_, _Service 2_). _Service 1_ is invoked, updates the state in the database, and sends a request to _Service 2_. Assume that this request fails. There is, in general, no way for _Service 1_ to know whether _Service 2_ processed the request and updated its state or not (c.f. [Two Generals Problem](https://en.wikipedia.org/wiki/Two_Generals%27_Problem)). To work around that, many techniques exist — making requests idempotent and retrying, commit/rollback protocols, or external transaction coordinators, for example. Solving this in the application layer is complex enough, and including the database into these approaches only adds more complexity.

In the scenario where the event-driven database takes care of state and messaging, we have a much easier problem to solve. Assume one shard of the database receives the initial message, updates its state, invokes _Service 1_, and routes the message produced by the function to another shard, to be delivered to _Service 2_. Now assume message transport errored — it may have failed or not, we cannot know for certain. Because the database is in charge of state and messaging, it can offer a generic solution to make sure that either both go through or none does, for example through transactions or [consistent snapshots](https://dl.acm.org/doi/abs/10.14778/3137765.3137777). The application functions are stateless and their invocations without side effects, which means they can be re-invoked again without implications on consistency.

<div style="line-height:60%;">
    <br>
</div>

<center>
	<figure>
	<img src="{{< siteurl >}}/img/blog/2020-04-07-release-statefun-2.0.0/image8.png" width="600px" alt="Statefun 6"/>
	<br/><br/>
	<figcaption><i><b>Fig.6:</b> The event-driven database integrates state access and messaging, guaranteeing consistency.</i></figcaption>
	</figure>
</center>

<div style="line-height:150%;">
    <br>
</div>

That is the big lesson we learned from working on stream processing technology in the past years: **state access/updates and messaging need to be integrated**. This gives you consistency, scalable behavior and backpressures well based on both state access and compute bottlenecks.

Despite state and computation being physically separated here, the scheduling/dispatching of function invocations is still integrated and physically co-located with state access, preserving the consistency guarantees given by physical state/compute co-location.

## Remote, Co-located or Embedded Functions

Functions can be deployed in various ways that trade off loose coupling and independent scaling with performance overhead. Each module of functions can be of a different kind, so some functions can run remote, while others could run embedded.

### Remote Functions

_Remote Functions_ are the mechanism described so far, where functions are deployed separately from the Flink StateFun cluster. The state/messaging tier (i.e. the Flink processes) and the function tier can be deployed and scaled independently. All function invocations are remote and have to go through the endpoint service.

<div style="line-height:60%;">
    <br>
</div>

<center>
<img src="{{< siteurl >}}/img/blog/2020-04-07-release-statefun-2.0.0/image6.png" width="600px" alt="Statefun 7"/>
</center>

<div style="line-height:150%;">
    <br>
</div>

In a similar way as databases are accessed via a standardized protocol (e.g. ODBC/JDBC for relational databases, REST for many key/value stores), StateFun 2.0 invokes functions and services through a standardized protocol: HTTP or gRPC with data in a well-defined ProtoBuf schema.

### Co-located Functions

An alternative way of deploying functions is _co-location_ with the Flink JVM processes. In such a setup, each Flink TaskManager would talk to one function process sitting “next to it”. A common way to do this is to use a system like Kubernetes and deploy pods consisting of a Flink container and the function container that communicate via the pod-local network.

This mode supports different languages while avoiding to route invocations through a Service/Gateway/LoadBalancer, but it cannot scale the state and compute parts independently.

<div style="line-height:60%;">
    <br>
</div>

<center>
<img src="{{< siteurl >}}/img/blog/2020-04-07-release-statefun-2.0.0/image9.png" width="600px" alt="Statefun 8"/>
</center>

<div style="line-height:150%;">
    <br>
</div>

This style of deployment is similar to how [Apache Beam’s portability layer](https://beam.apache.org/roadmap/portability/) and [Flink’s Python API]({{ site.docs-stable }}/tutorials/python_table_api.html) deploy their non-JVM language SDKs.

### Embedded Functions

_Embedded Functions_ are the mode of Stateful Functions 1.0 and Flink’s Java/Scala stream processing APIs. Functions are deployed into the JVM and are directly invoked with the messages and state access. This is the most performant way, though at the cost of only supporting JVM languages.

<div style="line-height:60%;">
    <br>
</div>

<center>
<img src="{{< siteurl >}}/img/blog/2020-04-07-release-statefun-2.0.0/image11.png" width="600px" alt="Statefun 9"/>
</center>

<div style="line-height:150%;">
    <br>
</div>

Following the database analogy, embedded functions are a bit like _stored procedures_, but in a principled way: the functions here are normal Java/Scala/Kotlin functions implementing standard interfaces and can be developed or tested in any IDE.

## Loading Data into the Database

When building a new stateful application, you usually don’t start from a completely blank slate. Often, the application has initial state, such as initial “bootstrap” state, or state from previous versions of the application. When using a database, one could simply bulk load the data to prepare the application.

The equivalent step for Flink would be to write a [savepoint]({{ site.docs-stable }}/ops/state/savepoints.html) that contains the initial state. Savepoints are snapshots of the state of the distributed stream processing application and can be passed to Flink to start processing from that state. Think of them as a database dump, but of a distributed streaming database. In the case of StateFun, the savepoint would contain the state of the functions.

To create a savepoint for a Stateful Functions program, check out the [State Bootstrapping API]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.0/deployment-and-operations/state-bootstrap.html) that is part of StateFun 2.0. The State Bootstrapping API uses Flink’s [DataSet API]({{ site.docs-stable }}/dev/batch/), but we plan to expand this to use SQL in the next versions.

## Try it out and get involved!

We hope that we could convey some of the excitement we feel about Stateful Functions. If we managed to pique your curiosity, try it out — for example, starting with [this walkthrough]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.0/getting-started/python_walkthrough.html).

The project is still in a comparatively early stage, so if you want to get involved, there is lots to work on: SDKs for other languages (e.g. Go, JavaScript, Rust), ingresses/egresses and tools for testing, among others.

To follow the project and learn more, please check out these resources:

* Code: [https://github.com/apache/flink-statefun](https://github.com/apache/flink-statefun)
* Docs: [{{< param DocsBaseUrl >}}flink-statefun-docs-release-2.0/]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.0/)
* Apache Flink project site: [https://flink.apache.org/](https://flink.apache.org/)
* Apache Flink on Twitter: [@ApacheFlink](https://twitter.com/apacheflink)
* Stateful Functions Webpage: [https://statefun.io](https://statefun.io)
* Stateful Functions on Twitter: [@StateFun_IO](https://twitter.com/statefun_io)

## Thank you!

The Apache Flink community would like to thank all contributors that have made this release possible:

David Anderson, Dian Fu, Igal Shilman, Seth Wiesman, Stephan Ewen, Tzu-Li (Gordon) Tai, hequn8128


