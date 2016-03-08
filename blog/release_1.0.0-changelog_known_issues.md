---
title: "Release 1.0.0 – Changelog and Known Issues"
---

* toc
{:toc}

## Changelog
    
### Sub-task

<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-7'>FLINK-7</a>] -         [GitHub] Enable Range Partitioner
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-146'>FLINK-146</a>] -         Sorted output not working
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1982'>FLINK-1982</a>] -         Remove dependencies on Record for Flink runtime and core
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2676'>FLINK-2676</a>] -         Add abstraction for keyed window state
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2680'>FLINK-2680</a>] -         Create a dedicated aligned-event time window operator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2730'>FLINK-2730</a>] -         Add CPU/Network utilization graphs to new web dashboard
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2732'>FLINK-2732</a>] -         Add access to the TaskManagers&#39; log file and out file in the web dashboard.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2850'>FLINK-2850</a>] -         Limit the types of jobs which can run in detached mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2853'>FLINK-2853</a>] -         Apply JMH on MutableHashTablePerformanceBenchmark class.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2869'>FLINK-2869</a>] -         Apply JMH on IOManagerPerformanceBenchmark class.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2889'>FLINK-2889</a>] -         Apply JMH on LongSerializationSpeedBenchmark class
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2890'>FLINK-2890</a>] -         Apply JMH on StringSerializationSpeedBenchmark class.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2900'>FLINK-2900</a>] -         Remove Record-API dependencies from Hadoop Compat module
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2901'>FLINK-2901</a>] -         Several flink-test ITCases depend on Record API features
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2906'>FLINK-2906</a>] -         Remove Record-API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2919'>FLINK-2919</a>] -         Apply JMH on FieldAccessMinibenchmark class.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2920'>FLINK-2920</a>] -         Apply JMH on KryoVersusAvroMinibenchmark class.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2933'>FLINK-2933</a>] -         Flink scala libraries exposed with maven should carry scala version
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2972'>FLINK-2972</a>] -         Remove Twitter Chill dependency from flink-java module
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3057'>FLINK-3057</a>] -         [py] Provide a way to pass information back to the plan process
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3070'>FLINK-3070</a>] -         Create an asynchronous state handle interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3071'>FLINK-3071</a>] -         Add asynchronous materialization thread
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3140'>FLINK-3140</a>] -         NULL value data layout in Row Serializer/Comparator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3195'>FLINK-3195</a>] -         Restructure examples projects and package streaming examples
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3201'>FLINK-3201</a>] -         Enhance Partitioned State Interface with State Types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3208'>FLINK-3208</a>] -         Rename Gelly vertex-centric model to scatter-gather
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3224'>FLINK-3224</a>] -         The Streaming API does not call setInputType if a format implements InputTypeConfigurable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3275'>FLINK-3275</a>] -         [py] Add support for Dataset.setParallelism()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3285'>FLINK-3285</a>] -         Skip Maven deployment of flink-java8
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3312'>FLINK-3312</a>] -         Add convenience accessor methods for extended state interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3327'>FLINK-3327</a>] -         Attach the ExecutionConfig to the JobGraph and make it accessible to the AbstractInvocable.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3363'>FLINK-3363</a>] -         JobManager does not shut down dedicated executor properly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3365'>FLINK-3365</a>] -         BlobLibraryCacheManager does not shutdown Timer thread
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3371'>FLINK-3371</a>] -         Move TriggerCotext and TriggerResult to their own classes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3384'>FLINK-3384</a>] -         Create atomic closable queue for communication between Kafka Threads
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3388'>FLINK-3388</a>] -         Expose task accumulators via JMX
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3401'>FLINK-3401</a>] -         AscendingTimestampExtractor should not fail on order violation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3437'>FLINK-3437</a>] -         Fix UI router state for job plan
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3468'>FLINK-3468</a>] -         Change Timestamp Extractors to not support negative timestamps
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3470'>FLINK-3470</a>] -         EventTime WindowAssigners should error on negative timestamps
</li>
</ul>
                            
### Bug

