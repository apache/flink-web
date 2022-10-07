---
authors:
- igalshilman: null
  name: Igal Shilman
  twitter: IgalShilman
- name: Tzu-Li (Gordon) Tai
  twitter: tzulitai
  tzulitai: null
categories: news
date: "2021-04-15T08:00:00Z"
subtitle: The Apache Flink community is happy to announce the release of Stateful
  Functions (StateFun) 3.0.0.
title: 'Stateful Functions 3.0.0: Remote Functions Front and Center'
---

The Apache Flink community is happy to announce the release of Stateful Functions (StateFun) 3.0.0!
Stateful Functions is a cross-platform stack for building Stateful Serverless applications, making it radically simpler
to develop scalable, consistent, and elastic distributed applications.

This new release brings **remote functions to the front and center of StateFun**, making the disaggregated setup that
separates the application logic from the StateFun cluster the default. It is now easier, more efficient, and more
ergonomic to write applications that live in their own processes or containers. With the new Java SDK this is now also
possible for all JVM languages, in addition to Python.

{% toc %}

## Background

Starting with the first StateFun release, before the project was donated to the Apache Software Foundation, our focus was: **making scalable stateful applications easy to build and run**. 
  
The first StateFun version introduced an SDK that allowed writing stateful functions that build up a StateFun application packaged and deployed as a particular Flink job submitted to a Flink cluster. Having functions executing within the same JVM as Flink has some advantages, such as the deployment's performance and immutability. However, it had a few limitations:

1. ❌ ⠀Functions can be written only in a JVM based language.
2. ❌ ⠀A blocking call/CPU heavy task in one function can affect other functions and operations that need to complete in a timely manner, such as checkpointing.
3. ❌ ⠀Deploying a new version of the function required a stateful upgrade of the backing Flink job.

With StateFun 2.0.0, the debut official release after the project was donated to Apache Flink, the community introduced the concept of *remote functions*, together with an additional SDK for the Python language.
A remote function is a function that executes in a separate process and is invoked via HTTP by the StateFun cluster processes.
Remote functions introduce a new and exciting capability: **state and compute disaggregation** - allowing users to scale the functions independently of the StateFun cluster, which essentially plays the role of handling messaging and state in a consistent and fault-tolerant manner.

While remote functions did address the limitations (1) and (2) mentioned above, we still had some room to improve: 

1. ❌ ⠀A stateful restart of the StateFun processes is required to register a new function or to change the state definitions of an existing function.
2. ❌ ⠀The SDK had a few friction points around state and messaging ergonomics - it had a heavy dependency on Google’s Protocol Buffers for it’s multi-language object representation.

As business requirements evolve, the application logic naturally evolves with it. For StateFun applications, this often means
typical changes such as adding new functions to the application or updating some existing functions to include new state to be persisted.
This is where the first limitation becomes an issue - such operations require a stateful restart of the StateFun cluster
in order for the changes to be discovered, meaning that *all* functions of the application would have some downtime for
this to take effect. With remote functions being standalone instances that are supposedly independent of the StateFun cluster processes,
this is obviously non-ideal. By making remote functions the default in StateFun, we're aiming at enabling full flexibility
and ease of operations for application upgrades.

The second limitation around state and messaging ergonomics had came up a few times from our users. Prior to this release,
all state values and message objects were strictly required to be Protobuf objects. This made it cumbersome to use common
types such as JSON or simple strings as state and messages.

With the new StateFun 3.0.0 release, the community has enhanced the remote functions protocol (the protocol that describes how StateFun communicates with the remote function processes) to address all the issues mentioned above.
Building on the new protocol, we rewrote the Python SDK and introduced a brand new remote Java SDK.

## New Features

### Unified Language SDKs

One of the goals that we set up to achieve with the SDKs is a unified set of concepts across all the languages.
Having standard and unified SDK concepts across the board makes it straightforward for users to switch the languages their
functions are implemented in.

Here is the same function written with the updated Python SDK and newly added Java SDK in StateFun 3.0.0:

#### Python

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

#### Java

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
* a unified cross-language way to send, receive, and store values across languages (see also *Cross-Language Type System* below).
* `ValueSpec` to describe the state name, type and possibly expiration configuration. Please note that it is no longer necessary to declare the state ahead of time in a `module.yaml`.

For a detailed SDK tutorial, we would like to encourage you to visit:

- [Java SDK showcase](https://github.com/apache/flink-statefun-playground/tree/release-3.0/java/showcase)
- [Python SDK showcase](https://github.com/apache/flink-statefun-playground/tree/release-3.0/python/showcase)

### Cross-Language Type System

StateFun 3.0.0 introduces a new type system with cross-language support for common primitive types, such as boolean,
integer, long, etc. This is of course all transparent for the user, so you don't need to worry about it. Functions
implemented in various languages (e.g. Java or Python) can message each other by directly sending supported primitive
values as message arguments. Moreover, the type system is used for state values as well - so, you can expect that a function
can safely read previous state after reimplementing it in a different language.

The type system is also very easily extensible to support custom message types, such as JSON or Protobuf messages.
StateFun makes this super easy by providing builder utilities to help you create custom types.

### Dynamic Registration of State and Functions

Starting with this release it is now possible to dynamically register new functions without going through a stateful upgrade cycle of the StateFun cluster (which entails the standard process of performing a stateful restart of a Flink job).
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

A new Java SDK was added for remote functions to extend the array of supported languages to also include all JVM based languages.
The language SDKs now have unified concepts and constructs in their APIs so that they will all feel familiar to work with
when switching around languages for your functions. In upcoming releases, the community is also looking forward to
continuing building on top of the new remote function protocol to provide an even more language SDKs, such as Golang.

## Release Resources

The binary distribution and source artifacts are now available on the updated [Downloads](https://flink.apache.org/downloads.html)
page of the Flink website, and the most recent Python SDK distribution is available on [PyPI](https://pypi.org/project/apache-flink-statefun/).
You can also find official StateFun Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-statefun).

For more details, check the [updated documentation]({{site.DOCS_BASE_URL}}flink-statefun-docs-release-3.0/) and the
[release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12348822)
for a detailed list of changes and new features if you plan to upgrade your setup to Stateful Functions 3.0.0.
We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists)
or [JIRA](https://issues.apache.org/jira/browse/)

## List of Contributors

The Apache Flink community would like to thank all contributors that have made this release possible:

```
Authuir, Chesnay Schepler, David Anderson, Dian Fu, Frans King, Galen Warren, Guillaume Vauvert, Igal Shilman, Ismaël Mejía, Kartik Khare, Konstantin Knauf, Marta Paes Moreira, Patrick Lucas, Patrick Wiener, Rafi Aroch, Robert Metzger, RocMarshal, Seth Wiesman, Siddique Ahmad, SteNicholas, Stephan Ewen, Timothy Bess, Tymur Yarosh, Tzu-Li (Gordon) Tai, Ufuk Celebi, abc863377, billyrrr, congxianqiu, danp11, hequn8128, kaibo, klion26, morsapaes, slinkydeveloper, wangchao, wangzzu, winder
```

If you’d like to get involved, we’re always [looking for new contributors](https://github.com/apache/flink-statefun#contributing).
