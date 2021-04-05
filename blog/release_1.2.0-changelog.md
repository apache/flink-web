---
title: "Release 1.2.0 – Changelog"
---

* toc
{:toc}

## Changelog

The 1.2.0 release [resolved 650 JIRA issues](https://issues.apache.org/jira/issues/?jql=project+%3D+FLINK+AND+fixVersion+%3D+1.2.0) in total.



    
<h2>        Sub-task
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3202'>FLINK-3202</a>] -         Make Timer/Trigger Service Scoped to Key/Namespace
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3580'>FLINK-3580</a>] -         Reintroduce Date/Time and implement scalar functions for it
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3660'>FLINK-3660</a>] -         Measure latency of elements and expose it as a metric
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3761'>FLINK-3761</a>] -         Refactor State Backends/Make Keyed State Key-Group Aware
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3950'>FLINK-3950</a>] -         Add Meter Metric Type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4174'>FLINK-4174</a>] -         Enhance Window Evictor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4221'>FLINK-4221</a>] -         Show metrics in WebFrontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4273'>FLINK-4273</a>] -         Refactor JobClientActor to watch already submitted jobs 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4312'>FLINK-4312</a>] -         Remove Serializabiliy of ExecutionGraph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4317'>FLINK-4317</a>] -         Restructure documentation layout
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4320'>FLINK-4320</a>] -         Fix misleading ScheduleMode names
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4324'>FLINK-4324</a>] -         Enable Akka SSL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4325'>FLINK-4325</a>] -         Implement Web UI HTTPS
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4380'>FLINK-4380</a>] -         Introduce KeyGroupAssigner and Max-Parallelism Parameter
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4381'>FLINK-4381</a>] -         Refactor State to Prepare For Key-Group State Backends
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4384'>FLINK-4384</a>] -         Add a &quot;scheduleRunAsync()&quot; feature to the RpcEndpoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4386'>FLINK-4386</a>] -         Add as way to assert that code runs in the RpcEndpoint&#39;s Main Thread
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4389'>FLINK-4389</a>] -         Expose metrics to Webfrontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4392'>FLINK-4392</a>] -         Make RPC Service Thread Safe
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4403'>FLINK-4403</a>] -         RPC proxy classloading should use Flink class&#39; classloader
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4404'>FLINK-4404</a>] -         Implement Data Transfer SSL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4405'>FLINK-4405</a>] -         Implement Blob Server SSL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4434'>FLINK-4434</a>] -         Add a testing RPC service
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4490'>FLINK-4490</a>] -         Decouple Slot and Instance
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4507'>FLINK-4507</a>] -         Deprecate savepoint backend config
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4509'>FLINK-4509</a>] -         Specify savepoint directory per savepoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4510'>FLINK-4510</a>] -         Always create CheckpointCoordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4512'>FLINK-4512</a>] -         Add option for persistent checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4670'>FLINK-4670</a>] -         Add watch mechanism on current RPC framework
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4685'>FLINK-4685</a>] -         Gather operator checkpoint durations data sizes from the runtime
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4691'>FLINK-4691</a>] -         Add group-windows for streaming tables	
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4697'>FLINK-4697</a>] -         Gather more detailed checkpoint stats in CheckpointStatsTracker
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4698'>FLINK-4698</a>] -         Visualize additional checkpoint information
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4748'>FLINK-4748</a>] -         Fix shutdown of automatic watermark context
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4749'>FLINK-4749</a>] -         Remove redundant processing time timers and futures in the window operator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4750'>FLINK-4750</a>] -         Ensure that active processing time triggers complete before closing operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4768'>FLINK-4768</a>] -         Migrate High Availability configuration options
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4826'>FLINK-4826</a>] -         Add keytab based kerberos support for Mesos environment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4877'>FLINK-4877</a>] -         Refactorings around FLINK-3674 (User Function Timers)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4884'>FLINK-4884</a>] -         Eagerly Store MergingWindowSet in State in WindowOperator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4899'>FLINK-4899</a>] -         Implement DCOS package
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4900'>FLINK-4900</a>] -         Implement Docker image support
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4901'>FLINK-4901</a>] -         Build DCOS Docker image
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4918'>FLINK-4918</a>] -         Add SSL support to Mesos artifact server
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4921'>FLINK-4921</a>] -         Upgrade to Mesos 1.0.1
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4922'>FLINK-4922</a>] -         Write documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4937'>FLINK-4937</a>] -         Add incremental group window aggregation for streaming Table API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4959'>FLINK-4959</a>] -         Write Documentation for ProcessFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4984'>FLINK-4984</a>] -         Add Cancellation Barriers to BarrierTracker and BarrierBuffer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4985'>FLINK-4985</a>] -         Report Declined/Canceled Checkpoints to Checkpoint Coordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4987'>FLINK-4987</a>] -         Harden slot pool logic
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4993'>FLINK-4993</a>] -         Don&#39;t Allow Trigger.onMerge() to return TriggerResult
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4994'>FLINK-4994</a>] -         Don&#39;t Clear Trigger State and Merging Window Set When Purging
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5042'>FLINK-5042</a>] -         Convert old savepoints to new savepoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5043'>FLINK-5043</a>] -         Converting keyed state from Flink 1.1 backend implementations to their new counterparts in 1.2
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5044'>FLINK-5044</a>] -         Converting operator and function state from Flink 1.1 for all changed operators in 1.2
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5091'>FLINK-5091</a>] -         Formalize the AppMaster environment for docker compability
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5290'>FLINK-5290</a>] -         Ensure backwards compatibility of the hashes used to generate JobVertexIds
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5293'>FLINK-5293</a>] -         Make the Kafka consumer backwards compatible.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5294'>FLINK-5294</a>] -         Make the WindowOperator backwards compatible.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5295'>FLINK-5295</a>] -         Migrate the AlignedWindowOperators to the WindowOperator and make it backwards compatible.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5317'>FLINK-5317</a>] -         Make the continuous file processing code backwards compatible,
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5318'>FLINK-5318</a>] -         Make the Rolling sink backwards compatible.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5386'>FLINK-5386</a>] -         Refactoring Window Clause
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5454'>FLINK-5454</a>] -         Add Documentation about how to tune Checkpointing for large state
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5455'>FLINK-5455</a>] -         Create documentation how to upgrade jobs and Flink framework versions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5456'>FLINK-5456</a>] -         Add docs about new state and checkpointing interfaces
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5457'>FLINK-5457</a>] -         Create documentation for Asynchronous I/O
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5458'>FLINK-5458</a>] -         Add documentation how to migrate from Flink 1.1. to Flink 1.2
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5459'>FLINK-5459</a>] -         Add documentation how to debug classloading issues
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5460'>FLINK-5460</a>] -         Add documentation how to use Flink with Docker
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5474'>FLINK-5474</a>] -         Extend DC/OS documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5494'>FLINK-5494</a>] -         Improve Mesos documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5502'>FLINK-5502</a>] -         Add documentation about migrating functions from 1.1 to 1.2
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5529'>FLINK-5529</a>] -         Improve / extends windowing documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5555'>FLINK-5555</a>] -         Add documentation about debugging watermarks
</li>
</ul>
                            
