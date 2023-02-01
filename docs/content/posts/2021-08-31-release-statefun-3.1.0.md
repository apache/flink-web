---
authors:
- name: Seth Wiesman
  sjwiesman: null
  twitter: sjwiesman
- igalshilman: null
  name: Igal Shilman
  twitter: IgalShilman
- name: Tzu-Li (Gordon) Tai
  twitter: tzulitai
  tzulitai: null
date: "2021-08-31T08:00:00Z"
subtitle: The Apache Flink community is happy to announce the release of Stateful
  Functions (StateFun) 3.1.0.
title: Stateful Functions 3.1.0 Release Announcement
---

Stateful Functions is a cross-platform stack for building Stateful Serverless applications, making it radically simpler to develop scalable, consistent, and elastic distributed applications.
This new release brings various improvements to the StateFun runtime, a leaner way to specify StateFun module components, and a brand new GoLang SDK! 

The binary distribution and source artifacts are now available on the updated [Downloads](https://flink.apache.org/downloads.html)
page of the Flink website, and the most recent Java SDK, Python SDK, and GoLang SDK distributions are available on [Maven](https://search.maven.org/artifact/org.apache.flink/statefun-sdk-java/3.1.0/jar), [PyPI](https://pypi.org/project/apache-flink-statefun/), and [Github](https://github.com/apache/flink-statefun/tree/statefun-sdk-go/v3.1.0) repecitvely.
You can also find official StateFun Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-statefun).

For more details, check the complete [release changelog](https://issues.apache.org/jira/secure/ReleaseNote.jspa?version=12350038&projectId=12315522) 
and the [updated documentation]({{< param DocsBaseUrl >}}flink-statefun-docs-release-3.0/).
We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists)
or [JIRA](https://issues.apache.org/jira/browse/)!

{% toc %}

## New Features 

### Delayed Message Cancellation

Stateful Functions communicate by sending messages, but sometimes it is helpful that a function will send a message for itself.
For example, you may want to set a time limit on a customer onboarding flow to complete.
This can easily be implmented by sending a message with a delay.
But up until now, there was no way to indicate to the StateFun runtime that a particular delayed message is not necessary anymore (a customer had completed their onboarding flow).
With StateFun 3.1, it is now possible to cancel a delayed message.

```python
...
context.send_after(timedelta(days=3),
                  message_builder(target_typename="fns/onboarding",
                                  target_id="user-1234",
                                  str_value="send a reminder email"),
                  cancellation_token="flow-1234")
...
```

To cancel the message at a later time, simply call 

```python
context.cancel_delayed_message("flow-1234")
```

Please note that a message cancellation occurs on a best-effort basis, as the message might have already been delivered or enqueued for immediate delivery on a remote worker’s mailbox.

### New way to specify components 

StateFun applications consist of multiple configuration components, including remote function endpoints, along with ingress and egress definitions, defined in a YAML format. 
We've added a new structure that treats each StateFun component as a standalone YAML document in this release.
Thus, a `module.yaml` file becomes simply a collection of components.

```yaml
kind: io.statefun.endpoints.v2/http
spec:
  functions: com.example/*
  urlPathTemplate: https://bar.foo.com/{function.name}
---
kind: io.statefun.kafka.v1/ingress
spec:
  id: com.example/my-ingress
  address: kafka-broker:9092
  consumerGroupId: my-consumer-group
  topics:
    - topic: message-topic
      valueType: io.statefun.types/string
      targets:
        - com.example/greeter
---
kind: io.statefun.kafka.v1/egress
spec:
  id: com.example/my-egress
  address: kafka-broker:9092
  deliverySemantic:
    type: exactly-once
    transactionTimeout: 15min
---
```

While this might seem like a minor cosmetic improvement, this change opens the door to more flexible configuration management options in future releases - such as managing each component as a custom K8s resource definition or even behind a REST API. StateFun still supports the legacy module format in version 3.0 for backward compatibility, but users are encouraged to upgrade. 
The community is providing an [automated migration tool](https://github.com/sjwiesman/statefun-module-upgrade) to ease the transition. 

### Pluggable transport for remote function invocations
It is possible to plugin a custom mechanism that invokes a remote stateful function starting with this release.
Users who wish to use a customized transport need to register it as an extension and later reference it straight from the endpoint component definition.

For example:

```yaml
kind: io.statefun.endpoints.v2/http
spec:
 functions: com.foo.bar/*
 urlPathTemplate: https://{function.name}/
 maxNumBatchRequests: 10000
 transport:
   type: com.foo.bar/pubsub
   some_property1: some_value1
```

For a complete example of a custom transport you can start exploring [here](https://github.com/apache/flink-statefun/blob/release-3.1.0/statefun-flink/statefun-flink-core/src/main/java/org/apache/flink/statefun/flink/core/nettyclient/NettyTransportModule.java).
Along with a reference usage over [here](https://github.com/apache/flink-statefun/blob/release-3.1.0/statefun-e2e-tests/statefun-smoke-e2e-java/src/test/resources/remote-module/module.yaml#L21-L22 ).

### Asynchronous, non blocking remote function invocation (beta)

For this release we’ve included a new transport implementation (opt in for this release) that is implemented on top of the asynchronous Netty framework.
This transport enables much higher resource utilization, higher throughput, and lower remote function invocation latency.

To enable this new transport, set the transport type to be `io.statefun.transports.v1/async`
Like in the following example:

```yaml
kind: io.statefun.endpoints.v2/http
spec:
 functions: fns/*
 urlPathTemplate: https://api-gateway.foo.bar/{function.name}
 maxNumBatchRequests: 10000
 transport:
   type: io.statefun.transports.v1/async
   call: 2m
   connect: 20s
```

Take it for a spin!


### A brand new GoLang SDK

Stateful Functions provides a unified model for building stateful applications across various programming languages and deployment environments.
The community is thrilled to release an official GoLang SDK as part of the 3.1.0 release. 

```go
import (
  "fmt"
  "github.com/apache/flink-statefun/statefun-sdk-go/v3/pkg/statefun"
  "net/http"
)
 
type Greeter struct {
  SeenCount statefun.ValueSpec
}
 
func (g *Greeter) Invoke(ctx statefun.Context, message statefun.Message) error {
  storage := ctx.Storage()
 
  // Read the current value of the state
  // or zero value if no value is set
  var count int32
  storage.Get(g.SeenCount, &count)
 
  count += 1
 
  // Update the state which will
  // be made persistent by the runtime
  storage.Set(g.SeenCount, count)
 
  name := message.AsString()
  greeting := fmt.Sprintf("Hello there %s at the %d-th time!\n", name, count)
 
  ctx.Send(statefun.MessageBuilder{
     Target:    *ctx.Caller(),
     Value:     greeting,
  })
 
  return nil
}
 
 
func main() {
  greeter := &Greeter{
     SeenCount: statefun.ValueSpec{
        Name:      "seen_count",
        ValueType: statefun.Int32Type,
     },
  }
 
  builder := statefun.StatefulFunctionsBuilder()
  _ = builder.WithSpec(statefun.StatefulFunctionSpec{
     FunctionType: statefun.TypeNameFrom("com.example.fns/greeter"),
     States:       []statefun.ValueSpec{greeter.SeenCount},
     Function:     greeter,
  })
 
  http.Handle("/statefun", builder.AsHandler())
  _ = http.ListenAndServe(":8000", nil)
}
```

As with the Python and Java SDKs, the Go SDK includes:

  - An address scoped storage acting as a key-value store for a particular address.
  - A unified cross-language way to send, receive and store values across languages.
  - Dynamic `ValueSpec` to describe the state name, type, and possibly expiration configuration at runtime.

You can get started by adding the SDK to your `go.mod` file. 

`require github.com/apache/flink-statefun/statefun-sdk-go/v3 v3.1.0`

For a detailed SDK tutorial, we would like to encourage you to visit: 

  - [GoLang SDK Showcase](https://github.com/apache/flink-statefun-playground/tree/release-3.1/go/showcase)
  - [GoLang Greeter](https://github.com/apache/flink-statefun-playground/tree/release-3.1/go/greeter)
  - [GoLang SDK Documentation]({{< param DocsBaseUrl >}}flink-statefun-docs-release-3.1/docs/sdk/golang/)

## Release Notes

## Release Notes

Please review the [release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?version=12350038&projectId=12315522)
for a detailed list of changes and new features if you plan to upgrade your setup to Stateful Functions 3.1.0.

## List of Contributors

Evans Ye, George Birbilis, Igal Shilman, Konstantin Knauf, Seth Wiesman, Siddique Ahmad, Tzu-Li (Gordon) Tai, ariskk, austin ce

If you’d like to get involved, we’re always [looking for new contributors](https://github.com/apache/flink-statefun#contributing).
