---
layout: post
title:  "Delegation Token Framework: Obtain, Distribute and Use Temporary Credentials Automatically"
date: 2023-01-20T08:00:00.000Z
categories: news
authors:
- gaborgsomogyi:
  name: "Gabor Somogyi"
- mbalassi:
  name: "Marton Balassi"
  twitter: "MartonBalassi"
---

The Apache Flink Community is pleased to announce that the upcoming minor version of Flink (1.17) includes 
the Delegation Token Framework proposed in [FLIP-272](https://cwiki.apache.org/confluence/display/FLINK/FLIP-272%3A+Generalized+delegation+token+support).
This enables Flink to authenticate to external services at a central location (JobManager) and distribute authentication
tokens to the TaskManagers.

## Introduction

Authentication in distributed systems is not an easy task. Previously all worker nodes (TaskManagers) reading from or 
writing to an external system needed to authenticate on their own. In such a case several things can go wrong, including but not limited to:

* Too many authentication requests (potentially resulting in rejected requests)
* Large number of retries on authentication failures
* Re-occurring propagation/update of temporary credentials in a timely manner
* Dependency issues when external system libraries are having the same dependency with different versions
* Each authentication/temporary credentials are different making standardization challenging
* ...

The aim of Delegation Token Framework is to solve the above challenges. The framework is authentication protocol agnostic and pluggable.
The primary design concept is that authentication happens only at a single location (JobManager), the obtained temporary
credentials propagated automatically to all the task managers where they can be used. The token re-obtain process is also handled
in the JobManager.

<p align="center">
<img src="{{ site.baseurl }}/img/blog/2023-01-20-delegation-token-framework/delegation_token_framework.svg" width="70%" height="70%">
</p>

New authentication providers can be added with small amount of code which is going to be loaded by Flink automatically.
At the moment the following external systems are supported:

* Hadoop filesystems
* HBase
* S3

Planned, but not yet implemented/contributed:

* Kafka
* Hive

The design and implementation approach has already been proven in [Apache Spark](https://spark.apache.org/docs/latest/security.html#kerberos).
Gabor is a Spark committer, he championed this feature in the Spark community. The most notable improvement we achieved compared to the
current state in Spark is that the framework in Flink is already authentication protocol agnostic (and not bound to Kerberos).

## Documentation

For more details please refer to the following documentation:

* [Delegation Tokens In General](https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/security/security-delegation-token/)
* [How to use Kerberos delegation tokens](https://nightlies.apache.org/flink/flink-docs-master/docs/deployment/security/security-kerberos/#using-delegation-tokens)

## Development details

Major tickets where the framework has been added:

* [FLINK-21232](https://issues.apache.org/jira/browse/FLINK-21232) Kerberos delegation token framework
* [FLINK-29918](https://issues.apache.org/jira/browse/FLINK-29918) Generalized delegation token support
* [FLINK-30704](https://issues.apache.org/jira/browse/FLINK-30704) Add S3 delegation token support

## Example implementation

Adding a new authentication protocol is relatively straight-forward:

* Check out the [example implementation](https://github.com/gaborgsomogyi/flink-test-java-delegation-token-provider)
* Change `FlinkTestJavaDelegationTokenProvider.obtainDelegationTokens` to obtain a custom token from any external service
* Change `FlinkTestJavaDelegationTokenReceiver.onNewTokensObtained` to receive the previously obtained tokens on all task managers
* Use the tokens for external service authentication
* Compile the project and put it into the classpath (adding it inside a plugin also supported)
* Enjoy that Flink does all the heavy lifting behind the scenes :-)

## Example implementation testing

The existing providers are tested with the [Flink Kubernetes Operator](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-main/)
but one can use any other supported deployment model, because the framework is not bound to any of them.
We choose the Kubernetes Operator so that we could provide a completely containerized and easily reproducible test environment.

An example tutorial can be found [here](https://gist.github.com/gaborgsomogyi/ac4f71ead8494da2f5c35265bcb1e885) on
external system authentication.

## Summary

The Delegation Token Framework is feature complete on the master branch and is becoming generally available on the release of 
Flink 1.17. The framework obtains authentication tokens at a central location and propagates them to all workers on a re-occurring basis.

Any connector to an external system which supports authentication can be a potential user of this framework. 
To support authentication in your connector we encourage you to implement your own `DelegationTokenProvider/DelegationTokenReceiver` pair.