<h2>        Bug
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2662'>FLINK-2662</a>] -         CompilerException: &quot;Bug: Plan generation for Unions picked a ship strategy between binary plan operators.&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2821'>FLINK-2821</a>] -         Change Akka configuration to allow accessing actors from different URLs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2839'>FLINK-2839</a>] -         Failing test: OperatorStatsAccumulatorTest.testAccumulatorAllStatistics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3138'>FLINK-3138</a>] -         Method References are not supported as lambda expressions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3680'>FLINK-3680</a>] -         Remove or improve (not set) text in the Job Plan UI
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3706'>FLINK-3706</a>] -         YARNSessionCapacitySchedulerITCase.testNonexistingQueue unstable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3813'>FLINK-3813</a>] -         YARNSessionFIFOITCase.testDetachedMode failed on Travis
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3888'>FLINK-3888</a>] -         Custom Aggregator with Convergence can&#39;t be registered directly with DeltaIteration
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3918'>FLINK-3918</a>] -         Not configuring any time characteristic leads to a ClassCastException
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4021'>FLINK-4021</a>] -         Problem of setting autoread for netty channel when more tasks sharing the same Tcp connection
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4035'>FLINK-4035</a>] -         Add Apache Kafka 0.10 connector
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4073'>FLINK-4073</a>] -         YARNSessionCapacitySchedulerITCase.testTaskManagerFailure failed on Travis
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4081'>FLINK-4081</a>] -         FieldParsers should support empty strings
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4100'>FLINK-4100</a>] -         RocksDBStateBackend#close() can throw NPE
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4108'>FLINK-4108</a>] -         NPE in Row.productArity
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4140'>FLINK-4140</a>] -         CheckpointCoordinator fails to discard completed checkpoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4148'>FLINK-4148</a>] -         incorrect calculation distance in QuadTree
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4155'>FLINK-4155</a>] -         Get Kafka producer partition info in open method instead of constructor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4177'>FLINK-4177</a>] -         CassandraConnectorTest.testCassandraCommitter causing unstable builds
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4219'>FLINK-4219</a>] -         Quote PDSH opts in start-cluster.sh
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4226'>FLINK-4226</a>] -         Typo: Define Keys using Field Expressions example should use window and not reduce
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4236'>FLINK-4236</a>] -         Flink Dashboard stops showing list of uploaded jars if main method cannot be looked up
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4252'>FLINK-4252</a>] -         Table program cannot be compiled
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4255'>FLINK-4255</a>] -         Unstable test WebRuntimeMonitorITCase.testNoEscape
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4257'>FLINK-4257</a>] -         Handle delegating algorithm change of class
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4259'>FLINK-4259</a>] -         Unclosed FSDataOutputStream in FileCache#copy()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4263'>FLINK-4263</a>] -         SQL&#39;s VALUES does not work properly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4270'>FLINK-4270</a>] -         &#39;as&#39; in front of join does not work
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4271'>FLINK-4271</a>] -         There is no way to set parallelism of operators produced by CoGroupedStreams
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4276'>FLINK-4276</a>] -         TextInputFormatTest.testNestedFileRead fails on Windows OS
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4285'>FLINK-4285</a>] -         Non-existing example in Flink quickstart setup documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4289'>FLINK-4289</a>] -         Source files have executable flag set
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4290'>FLINK-4290</a>] -         CassandraConnectorTest deadlocks
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4291'>FLINK-4291</a>] -         No log entry for unscheduled reporters
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4292'>FLINK-4292</a>] -         HCatalog project incorrectly set up
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4293'>FLINK-4293</a>] -         Malformatted Apache Headers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4296'>FLINK-4296</a>] -         Scheduler accepts more tasks than it has task slots available
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4297'>FLINK-4297</a>] -         Yarn client can&#39;t determine fat jar location if path contains spaces
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4298'>FLINK-4298</a>] -         Clean up Storm Compatibility Dependencies
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4304'>FLINK-4304</a>] -         Jar names that contain whitespace cause problems in web client
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4307'>FLINK-4307</a>] -         Broken user-facing API for ListState
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4309'>FLINK-4309</a>] -         Potential null pointer dereference in DelegatingConfiguration#keySet()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4311'>FLINK-4311</a>] -         TableInputFormat fails when reused on next split
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4313'>FLINK-4313</a>] -         Inconsistent code for Key/Value in the CheckpointCoordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4314'>FLINK-4314</a>] -         Test instability in JobManagerHAJobGraphRecoveryITCase.testJobPersistencyWhenJobManagerShutdown
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4316'>FLINK-4316</a>] -         Make flink-core independent of Hadoop
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4323'>FLINK-4323</a>] -         Checkpoint Coordinator Removes HA Checkpoints in Shutdown
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4329'>FLINK-4329</a>] -         Fix Streaming File Source Timestamps/Watermarks Handling
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4332'>FLINK-4332</a>] -         Savepoint Serializer mixed read()/readFully()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4333'>FLINK-4333</a>] -         Name mixup in Savepoint versions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4337'>FLINK-4337</a>] -         Remove unnecessary Scala suffix from Hadoop1 artifact
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4341'>FLINK-4341</a>] -         Kinesis connector does not emit maximum watermark properly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4342'>FLINK-4342</a>] -         Fix dependencies of flink-connector-filesystem
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4385'>FLINK-4385</a>] -         Union on Timestamp fields does not work
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4387'>FLINK-4387</a>] -         Instability in KvStateClientTest.testClientServerIntegration()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4388'>FLINK-4388</a>] -         Race condition during initialization of MemorySegmentFactory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4394'>FLINK-4394</a>] -         RMQSource: The QueueName is not accessible to subclasses
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4398'>FLINK-4398</a>] -         Unstable test KvStateServerHandlerTest.testSimpleQuery
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4409'>FLINK-4409</a>] -         class conflict between jsr305-1.3.9.jar and flink-shaded-hadoop2-1.1.1.jar
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4411'>FLINK-4411</a>] -         [py] Chained dual input children are not properly propagated
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4412'>FLINK-4412</a>] -         [py] Chaining does not properly handle broadcast variables
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4417'>FLINK-4417</a>] -         Checkpoints should be subsumed by CheckpointID not, by timestamp
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4418'>FLINK-4418</a>] -         ClusterClient/ConnectionUtils#findConnectingAddress fails immediately if InetAddress.getLocalHost throws exception
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4425'>FLINK-4425</a>] -         &quot;Out Of Memory&quot; during savepoint deserialization
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4436'>FLINK-4436</a>] -         Unclosed DataOutputBuffer in Utils#setTokensFor()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4437'>FLINK-4437</a>] -         Lock evasion around lastTriggeredCheckpoint may lead to lost updates to related fields
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4453'>FLINK-4453</a>] -         Scala code example in Window documentation shows Java
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4454'>FLINK-4454</a>] -         Lookups for JobManager address in config
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4482'>FLINK-4482</a>] -         numUnsuccessfulCheckpointsTriggers is accessed without holding triggerLock
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4485'>FLINK-4485</a>] -         Finished jobs in yarn session fill /tmp filesystem
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4486'>FLINK-4486</a>] -         JobManager not fully running when yarn-session.sh finishes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4488'>FLINK-4488</a>] -         Prevent cluster shutdown after job execution for non-detached jobs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4506'>FLINK-4506</a>] -         CsvOutputFormat defaults allowNullValues to false, even though doc and declaration says true
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4514'>FLINK-4514</a>] -         ExpiredIteratorException in Kinesis Consumer on long catch-ups to head of stream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4522'>FLINK-4522</a>] -         Gelly link broken in homepage
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4526'>FLINK-4526</a>] -         ApplicationClient: remove redundant proxy messages
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4544'>FLINK-4544</a>] -         TaskManager metrics are vulnerable to custom JMX bean installation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4556'>FLINK-4556</a>] -         Make Queryable State Key-Group Aware
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4559'>FLINK-4559</a>] -         Kinesis Producer not setting credentials provider properly when AWS_CREDENTIALS_PROVIDER is &quot;AUTO&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4563'>FLINK-4563</a>] -         [metrics] scope caching not adjusted for multiple reporters
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4564'>FLINK-4564</a>] -         [metrics] Delimiter should be configured per reporter
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4566'>FLINK-4566</a>] -         ProducerFailedException does not properly preserve Exception causes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4567'>FLINK-4567</a>] -         Enhance SerializedThrowable to properly preserver cause chains
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4570'>FLINK-4570</a>] -         Scalastyle Maven plugin fails undeterministically
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4572'>FLINK-4572</a>] -         Convert to negative in LongValueToIntValue
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4573'>FLINK-4573</a>] -         Potential resource leak due to unclosed RandomAccessFile in TaskManagerLogHandler
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4581'>FLINK-4581</a>] -         Table API throws &quot;No suitable driver found for jdbc:calcite&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4586'>FLINK-4586</a>] -         NumberSequenceIterator and Accumulator threading issue
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4588'>FLINK-4588</a>] -         Fix Merging of Covering Window in MergingWindowSet
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4589'>FLINK-4589</a>] -         Fix Merging of Covering Window in MergingWindowSet
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4590'>FLINK-4590</a>] -         Some Table API tests are failing when debug lvl is set to DEBUG
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4592'>FLINK-4592</a>] -         Fix flaky test ScalarFunctionsTest.testCurrentTimePoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4594'>FLINK-4594</a>] -         Validate lower bound in MathUtils.checkedDownCast
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4601'>FLINK-4601</a>] -         Check for empty string properly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4603'>FLINK-4603</a>] -         KeyedStateBackend cannot restore user code classes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4609'>FLINK-4609</a>] -         Remove redundant check for null in CrossOperator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4612'>FLINK-4612</a>] -         Close FileWriter using try with resources
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4614'>FLINK-4614</a>] -         Kafka connector documentation refers to Flink 1.2-SNAPSHOT
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4618'>FLINK-4618</a>] -         FlinkKafkaConsumer09 should start from the next record on startup from offsets in Kafka
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4619'>FLINK-4619</a>] -         JobManager does not answer to client when restore from savepoint fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4622'>FLINK-4622</a>] -         CLI help message should include &#39;savepoint&#39; action
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4624'>FLINK-4624</a>] -         Gelly&#39;s summarization algorithm cannot deal with null vertex group values
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4626'>FLINK-4626</a>] -         Missing break in MetricStore#add()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4628'>FLINK-4628</a>] -         User class loader unavailable during input split assignment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4631'>FLINK-4631</a>] -         NullPointerException during stream task cleanup
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4640'>FLINK-4640</a>] -         Serialization of the initialValue of a Fold on WindowedStream fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4645'>FLINK-4645</a>] -         Hard to register Kryo Serializers due to generics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4651'>FLINK-4651</a>] -         Re-register processing time timers at the WindowOperator upon recovery.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4652'>FLINK-4652</a>] -         Don&#39;t pass credentials explicitly to AmazonClient - use credentials provider instead
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4659'>FLINK-4659</a>] -         Potential resource leak due to unclosed InputStream in SecurityContext#populateSystemSecurityProperties()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4663'>FLINK-4663</a>] -         Flink JDBCOutputFormat logs wrong WARN message
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4665'>FLINK-4665</a>] -         Remove boxing/unboxing to parse a primitive
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4666'>FLINK-4666</a>] -         Make constants to be final in ParameterTool
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4667'>FLINK-4667</a>] -         Yarn Session CLI not listening on correct ZK namespace when HA is enabled to use ZooKeeper backend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4671'>FLINK-4671</a>] -         Table API can not be built
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4672'>FLINK-4672</a>] -         TaskManager accidentally decorates Kill messages
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4677'>FLINK-4677</a>] -         Jars with no job executions produces NullPointerException in ClusterClient
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4696'>FLINK-4696</a>] -         Limit the number of Akka Dispatcher Threads in LocalMiniCluster
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4700'>FLINK-4700</a>] -         Harden the TimeProvider test
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4702'>FLINK-4702</a>] -         Kafka consumer must commit offsets asynchronously
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4708'>FLINK-4708</a>] -         Scope Mini Kerberos Cluster dependencies as test dependencies
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4709'>FLINK-4709</a>] -         InputStreamFSInputWrapper does not close wrapped stream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4710'>FLINK-4710</a>] -         Remove transitive Guice dependency from Hadoop
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4711'>FLINK-4711</a>] -         TaskManager can crash due to failing onPartitionStateUpdate call
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4718'>FLINK-4718</a>] -         Confusing label in Parallel Streams Diagram
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4727'>FLINK-4727</a>] -         Kafka 0.9 Consumer should also checkpoint auto retrieved offsets even when no data is read
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4730'>FLINK-4730</a>] -         Introduce CheckpointMetaData
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4731'>FLINK-4731</a>] -         HeapKeyedStateBackend restoring broken for scale-in
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4732'>FLINK-4732</a>] -         Maven junction plugin security threat
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4741'>FLINK-4741</a>] -         WebRuntimeMonitor does not shut down all of it&#39;s threads (EventLoopGroups) on exit.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4743'>FLINK-4743</a>] -         The sqrt/power function not accept the real data types.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4744'>FLINK-4744</a>] -         Introduce usercode class loader to deserialize partitionable operator state
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4747'>FLINK-4747</a>] -         Instability due to pending processing timers on operator close
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4753'>FLINK-4753</a>] -         Kafka 0.8 connector&#39;s Periodic Offset Committer should synchronize on checkpoint lock
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4774'>FLINK-4774</a>] -         QueryScopeInfo scope concatenation broken
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4777'>FLINK-4777</a>] -         ContinuousFileMonitoringFunction may throw IOException when files are moved
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4784'>FLINK-4784</a>] -         MetricQueryService actor name collision
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4786'>FLINK-4786</a>] -         BarrierBufferTest test instability
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4788'>FLINK-4788</a>] -         State backend class cannot be loaded, because fully qualified name converted to lower-case
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4791'>FLINK-4791</a>] -         Fix issues caused by expression reduction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4793'>FLINK-4793</a>] -         Using a local method with :: notation in Java 8 causes index out of bounds
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4794'>FLINK-4794</a>] -         partition_by_hash() crashes if no parameter is provided
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4795'>FLINK-4795</a>] -         CsvStringify crashes in case of tuple in tuple, t.e. (&quot;a&quot;, True, (1,5))
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4798'>FLINK-4798</a>] -         CEPITCase.testSimpleKeyedPatternCEP test failure
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4801'>FLINK-4801</a>] -         Input type inference is faulty with custom Tuples and RichFunctions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4804'>FLINK-4804</a>] -         Grouping.first() function usage fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4805'>FLINK-4805</a>] -         Stringify() crashes with Python3 (run with pyflink3)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4824'>FLINK-4824</a>] -         CliFrontend shows misleading error message when main() method returns before env.execute()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4827'>FLINK-4827</a>] -         The scala example of SQL on Streaming Tables  with wrong variable name in flink document
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4829'>FLINK-4829</a>] -         Accumulators are not thread safe
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4833'>FLINK-4833</a>] -         Unstable test OperatorStatsAccumulatorTest.testAccumulatorHeavyHitterCountMinSketch
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4838'>FLINK-4838</a>] -         remove STREAM keyword in StreamSQLExample
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4845'>FLINK-4845</a>] -         Fix Job Exceptions page
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4852'>FLINK-4852</a>] -         ClassCastException when assigning Watermarks with TimeCharacteristic.ProcessingTime
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4862'>FLINK-4862</a>] -         NPE on EventTimeSessionWindows with ContinuousEventTimeTrigger
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4866'>FLINK-4866</a>] -         Make Trigger.clear() Abstract to Enforce Implementation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4870'>FLINK-4870</a>] -         ContinuousFileMonitoringFunction does not properly handle absolut Windows paths
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4872'>FLINK-4872</a>] -         Type erasure problem exclusively on cluster execution
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4875'>FLINK-4875</a>] -         operator name not correctly inferred
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4879'>FLINK-4879</a>] -         class KafkaTableSource should be public just like KafkaTableSink
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4887'>FLINK-4887</a>] -         Replace ActorGateway by TaskManagerGateway interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4890'>FLINK-4890</a>] -         FileInputFormatTest#testExcludeFiles fails on Windows OS
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4907'>FLINK-4907</a>] -         Add Test for Timers/State Provided by AbstractStreamOperator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4932'>FLINK-4932</a>] -         Don&#39;t let ExecutionGraph fail when in state Restarting
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4933'>FLINK-4933</a>] -         ExecutionGraph.scheduleOrUpdateConsumers can fail the ExecutionGraph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4941'>FLINK-4941</a>] -         Show ship strategy in web interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4945'>FLINK-4945</a>] -         KafkaConsumer logs wrong warning about confirmation for unknown checkpoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4967'>FLINK-4967</a>] -         RockDB state backend fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4973'>FLINK-4973</a>] -         Flakey Yarn tests due to recently added latency marker
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4977'>FLINK-4977</a>] -         Enum serialization does not work in all cases
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4991'>FLINK-4991</a>] -         TestTask hangs in testWatchDogInterruptsTask
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4998'>FLINK-4998</a>] -         ResourceManager fails when num task slots &gt; Yarn vcores
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5002'>FLINK-5002</a>] -         Lack of synchronization in LocalBufferPool#getNumberOfUsedBuffers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5007'>FLINK-5007</a>] -         Retain externalized checkpoint on suspension
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5011'>FLINK-5011</a>] -         TraversableSerializer does not perform a deep copy of the elements it is traversing
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5014'>FLINK-5014</a>] -         RocksDBStateBackend misses good toString
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5016'>FLINK-5016</a>] -         EventTimeWindowCheckpointingITCase testTumblingTimeWindowWithKVStateMaxMaxParallelism with RocksDB hangs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5019'>FLINK-5019</a>] -         Proper isRestored result for tasks that did not write state
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5027'>FLINK-5027</a>] -         FileSource finishes successfully with a wrong path
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5028'>FLINK-5028</a>] -         Stream Tasks must not go through clean shutdown logic on cancellation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5032'>FLINK-5032</a>] -         CsvOutputFormatTest fails on Windows OS
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5033'>FLINK-5033</a>] -         CEP operators don&#39;t properly advance time
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5037'>FLINK-5037</a>] -         Instability in AbstractUdfStreamOperatorLifecycleTest
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5038'>FLINK-5038</a>] -         Errors in the &quot;cancelTask&quot; method prevent closeables from being closed early
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5039'>FLINK-5039</a>] -         Avro GenericRecord support is broken
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5040'>FLINK-5040</a>] -         Set correct input channel types with eager scheduling
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5048'>FLINK-5048</a>] -         Kafka Consumer (0.9/0.10) threading model leads problematic cancellation behavior
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5049'>FLINK-5049</a>] -         Instability in QueryableStateITCase.testQueryableStateWithTaskManagerFailure
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5050'>FLINK-5050</a>] -         JSON.org license is CatX
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5055'>FLINK-5055</a>] -         Security feature crashes JM for certain Hadoop versions even though using no Kerberos
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5056'>FLINK-5056</a>] -         BucketingSink deletes valid data when checkpoint notification is slow.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5057'>FLINK-5057</a>] -         Cancellation timeouts are picked from wrong config
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5058'>FLINK-5058</a>] -         taskManagerMemory attribute set wrong value in FlinkShell
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5063'>FLINK-5063</a>] -         State handles are not properly cleaned up for declined or expired checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5071'>FLINK-5071</a>] -         YARN: yarn.containers.vcores config not respected when checking for vcores
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5073'>FLINK-5073</a>] -         ZooKeeperCompleteCheckpointStore executes blocking delete operation in ZooKeeper client thread
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5075'>FLINK-5075</a>] -         Kinesis consumer incorrectly determines shards as newly discovered when tested against Kinesalite
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5082'>FLINK-5082</a>] -         Pull ExecutionService lifecycle management out of the JobManager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5085'>FLINK-5085</a>] -         Execute CheckpointCoodinator&#39;s state discard calls asynchronously
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5097'>FLINK-5097</a>] -         The TypeExtractor is missing input type information in some Graph methods
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5102'>FLINK-5102</a>] -         Connection establishment does not react to interrupt
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5109'>FLINK-5109</a>] -         Invalid Content-Encoding Header in REST API responses
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5111'>FLINK-5111</a>] -         Change the assignToKeyGroup() method to not use Object.hashCode()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5112'>FLINK-5112</a>] -         Remove unused accumulator code from ArchivedExecutionJobVertex
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5114'>FLINK-5114</a>] -         PartitionState update with finished execution fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5118'>FLINK-5118</a>] -         Inconsistent records sent/received metrics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5119'>FLINK-5119</a>] -         Last taskmanager heartbeat not showing in web frontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5143'>FLINK-5143</a>] -         Add EXISTS to list of supported operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5144'>FLINK-5144</a>] -         Error while applying rule AggregateJoinTransposeRule
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5147'>FLINK-5147</a>] -         StreamingOperatorsITCase.testGroupedFoldOperation failed on Travis
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5149'>FLINK-5149</a>] -         ContinuousEventTimeTrigger doesn&#39;t fire at the end of the window
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5150'>FLINK-5150</a>] -         WebUI metric-related resource leak
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5154'>FLINK-5154</a>] -         Duplicate TypeSerializer when writing RocksDB Snapshot
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5158'>FLINK-5158</a>] -         Handle ZooKeeperCompletedCheckpointStore exceptions in CheckpointCoordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5160'>FLINK-5160</a>] -         SecurityContextTest#testCreateInsecureHadoopCtx fails on windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5162'>FLINK-5162</a>] -         BlobRecoveryItCase#testBlobServerRecovery fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5164'>FLINK-5164</a>] -         Hadoop-compat IOFormat tests fail on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5173'>FLINK-5173</a>] -         Upgrade RocksDB dependency
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5179'>FLINK-5179</a>] -         MetricRegistry life-cycle issues with HA
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5184'>FLINK-5184</a>] -         Error result of compareSerialized in RowComparator class
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5193'>FLINK-5193</a>] -         Recovering all jobs fails completely if a single recovery fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5197'>FLINK-5197</a>] -         Late JobStatusChanged messages can interfere with running jobs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5206'>FLINK-5206</a>] -         Flakey PythonPlanBinderTest
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5209'>FLINK-5209</a>] -         Fix TaskManager metrics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5214'>FLINK-5214</a>] -         Clean up checkpoint files when failing checkpoint operation on TM
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5216'>FLINK-5216</a>] -         CheckpointCoordinator&#39;s &#39;minPauseBetweenCheckpoints&#39; refers to checkpoint start rather then checkpoint completion
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5218'>FLINK-5218</a>] -         Eagerly close checkpoint streams on cancellation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5221'>FLINK-5221</a>] -         Checkpointed workless in Window Operator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5228'>FLINK-5228</a>] -         LocalInputChannel re-trigger request and release deadlock
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5229'>FLINK-5229</a>] -         Cleanup StreamTaskStates if a checkpoint operation of a subsequent operator fails 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5247'>FLINK-5247</a>] -         Fix incorrect check in allowedLateness() method. Make it a no-op for non-event time windows.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5248'>FLINK-5248</a>] -         SavepointITCase doesn&#39;t catch savepoint restore failure
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5261'>FLINK-5261</a>] -         ScheduledDropwizardReporter does not properly clean up metrics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5267'>FLINK-5267</a>] -         TaskManager logs not scrollable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5274'>FLINK-5274</a>] -         LocalInputChannel throws NPE if partition reader is released
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5275'>FLINK-5275</a>] -         InputChanelDeploymentDescriptors throws misleading Exception if producer failed/cancelled
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5285'>FLINK-5285</a>] -         CancelCheckpointMarker flood when using at least once mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5289'>FLINK-5289</a>] -         NPE when using value state on non-keyed stream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5292'>FLINK-5292</a>] -         Make the operators for 1.1-&gt;1.2 backwards compatible.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5296'>FLINK-5296</a>] -         Expose the old AlignedWindowOperators to the user through explicit commands.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5298'>FLINK-5298</a>] -         TaskManager crashes when TM log not existant
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5307'>FLINK-5307</a>] -         Log configuration for every reporter
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5320'>FLINK-5320</a>] -         Fix result TypeInformation in WindowedStream.fold(ACC, FoldFunction, WindowFunction)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5321'>FLINK-5321</a>] -         FlinkMiniCluster does not start Jobmanager MetricQueryService
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5323'>FLINK-5323</a>] -         CheckpointNotifier should be removed from docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5326'>FLINK-5326</a>] -         IllegalStateException: Bug in Netty consumer logic: reader queue got notified by partition about available data,  but none was available
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5329'>FLINK-5329</a>] -         Metric list is being cut off in the WebFrontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5330'>FLINK-5330</a>] -         Harden KafkaConsumer08Test
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5332'>FLINK-5332</a>] -         Non-thread safe FileSystem::initOutPathLocalFS() can cause lost files/directories in local execution
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5344'>FLINK-5344</a>] -         docs don&#39;t build in dockerized jekyll; -p option is broken
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5345'>FLINK-5345</a>] -         IOManager failed to properly clean up temp file directory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5349'>FLINK-5349</a>] -         Fix code sample for Twitter connector
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5350'>FLINK-5350</a>] -         Don&#39;t overwrite existing Jaas config property
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5356'>FLINK-5356</a>] -         librocksdbjni*.so is not deleted from /tmp directory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5357'>FLINK-5357</a>] -         WordCountTable fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5359'>FLINK-5359</a>] -         Job Exceptions view doesn&#39;t scroll 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5361'>FLINK-5361</a>] -         Flink shouldn&#39;t require Kerberos credentials
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5364'>FLINK-5364</a>] -         Rework JAAS configuration to support user-supplied entries
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5365'>FLINK-5365</a>] -         Mesos AppMaster/TaskManager should obey sigterm
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5369'>FLINK-5369</a>] -         Rework jsr305 and logging dependencies
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5375'>FLINK-5375</a>] -         Fix watermark documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5379'>FLINK-5379</a>] -         Flink CliFrontend does not return when not logged in with kerberos
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5380'>FLINK-5380</a>] -         Number of outgoing records not reported in web interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5381'>FLINK-5381</a>] -         Scrolling in some web interface pages doesn&#39;t work (taskmanager details, jobmanager config)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5382'>FLINK-5382</a>] -         Taskmanager log download button causes 404
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5392'>FLINK-5392</a>] -         flink-dist build failed when change scala version to 2.11
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5394'>FLINK-5394</a>] -         the estimateRowCount method of DataSetCalc didn&#39;t work
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5397'>FLINK-5397</a>] -         Fail to deserialize savepoints in v1.1 when there exist missing fields in class serialization descriptors
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5407'>FLINK-5407</a>] -         Savepoint for iterative Task fails.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5408'>FLINK-5408</a>] -         RocksDB initialization can fail with an UnsatisfiedLinkError in the presence of multiple classloaders
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5417'>FLINK-5417</a>] -         Fix the wrong config file name 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5418'>FLINK-5418</a>] -         Estimated row size does not support nested types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5419'>FLINK-5419</a>] -         Taskmanager metrics not accessible via REST
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5427'>FLINK-5427</a>] -         Typo in the event_timestamps_watermarks doc
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5432'>FLINK-5432</a>] -         ContinuousFileMonitoringFunction is not monitoring nested files
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5434'>FLINK-5434</a>] -         Remove unsupported project() transformation from Scala DataStream docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5443'>FLINK-5443</a>] -         Create a path to migrate from the Rolling to the BucketingSink.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5444'>FLINK-5444</a>] -         Flink UI uses absolute URLs.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5450'>FLINK-5450</a>] -         WindowOperator logs about &quot;re-registering state from an older Flink version&quot; even though its not a restored window
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5464'>FLINK-5464</a>] -         MetricQueryService throws NullPointerException on JobManager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5467'>FLINK-5467</a>] -         Stateless chained tasks set legacy operator state
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5468'>FLINK-5468</a>] -         Restoring from a semi async rocksdb statebackend (1.1) to 1.2 fails with ClassNotFoundException
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5470'>FLINK-5470</a>] -         Requesting non-existing log/stdout file from TM crashes the TM
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5473'>FLINK-5473</a>] -         setMaxParallelism() higher than 1 is possible on non-parallel operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5482'>FLINK-5482</a>] -         QueryableStateClient does not recover from a failed lookup due to a non-running job
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5483'>FLINK-5483</a>] -         Link to &quot;linking modules not contained in binary distribution&quot; broken in all connector documentations
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5484'>FLINK-5484</a>] -         Kryo serialization changed between 1.1 and 1.2
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5492'>FLINK-5492</a>] -         BootstrapTools log wrong address of started ActorSystem
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5493'>FLINK-5493</a>] -         FlinkDistributionOverlay does not properly display missing environment variables
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5495'>FLINK-5495</a>] -         ZooKeeperMesosWorkerStore cannot be instantiated
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5496'>FLINK-5496</a>] -         ClassCastException when using Mesos HA mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5504'>FLINK-5504</a>] -         mesos-appmaster.sh logs to wrong directory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5518'>FLINK-5518</a>] -         HadoopInputFormat throws NPE when close() is called before open()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5520'>FLINK-5520</a>] -         Disable outer joins with non-equality predicates
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5530'>FLINK-5530</a>] -         race condition in AbstractRocksDBState#getSerializedValue
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5531'>FLINK-5531</a>] -         SSl code block formatting is broken
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5532'>FLINK-5532</a>] -         Make the marker WindowAssigners for the fast aligned windows non-extendable.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5549'>FLINK-5549</a>] -         TypeExtractor fails with RuntimeException, but should use GenericTypeInfo
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5556'>FLINK-5556</a>] -         BarrierBuffer resets bytes written on spiller roll over
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5560'>FLINK-5560</a>] -         Header in checkpoint stats summary misaligned
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5561'>FLINK-5561</a>] -         DataInputDeserializer#available returns one too few
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5562'>FLINK-5562</a>] -         Driver fixes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5578'>FLINK-5578</a>] -         Each time application is submitted to yarn, application id increases by two
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5580'>FLINK-5580</a>] -         Kerberos keytabs not working for YARN deployment mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5585'>FLINK-5585</a>] -         NullPointer Exception in JobManager.updateAccumulators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5602'>FLINK-5602</a>] -         Migration with RocksDB job led to NPE for next checkpoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5612'>FLINK-5612</a>] -         GlobPathFilter not-serializable exception
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5613'>FLINK-5613</a>] -         QueryableState: requesting a non-existing key in RocksDBStateBackend is not consistent with the MemoryStateBackend and FsStateBackend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5617'>FLINK-5617</a>] -         Check new public APIs in 1.2 release
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5626'>FLINK-5626</a>] -         Improve resource release in RocksDBKeyedStateBackend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5637'>FLINK-5637</a>] -         Default Flink configuration contains whitespace characters, causing parser WARNings
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5638'>FLINK-5638</a>] -         Deadlock when closing two chained async I/O operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5643'>FLINK-5643</a>] -         StateUtil.discardStateFuture fails when state future contains null value
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5660'>FLINK-5660</a>] -         Not properly cleaning PendingCheckpoints up
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5663'>FLINK-5663</a>] -         Checkpoint fails because of closed registry
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5666'>FLINK-5666</a>] -         Blob files are not cleaned up from ZK storage directory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5667'>FLINK-5667</a>] -         Possible state data loss when task fails while checkpointing
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5670'>FLINK-5670</a>] -         Local RocksDB directories not cleaned up
</li>
</ul>
                    
