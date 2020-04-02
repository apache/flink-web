---
title: "Stateful Functions — Event-driven Applications on Apache Flink"
layout: base
---
<div class="row-fluid">

  <div class="col-sm-12">
    <p class="lead" markdown="span">
      **Stateful Functions — Event-driven Applications on Apache Flink<sup>®</sup>**
    </p>
  </div>
<div class="col-sm-12">
  <hr />
</div>

</div>

Stateful Functions is an API that **simplifies building distributed stateful applications**. It's based on functions with persistent state that can interact dynamically with strong consistency guarantees.

<div style="line-height:60%;">
    <br>
</div>

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/stateful-functions/statefun-overview.png" width="650px"/>
</div>

### Stateful Functions Applications

A _stateful function_ is a small piece of logic/code existing in multiple instances that represent entities — similar to [actors](https://www.brianstorti.com/the-actor-model/). Functions are invoked through messages and are:

<div class="jumbotron" style="height:165px;padding-top: 18px;">
  <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Stateful</b></p> 
  <p style="font-size:100%;">Functions have embedded, fault-tolerant state, accessed locally like a variable.</p>
  <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Virtual</b></p> 
  <p style="font-size:100%;">Much like FaaS, functions don't reserve resources — inactive functions don't consume CPU/Memory.</p>
</div>

Applications are composed of _modules_ of multiple functions that can interact arbitrarily with:

<div class="jumbotron" style="height:235px;padding-top: 18px;">
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Exactly-once Semantics</b></p> 
    <p style="font-size:100%;">State and messaging go hand-in-hand, providing exactly-once message/state semantics.</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Logical Addressing</b></p> 
    <p style="font-size:100%;">Functions message each other by logical addresses. No name resulution needed.</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> Dynamic and Cyclic Messaging</b></p> 
    <p style="font-size:100%;">Messaging patterns don't need to be pre-defined as dataflows (<i>dynamic</i>) and are also not restricted to DAGs (<i>cyclic</i>).</p>
</div>

<hr />

## A Runtime built for Serverless Architectures

The Stateful Functions runtime is designed to provide a set of properties similar to what characterizes [serverless functions](https://martinfowler.com/articles/serverless.html), but applied to stateful problems.

<div style="line-height:60%;">
    <br>
</div>

<!-- Remote Execution -->
<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/stateful-functions/statefun-remote.png" width="600px"/>
</div>

The runtime is built on Apache Flink<sup>®</sup>, with the following design principles:

<div class="jumbotron" style="height:315px;padding-top: 18px;">
    <p style="font-size:100%;"><b>Logical Compute/State Co-location:</b></p> 
    <p style="font-size:100%;">Messaging, state access/updates and function invocations are managed tightly together. This ensures a high-level of consistency out-of-the-box.</p>
    <p style="font-size:100%;"><b>Physical Compute/State Separation:</b></p> 
    <p style="font-size:100%;">Functions can be executed remotely, with message and state access provided as part of the invocation request. This way, functions can be managed like stateless processes and support rapid scaling, rolling upgrades and other common operational patterns.</p>
    <p style="font-size:100%;"><b>Language Independence:</b></p> 
    <p style="font-size:100%;">Function invocations use a simple HTTP/gRPC-based protocol so that Functions can be easily implemented in various languages.</p>
</div>

This makes it possible to execute functions on a **Kubernetes deployment**, a **FaaS platform** or **behind a (micro)service**, while providing consistent state and lightweight messaging between functions.

<hr />

## Key Benefits

<div style="line-height:60%;">
    <br>
</div>

<!-- Product Marketing Properties -->
<div class="row">
  <!-- Arbitrary Messaging -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop3.png" alt="Arbitrary Messaging" width="90" height="90">
      <h3>Dynamic Messaging</h3>
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
    <p align="justify" href="https://thenewstack.io/10-key-attributes-of-cloud-native-applications/"><a href="">Learn More</a></p>
  </div>
  <!-- "Stateless" Operation -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop2.png" alt="Stateless Operation" width="90" height="90">
      <h3>"Stateless" Operation</h3>
    </div>
    <p align="justify">State access is part of the function invocation and so Stateful Functions applications behave like stateless processes that can be managed with the same simplicity and benefits, like rapid scalability, scale-to-zero and rolling/zero-downtime upgrades.
    </p>
    <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-statefun-docs-master/concepts/logical.html#function-lifecycle">Learn More</a></p>
  </div>
</div>

<hr />

## An Example: Feature Engineering for Fraud Detection

<div style="line-height:60%;">
    <br>
</div>

  <img src="{{ site.baseurl }}/img/stateful-functions/model-score.svg" width="350px"/>

<div style="line-height:150%;">
    <br>
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