<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1278'>FLINK-1278</a>] -         Remove the Record special code paths
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1644'>FLINK-1644</a>] -         WebClient dies when no ExecutionEnvironment in main method
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1989'>FLINK-1989</a>] -         Sorting of POJO data set from TableEnv yields NotSerializableException
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2115'>FLINK-2115</a>] -         TableAPI throws ExpressionException for &quot;Dangling GroupBy operation&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2263'>FLINK-2263</a>] -         ExecutionGraph uses Thread.sleep to delay execution retries
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2315'>FLINK-2315</a>] -         Hadoop Writables cannot exploit implementing NormalizableKey
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2348'>FLINK-2348</a>] -         IterateExampleITCase failing
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2351'>FLINK-2351</a>] -         Deprecate config builders in InputFormats and Output formats
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2369'>FLINK-2369</a>] -         On Windows, in testFailingSortingDataSinkTask the temp file is not removed
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2392'>FLINK-2392</a>] -         Instable test in flink-yarn-tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2443'>FLINK-2443</a>] -         [CompactingHashTable] GSA Connected Components fails with NPE
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2491'>FLINK-2491</a>] -         Operators are not participating in state checkpointing in some cases
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2504'>FLINK-2504</a>] -         ExternalSortLargeRecordsITCase.testSortWithLongAndShortRecordsMixed failed spuriously
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2586'>FLINK-2586</a>] -         Unstable Storm Compatibility Tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2608'>FLINK-2608</a>] -         Arrays.asList(..) does not work with CollectionInputFormat
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2622'>FLINK-2622</a>] -         Scala DataStream API does not have writeAsText method which supports WriteMode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2624'>FLINK-2624</a>] -         RabbitMQ source / sink should participate in checkpointing
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2662'>FLINK-2662</a>] -         CompilerException: &quot;Bug: Plan generation for Unions picked a ship strategy between binary plan operators.&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2671'>FLINK-2671</a>] -         Instable Test StreamCheckpointNotifierITCase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2674'>FLINK-2674</a>] -         Rework windowing logic
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2695'>FLINK-2695</a>] -         KafkaITCase.testConcurrentProducerConsumerTopology failed on Travis
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2719'>FLINK-2719</a>] -         ProcessFailureStreamingRecoveryITCase&gt;AbstractProcessFailureRecoveryTest.testTaskManagerProcessFailure failed on Travis
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2739'>FLINK-2739</a>] -         Release script depends on the order of parent module information
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2747'>FLINK-2747</a>] -         TypeExtractor does not correctly analyze Scala Immutables (AnyVal)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2752'>FLINK-2752</a>] -         Documentation is not easily differentiable from the Flink homepage
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2757'>FLINK-2757</a>] -         DataSinkTaskTest fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2758'>FLINK-2758</a>] -          TaskManagerRegistrationTest fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2759'>FLINK-2759</a>] -         TaskManagerProcessReapingTest fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2769'>FLINK-2769</a>] -         Web dashboard port not configurable on client side
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2771'>FLINK-2771</a>] -         IterateTest.testSimpleIteration fails on Travis
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2797'>FLINK-2797</a>] -         CLI: Missing option to submit jobs in detached mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2799'>FLINK-2799</a>] -         Yarn tests cannot be executed with DEBUG log level
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2800'>FLINK-2800</a>] -         kryo serialization problem
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2823'>FLINK-2823</a>] -         YARN client should report a proper exception if Hadoop Env variables are not set
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2826'>FLINK-2826</a>] -         transformed is modified in BroadcastVariableMaterialization#decrementReferenceInternal without proper locking
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2827'>FLINK-2827</a>] -         Potential resource leak in TwitterSource#loadAuthenticationProperties()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2832'>FLINK-2832</a>] -         Failing test: RandomSamplerTest.testReservoirSamplerWithReplacement
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2838'>FLINK-2838</a>] -         Inconsistent use of URL and Path classes for resources
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2845'>FLINK-2845</a>] -         TimestampITCase.testWatermarkPropagation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2879'>FLINK-2879</a>] -         Links in documentation are broken
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2913'>FLINK-2913</a>] -         Close of ObjectOutputStream should be enclosed in finally block in FsStateBackend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2914'>FLINK-2914</a>] -         Missing break in ZooKeeperSubmittedJobGraphStore#SubmittedJobGraphsPathCacheListener#childEvent()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2930'>FLINK-2930</a>] -         ExecutionConfig execution retry delay not respected
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2934'>FLINK-2934</a>] -         Remove placehoder pages in Web dashboard
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2937'>FLINK-2937</a>] -         Typo in Quickstart-&gt;Scala API-&gt;Alternative Build Tools: SBT
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2938'>FLINK-2938</a>] -         Streaming docs not in sync with latest state changes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2942'>FLINK-2942</a>] -         Dangling operators in web UI&#39;s program visualization (non-deterministic)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2950'>FLINK-2950</a>] -         Markdown presentation problem in SVM documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2954'>FLINK-2954</a>] -         Not able to pass custom environment variables in cluster to processes that spawning TaskManager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2958'>FLINK-2958</a>] -         StreamingJobGraphGenerator sets hard coded number execution retry
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2963'>FLINK-2963</a>] -         Dependence on SerializationUtils#deserialize() should be avoided
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2967'>FLINK-2967</a>] -         TM address detection might not always detect the right interface on slow networks / overloaded JMs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2977'>FLINK-2977</a>] -         Cannot access HBase in a Kerberos secured Yarn cluster
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2979'>FLINK-2979</a>] -         RollingSink does not work with Hadoop 2.7.1
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2987'>FLINK-2987</a>] -         Flink 0.10 fails to start on YARN 2.6.0
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2989'>FLINK-2989</a>] -         Job Cancel button doesn&#39;t work on Yarn
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2990'>FLINK-2990</a>] -         Scala 2.11 build fails to start on YARN
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2992'>FLINK-2992</a>] -         New Windowing code is using SerializationUtils with wrong classloader
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3000'>FLINK-3000</a>] -         Add ShutdownHook to YARN CLI to prevent lingering sessions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3005'>FLINK-3005</a>] -         Commons-collections object deserialization remote command execution vulnerability
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3009'>FLINK-3009</a>] -         Cannot build docs with Jekyll 3.0.0
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3011'>FLINK-3011</a>] -         Cannot cancel failing/restarting streaming job from the command line
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3013'>FLINK-3013</a>] -         Incorrect package declaration in GellyScalaAPICompletenessTest.scala
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3019'>FLINK-3019</a>] -         CLI does not list running/restarting jobs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3020'>FLINK-3020</a>] -         Local streaming execution: set number of task manager slots to the maximum parallelism
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3022'>FLINK-3022</a>] -         Broken link &#39;Working With State&#39; in Fault Tolerance Section of Stream Programming Guide
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3024'>FLINK-3024</a>] -         TimestampExtractor Does not Work When returning Long.MIN_VALUE
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3025'>FLINK-3025</a>] -         Flink Kafka consumer may get stuck due to Kafka/Zookeeper client bug
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3032'>FLINK-3032</a>] -         Flink does not start on Hadoop 2.7.1 (HDP), due to class conflict
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3043'>FLINK-3043</a>] -         Kafka Connector description in Streaming API guide is wrong/outdated
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3047'>FLINK-3047</a>] -         Local batch execution: set number of task manager slots to the maximum parallelism
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3048'>FLINK-3048</a>] -         DataSinkTaskTest.testCancelDataSinkTask
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3052'>FLINK-3052</a>] -         Optimizer does not push properties out of bulk iterations
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3054'>FLINK-3054</a>] -         Remove R (return) type variable from SerializationSchema
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3059'>FLINK-3059</a>] -         Javadoc fix for DataSet.writeAsText()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3061'>FLINK-3061</a>] -         Kafka Consumer is not failing if broker is not available
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3062'>FLINK-3062</a>] -         Kafka Producer is not failing if broker is not available/no partitions available
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3067'>FLINK-3067</a>] -         Kafka source fails during checkpoint notifications with NPE
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3080'>FLINK-3080</a>] -         Cannot union a data stream with a product of itself
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3081'>FLINK-3081</a>] -         Kafka Periodic Offset Committer does not properly terminate on canceling
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3082'>FLINK-3082</a>] -         Confusing error about ManualTimestampSourceFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3087'>FLINK-3087</a>] -         Table API do not support multi count in aggregation.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3098'>FLINK-3098</a>] -         Cast from Date to Long throw compile error.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3100'>FLINK-3100</a>] -         Signal handler prints error on normal shutdown of cluster
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3101'>FLINK-3101</a>] -         Flink Kafka consumer crashes with NPE when it sees deleted record
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3103'>FLINK-3103</a>] -         Remove synchronization in FsStateBackend#FsCheckpointStateOutputStream#close()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3108'>FLINK-3108</a>] -         JoinOperator&#39;s with() calls the wrong TypeExtractor method
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3117'>FLINK-3117</a>] -         Storm Tick Tuples are not supported
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3118'>FLINK-3118</a>] -         Check if MessageFunction implements ResultTypeQueryable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3121'>FLINK-3121</a>] -         Watermark forwarding does not work for sources not producing any data
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3125'>FLINK-3125</a>] -         Web dashboard does not start when log files are not found
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3134'>FLINK-3134</a>] -         Make YarnJobManager&#39;s allocate call asynchronous
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3136'>FLINK-3136</a>] -         Scala Closure Cleaner uses wrong ASM import
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3138'>FLINK-3138</a>] -         Method References are not supported as lambda expressions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3143'>FLINK-3143</a>] -         Update Clojure Cleaner&#39;s ASM references to ASM5
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3144'>FLINK-3144</a>] -         [storm] LocalCluster prints nothing without a configured logger
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3145'>FLINK-3145</a>] -         Storm examples can&#39;t be run without flink-java as dependency
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3151'>FLINK-3151</a>] -         YARN kills Flink TM containers due to memory overuse (outside heap/offheap)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3156'>FLINK-3156</a>] -         FlinkKafkaConsumer fails with NPE on notifyCheckpointComplete
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3157'>FLINK-3157</a>] -         Web frontend json files contain author attribution 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3166'>FLINK-3166</a>] -         The first program in ObjectReuseITCase has the wrong expected result, and it succeeds
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3171'>FLINK-3171</a>] -         Consolidate zoo of wrapper classes for input/output-stream to data-input/output-view
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3173'>FLINK-3173</a>] -         Bump org.apache.httpcomponents.httpclient version to 4.2.6
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3175'>FLINK-3175</a>] -         KafkaITCase.testOffsetAutocommitTest
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3179'>FLINK-3179</a>] -         Combiner is not injected if Reduce or GroupReduce input is explicitly partitioned
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3180'>FLINK-3180</a>] -         MemoryLogger does not log direct memory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3185'>FLINK-3185</a>] -         Silent failure during job graph recovery
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3188'>FLINK-3188</a>] -         Deletes in Kafka source should be passed on to KeyedDeserializationSchema
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3189'>FLINK-3189</a>] -         Error while parsing job arguments passed by CLI
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3196'>FLINK-3196</a>] -         InputStream should be closed in EnvironmentInformation#getRevisionInformation()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3197'>FLINK-3197</a>] -         InputStream not closed in BinaryInputFormat#createStatistics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3206'>FLINK-3206</a>] -         Heap size for non-pre-allocated off-heap memory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3218'>FLINK-3218</a>] -         Merging Hadoop configurations overrides user parameters
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3220'>FLINK-3220</a>] -         Flink does not start on Hortonworks Sandbox 2.3.2 due to missing class
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3236'>FLINK-3236</a>] -         Flink user code classloader should have Flink classloader as parent classloader
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3240'>FLINK-3240</a>] -         Remove or document DataStream(.global|.forward)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3242'>FLINK-3242</a>] -         User-specified StateBackend is not Respected if Checkpointing is Disabled
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3243'>FLINK-3243</a>] -         Fix Interplay of TimeCharacteristic and Time Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3247'>FLINK-3247</a>] -         Kafka Connector unusable with quickstarts - shading issue
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3248'>FLINK-3248</a>] -         RMQSource does not provide a constructor for credentials or other options
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3250'>FLINK-3250</a>] -         Savepoint coordinator requires too strict parallelism match
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3251'>FLINK-3251</a>] -         Checkpoint stats show ghost numbers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3252'>FLINK-3252</a>] -         Checkpoint stats only displayed after click on graph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3254'>FLINK-3254</a>] -         CombineFunction interface not respected
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3255'>FLINK-3255</a>] -         Chaining behavior should not depend on parallelism
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3260'>FLINK-3260</a>] -         ExecutionGraph gets stuck in state FAILING
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3261'>FLINK-3261</a>] -         Tasks should eagerly report back when they cannot start a checkpoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3266'>FLINK-3266</a>] -         LocalFlinkMiniCluster leaks resources when multiple jobs are submitted
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3267'>FLINK-3267</a>] -         Disable reference tracking in Kryo fallback serializer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3268'>FLINK-3268</a>] -         Unstable test JobManagerSubmittedJobGraphsRecoveryITCase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3271'>FLINK-3271</a>] -         Using webhdfs in a flink topology throws classnotfound exception
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3274'>FLINK-3274</a>] -         Prefix Kafka connector accumulators with unique id
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3280'>FLINK-3280</a>] -         Wrong usage of Boolean.getBoolean()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3281'>FLINK-3281</a>] -         IndexOutOfBoundsException when range-partitioning empty DataSet 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3286'>FLINK-3286</a>] -         Remove JDEB Debian Package code from flink-dist
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3287'>FLINK-3287</a>] -         Flink Kafka Consumer fails due to Curator version conflict
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3289'>FLINK-3289</a>] -         Double reference to flink-contrib
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3292'>FLINK-3292</a>] -         Bug in flink-jdbc. Not all JDBC drivers supported
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3293'>FLINK-3293</a>] -         Custom Application Name on YARN is ignored in deploy jobmanager mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3296'>FLINK-3296</a>] -         DataStream.write*() methods are not flushing properly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3300'>FLINK-3300</a>] -         Concurrency Bug in Yarn JobManager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3304'>FLINK-3304</a>] -         AvroOutputFormat.setSchema() doesn&#39;t work in yarn-cluster mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3314'>FLINK-3314</a>] -         Early cancel calls can cause Tasks to not cancel properly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3322'>FLINK-3322</a>] -         MemoryManager creates too much GC pressure with iterative jobs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3328'>FLINK-3328</a>] -         Incorrectly shaded dependencies in flink-runtime
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3333'>FLINK-3333</a>] -         Documentation about object reuse should be improved
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3337'>FLINK-3337</a>] -         mvn test fails on flink-runtime because curator classes not found
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3338'>FLINK-3338</a>] -         Kafka deserialization issue - ClassNotFoundException
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3339'>FLINK-3339</a>] -         Checkpointing NPE when using filterWithState
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3340'>FLINK-3340</a>] -         Fix object juggling in drivers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3341'>FLINK-3341</a>] -         Kafka connector&#39;s &#39;auto.offset.reset&#39; inconsistent with Kafka
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3342'>FLINK-3342</a>] -         Operator checkpoint statistics state size overflow 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3350'>FLINK-3350</a>] -         Increase timeouts on Travis Builds
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3351'>FLINK-3351</a>] -         RocksDB Backend cannot determine correct local db path
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3352'>FLINK-3352</a>] -         RocksDB Backend cannot determine correct hdfs path
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3353'>FLINK-3353</a>] -         CSV-related tests may fail depending on locale
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3357'>FLINK-3357</a>] -         Drop JobId.toShortString()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3359'>FLINK-3359</a>] -         Make RocksDB file copies asynchronous
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3361'>FLINK-3361</a>] -         Wrong error messages for execution retry delay and akka ask pause config values
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3368'>FLINK-3368</a>] -         Kafka 0.8 consumer fails to recover from broker shutdowns
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3369'>FLINK-3369</a>] -         RemoteTransportException should be instance of CancelTaskException
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3373'>FLINK-3373</a>] -         Using a newer library of Apache HttpClient than 4.2.6 will get class loading problems
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3385'>FLINK-3385</a>] -         Fix outer join skipping unprobed partitions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3392'>FLINK-3392</a>] -         Unprotected access to elements in ClosableBlockingQueue#size()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3393'>FLINK-3393</a>] -         ExternalProcessRunner wait to finish copying error stream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3394'>FLINK-3394</a>] -         Clear up the contract of MutableObjectIterator.next(reuse)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3396'>FLINK-3396</a>] -         Job submission Savepoint restore logic flawed
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3400'>FLINK-3400</a>] -         RocksDB Backend does not work when not in Flink lib folder
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3412'>FLINK-3412</a>] -         Remove implicit conversions JavaStream / ScalaStream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3415'>FLINK-3415</a>] -         TimestampExctractor accepts negative watermarks 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3416'>FLINK-3416</a>] -         [py] .bat files fail when path contains spaces
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3420'>FLINK-3420</a>] -         Remove &quot;ReadTextFileWithValue&quot; from StreamExecutionEnvironment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3423'>FLINK-3423</a>] -         ExternalProcessRunnerTest fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3424'>FLINK-3424</a>] -         FileStateBackendtest.testStateOutputStream fails on windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3425'>FLINK-3425</a>] -         DataSinkTaskTest.Failing[Sorting]DataSinkTask fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3426'>FLINK-3426</a>] -         JobManagerLeader[Re]ElectionTest.testleaderElection fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3432'>FLINK-3432</a>] -         ZookeeperOffsetHandlerTest fails on windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3434'>FLINK-3434</a>] -         Return value from flinkYarnClient#deploy() should be checked against null
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3438'>FLINK-3438</a>] -         ExternalProcessRunner fails to detect ClassNotFound exception because of locale settings
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3439'>FLINK-3439</a>] -         Remove final Long.MAX_VALUE Watermark in StreamSource
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3440'>FLINK-3440</a>] -         Kafka should also checkpoint partitions where no initial offset was retrieved
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3448'>FLINK-3448</a>] -         WebRuntimeMonitor: Move initialization of handlers to start() method
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3449'>FLINK-3449</a>] -         createInput swallows exception if TypeExtractor fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3450'>FLINK-3450</a>] -         RocksDB Backed Window Fails with KryoSerializer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3453'>FLINK-3453</a>] -         Fix TaskManager logs exception when sampling backpressure while task completes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3458'>FLINK-3458</a>] -         Shading broken in flink-shaded-hadoop
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3478'>FLINK-3478</a>] -         Flink serves arbitary files through the web interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3483'>FLINK-3483</a>] -         Job graph visualization not working properly in OS X Chrome
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3485'>FLINK-3485</a>] -         The SerializedListAccumulator value doest seem to be right
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3499'>FLINK-3499</a>] -         Possible ghost references in ZooKeeper completed checkpoint store
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3511'>FLINK-3511</a>] -         Flink library examples not runnable without adding dependencies
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3512'>FLINK-3512</a>] -         Savepoint backend should not revert to &quot;jobmanager&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3513'>FLINK-3513</a>] -         Fix interplay of automatic Operator UID and Changing name of WindowOperator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3518'>FLINK-3518</a>] -         Stale docs for quickstart setup
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3525'>FLINK-3525</a>] -         Missing call to super#close() in TimestampsAndPeriodicWatermarksOperator#close()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3526'>FLINK-3526</a>] -         ProcessingTime Window Assigner and Trigger are broken
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3534'>FLINK-3534</a>] -         Cancelling a running job can lead to restart instead of stopping
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3540'>FLINK-3540</a>] -         Hadoop 2.6.3 build contains /com/google/common (guava) classes in flink-dist.jar
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3554'>FLINK-3554</a>] -         Bounded sources should emit a Max Watermark when they are done
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3556'>FLINK-3556</a>] -         Unneeded check in HA blob store configuration
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3562'>FLINK-3562</a>] -         Update docs in the course of EventTimeSourceFunction removal
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3565'>FLINK-3565</a>] -         FlinkKafkaConsumer does not work with Scala 2.11 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3569'>FLINK-3569</a>] -         Test cases fail due to Maven Shade plugin
</li>
</ul>
                        
