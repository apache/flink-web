---
authors:
- name: Till Rohrmann
  trohrmann: null
  twitter: stsffap
- igalshilman: null
  name: Igal Shilman
  twitter: IgalShilman
date: "2022-01-31T08:00:00Z"
subtitle: The Apache Flink community is happy to announce the release of Stateful
  Functions (StateFun) 3.2.0.
title: Stateful Functions 3.2.0 Release Announcement
---

Stateful Functions is a cross-platform stack for building Stateful Serverless applications, making it radically simpler to develop scalable, consistent, and elastic distributed applications.
This new release brings various improvements to the StateFun runtime, a leaner way to specify StateFun module components, and a brand new JavaScript SDK!

The binary distribution and source artifacts are now available on the updated [Downloads](https://flink.apache.org/downloads.html)
page of the Flink website, and the most recent Java SDK, Python SDK,, GoLang SDK and JavaScript SDK distributions are available on [Maven](https://search.maven.org/artifact/org.apache.flink/statefun-sdk-java/3.2.0/jar), [PyPI](https://pypi.org/project/apache-flink-statefun/), [Github](https://github.com/apache/flink-statefun/tree/statefun-sdk-go/v3.2.0), and [npm](https://www.npmjs.com/package/apache-flink-statefun) respectively.
You can also find official StateFun Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-statefun).

For more details, check the complete [release changelog](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12350540)
and the [updated documentation]({{< param DocsBaseUrl >}}flink-statefun-docs-release-3.2/).
We encourage you to download the release and share your feedback with the community through the [Flink mailing lists](https://flink.apache.org/community.html#mailing-lists)
or [JIRA](https://issues.apache.org/jira/browse/)!

{% toc %}

## New Features

### A brand new JavaScript SDK for NodeJS

Stateful Functions provides a unified model for building stateful applications across various programming languages and deployment environments.
The community is thrilled to release an official JavaScript SDK as part of the 3.2.0 release.

```js
const http = require("http");
const {messageBuilder, StateFun, Context} = require("apache-flink-statefun");

let statefun = new StateFun();
statefun.bind({
    typename: "com.example.fns/greeter",
    fn(context, message) {
        const name = message.asString();
        let seen = context.storage.seen || 0;
        seen = seen + 1;
        context.storage.seen = seen;

        context.send(
            messageBuilder({typename: 'com.example.fns/inbox',
                            id: name,
                            value: `"Hello ${name} for the ${seen}th time!"`})
        );
    },
    specs: [{
        name: "seen",
        type: StateFun.intType(),
    }]
});

http.createServer(statefun.handler()).listen(8000);
```

As with the Python, Java and Go SDKs, the JavaScript SDK includes:

  - An address scoped storage acting as a key-value store for a particular address.
  - A unified cross-language way to send, receive and store values across languages.
  - Dynamic `ValueSpec` to describe the state name, type, and possibly expiration configuration at runtime.

You can get started by adding the SDK to your project.

`npm install apache-flink-statefun@3.2.0`

For a detailed SDK tutorial, we would like to encourage you to visit:

  - [JavaScript SDK Documentation]({{< param DocsBaseUrl >}}flink-statefun-docs-release-3.2/docs/sdk/js/)

### Support different remote functions module names

With the newly introduced configuration option `statefun.remote.module-name`, it is possible to override the default remote module file name (`module.yaml`).

To provide a different name, for example `prod.yaml` that is located at `/flink/usrlib/prod.yaml`, one can add the following to ones `flink-conf.yaml`:

```bash
statefun.remote.module-name: /flink/usrlib/prod.yaml
```

For more information see [FLINK-25308](https://issues.apache.org/jira/browse/FLINK-25308).

### Allow creating custom metrics

The embedded SDK now supports registering custom counters.
For more information see [FLINK-22533](https://issues.apache.org/jira/browse/FLINK-22533).

### Upgraded Flink dependency to 1.14.3

Stateful Functions 3.2.0 runtime uses Flink 1.14.3 underneath.
This means that Stateful Functions benefits from the latest improvements and stabilisations that went into Flink.
For more information see [Flink's release announcement](https://flink.apache.org/news/2022/01/17/release-1.14.3.html).

## Release Notes

Please review the [release notes](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12350540)
for a detailed list of changes and new features if you plan to upgrade your setup to Stateful Functions 3.2.0.

## List of Contributors

Seth Wiesman, Igal Shilman, Till Rohrmann, Stephan Ewen, Tzu-Li (Gordon) Tai, Ingo Bürk, Evans Ye, neoXfire, Galen Warren

If you’d like to get involved, we’re always [looking for new contributors](https://github.com/apache/flink-statefun#contributing).
