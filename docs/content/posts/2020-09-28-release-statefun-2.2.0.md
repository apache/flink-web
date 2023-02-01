---
authors:
- name: Tzu-Li (Gordon) Tai
  twitter: tzulitai
  tzulitai: null
- igalshilman: null
  name: Igal Shilman
  twitter: IgalShilman
date: "2020-09-28T08:00:00Z"
title: Stateful Functions 2.2.0 Release Announcement
---

The Apache Flink community is happy to announce the release of Stateful Functions (StateFun) 2.2.0! This release
introduces major features that extend the SDKs, such as support for asynchronous functions in the Python SDK, new
persisted state constructs, and a new SDK that allows embedding StateFun functions within a Flink DataStream job.
Moreover, we've also included important changes that improve out-of-the-box stability for common workloads,
as well as increased observability for operational purposes.

We've also seen new 3rd party SDKs for StateFun being developed since the last release. While they are not part of the
release artifacts, it's great seeing these community-driven additions! We've highlighted these efforts below
in this announcement.

The binary distribution and source artifacts are now available on the updated [Downloads](https://flink.apache.org/downloads.html)
page of the Flink website, and the most recent Python SDK distribution is available on [PyPI](https://pypi.org/project/apache-flink-statefun/).
For more details, check the complete [release changelog](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12348350)
and the [updated documentation]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.2/).
We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists)
or [JIRA](https://issues.apache.org/jira/browse/)!
{% toc %}

## New Features

### Asynchronous functions in Python SDK

This release enables registering asynchronous Python functions as stateful functions by introducing a new handler
in the [Python SDK]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.2/sdk/python.html): ``AsyncRequestReplyHandler``.
This allows serving StateFun functions with Python web frameworks that support asynchronous IO natively (for example,
[aiohttp](https://pypi.org/project/aiohttp/)):

```python
from statefun import StatefulFunctions
from statefun import AsyncRequestReplyHandler

functions = StatefulFunctions()

@functions.bind("example/greeter")
async def greeter(context, message):
  html = await fetch(session, 'http://....')
  context.pack_and_reply(SomeProtobufMessage(html))

# expose this handler via an async web framework
handler = AsyncRequestReplyHandler(functions)
```

For more details, please see the docs on [exposing Python functions]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.2/sdk/python.html#exposing-functions).

### Flink DataStream Integration SDK

Using this SDK, you may combine pipelines written with the Flink ``DataStream`` API or higher-level libraries
(such as Table API, CEP etc., basically anything that can consume or produce a ``DataStream``) with the programming constructs
provided by Stateful Functions, as demonstrated below:

```java
StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

DataStream<RoutableMessage> namesIngress = ...

StatefulFunctionEgressStreams egresses =
    StatefulFunctionDataStreamBuilder.builder("example")
        .withDataStreamAsIngress(namesIngress)
        .withRequestReplyRemoteFunction(
            RequestReplyFunctionBuilder.requestReplyFunctionBuilder(
                    REMOTE_GREET, URI.create("http://..."))
                .withPersistedState("seen_count")
        .withFunctionProvider(GREET, unused -> new MyFunction())
        .withEgressId(GREETINGS)
        .build(env);

DataStream<String> responsesEgress = getDataStreamForEgressId(GREETINGS);
```

Events from ``DataStream`` ingresses are being routed to bound functions, and events sent to
egresses are captured as ``DataStream`` egresses. This opens up the possibility of building complex streaming
applications.

### Construct for Dynamic State Registration

Prior to this release, the persisted state constructs in the Java SDK, such as ``PersistedValue``, ``PersistedTable`` etc.,
had to be eagerly defined in a stateful function's class. In certain scenarios, what state a function requires is not
known in advance, and may only be dynamically registered at runtime (e.g., when a function is invoked).

This release enables that by providing a new ``PersistedStateRegistry`` construct:

```java
public class MyFunction implements StatefulFunction {
    @Persisted
    private final PersistedStateRegistry registry = new PersistedStateRegistry();
    private final PersistedValue<String> myValue;

    public void invoke(Context context, Object input) {
        if (myValue == null) {
            myValue = registry.registerValue(PersistedValue.of("my-value", String.class));
        }
        ...
    }
}
```

## Improvements

### Remote Functions Communication Stability

After observing common workloads, a few configurations for communicating with remote functions were adjusted for a better
out-of-the-box connection stability. This includes the following:

* The underlying connection pool was tuned for low latency, high throughput workloads. This allows StateFun to reuse
  existing connections much more aggressively and avoid re-establishing a connection for each request.
* StateFun applies backpressure once the total number of uncompleted requests reaches a per JVM threshold (``statefun.async.max-per-task``),
  but observing typical workloads we have discovered that the default value is set too high. In this release the default
  was reduced to improve stability and resource consumption, in the face of a slow-responding remote function.

### Operational observability of a StateFun Application

One major goal of this release was to take a necessary step towards supporting auto-scaling of remote functions. Towards that end,
we've exposed several metrics related to workload of remote functions and resulting backpressure applied by the function
dispatchers. This includes the following:

* Per function type invocation duration / latency histograms
* Per function type backlog size
* Per JVM (StateFun worker) and per function type number of in-flight invocations

The full list of metrics and their descriptions can be found [here]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.2/deployment-and-operations/metrics.html).

### Fine-grained control over remote connection lifecycle

With this release, it's possible to set individual timeouts for overall duration and individual read and write IO operations
of HTTP requests with remote functions. You can find the corresponding field names in a function spec that defines
these timeout values [here]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.2/sdk/index.html#defining-functions).

## 3rd Party SDKs

Since the last release, we've seen new 3rd party SDKs for different languages being implemented on top of StateFun's
remote function HTTP request-reply protocol, including [Go](https://github.com/sjwiesman/statefun-go/) and [Rust](https://github.com/aljoscha/statefun-rust) implementations. While these SDKs are not
endorsed or maintained by the Apache Flink PMC and currently not part of the current releases, it is great to see these
new additions that demonstrate the extensibility of the framework.

For that reason, we've added
a new [page in the documentation]({{< param DocsBaseUrl >}}flink-statefun-docs-release-2.2/sdk/external.html)
to list the 3rd party SDKs that the community is aware of. If you've also worked on a new language SDK for StateFun that
is stable and you plan to continue maintaining, please consider letting the community know of your work by
submitting a pull request to add your project to the list!

## Important Patch Notes

Below is a list of user-facing interface and configuration changes, dependency version upgrades, or removal of supported versions that would be
important to be aware of when upgrading your StateFun applications to this version:

* [[FLINK-18812](https://issues.apache.org/jira/browse/FLINK-18812)] The Flink version in StateFun 2.2 has been upgraded to 1.11.1.
* [[FLINK-19203](https://issues.apache.org/jira/browse/FLINK-19203)] Upgraded Scala version to 2.12, and dropped support for 2.11.
* [[FLINK-19190](https://issues.apache.org/jira/browse/FLINK-19190)] All existing metric names have been renamed to be camel-cased instead of snake-cased, to conform with the Flink metric naming conventions. **This breaks existing deployments if you depended on previous metrics**.
* [[FLINK-19192](https://issues.apache.org/jira/browse/FLINK-19192)] The connection pool size for remote function HTTP requests have been increased to 1024, with a stale TTL of 1 minute.
* [[FLINK-19191](https://issues.apache.org/jira/browse/FLINK-19191)] The default max number of asynchronous operations per JVM (StateFun worker) has been decreased to 1024.

## Release Notes

Please review the [release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12348350)
for a detailed list of changes and new features if you plan to upgrade your setup to Stateful Functions 2.2.0.

## List of Contributors

The Apache Flink community would like to thank all contributors that have made this release possible:

abc863377, Authuir, Chesnay Schepler, Congxian Qiu, David Anderson, Dian Fu, Francesco Guardiani, Igal Shilman, Marta Paes Moreira, Patrick Wiener, Rafi Aroch, Seth Wiesman, Stephan Ewen, Tzu-Li (Gordon) Tai, Ufuk Celebi

If you’d like to get involved, we’re always [looking for new contributors](https://github.com/apache/flink-statefun#contributing).