### Improvement

<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-8'>FLINK-8</a>] -         [GitHub] Implement automatic sample histogram building for Range Partitioning
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-553'>FLINK-553</a>] -         Add getGroupKey() method to group-at-time operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-573'>FLINK-573</a>] -         Clean-up MapOperators in optimizer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-734'>FLINK-734</a>] -         Integrate web job client into JobManager web interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-987'>FLINK-987</a>] -         Extend TypeSerializers and -Comparators to work directly on Memory Segments
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1045'>FLINK-1045</a>] -         Remove Combinable Annotation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1228'>FLINK-1228</a>] -         Add REST Interface to JobManager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1240'>FLINK-1240</a>] -         We cannot use sortGroup on a global reduce
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1513'>FLINK-1513</a>] -         Remove GlobalConfiguration Singleton
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1666'>FLINK-1666</a>] -         Clean-up Field Expression Code
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1702'>FLINK-1702</a>] -         Authenticate via Kerberos from the client only
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1778'>FLINK-1778</a>] -         Improve normalized keys in composite key case
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1903'>FLINK-1903</a>] -         Joins where one side uses a field more than once don&#39;t work
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1947'>FLINK-1947</a>] -         Make Avro and Tachyon test logging less verbose
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2017'>FLINK-2017</a>] -         Add predefined required parameters to ParameterTool
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2021'>FLINK-2021</a>] -         Rework examples to use ParameterTool
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2075'>FLINK-2075</a>] -         Shade akka and protobuf dependencies away
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2185'>FLINK-2185</a>] -         Rework semantics for .setSeed function of SVM
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2213'>FLINK-2213</a>] -         Configure number of vcores
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2239'>FLINK-2239</a>] -         print() on DataSet: stream results and print incrementally
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2342'>FLINK-2342</a>] -         Add new fit operation and more tests for StandardScaler
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2344'>FLINK-2344</a>] -         Deprecate/Remove the old Pact Pair type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2380'>FLINK-2380</a>] -         Allow to configure default FS for file inputs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2399'>FLINK-2399</a>] -         Fail when actor versions don&#39;t match
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2455'>FLINK-2455</a>] -         Misleading I/O manager error log messages
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2488'>FLINK-2488</a>] -         Expose attemptNumber in RuntimeContext
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2518'>FLINK-2518</a>] -         Avoid predetermination of ports for network services
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2523'>FLINK-2523</a>] -         Make task canceling interrupt interval configurable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2524'>FLINK-2524</a>] -         Add &quot;getTaskNameWithSubtasks()&quot; to RuntimeContext
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2559'>FLINK-2559</a>] -         Fix Javadoc (e.g. Code Examples)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2646'>FLINK-2646</a>] -         Rich functions should provide a method &quot;closeAfterFailure()&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2667'>FLINK-2667</a>] -         Rework configuration parameters
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2716'>FLINK-2716</a>] -         Checksum method for DataSet and Graph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2788'>FLINK-2788</a>] -         Add type hint with TypeExtactor call on Hint Type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2795'>FLINK-2795</a>] -         Print JobExecutionResult for interactively invoked jobs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2882'>FLINK-2882</a>] -         Improve performance of string conversions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2893'>FLINK-2893</a>] -         Rename recovery configuration keys
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2895'>FLINK-2895</a>] -         Duplicate immutable object creation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2897'>FLINK-2897</a>] -         Use distinct initial indices for OutputEmitter round-robin
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2898'>FLINK-2898</a>] -         Invert Travis CI build order
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2902'>FLINK-2902</a>] -         Web interface sort tasks newest first
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2904'>FLINK-2904</a>] -         Web interface truncated task counts
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2932'>FLINK-2932</a>] -         Flink quickstart docs should ask users to download from https, not http
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2936'>FLINK-2936</a>] -         ClassCastException when using EventTimeSourceFunction in non-EventTime program
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2940'>FLINK-2940</a>] -         Deploy multiple Scala versions for Maven artifacts
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2947'>FLINK-2947</a>] -         Coloured Scala Shell
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2949'>FLINK-2949</a>] -         Add method &#39;writeSequencefile&#39; to DataSet 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2961'>FLINK-2961</a>] -         Add support for basic type Date in Table API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2962'>FLINK-2962</a>] -         Cluster startup script refers to unused variable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2966'>FLINK-2966</a>] -         Improve the way job duration is reported on web frontend.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2974'>FLINK-2974</a>] -         Add periodic offset commit to Kafka Consumer if checkpointing is disabled
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2976'>FLINK-2976</a>] -         Save and load checkpoints manually
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2981'>FLINK-2981</a>] -         Update README for building docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2984'>FLINK-2984</a>] -         Support lenient parsing of SVMLight input files
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2991'>FLINK-2991</a>] -         Extend Window Operators to Allow Efficient Fold Operation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2993'>FLINK-2993</a>] -         Set default DelayBetweenExecutionRetries to 0
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2994'>FLINK-2994</a>] -         Client sysout logging does not report exceptions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3003'>FLINK-3003</a>] -         Add container allocation timeout to YARN CLI
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3017'>FLINK-3017</a>] -         Broken &#39;Slots&#39; link on Streaming Programming Guide
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3023'>FLINK-3023</a>] -         Show Flink version + commit id for -SNAPSHOT versions in web frontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3028'>FLINK-3028</a>] -         Cannot cancel restarting job via web frontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3030'>FLINK-3030</a>] -         Enhance Dashboard to show Execution Attempts
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3039'>FLINK-3039</a>] -         Trigger KeyValueState cannot be Scala Int
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3040'>FLINK-3040</a>] -         Add docs describing how to configure State Backends
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3042'>FLINK-3042</a>] -         Define a way to let types create their own TypeInformation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3044'>FLINK-3044</a>] -         In YARN mode, configure FsStateBackend by default.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3045'>FLINK-3045</a>] -         Properly expose the key of a kafka message
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3046'>FLINK-3046</a>] -         Integrate the Either Java type with the TypeExtractor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3049'>FLINK-3049</a>] -         Move &quot;Either&quot; type to package &quot;org.apache.flink.types&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3050'>FLINK-3050</a>] -         Add custom Exception type to suppress job restarts
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3051'>FLINK-3051</a>] -         Define a maximum number of concurrent inflight checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3055'>FLINK-3055</a>] -         ExecutionVertex has duplicate method getParallelSubtaskIndex and getSubTaskIndex
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3056'>FLINK-3056</a>] -         Show bytes sent/received as MBs/GB and so on in web interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3063'>FLINK-3063</a>] -         [py] Remove combiner
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3069'>FLINK-3069</a>] -         Make state materialization asynchronous
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3073'>FLINK-3073</a>] -         Activate streaming mode by default
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3074'>FLINK-3074</a>] -         Make ApplicationMaster/JobManager akka port configurable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3076'>FLINK-3076</a>] -         Display channel exchange mode in the plan visualizer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3077'>FLINK-3077</a>] -         Add &quot;version&quot; command to CliFrontend for showing the version of the installation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3083'>FLINK-3083</a>] -         Add docs how to configure streaming fault tolerance
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3084'>FLINK-3084</a>] -         File State Backend should not write very small state into files
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3085'>FLINK-3085</a>] -         Move State Backend Initialization from &quot;registerInputOutput()&quot; to &quot;invoke()&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3114'>FLINK-3114</a>] -         Read cluster&#39;s default parallelism upon remote job submission
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3115'>FLINK-3115</a>] -         Update Elasticsearch connector to 2.X
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3116'>FLINK-3116</a>] -         Remove RecordOperator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3120'>FLINK-3120</a>] -         Set number of event loop thread and number of buffer pool arenas to same number
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3122'>FLINK-3122</a>] -         Generalize value type in LabelPropagation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3123'>FLINK-3123</a>] -         Allow setting custom start-offsets for the Kafka consumer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3124'>FLINK-3124</a>] -         Introduce a TaskInfo object to better represent task name, index, attempt number etc.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3127'>FLINK-3127</a>] -         Measure backpressure in Flink jobs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3131'>FLINK-3131</a>] -         Expose checkpoint metrics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3132'>FLINK-3132</a>] -         Restructure streaming guide
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3133'>FLINK-3133</a>] -         Introduce collect()/coun()/print() methods in DataStream API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3135'>FLINK-3135</a>] -         Add chainable driver for UNARY_NO_OP strategy
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3147'>FLINK-3147</a>] -         HadoopOutputFormatBase should expose fields as protected
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3154'>FLINK-3154</a>] -         Update Kryo version from 2.24.0 to 3.0.3
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3160'>FLINK-3160</a>] -         Aggregate operator statistics by TaskManager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3161'>FLINK-3161</a>] -         Externalize cluster start-up and tear-down when available
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3169'>FLINK-3169</a>] -         Drop {{Key}} type from Record Data Model
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3172'>FLINK-3172</a>] -         Specify jobmanager port in HA mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3174'>FLINK-3174</a>] -         Add merging WindowAssigner
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3176'>FLINK-3176</a>] -         Window Apply Website Example
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3178'>FLINK-3178</a>] -         Make Closing Behavior of Window Operators Configurable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3181'>FLINK-3181</a>] -         The vertex-centric SSSP example and library method send unnecessary messages during the first superstep
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3194'>FLINK-3194</a>] -         Remove web client
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3198'>FLINK-3198</a>] -         Rename Grouping.getDataSet() method and add JavaDocs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3200'>FLINK-3200</a>] -         Use Partitioned State Abstraction in WindowOperator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3209'>FLINK-3209</a>] -         Remove Unused ProcessingTime, EventTime and AbstractTime
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3213'>FLINK-3213</a>] -         Union of two streams with different parallelism should adjust parallelism automatically
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3219'>FLINK-3219</a>] -         Implement DataSet.count using a single operator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3232'>FLINK-3232</a>] -         Add option to eagerly deploy channels
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3233'>FLINK-3233</a>] -         PartitionOperator does not support expression keys on atomic types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3234'>FLINK-3234</a>] -         SortPartition does not support KeySelectorFunctions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3235'>FLINK-3235</a>] -         Drop Flink-on-Tez code
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3244'>FLINK-3244</a>] -         Add log messages to savepoint coordinator restore
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3246'>FLINK-3246</a>] -         Consolidate maven project names with *-parent suffix
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3249'>FLINK-3249</a>] -         Wrong &quot;unknown partition state/input gate&quot; error messages
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3258'>FLINK-3258</a>] -         Merge AbstractInvokable&#39;s registerInputOutput and invoke
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3259'>FLINK-3259</a>] -         Redirect programming guides to new layout
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3262'>FLINK-3262</a>] -         Remove fuzzy versioning from Bower dependencies
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3265'>FLINK-3265</a>] -         RabbitMQ Source not threadsafe: ConcurrentModificationException
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3270'>FLINK-3270</a>] -         Add example for reading and writing to Kafka
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3273'>FLINK-3273</a>] -         Remove Scala dependency from flink-streaming-java
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3276'>FLINK-3276</a>] -         Move runtime parts of flink-streaming-java to flink-runtime
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3278'>FLINK-3278</a>] -         Add Partitioned State Backend Based on RocksDB
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3290'>FLINK-3290</a>] -         [py] Generalize OperationInfo transfer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3299'>FLINK-3299</a>] -         Remove ApplicationID from Environment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3303'>FLINK-3303</a>] -         Move all non-batch specific classes in flink-java to flink-core
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3305'>FLINK-3305</a>] -         Remove JavaKaffee serializer util
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3306'>FLINK-3306</a>] -         Auto type registration at Kryo is buggy
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3308'>FLINK-3308</a>] -         [py] Remove debug mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3309'>FLINK-3309</a>] -         [py] Resolve maven warnings
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3310'>FLINK-3310</a>] -         Add back pressure statistics to web frontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3334'>FLINK-3334</a>] -         Change default log4j.properties Conversion pattern to include year-month-day in the timestamp
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3336'>FLINK-3336</a>] -         Add Semi-Rebalance Data Shipping for DataStream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3347'>FLINK-3347</a>] -         TaskManager ActorSystems need to restart themselves in case they notice quarantine
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3348'>FLINK-3348</a>] -         taskmanager.memory.off-heap missing bc documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3355'>FLINK-3355</a>] -         Allow passing RocksDB Option to RocksDBStateBackend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3358'>FLINK-3358</a>] -         Create constructors for FsStateBackend in RocksDBBackens
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3364'>FLINK-3364</a>] -         Don&#39;t initialize SavepointStore in JobManager constructor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3375'>FLINK-3375</a>] -         Allow Watermark Generation in the Kafka Source
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3376'>FLINK-3376</a>] -         Add an illustration of Event Time and Watermarks to the docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3378'>FLINK-3378</a>] -         Consolidate TestingCluster and FokableFlinkMiniCluster
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3379'>FLINK-3379</a>] -         Refactor TimestampExtractor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3386'>FLINK-3386</a>] -         Kafka consumers are not properly respecting the &quot;auto.offset.reset&quot; behavior
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3389'>FLINK-3389</a>] -         Add Pre-defined Options settings for RocksDB State backend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3395'>FLINK-3395</a>] -         Polishing the web UI
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3402'>FLINK-3402</a>] -         Refactor Common Parts of Stream/Batch Documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3413'>FLINK-3413</a>] -         Remove implicit Seq to DataStream conversion
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3419'>FLINK-3419</a>] -         Drop partitionByHash from DataStream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3421'>FLINK-3421</a>] -         Remove all unused ClassTag context bounds in the Streaming Scala API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3422'>FLINK-3422</a>] -         Scramble HashPartitioner hashes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3430'>FLINK-3430</a>] -         Remove &quot;no POJO&quot; warning in TypeAnalyzer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3435'>FLINK-3435</a>] -         Change interplay of Ingestion Time and Event Time
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3436'>FLINK-3436</a>] -         Remove ComplexIntegrationITCase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3455'>FLINK-3455</a>] -         Bump Kafka 0.9 connector dependency to Kafka 0.9.0.1
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3459'>FLINK-3459</a>] -         Make build SBT compatible
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3460'>FLINK-3460</a>] -         Make flink-streaming-connectors&#39; flink dependencies provided
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3461'>FLINK-3461</a>] -         Remove duplicate condition check in ZooKeeperLeaderElectionService
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3469'>FLINK-3469</a>] -         Improve documentation for grouping keys
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3509'>FLINK-3509</a>] -         Update Hadoop versions in release script and on travis to the latest minor version
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3520'>FLINK-3520</a>] -         Periodic watermark operator should emit current watermark in close()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3521'>FLINK-3521</a>] -         Make Iterable part of method signature for WindowFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3522'>FLINK-3522</a>] -         Storm examples &quot;PrintSampleStream&quot; throws an error if called without arguments
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3527'>FLINK-3527</a>] -         Scala DataStream has no transform method
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3528'>FLINK-3528</a>] -         Add Incremental Fold for Non-Keyed Window Operator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3535'>FLINK-3535</a>] -         Decrease logging verbosity of StackTraceSampleCoordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3536'>FLINK-3536</a>] -         Make clearer distinction between event time and processing time
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3538'>FLINK-3538</a>] -         DataStream join API does not enforce consistent usage
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3548'>FLINK-3548</a>] -         Remove unnecessary generic parameter from SingleOutputStreamOperator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3559'>FLINK-3559</a>] -         Don&#39;t print pid file check if no active PID
</li>
</ul>
            
