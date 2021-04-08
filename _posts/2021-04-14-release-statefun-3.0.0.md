---
layout: post
title:  "Stateful Functions 3.0.0 Release Announcement"
subtitle: "The Apache Flink community is happy to announce the release of Stateful Functions (StateFun) 3.0.0."
date: 2021-04-14T08:00:00.000Z
categories: news
authors:
- igalshilman:
  name: "Igal Shilman"
  twitter: "IgalShilman"
- tzulitai:
  name: "Tzu-Li (Gordon) Tai"
  twitter: "tzulitai"
---

The Apache Flink community is happy to announce the release of Stateful Functions (StateFun) 3.0.0!  This release focuses on bringing remote functions to the front and center of StateFun. It is now easier, more efficient, and more ergonomic to write applications that live in a separate process to the StateFun cluster.

The binary distribution and source artifacts are now available on the updated [Downloads](https://flink.apache.org/downloads.html)
page of the Flink website, and the most recent Python SDK distribution is available on [PyPI](https://pypi.org/project/apache-flink-statefun/).
You can also find official StateFun Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-statefun).

For more details, check the complete [release changelog](https://issues.apache.org/jira/secure/ReleaseNote.jspa?version=12348822&styleName=&projectId=12315522) 
and the [updated documentation](https://ci.apache.org/projects/flink/flink-statefun-docs-release-3.0/).
We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists)
or [JIRA](https://issues.apache.org/jira/browse/)!

{% toc %}

## Background

Starting with the very first StateFun release before the project was donated to the Apache Software Foundation, our focus was: **making scalable stateful applications easy to build and run**. 
  
The first StateFun version introduced an SDK that allowed writing stateful functions that build up a StateFun application, which is packaged and deployed as a very specific Flink job that is submitted to a Flink cluster. Having functions executing within the same JVM as Flink has some advantages such as performance and immutability of the deployment. However, it had a few limitations:

1. ❌ ⠀Functions can be written only in a JVM based language.
2. ❌ ⠀A blocking call/CPU heavy task in one function can affect other functions and operations that need to complete in a timely manner, such as checkpointing.
3. ❌ ⠀Deploying a new version of the function required a stateful upgrade of the backing Flink job.

With StateFun 2.0.0, the debut official release after the project was donated to Apache Flink, the community introduced the concept of “remote functions”, together with an additional SDK for the Python language.
A remote function is a function that executes in a separate process and is invoked via HTTP by Apache Flink.
Remote functions introduces a new and exciting capability: **state and compute disaggregation** - allowing users to scale the functions independently of the Flink cluster, which essentially plays the role of handling messaging and state in a consistent and fault-tolerant manner.

While remote functions did address the limitations (1) and (2) mentioned above, we still had some room to improve:
  
1. ✅ ⠀Functions can be written in any language (initially Python)
2. ✅ ⠀Blocking calls / CPU heavy computations happens in a separate process(es) 
3. ❌ ⠀Registering a new function, or changing the state definitions of an existing function required a stateful upgrade of the StateFun processes.
4. ❌ ⠀The SDK had a few friction points around state and messaging ergonomics - it had a heavy dependency on Google’s Protocol Buffers for it’s multi-language object representation.
 

With the new **StateFun 3.0** release, the community has enhanced the remote functions protocol (the protocol that describes how StateFun communicates with the remote processes) to address the issues above.
Building on the new protocol we rewrote the Python SDK, and introduced a brand new remote Java SDK.

## New Language SDKs

One of the goals that we set up to achieve with the new SDK is a unified set of concepts across all the languages. Here is the same function written in Python and Java:

### Python

```python
@functions.bind(typename="example/greeter", specs=[ValueSpec(name="visits", type=IntType)])
async def greeter(context: Context, message: Message):
    # update the visit count.
    visits = context.storage.visits or 0
    visits += 1
    context.storage.visits = visits

    # compute a greeting
    name = message.as_string()
    greeting = f"Hello there {name} at the {visits}th time!"

    caller = context.caller

    context.send(message_builder(target_typename=caller.typename,
                                 target_id=caller.id,
                                 str_value=greeting))
```

### Java

```java
static final class Greeter implements StatefulFunction {
    static final ValueSpec<Integer> VISITS = ValueSpec.named("visits").withIntType();

    @Override
    public CompletableFuture<Void> apply(Context context, Message message){
        // update the visits count
        int visits = context.storage().get(VISITS).orElse(0);
        visits++;
        context.storage().set(VISITS, visits);

        // compute a greeting
        var name = message.asUtf8String();
        var greeting = String.format("Hello there %s at the %d-th time!\n", name, visits);

        // reply to the caller with a greeting
        var caller = context.caller().get();
        context.send(
            MessageBuilder.forAddress(caller)
                .withValue(greeting)
                .build()
        );

        return context.done();
    }
}
```

Although there are some language specific differences, the terms and concepts are the same:

* an address scoped storage acting as a key-value store for a particular address.
* A unified cross-language way to send, receive, and store values across languages.
* `ValueSpec` to describe the state name, type and possibly expiration configuration. Please note that it is no longer necessary to declare the state ahead of time in a `module.yaml`.

    
For a detailed SDK tutorial, we would like to encourage you to visit:

- [Java SDK showcase](https://github.com/apache/flink-statefun-playground/tree/release-3.0/java/showcase)
- [Python SDK showcase](https://github.com/apache/flink-statefun-playground/tree/release-3.0/python/showcase)

## Dynamic Registration of State and Functions

Starting with this release, it is now possible to dynamically register new functions, without going through a stateful upgrade cycle of the StateFun cluster (which entails the standard process of performing a stateful restart of a Flink job).
This is achieved with a new `endpoint` definition that supports target URL templating.

Consider the following definition:

```yaml
endpoints:
    - endpoint:
        meta:
            kind: http
            spec:
        functions: example/*
        urlPathTemplate: https://loadbalancer.svc.cluster.local/{function.name}    
```

With this definition, all messages being addressed to functions under the namespace `example` will be forwarded to the specified templated URL.
For example, a message being addressed to a function of typename `example/greeter` would be forwarded to `https://loadbalancer.svc.cluster.local/greeter`.

This unlocks the possibility to dynamically introduce new functions into the topology without ever restarting the Stateful Functions application.

## Summary

With 3.0.0, we've brought remote functions to the front and center of StateFun. This is done by a new remote function protocol that:

1. ✅ ⠀Allows registering a new function or changing the state definitions of an existing function to happen dynamically without any downtime, and
2. ✅ ⠀Provides a cross-language type system, which comes along with a few built-in primitive types, that can be used for messaging and state.

Moreover, the language SDKs now have unified concepts and constructs in their APIs so that they will all feel familiar to work with when switching around languages for your functions. 
In upcoming releases, the community is also looking forward to continuing building on top of the new remote function protocol to provide an even wider array of language SDKs, such as Golang.

## Release Notes

Please review the [release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12348350)
for a detailed list of changes and new features if you plan to upgrade your setup to Stateful Functions 3.0.0.

## List of Contributors

The Apache Flink community would like to thank all contributors that have made this release possible:

```
Authuir, Chesnay Schepler, David Anderson, Dian Fu, Frans King, Galen Warren, Guillaume Vauvert, Igal Shilman, Ismaël Mejía, Kartik Khare, Konstantin Knauf, Marta Paes Moreira, Patrick Lucas, Patrick Wiener, Rafi Aroch, Robert Metzger, RocMarshal, Seth Wiesman, Siddique Ahmad, SteNicholas, Stephan Ewen, Timothy Bess, Tymur Yarosh, Tzu-Li (Gordon) Tai, Ufuk Celebi, abc863377, billyrrr, congxianqiu, danp11, hequn8128, kaibo, klion26, morsapaes, slinkydeveloper, wangchao, wangzzu, winder
```

If you’d like to get involved, we’re always [looking for new contributors](https://github.com/apache/flink-statefun#contributing).
