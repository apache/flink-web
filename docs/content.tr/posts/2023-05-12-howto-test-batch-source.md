---
title:  "Howto test a batch source with the new Source framework"
date: "2023-05-12T08:00:00.000Z"
authors:
- echauchot:
  name: "Etienne Chauchot"
  twitter: "echauchot"

---

## Introduction

The Flink community has
designed [a new Source framework](https://nightlies.apache.org/flink/flink-docs-release-1.16/docs/dev/datastream/sources/)
based
on [FLIP-27](https://cwiki.apache.org/confluence/display/FLINK/FLIP-27%3A+Refactor+Source+Interface)
lately. This article is the
continuation of
the [howto create a batch source with the new Source framework article](https://flink.apache.org/2023/04/14/howto-create-batch-source/)
. Now it is
time to test the created source ! As the previous article, this one was built while implementing the
[Flink batch source](https://github.com/apache/flink-connector-cassandra/commit/72e3bef1fb9ee6042955b5e9871a9f70a8837cca)
for [Cassandra](https://cassandra.apache.org/_/index.html).

## Unit testing the source

### Testing the serializers

[Example Cassandra SplitSerializer](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/split/CassandraSplitSerializer.java)
and [SplitEnumeratorStateSerializer](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/main/java/org/apache/flink/connector/cassandra/source/enumerator/CassandraEnumeratorStateSerializer.java)

In the previous article, we
created [serializers](https://flink.apache.org/2023/04/14/howto-create-batch-source/#serializers)
for Split and SplitEnumeratorState. We should now test them in unit tests. To test serde
we create an object, serialize it using the serializer and then deserialize it using the same
serializer and finally assert on the equality of the two objects. Thus, hascode() and equals() need
to be implemented for the serialized objects.

### Other unit tests

Of course, we also need to unit test low level processing such as query building for example or any
processing that does not require a running backend.

## Integration testing the source

For tests that require a running backend, Flink provides a JUnit5 source test framework. It is composed of different parts gathered in a test suite:

* [The Flink environment](#flink-environment)
* [The backend environment](#backend-environment)
* [The checkpointing semantics](#checkpointing-semantics)
* [The test context](#test-context)

[Example Cassandra SourceITCase
](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/test/java/org/apache/flink/connector/cassandra/source/CassandraSourceITCase.java)

For the test to be integrated to Flink CI, the test class must be called *ITCAse. But it can be called
differently if the test belongs to somewhere else.
The class extends [SourceTestSuiteBase](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/testsuites/SourceTestSuiteBase.html)
. This test suite provides all
the necessary tests already (single split, multiple splits, idle reader, etc...). It is targeted for
batch and streaming sources, so for our batch source case here, the tests below need to be disabled
as they are targeted for streaming sources. They can be disabled by overriding them in the ITCase
and annotating them with `@Disabled`:

* testSourceMetrics
* testSavepoint
* testScaleUp
* testScaleDown
* testTaskManagerFailure

Of course we can add our own integration tests cases for example tests on limits, tests on low level
splitting or any test that requires a running backend. But for most cases we only need to provide
Flink test environment classes to configure the ITCase:

### Flink environment

We add this annotated field to our ITCase and we're done

```java
@TestEnv
MiniClusterTestEnvironment flinkTestEnvironment = new MiniClusterTestEnvironment();
```

### Backend environment
[Example Cassandra TestEnvironment](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/test/java/org/apache/flink/connector/cassandra/source/CassandraTestEnvironment.java)

To test the connector we need a backend to run the connector against. This TestEnvironment 
provides everything related to the backend: the container, its configuration, the session to connect to it, 
and all the elements bound to the whole test case (table space, initialization requests ...)  

We add this annotated field to our ITCase

```java
@TestExternalSystem
MyBackendTestEnvironment backendTestEnvironment = new MyBackendTestEnvironment();
```

To integrate with JUnit5 BackendTestEnvironment
implements [TestResource](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/TestResource.html)
. This environment is scoped to the test suite, so it is where we setup the backend and shared resources (session, tablespace, etc...) by
implementing [startup()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/TestResource.html#startUp--)
and [tearDown()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/TestResource.html#tearDown--)
methods. For
that we advise the use of [testContainers](https://www.testcontainers.org/) that relies on docker
images to provide a real backend
instance (not a mock) that is representative for integration tests. Several backends are supported
out of the box by testContainers. We need to configure test containers that way:

* Redirect container output (error and standard output) to Flink logs
* Set the different timeouts to cope with CI server load
* Set retrial mechanisms for connection, initialization requests etc... for the same reason

### Checkpointing semantics

In big data execution engines, there are 2 levels of guarantee regarding source and sinks:

* At least once: upon failure and recovery, some records may be reflected multiple times but none
  will
  be lost
* Exactly once: upon failure and recovery, every record will be reflected exactly once

By the following code we verify that the source supports exactly once semantics:

```java
@TestSemantics
CheckpointingMode[] semantics = new CheckpointingMode[] {CheckpointingMode.EXACTLY_ONCE};
```

That being said, we could encounter a problem while running the tests : the default assertions in
the Flink source test framework assume that the data is read in the same order it was written. This
is untrue for most big data backends where ordering is usually not deterministic. To support
unordered checks and still use all the framework provided tests, we need to override
[SourceTestSuiteBase#checkResultWithSemantic](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/testsuites/SourceTestSuiteBase.html#checkResultWithSemantic-org.apache.flink.util.CloseableIterator-java.util.List-org.apache.flink.streaming.api.CheckpointingMode-java.lang.Integer-)
in out ITCase:

```java
@Override
protected void checkResultWithSemantic(
  CloseableIterator<Pojo> resultIterator,
  List<List<Pojo>> testData,
  CheckpointingMode semantic,
  Integer limit) {
    if (limit != null) {
      Runnable runnable =
      () -> CollectIteratorAssertions.assertUnordered(resultIterator)
        .withNumRecordsLimit(limit)
        .matchesRecordsFromSource(testData, semantic);
      assertThat(runAsync(runnable)).succeedsWithin(DEFAULT_COLLECT_DATA_TIMEOUT);
    } else {
        CollectIteratorAssertions.assertUnordered(resultIterator)
                .matchesRecordsFromSource(testData, semantic);
    }
}
```

This is a copy-paste of the parent method where _CollectIteratorAssertions.assertOrdered()_
is
replaced by _CollectIteratorAssertions.assertUnordered()_.

### Test context
[Example Cassandra TestContext](https://github.com/apache/flink-connector-cassandra/blob/d92dc8d891098a9ca6a7de6062b4630079beaaef/flink-connector-cassandra/src/test/java/org/apache/flink/connector/cassandra/source/CassandraTestContext.java)

The test context provides Flink with means to interact with the backend, like inserting test
data, creating tables or constructing the source. It is scoped to the test case (and not to the test
suite).

It is linked to the ITCase through a factory of TestContext as shown below.

```java
@TestContext
TestContextFactory contextFactory = new TestContextFactory(testEnvironment);
```

TestContext implements [DataStreamSourceExternalContext](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/external/source/DataStreamSourceExternalContext.html):

* We don't connect to the backend at each test case, so the shared resources such as session are
  created by the backend test environment (test suite scoped). They are then passed to the test
  context by constructor. It is also in the constructor that we initialize test case backend
  resources such as test case table.
* close() : drop the created test case resources
* [getProducedType()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/api/java/typeutils/ResultTypeQueryable.html#getProducedType--):
  specify the test output type of the source such as a test Pojo for example
* [getConnectorJarPaths()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/external/ExternalContext.html#getConnectorJarPaths--):
  provide a list of attached jars. Most of the time, we can return an empty
  list as maven already adds the jars to the test classpath
* [createSource()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/external/source/DataStreamSourceExternalContext.html#createSource-org.apache.flink.connector.testframe.external.source.TestingSourceSettings-):
  here we create the source as a user would have done. It will be provided to the
  test cases by the Flink test framework
* [createSourceSplitDataWriter()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/external/source/DataStreamSourceExternalContext.html#createSourceSplitDataWriter-org.apache.flink.connector.testframe.external.source.TestingSourceSettings-):
  here we create
  an [ExternalSystemSplitDataWriter](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/external/ExternalSystemSplitDataWriter.html)
  responsible for
  writing test data which comes as a list of produced type objects such as defined in
  getProducedType()
* [generateTestData()](https://nightlies.apache.org/flink/flink-docs-master/api/java/org/apache/flink/connector/testframe/external/source/DataStreamSourceExternalContext.html#generateTestData-org.apache.flink.connector.testframe.external.source.TestingSourceSettings-int-long-):
  produce the list of test data that will be given to the
  ExternalSystemSplitDataWriter. We must make sure that equals() returns false when 2 records of
  this list belong to different splits. The easier for that is to include the split id into the
  produced type and make sure equals() and hashcode() are properly implemented to include this
  field.

## Contributing the source to Flink

Lately, the Flink community has externalized all the connectors to external repositories that are
sub-repositories of the official Apache Flink repository. This is mainly to decouple the release of
Flink to the release of the connectors. To distribute the created source, we need to
follow [this official wiki page](https://cwiki.apache.org/confluence/display/FLINK/Externalized+Connector+development)
.

## Conclusion

This concludes the series of articles about creating a batch source with the new Flink framework.
This was needed as, apart from the javadocs, the documentation about testing is missing for now. I
hope you enjoyed reading and I hope the Flink community will receive a source PR from you soon :) 