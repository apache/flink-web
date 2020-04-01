---
title: "Stateful Functions — Event-driven Applications on Apache Flink"
layout: base
---
<div class="row-fluid">

  <div class="col-sm-12">
    <p class="lead" markdown="span">
      **Stateful Functions — Event-driven Applications on Apache Flink<sup>®</sup>**
    </p>
    <p markdown="span">
    *A library for building and running distributed, stateful applications at any scale.*
    </p>
  </div>
<div class="col-sm-12">
  <hr />
</div>

</div>

## An API that simplifies building Distributed Stateful Applications

*Stateful Functions* is based on functions with persistent state that can interact dynamically with strong consistency guarantees.

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/stateful-functions/statefun-overview.png" width="650px"/>
</div>

<div class="jumbotron">
  <p style="font-size:110%;">A stateful function is a <span class="text-info">small piece of logic/code</span>, existing in many instances that represent entities, similar to actors. The functions is invoked through a message and are:</p>
 
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Stateful</b> Functions have embedded, fault-tolerant state, accessed locally like a variable.</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Virtual</b> Like FaaS, stateful functions don't reserve resources. Inactive functions don't consume CPU/Memory.</p>
  
  <p style="font-size:110%;">Applications are <span class="text-info">composed from multiple functions</span> that <span class="text-info">message each other</span>:</p>
    
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Exactly-once</b> State and messaging go hand-in-hand, providing exactly once message/state semantics.</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Logical Addressing</b> Functions message each other by logical addresses. No name resulution needed.</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Cyclic data flows</b> In contrast to stream processing, messaging patterns are not restricted to DAGs.</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Dynamic messaging</b> Messaging patterns are not required to be pre-defined in a dataflow API (as in stream processing).</p>
</div>

<hr />

## A Runtime built for Serverless Architectures

The Stateful Functions runtime is designed to provide a set of properties similar to what characterizes [serverless functions](https://martinfowler.com/articles/serverless.html), but applied to stateful problems.

<!-- Remote Execution -->
<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/stateful-functions/statefun-remote.png" width="650px"/>
</div>

<div class="jumbotron">
  <p style="font-size:110%;">The Stateful Functions runtime is built on Apache Flink<sup>®</sup> with the following design principles:</p>
 
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Logical Compute/State Co-location</b> Messaging, State-access, and Function Invocations are managed tightly together. This gives a high-level of consistence out-of-the-box.</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Optional Physical Compute/State Separation</b> Functions can be executed remotely, message and state access are provided as part of the invokation request. That way functions can be manages like stateless processes, and support rapid scaling, rolling upgrades, and other common operational patterns.</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Language independent</b> Function invocations use a simple HTTP/gRPC-based protocol so that Functions can be easily implemented in various languages.</p>
</div>

This design makes it possible to execute the stateful functions on a **FaaS platform**, a **Kubernetes deployment** or **behind a (micro)service**, while providing consistent state and lightweight messaging between functions.

<hr />

## Key Features at a Glance

<!-- Product Marketing Properties -->
<div class="row">
  <!-- Arbitrary Messaging -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop3.png" alt="Arbitrary Messaging" width="90" height="90">
      <h3>Arbitrary Messaging</h3>
    </div>
    <p align="justify">The API allows you to build and compose functions that communicate dynamic- and arbitrarily with each other. This gives you much more flexibility compared to the acyclic nature of classical stream processing topologies.</p>
    <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-statefun-docs-master/concepts/application-building-blocks.html#stateful-functions">Learn More</a></p>
  </div>
  <!-- Consistent State -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop1.png" alt="Consistent State" width="90" height="90">
      <h3>Consistent State</h3>
      <p align="justify">Functions can keep local state that is persistent and integrated with the messaging between functions. This gives you the effect of exactly-once state access/updates and guaranteed efficient messaging out-of-the-box.</p>
      <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-statefun-docs-master/concepts/application-building-blocks.html#persisted-states">Learn More</a></p>
    </div>
  </div>
  <!-- Multi-language Support -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop4.png" alt="Multi-language Support" width="90" height="90">
      <h3>Multi-language Support</h3>
    </div>
    <p align="justify">Functions can be implemented in any programming language that can handle HTTP requests or bring up a gRPC server, with initial support for Python. More SDKs will be added for languages like Go, Javascript and Rust.
    </p>
    <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-statefun-docs-master/sdk/modules.html#modules">Learn More</a></p>
  </div>
</div>

<hr />

<div class="row">
  <!-- No Database Required -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop5.png" alt="No Database Required" width="90" height="90">
      <h3>No Database Required</h3>
    </div>
    <p align="justify">State durability and fault tolerance build on Apache Flink’s robust distributed snapshots model. This requires nothing but a simple blob storage tier (e.g. S3, GCS, HDFS) to store the state snapshots.</p>
    <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-docs-stable/internals/stream_checkpointing.html">Learn More</a></p>
  </div>
  <!-- Cloud Native -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop6.png" alt="Ecosystem Integration" width="90" height="90">
      <h3>Cloud Native</h3>
    </div>
    <p align="justify">Stateful Function's approach to state and composition can be combined with the capabilities of modern serverless platforms like Kubernetes, Knative and AWS Lambda.</p>
    <p align="justify"><a href="">Learn More</a></p>
  </div>
  <!-- "Stateless" Operation -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop2.png" alt="Stateless Operation" width="90" height="90">
      <h3>"Stateless" Operation</h3>
    </div>
    <p align="justify">State access is part of the function invocation and so Stateful Functions applications behave like stateless applications that can be managed with the same simplicity and benefits, like rapid scalability, scale-to-zero and rolling/zero-downtime upgrades.
    </p>
    <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-statefun-docs-master/concepts/logical.html#function-lifecycle">Learn More</a></p>
  </div>
</div>

<hr />

<div class="jumbotron">
  <h2>An Example: Feature Engineering for Fraud Detection</h2>
  <div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/stateful-functions/model-score.svg" width="380px"/>
</div>
</div>

## Learn More

If you find these ideas interesting, give Stateful Functions a try and get involved! Check out the [Getting Started](https://ci.apache.org/projects/flink/flink-statefun-docs-master/getting-started/project-setup.html) section for introduction walkthroughs and the [documentation](https://ci.apache.org/projects/flink/flink-statefun-docs-master/) for a deeper look into the internals of Stateful Functions.

<hr />

<div class="row">
    <div class="col-sm-5">
      <h3>For a quick overview,</h3>
      watch <a href="https://youtu.be/fCeHCMJXXM0">this whiteboard session</a>.
    </div>
    <div class="col-sm-7">
      <div class="bs-example" data-example-id="responsive-embed-16by9-iframe-youtube">
        <div class="embed-responsive embed-responsive-16by9">
          <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/fCeHCMJXXM0" allowfullscreen></iframe>" allowfullscreen></iframe>
        </div>
      </div>
    </div>
</div>