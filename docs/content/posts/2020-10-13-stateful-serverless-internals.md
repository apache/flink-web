---
authors:
- name: Tzu-Li (Gordon) Tai
  twitter: tzulitai
  tzulitai: null
date: "2020-10-13T00:00:00Z"
excerpt: This blog post dives deep into the internals of the StateFun runtime, taking
  a look at how it enables consistent and fault-tolerant stateful serverless applications.
subtitle: A look at how Apache Flink Stateful Functions' runtime enables consistent
  and fault-tolerant stateful serverless applications
title: 'Stateful Functions Internals: Behind the scenes of Stateful Serverless'
---

Stateful Functions (StateFun) simplifies the building of distributed stateful applications by combining the best of two worlds:
the strong messaging and state consistency guarantees of stateful stream processing, and the elasticity and serverless experience of today's cloud-native architectures and
popular event-driven FaaS platforms. Typical StateFun applications consist of functions deployed behind simple services
using these modern platforms, with a separate StateFun cluster playing the role of an “[event-driven database](https://flink.apache.org/news/2020/04/07/release-statefun-2.0.0.html)”
that provides consistency and fault-tolerance for the functions' state and messaging.

But how exactly does StateFun achieve that? How does the StateFun cluster communicate with the functions?

This blog dives deep into the internals of the StateFun runtime. The entire walkthrough is complemented by a
[demo application](https://github.com/tzulitai/statefun-aws-demo/) which can be completely deployed on AWS services.
Most significantly, in the demo, the stateful functions are deployed and serviced using [AWS Lambda](https://aws.amazon.com/lambda/),
a popular FaaS platform among many others. The goal here is to allow readers to have a good grasp of the interaction between
the StateFun runtime and the functions, how that works cohesively to provide a Stateful Serverless experience, and how they can apply
what they've learnt to deploy their StateFun applications on other public cloud offerings such as GCP or Microsoft Azure.

{% toc %}

## Introducing the example: Shopping Cart

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
You can find the full code [here](https://github.com/tzulitai/statefun-aws-demo/blob/master/app/shopping_cart.py), which
uses StateFun's [Python SDK]({{< param DocsBaseUrl >}}flink-statefun-docs-master/sdk/python.html). Alternatively, if you are
unfamiliar with StateFun's API, you can check out this [earlier blog](https://flink.apache.org/2020/08/19/statefun.html)
on modeling applications and stateful entities using [StateFun's programming constructs]({{< param DocsBaseUrl >}}flink-statefun-docs-master/concepts/application-building-blocks.html).
</div>

Let’s first take a look at a high-level overview of the motivating demo for this blog post: a shopping cart application.
The diagram below covers the functions that build up the application, the state that the functions would keep, and the messages
that flow between them. We’ll be referencing this example throughout the blog post.

<center>
	<figure>
	<img src="{{< siteurl >}}/img/blog/2020-10-13-stateful-serverless-internals/shopping-cart-overview.png" width="600px" alt="Shopping cart application"/>
	<figcaption><i><b>Fig.1:</b> An overly simplified shopping cart application.</i></figcaption>
	</figure>
</center>
<br>

The application consists of two function types: a `cart` function and an `inventory` function.
Each instance of the `cart` function is associated with a single user entity, with its state being the items in the cart
for that user (`ItemsInCart`). In the same way, each instance of the `inventory` function represents a single inventory,
maintaining as state the number of items in stock (`NumInStock`) as well as the number of items reserved across all
user carts (`NumReserved`). Messages can be sent to function instances using their logical addresses, which consists
of the function type and the instance's entity ID, e.g. `(cart:Kim)` or `(inventory:socks)`.

There are two external messages being sent to and from the shopping cart application via ingresses and egresses:
`AddToCart`, which is sent to the ingress when an item is added to a user’s cart (e.g. sent by a front-end web application),
and `AddToCartResult`, which is sent back from our application to acknowledge the action.

`AddToCart` messages are handled by the `cart` function, which in turn invokes other functions to form the main logic of the application.
To keep things simple, only two messages between functions are demonstrated: `RequestItem`, sent from the `cart` function to the `inventory`
function, representing a request to reserve an item, and `ItemReserved`, which is a response from the inventory function to acknowledge the request.

## What happens in the Stateful Functions runtime?

Now that we understand the business logic of the shopping cart application, let's take a closer look at what keeps the state
of the functions and messages sent between them consistent and fault-tolerant: the StateFun cluster.

<figure style="float:right;padding-left:1px;padding-top: 0px">
  <img src="{{< siteurl >}}/img/blog/2020-10-13-stateful-serverless-internals/abstract-deployment.png" width="400px">
  <figcaption style="padding-top: 10px;text-align:center"><i><b>Fig.2:</b> Simplified view of a StateFun app deployment.</i></figcaption>
</figure>

The StateFun runtime is built on-top of Apache Flink, and applies the same battle-tested technique that Flink uses as the
basis for strongly consistent stateful streaming applications - <i><b>co-location of state and messaging</b></i>.
In a StateFun application, all messages are routed through the StateFun cluster, including messages sent from ingresses,
messages sent between functions, and messages sent from functions to egresses. Moreover, the state of all functions is
maintained in the StateFun cluster as well. Like Flink, the message streams flowing through the StateFun cluster and
function state are co-partitioned so that compute has local state access, and any updates to the state can be handled
atomically with computed side-effects, i.e. messages to send to other functions.

In more solid terms, take for example a message that is targeted for the logical address `(cart, "Kim")` being routed
through StateFun. Logical addresses are used in StateFun as the partitioning key for both message streams and state, so
that the resulting StateFun cluster partition that this message ends up in will have the state for `(cart, "Kim")`
locally available.

The only difference here for StateFun, compared to Flink, is that the actual compute doesn't happen within the StateFun
cluster partitions - <i><b>computation happens remotely in the function services</b></i>. So how does StateFun
route input messages to the remote function services and provide them with state access, all the while
preserving the same consistency guarantees as if state and compute were co-located?

### Remote Invocation Request-Reply Protocol

A StateFun cluster partition communicates with the functions using a slim and well-defined request-reply protocol, as
illustrated in **Fig. 3**. Upon receiving an input message, the cluster partition invokes the target functions via their
HTTP service endpoint. The service request body carries input events and current state for the functions, retrieved from
local state. Any outgoing messages and state mutations as a result of invocations are sent back through StateFun as part
of the service response. When the StateFun cluster partition receives the response, all state mutations are written back
to local state and outgoing messages are routed to other cluster partitions, which in turn invokes other function
services.

<center>
	<figure>
	<img src="{{< siteurl >}}/img/blog/2020-10-13-stateful-serverless-internals/request-reply-protocol.png" width="750px"/>
	<figcaption><i><b>Fig.3:</b> The remote invocation request/reply protocol.</i></figcaption>
	</figure>
</center>
<br>

Under the hood, StateFun SDKs like the Python SDK and other [3rd party SDKs for other languages]({{< param DocsBaseUrl >}}flink-statefun-docs-master/sdk/external.html)
all implement this protocol. From the user's perspective, they are programming with state local to their function deployment,
whereas in reality, state is maintained in StateFun and supplied through this protocol. It is easy to add more language SDKs,
as long as the language can handle HTTP requests and responses.

### Function state consistency and fault-tolerance

The runtime makes sure that only one invocation per function instance (e.g. `(cart, "Kim")`) is ongoing at any point in
time (i.e. invocations per entity are serial). If an invocation is ongoing while new messages for the same function
instance arrives, the messages are buffered in state and sent as a single batch as soon as the ongoing invocation completes.

In addition, since each request happens in complete isolation and all relevant information is encapsulated in each
request and response, <i><b>function invocations are effectively idempotent</b></i>
(i.e. results depend purely on the provided context of the invocation) and can be retried. This naturally avoids
violating consistency in case any function service hiccups occur.

For fault tolerance, all function state managed in the StateFun cluster is periodically and asynchronously checkpointed
to a blob storage (e.g. HDFS, S3, GCS) using Flink’s [original distributed snapshot mechanism]({{< param DocsBaseUrl >}}flink-docs-master/concepts/stateful-stream-processing.html#checkpointing).
These checkpoints contain <i><b>a globally consistent view of state across all functions of the application</b></i>,
including the offset positions in ingresses and the ongoing transaction state in egresses. In the case of an abrupt failure,
the system may restore from the latest available checkpoint: all function states will be restored and all events between
the checkpoint and the crash will be re-processed (and the functions re-invoked) with identical routing, all as if the failure
never happened.

### Step-by-step walkthrough of function invocations

Let's conclude this section by going through the actual messages that flow between StateFun and the functions in our shopping
cart demo application!

<strong>Customer "Kim" puts 2 socks into his shopping cart (Fig. 4):</strong>

<center>
	<figure>
	<img src="{{< siteurl >}}/img/blog/2020-10-13-stateful-serverless-internals/protocol-walkthrough-1.png" width="750px"/>
	<figcaption><i><b>Fig.4:</b> Message flow walkthrough.</i></figcaption>
	</figure>
</center>
<br>

* An event `AddToCart("Kim", "socks", 2)` comes through one of the ingress partitions <b>`(1)`</b>. The ingress event router is
configured to route `AddToCart` events to the function type `cart`, taking the user ID (`"Kim"`) as the instance ID. The
function type and instance ID together define the logical address of the target function instance for the event `(cart:Kim)`.

* Let's assume the event is read by StateFun partition B, but the `(cart:Kim)` address is owned by partition A.
The event is thus routed to partition A <b>`(2)`</b>.

* StateFun Partition A receives the event and processes it:
  - First, the runtime fetches the state for `(cart:Kim)` from the local state store, i.e. the existing items in Kim’s cart <b>`(3)`</b>.
  - Next, it marks `(cart:Kim)` as <i>"busy"</i>, meaning an invocation is happening. This buffers other messages targeted for
  `(cart:Kim)` in state until this invocation is completed.
  - The runtime grabs a free HTTP client connection and sends a request to the `cart` function type's service endpoint.
  The request contains the `AddToCart("Kim", "socks", 2)` message and the current state for `(cart:Kim)` <b>`(4)`</b>.
  - The remote `cart` function service receives the event and attempts to reserve socks with the `inventory` function.
  Therefore, it replies to the invocation with a new message `RequestItem("socks", 2)` targeted at the address `(inventory:socks)`.
  Any state modifications will be included in the response as well, but in this case there aren’t any state modifications yet
  (i.e. Kim’s cart is still empty until a reservation acknowledgement is received from the inventory service) <b>`(5)`</b>.
  - The StateFun runtime receives the response, routes the `RequestItem` message to other partitions,
  and marks `(cart:Kim)` as <i>"available"</i> again for invocation.


* Assuming that the `(inventory:socks)` address is owned by partition B, the message is routed to partition B <b>`(6)`</b>.

* Once partition B receives the `RequestItem` message, the runtime invokes the function `(inventory:socks)` in the same
way as described above, and receives a reply with a modification of the state of the inventory (the number of reserved socks is now increased by 2).
`(inventory:socks)` now also wants to reply reservation of 2 socks for Kim, so an `ItemReserved("socks", 2)`
message targeted for `(cart:Kim)` is also included in the response <b>`(7)`</b>, which will again be routed by the StateFun runtime.

## Stateful Serverless in the Cloud with FaaS and StateFun

We'd like to wrap up this blog by re-emphasizing how the StateFun runtime works well with cloud-native
architectures, and provide an overview of what your complete StateFun application deployment would look like
using public cloud services.

As you've already learnt in previous sections, invocation requests themselves are stateless, with all necessary information
for an invocation included in the HTTP request (i.e. input events and state access), and all side-effects of the invocation
included in the HTTP response (i.e. outgoing messages and state modifications).

<figure style="float:right;padding-left:1px;padding-top: 0px">
  <img src="{{< siteurl >}}/img/blog/2020-10-13-stateful-serverless-internals/aws-deployment.png" width="450px">
  <figcaption style="padding-top: 10px;text-align:center"><i><b>Fig.5:</b> Complete deployment example on AWS.</i></figcaption>
</figure>

A natural consequence of this characteristic is that there is no session-related dependency between individual HTTP
requests, making it very easy to horizontally scale the function deployments. This makes it very easy to deploy your
stateful functions using FaaS platforms solutions, allowing them to rapidly scale out, scale to zero, or be upgraded
with zero-downtime.

In our complementary demo code, you can find [here](https://github.com/tzulitai/statefun-aws-demo/blob/master/app/shopping_cart.py#L49)
the exact code on how to expose and service StateFun functions through AWS Lambda. Likewise, this is possible for any other
FaaS platform that supports triggering the functions using HTTP endpoints (and other transports as well in the future).

**Fig. 5** on the right illustrates what a complete AWS deployment of a StateFun application would look like, with functions
serviced via AWS Lambda, AWS Kinesis streams as ingresses and egresses, AWS EKS managed Kubernetes cluster to run the
StateFun cluster, and an AWS S3 bucket to store the periodic checkpoints. You can also follow the
[instructions](https://github.com/tzulitai/statefun-aws-demo#running-the-demo) in the demo code to try it out and deploy this yourself right away!

---

If you’d like to learn more about Stateful Functions, head over to the [official documentation]({{< param DocsBaseUrl >}}flink-statefun-docs-master/), where you can also find more hands-on tutorials to try out yourself!