<h3>        New Feature
</h3>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1723'>FLINK-1723</a>] -         Add cross validation for model evaluation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2157'>FLINK-2157</a>] -         Create evaluation framework for ML library
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2390'>FLINK-2390</a>] -         Replace iteration timeout with algorithm for detecting termination
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2411'>FLINK-2411</a>] -         Add basic graph summarization algorithm
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2435'>FLINK-2435</a>] -         Add support for custom CSV field parsers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2720'>FLINK-2720</a>] -         Add Storm-CountMetric in flink-stormcompatibility
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2728'>FLINK-2728</a>] -         Add missing features to new web dashboard
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2871'>FLINK-2871</a>] -         Add OuterJoin strategy with HashTable on outer side
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2905'>FLINK-2905</a>] -         Add intersect method to Graph class
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2951'>FLINK-2951</a>] -         Add Union operator to Table API.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2955'>FLINK-2955</a>] -         Add operations introduction in Table API page.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2978'>FLINK-2978</a>] -         Integrate web submission interface into the new dashboard
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2996'>FLINK-2996</a>] -         Add config entry to define BlobServer port
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3001'>FLINK-3001</a>] -         Add Support for Java 8 Optional type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3002'>FLINK-3002</a>] -         Add an EitherType to the Java API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3058'>FLINK-3058</a>] -         Add Kafka consumer for new 0.9.0.0 Kafka API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3093'>FLINK-3093</a>] -         Introduce annotations for interface stability
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3102'>FLINK-3102</a>] -         Allow reading from multiple topics with one FlinkKafkaConsumer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3170'>FLINK-3170</a>] -         Expose task manager metrics via JMX
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3192'>FLINK-3192</a>] -         Add explain support to print ast and sql physical execution plan. 
</li>
</ul>
                                                        