<h2>        Improvement
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2090'>FLINK-2090</a>] -         toString of CollectionInputFormat takes long time when the collection is huge
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2765'>FLINK-2765</a>] -         Upgrade hbase version for hadoop-2 to 1.2 release
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3042'>FLINK-3042</a>] -         Define a way to let types create their own TypeInformation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3347'>FLINK-3347</a>] -         TaskManager (or its ActorSystem) need to restart in case they notice quarantine
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3615'>FLINK-3615</a>] -         Add support for non-native SQL types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3670'>FLINK-3670</a>] -         Kerberos: Improving long-running streaming jobs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3677'>FLINK-3677</a>] -         FileInputFormat: Allow to specify include/exclude file name patterns
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3702'>FLINK-3702</a>] -         DataStream API PojoFieldAccessor doesn&#39;t support nested POJOs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3719'>FLINK-3719</a>] -         WebInterface: Moving the barrier between graph and stats
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3779'>FLINK-3779</a>] -         Add support for queryable state
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3787'>FLINK-3787</a>] -         Yarn client does not report unfulfillable container constraints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3866'>FLINK-3866</a>] -         StringArraySerializer claims type is immutable; shouldn&#39;t
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3869'>FLINK-3869</a>] -         WindowedStream.apply with FoldFunction is too restrictive
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3899'>FLINK-3899</a>] -         Document window processing with Reduce/FoldFunction + WindowFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3904'>FLINK-3904</a>] -         GlobalConfiguration doesn&#39;t ensure config has been loaded
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3921'>FLINK-3921</a>] -         StringParser not specifying encoding to use
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4023'>FLINK-4023</a>] -         Move Kafka consumer partition discovery from constructor to open()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4037'>FLINK-4037</a>] -         Introduce ArchivedExecutionGraph without any user classes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4068'>FLINK-4068</a>] -         Move constant computations out of code-generated `flatMap` functions.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4104'>FLINK-4104</a>] -         Restructure Gelly docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4129'>FLINK-4129</a>] -         Remove the example HITSAlgorithm
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4161'>FLINK-4161</a>] -         Quickstarts can exclude more flink-dist dependencies
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4179'>FLINK-4179</a>] -         Update TPCHQuery3Table example
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4189'>FLINK-4189</a>] -         Introduce symbols for internal use
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4190'>FLINK-4190</a>] -         Generalise RollingSink to work with arbitrary buckets
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4203'>FLINK-4203</a>] -         Improve Table API documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4204'>FLINK-4204</a>] -         Clean up gelly-examples
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4218'>FLINK-4218</a>] -         Sporadic &quot;java.lang.RuntimeException: Error triggering a checkpoint...&quot; causes task restarting
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4222'>FLINK-4222</a>] -         Allow Kinesis configuration to get credentials from AWS Metadata
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4241'>FLINK-4241</a>] -         Cryptic expression parser exceptions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4242'>FLINK-4242</a>] -         Improve validation exception messages
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4245'>FLINK-4245</a>] -         Metric naming improvements
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4247'>FLINK-4247</a>] -         CsvTableSource.getDataSet() expects Java ExecutionEnvironment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4248'>FLINK-4248</a>] -         CsvTableSource does not support reading SqlTimeTypeInfo types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4251'>FLINK-4251</a>] -         Add possiblity for the RMQ Streaming Sink to customize the queue
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4253'>FLINK-4253</a>] -         Rename &quot;recovery.mode&quot; config key to &quot;high-availability&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4260'>FLINK-4260</a>] -         Allow SQL&#39;s LIKE ESCAPE
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4268'>FLINK-4268</a>] -         Add a parsers for BigDecimal/BigInteger
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4281'>FLINK-4281</a>] -         Wrap all Calcite Exceptions in Flink Exceptions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4282'>FLINK-4282</a>] -         Add Offset Parameter to WindowAssigners
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4299'>FLINK-4299</a>] -         Show loss of job manager in Client
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4302'>FLINK-4302</a>] -         Add JavaDocs to MetricConfig
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4306'>FLINK-4306</a>] -         Fix Flink and Storm dependencies in flink-storm and flink-storm-examples
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4308'>FLINK-4308</a>] -         Allow uploaded jar directory to be configurable 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4310'>FLINK-4310</a>] -         Move BinaryCompatibility Check plugin to relevant projects
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4318'>FLINK-4318</a>] -         Make master docs build target version-specific
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4322'>FLINK-4322</a>] -         Unify CheckpointCoordinator and SavepointCoordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4340'>FLINK-4340</a>] -         Remove RocksDB Semi-Async Checkpoint Mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4366'>FLINK-4366</a>] -         Enforce parallelism=1 For AllWindowedStream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4369'>FLINK-4369</a>] -         EvictingWindowOperator Must Actually Evict Elements
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4378'>FLINK-4378</a>] -         Enable RollingSink to custom HDFS client configuration
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4396'>FLINK-4396</a>] -         GraphiteReporter class not found at startup of jobmanager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4410'>FLINK-4410</a>] -         Report more information about operator checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4431'>FLINK-4431</a>] -         Introduce a &quot;VisibleForTesting&quot; annotation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4435'>FLINK-4435</a>] -         Replace Guava&#39;s VisibleForTesting annotation with Flink&#39;s annotation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4439'>FLINK-4439</a>] -         Error message KafkaConsumer08 when all &#39;bootstrap.servers&#39; are invalid
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4445'>FLINK-4445</a>] -         Ignore unmatched state when restoring from savepoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4447'>FLINK-4447</a>] -         Include NettyConfig options on Configurations page
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4457'>FLINK-4457</a>] -         Make the ExecutionGraph independent of Akka
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4459'>FLINK-4459</a>] -         Introduce SlotProvider for Scheduler
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4478'>FLINK-4478</a>] -         Implement heartbeat logic
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4495'>FLINK-4495</a>] -         Running multiple jobs on yarn (without yarn-session)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4525'>FLINK-4525</a>] -         Drop the &quot;eager split pre-assignment&quot; code paths
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4527'>FLINK-4527</a>] -         Drop the &quot;flinkAccumulators&quot; from the Execution
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4539'>FLINK-4539</a>] -         Duplicate/inconsistent logic for physical memory size in classes &quot;Hardware&quot; and &quot;EnvironmentInformation&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4541'>FLINK-4541</a>] -         Support for SQL NOT IN operator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4543'>FLINK-4543</a>] -         Race Deadlock in SpilledSubpartitionViewTest
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4549'>FLINK-4549</a>] -         Test and document implicitly supported SQL functions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4550'>FLINK-4550</a>] -         Clearly define SQL operator table
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4552'>FLINK-4552</a>] -         Refactor WindowOperator/Trigger Tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4560'>FLINK-4560</a>] -         enforcer java version as 1.7
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4579'>FLINK-4579</a>] -         Add StateBackendFactory for RocksDB Backend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4599'>FLINK-4599</a>] -         Add &#39;explain()&#39; also to StreamTableEnvironment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4611'>FLINK-4611</a>] -         Make &quot;AUTO&quot; credential provider as default for Kinesis Connector
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4623'>FLINK-4623</a>] -         Create Physical Execution Plan of a DataStream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4625'>FLINK-4625</a>] -         Guard Flink processes against blocking shutdown hooks
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4638'>FLINK-4638</a>] -         Fix exception message for MemorySegment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4654'>FLINK-4654</a>] -         clean up docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4662'>FLINK-4662</a>] -         Bump Calcite version up to 1.9
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4668'>FLINK-4668</a>] -         Fix positive random int generation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4669'>FLINK-4669</a>] -         scala api createLocalEnvironment() function add default Configuration parameter
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4684'>FLINK-4684</a>] -         Remove obsolete classloader from CheckpointCoordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4704'>FLINK-4704</a>] -         Move Table API to org.apache.flink.table
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4715'>FLINK-4715</a>] -         TaskManager should commit suicide after cancellation failure
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4720'>FLINK-4720</a>] -         Implement an archived version of the execution graph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4723'>FLINK-4723</a>] -         Unify behaviour of committed offsets to Kafka / ZK for Kafka 0.8 and 0.9 consumer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4728'>FLINK-4728</a>] -         Replace reference equality with object equality
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4729'>FLINK-4729</a>] -         Use optional VertexCentric CombineFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4733'>FLINK-4733</a>] -         Port WebFrontend to new metric system
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4734'>FLINK-4734</a>] -         Remove use of Tuple setField for fixed position
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4736'>FLINK-4736</a>] -         Don&#39;t duplicate fields in Ordering
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4737'>FLINK-4737</a>] -         Add more compression algorithms to FileInputFormat
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4739'>FLINK-4739</a>] -         Adding packaging details for the Elasticsearch connector
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4745'>FLINK-4745</a>] -         Convert KafkaTableSource test to unit tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4751'>FLINK-4751</a>] -         Extend Flink&#39;s futures to support combining two futures
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4752'>FLINK-4752</a>] -         Improve session window documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4762'>FLINK-4762</a>] -         Use plural in time interval units
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4764'>FLINK-4764</a>] -         Introduce config options
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4771'>FLINK-4771</a>] -         Compression for AvroOutputFormat
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4772'>FLINK-4772</a>] -         Store metrics in MetricStore as strings
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4773'>FLINK-4773</a>] -         Introduce an OperatorIOMetricGroup
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4775'>FLINK-4775</a>] -         Simplify access to MetricStore
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4776'>FLINK-4776</a>] -         Move ExecutionGraph initialization into a dedicated class
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4780'>FLINK-4780</a>] -         Ability to use UDP protocol in metrics-graphite
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4787'>FLINK-4787</a>] -         Add REST API call for cancel-with-savepoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4792'>FLINK-4792</a>] -         Update documentation - FlinkML/QuickStart Guide
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4825'>FLINK-4825</a>] -         Implement a RexExecutor that uses Flink&#39;s code generation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4832'>FLINK-4832</a>] -         Count/Sum 0 elements
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4876'>FLINK-4876</a>] -         Allow web interface to be bound to a specific ip/interface/inetHost
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4881'>FLINK-4881</a>] -         Docker: Remove dependency on shared volumes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4892'>FLINK-4892</a>] -         Snapshot TimerService using Key-Grouped State
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4894'>FLINK-4894</a>] -         Don&#39;t block on buffer request after broadcastEvent 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4906'>FLINK-4906</a>] -         Use constants for the name of system-defined metrics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4913'>FLINK-4913</a>] -         Per-job Yarn clusters: include user jar in system class loader 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4917'>FLINK-4917</a>] -         Deprecate &quot;CheckpointedAsynchronously&quot; interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4923'>FLINK-4923</a>] -         Expose input/output buffers and bufferPool usage as a metric for a Task
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4924'>FLINK-4924</a>] -         Simplify Operator Test Harness Constructors
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4925'>FLINK-4925</a>] -         Integrate meters into IOMetricGroups
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4935'>FLINK-4935</a>] -         Submit job with savepoint via REST API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4936'>FLINK-4936</a>] -         Operator names for Gelly inputs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4939'>FLINK-4939</a>] -         GenericWriteAheadSink: Decouple the creating from the committing subtask for a pending checkpoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4943'>FLINK-4943</a>] -         flink-mesos/ConfigConstants: Typo: YYARN -&gt; YARN
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4946'>FLINK-4946</a>] -         Load jar files from subdirectories of lib
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4963'>FLINK-4963</a>] -         Tabulate edge direction for directed VertexMetrics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4970'>FLINK-4970</a>] -         Parameterize vertex value for SSSP
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4972'>FLINK-4972</a>] -         CoordinatorShutdownTest relies on race condition for success
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4975'>FLINK-4975</a>] -         Add a limit for how much data may be buffered during checkpoint alignment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4983'>FLINK-4983</a>] -         Web UI: Add favicon
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4996'>FLINK-4996</a>] -         Make CrossHint @Public
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5000'>FLINK-5000</a>] -         Rename Methods in ManagedInitializationContext
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5003'>FLINK-5003</a>] -         Provide Access to State Stores in Operator Snapshot Context
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5004'>FLINK-5004</a>] -         Add task manager option to disable queryable state server
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5008'>FLINK-5008</a>] -         Update quickstart documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5010'>FLINK-5010</a>] -         Decouple the death watch parameters from the Akka ask timeout
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5012'>FLINK-5012</a>] -         Provide Timestamp in TimelyFlatMapFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5020'>FLINK-5020</a>] -         Make the GenericWriteAheadSink rescalable.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5021'>FLINK-5021</a>] -         Makes the ContinuousFileReaderOperator rescalable.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5022'>FLINK-5022</a>] -         Suppress RejectedExecutionException when the Executor is shut down
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5026'>FLINK-5026</a>] -         Rename TimelyFlatMap to Process
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5034'>FLINK-5034</a>] -         Don&#39;t Write StateDescriptor to RocksDB Snapshot
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5035'>FLINK-5035</a>] -         Don&#39;t Write TypeSerializer to Heap State Snapshot
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5046'>FLINK-5046</a>] -         Avoid redundant serialization when creating the TaskDeploymentDescriptor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5054'>FLINK-5054</a>] -         Make the BucketingSink rescalable.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5096'>FLINK-5096</a>] -         Make the RollingSink rescalable.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5110'>FLINK-5110</a>] -         Remove the AbstractAlignedProcessingTimeWindowOperator.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5113'>FLINK-5113</a>] -         Make all Testing Functions implement CheckpointedFunction Interface.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5123'>FLINK-5123</a>] -         Add description how to do proper shading to Flink docs.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5124'>FLINK-5124</a>] -         Support more temporal arithmetic
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5128'>FLINK-5128</a>] -         Get Kafka partitions in FlinkKafkaProducer only if a partitioner is set
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5145'>FLINK-5145</a>] -         WebInterface to aggressive in pulling metrics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5146'>FLINK-5146</a>] -         Improved resource cleanup in RocksDB keyed state backend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5155'>FLINK-5155</a>] -         Deprecate ValueStateDescriptor constructors with default value
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5159'>FLINK-5159</a>] -         Improve perfomance of inner joins with a single row input
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5163'>FLINK-5163</a>] -         Make the production functions rescalable (apart from the Rolling/Bucketing Sinks)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5168'>FLINK-5168</a>] -         Scaladoc annotation link use [[]] instead of {@link}
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5169'>FLINK-5169</a>] -         Make consumption of input channels fair
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5181'>FLINK-5181</a>] -         Add Tests in StateBackendTestBase that verify Default-Value Behaviour
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5185'>FLINK-5185</a>] -         Decouple BatchTableSourceScan with TableSourceTable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5186'>FLINK-5186</a>] -         Move Row and RowTypeInfo into Flink core
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5192'>FLINK-5192</a>] -         Provide better log config templates
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5194'>FLINK-5194</a>] -         Log heartbeats on TRACE level
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5196'>FLINK-5196</a>] -         Don&#39;t log InputChannelDescriptor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5198'>FLINK-5198</a>] -         Overwrite TaskState toString
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5199'>FLINK-5199</a>] -         Improve logging of submitted job graph actions in HA case
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5201'>FLINK-5201</a>] -         Promote loaded config properties to INFO
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5207'>FLINK-5207</a>] -         Decrease HadoopFileSystem logging
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5211'>FLINK-5211</a>] -         Include an example configuration for all reporters
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5213'>FLINK-5213</a>] -         Missing @Override in Task
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5223'>FLINK-5223</a>] -         Add documentation of UDTF in Table API &amp; SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5224'>FLINK-5224</a>] -         Improve UDTF: emit rows directly instead of buffering them
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5226'>FLINK-5226</a>] -         Eagerly project unused attributes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5237'>FLINK-5237</a>] -         Consolidate and harmonize Window Translation Tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5240'>FLINK-5240</a>] -         Properly Close StateBackend in StreamTask when closing/canceling
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5249'>FLINK-5249</a>] -         description of datastream rescaling doesn&#39;t match the figure
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5250'>FLINK-5250</a>] -         Make AbstractUdfStreamOperator aware of WrappingFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5251'>FLINK-5251</a>] -         Decouple StreamTableSourceScan with TableSourceTable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5255'>FLINK-5255</a>] -         Improve single row check in DataSetSingleRowJoinRule
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5257'>FLINK-5257</a>] -         Display optimized logical plan when explaining table
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5258'>FLINK-5258</a>] -         reorganize the docs to improve navigation and reduce duplication
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5259'>FLINK-5259</a>] -         wrong execution environment in retry delays example
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5266'>FLINK-5266</a>] -         Eagerly project unused fields when selecting aggregation fields
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5278'>FLINK-5278</a>] -         Improve Task and checkpoint logging 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5280'>FLINK-5280</a>] -         Refactor TableSource
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5304'>FLINK-5304</a>] -         Change method name from crossApply to join in Table API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5306'>FLINK-5306</a>] -         Display checkpointing configuration details in web UI &quot;Configuration&quot; tab
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5310'>FLINK-5310</a>] -         Harden the RocksDB JNI library loading
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5311'>FLINK-5311</a>] -         Write user documentation for BipartiteGraph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5327'>FLINK-5327</a>] -         Remove IOException from StateObject::getStateSize
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5335'>FLINK-5335</a>] -         Allow ListCheckpointed user functions to return null
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5343'>FLINK-5343</a>] -         Add more option to CsvTableSink
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5366'>FLINK-5366</a>] -         Add end-to-end tests for Savepoint Backwards Compatibility
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5367'>FLINK-5367</a>] -         restore updates lost when merging recent doc refactoring
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5368'>FLINK-5368</a>] -         Let Kafka consumer show something when it fails to read one topic out of topic list
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5371'>FLINK-5371</a>] -         Add documentation for async I/O
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5377'>FLINK-5377</a>] -         Improve savepoint docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5395'>FLINK-5395</a>] -         support locally build distribution by script create_release_files.sh
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5404'>FLINK-5404</a>] -         Consolidate and update S3 documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5412'>FLINK-5412</a>] -         Enable RocksDB tests on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5421'>FLINK-5421</a>] -         Explicit restore method in Snapshotable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5424'>FLINK-5424</a>] -         Improve Restart Strategy Logging
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5430'>FLINK-5430</a>] -         Bring documentation up to speed for current feature set
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5438'>FLINK-5438</a>] -         Typo in JobGraph generator Exception 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5442'>FLINK-5442</a>] -         Add test to fix ordinals of serialized enum StateDescriptor.Type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5446'>FLINK-5446</a>] -         System metrics reference incomplete
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5447'>FLINK-5447</a>] -         Sync documentation of built-in functions for Table API with SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5448'>FLINK-5448</a>] -         Fix typo in StateAssignmentOperation Exception
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5451'>FLINK-5451</a>] -         Extend JMX metrics documentation section
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5452'>FLINK-5452</a>] -         Make table unit tests pass under cluster mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5466'>FLINK-5466</a>] -         Make production environment default in gulpfile
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5480'>FLINK-5480</a>] -         User-provided hashes for operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5485'>FLINK-5485</a>] -         Mark compiled web frontend files as binary when processed by git diff
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5507'>FLINK-5507</a>] -         remove queryable list state sink
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5508'>FLINK-5508</a>] -         Remove Mesos dynamic class loading
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5512'>FLINK-5512</a>] -         RabbitMQ documentation should inform that exactly-once holds for RMQSource only when parallelism is 1  
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5515'>FLINK-5515</a>] -         fix unused kvState.getSerializedValue call in KvStateServerHandler
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5521'>FLINK-5521</a>] -         remove unused KvStateRequestSerializer#serializeList
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5528'>FLINK-5528</a>] -         tests: reduce the retry delay in QueryableStateITCase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5557'>FLINK-5557</a>] -         Fix link in library methods
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5559'>FLINK-5559</a>] -         queryable state: KvStateRequestSerializer#deserializeKeyAndNamespace() throws an IOException without own failure message if deserialisation fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5574'>FLINK-5574</a>] -         Add checkpoint statistics docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5576'>FLINK-5576</a>] -         extend deserialization functions of KvStateRequestSerializer to detect unconsumed bytes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5609'>FLINK-5609</a>] -         Add last update time to docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5610'>FLINK-5610</a>] -         Rename Installation and Setup to Project Setup
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5615'>FLINK-5615</a>] -         queryable state: execute the QueryableStateITCase for all three state back-ends
</li>
</ul>
                
<h2>        New Feature
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1984'>FLINK-1984</a>] -         Integrate Flink with Apache Mesos
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3060'>FLINK-3060</a>] -         Add possibility to integrate custom types into the TypeExtractor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3097'>FLINK-3097</a>] -         Add support for custom functions in Table API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3239'>FLINK-3239</a>] -         Support for Kerberos enabled Kafka 0.9.0.0
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3674'>FLINK-3674</a>] -         Add an interface for Time aware User Functions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3755'>FLINK-3755</a>] -         Introduce key groups for key-value state to support dynamic scaling
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3848'>FLINK-3848</a>] -         Add ProjectableTableSource interface and translation rule
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3874'>FLINK-3874</a>] -         Add a Kafka TableSink with JSON serialization
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3929'>FLINK-3929</a>] -         Support for Kerberos Authentication with Keytab Credential
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3931'>FLINK-3931</a>] -         Implement Transport Encryption (SSL/TLS)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3932'>FLINK-3932</a>] -         Implement State Backend Security
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3940'>FLINK-3940</a>] -         Add support for ORDER BY OFFSET FETCH
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4180'>FLINK-4180</a>] -         Create a batch SQL example
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4181'>FLINK-4181</a>] -         Add a basic streaming Table API example
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4294'>FLINK-4294</a>] -         Allow access of composite type fields
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4359'>FLINK-4359</a>] -         Add INTERVAL type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4379'>FLINK-4379</a>] -         Add Rescalable Non-Partitioned State
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4391'>FLINK-4391</a>] -         Provide support for asynchronous operations over streams
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4420'>FLINK-4420</a>] -         Introduce star(*) to select all of the columns in the table
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4469'>FLINK-4469</a>] -         Add support for user defined table function in Table API &amp; SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4546'>FLINK-4546</a>] -          Remove STREAM keyword in Stream SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4554'>FLINK-4554</a>] -         Add support for array types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4576'>FLINK-4576</a>] -         Low Watermark Service in JobManager for Streaming Sources
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4639'>FLINK-4639</a>] -         Make Calcite features more pluggable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4643'>FLINK-4643</a>] -         Average Clustering Coefficient
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4664'>FLINK-4664</a>] -         Add translator to NullValue
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4717'>FLINK-4717</a>] -         Naive version of atomic stop signal with savepoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4844'>FLINK-4844</a>] -         Partitionable Raw Keyed/Operator State
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4861'>FLINK-4861</a>] -         Package optional project artifacts
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4934'>FLINK-4934</a>] -         Triadic Census
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4960'>FLINK-4960</a>] -         Allow the AbstractStreamOperatorTestHarness to test scaling down
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4976'>FLINK-4976</a>] -         Add a way to abort in flight checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5265'>FLINK-5265</a>] -         Introduce state handle replication mode for CheckpointCoordinator
</li>
</ul>
                                                    
<h2>        Task
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4315'>FLINK-4315</a>] -         Deprecate Hadoop dependent methods in flink-java
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4429'>FLINK-4429</a>] -         Move Redis Sink from Flink to Bahir
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4446'>FLINK-4446</a>] -         Move Flume Sink from Flink to Bahir
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4676'>FLINK-4676</a>] -         Merge flink-batch-connectors and flink-streaming-connectors modules
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4778'>FLINK-4778</a>] -         Update program example in /docs/setup/cli.md due to the change in FLINK-2021
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4891'>FLINK-4891</a>] -         Remove flink-contrib/flink-operator-stats
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4895'>FLINK-4895</a>] -         Drop support for Hadoop 1
</li>
</ul>
            
<h2>        Test
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4842'>FLINK-4842</a>] -         Introduce test to enforce order of operator / udf lifecycles 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4843'>FLINK-4843</a>] -         Introduce Test for FsCheckpointStateOutputStream::getPos
</li>
</ul>
        
<h2>        Wish
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4799'>FLINK-4799</a>] -         Re-add build-target symlink to project root
</li>
</ul>