### Task

<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1681'>FLINK-1681</a>] -         Remove the old Record API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2973'>FLINK-2973</a>] -         Add flink-benchmark with compliant licenses again
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3112'>FLINK-3112</a>] -         Remove unused RecordModelPostPass class
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3113'>FLINK-3113</a>] -         Remove unused global order methods from GenericDataSinkBase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3155'>FLINK-3155</a>] -         Update Flink docker version to latest stable Flink version
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3186'>FLINK-3186</a>] -         Deprecate DataSink.sortLocalOutput() methods
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3366'>FLINK-3366</a>] -         Rename @Experimental annotation to @PublicEvolving
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3367'>FLINK-3367</a>] -         Annotate all user-facing API classes with @Public or @PublicEvolving
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3484'>FLINK-3484</a>] -         Add setSlotSharingGroup documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3490'>FLINK-3490</a>] -         Bump Chill version to 0.7.4
</li>
</ul>
        
### Test

<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2480'>FLINK-2480</a>] -         Improving tests coverage for org.apache.flink.streaming.api
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2573'>FLINK-2573</a>] -         Add Kerberos test case
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2803'>FLINK-2803</a>] -         Add test case for Flink&#39;s memory allocation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3517'>FLINK-3517</a>] -         Number of job and task managers not checked in scripts
</li>
</ul>
        
### Wish

<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2429'>FLINK-2429</a>] -         Remove the &quot;enableCheckpointing()&quot; without interval variant
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2995'>FLINK-2995</a>] -         Set default number of retries to larger than 0
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3377'>FLINK-3377</a>] -         Remove final flag from ResultPartitionWriter class
</li>
</ul>

## Known Issues

- The `mvn clean verify` command does not succeed for the source release, because of issues with the Maven shade plugin. This has been resolved in the `release-1.0` branch.
- [FLINK-3578](https://issues.apache.org/jira/browse/FLINK-3578) - Scala DataStream API does not support Rich Window Functions.
