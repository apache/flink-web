---
title: "Release 1.3.0 – Changelog"
---

* toc
{:toc}

## Changelog

The 1.3.0 release [resolved 772 JIRA issues](https://issues.apache.org/jira/issues/?jql=project+%3D+FLINK+AND+fixVersion+%3D+1.3.0) in total.


    
<h2>        Sub-task
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3722'>FLINK-3722</a>] -         The divisions in the InMemorySorters&#39; swap/compare methods hurt performance
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4562'>FLINK-4562</a>] -         table examples make an divided module in flink-examples
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4692'>FLINK-4692</a>] -         Add tumbling group-windows for batch tables
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4693'>FLINK-4693</a>] -         Add session group-windows for batch tables	
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4697'>FLINK-4697</a>] -         Gather more detailed checkpoint stats in CheckpointStatsTracker
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4698'>FLINK-4698</a>] -         Visualize additional checkpoint information
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4769'>FLINK-4769</a>] -         Migrate Metrics configuration options
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4912'>FLINK-4912</a>] -         Introduce RECONCILING state in ExecutionGraph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4959'>FLINK-4959</a>] -         Write Documentation for ProcessFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4994'>FLINK-4994</a>] -         Don&#39;t Clear Trigger State and Merging Window Set When Purging
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5132'>FLINK-5132</a>] -         Introduce the ResourceSpec for grouping different resource factors in API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5133'>FLINK-5133</a>] -         Support to set resource for operator in DataStream and DataSet
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5134'>FLINK-5134</a>] -         Aggregate ResourceSpec for chained operators when generating job graph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5135'>FLINK-5135</a>] -         ResourceProfile for slot request should be expanded to correspond with ResourceSpec
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5219'>FLINK-5219</a>] -         Add non-grouped session windows for batch tables
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5239'>FLINK-5239</a>] -         Properly unpack thrown exceptions in RPC methods
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5268'>FLINK-5268</a>] -         Split TableProgramsTestBase into TableProgramsCollectionTestBase and TableProgramsClusterTestBase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5386'>FLINK-5386</a>] -         Refactoring Window Clause
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5417'>FLINK-5417</a>] -         Fix the wrong config file name 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5435'>FLINK-5435</a>] -         Cleanup the rules introduced by FLINK-5144 when calcite releases 1.12
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5454'>FLINK-5454</a>] -         Add Documentation about how to tune Checkpointing for large state
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5456'>FLINK-5456</a>] -         Add docs about new state and checkpointing interfaces
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5457'>FLINK-5457</a>] -         Create documentation for Asynchronous I/O
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5458'>FLINK-5458</a>] -         Add documentation how to migrate from Flink 1.1. to Flink 1.2
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5459'>FLINK-5459</a>] -         Add documentation how to debug classloading issues
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5474'>FLINK-5474</a>] -         Extend DC/OS documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5494'>FLINK-5494</a>] -         Improve Mesos documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5501'>FLINK-5501</a>] -         Determine whether the job starts from last JobManager failure
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5529'>FLINK-5529</a>] -         Improve / extends windowing documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5545'>FLINK-5545</a>] -         Remove FlinkAggregateExpandDistinctAggregatesRule when upgrading to Calcite 1.12
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5555'>FLINK-5555</a>] -         Add documentation about debugging watermarks
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5566'>FLINK-5566</a>] -         Introduce structure to hold table and column level statistics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5567'>FLINK-5567</a>] -         Introduce and migrate current table statistics to FlinkStatistics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5570'>FLINK-5570</a>] -         Support register external catalog to table environment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5618'>FLINK-5618</a>] -         Add queryable state documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5640'>FLINK-5640</a>] -         configure the explicit Unit Test file suffix
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5653'>FLINK-5653</a>] -         Add processing time OVER ROWS BETWEEN x PRECEDING aggregation to SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5654'>FLINK-5654</a>] -         Add processing time OVER RANGE BETWEEN x PRECEDING aggregation to SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5655'>FLINK-5655</a>] -         Add event time OVER RANGE BETWEEN x PRECEDING aggregation to SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5656'>FLINK-5656</a>] -         Add processing time OVER ROWS BETWEEN UNBOUNDED PRECEDING aggregation to SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5658'>FLINK-5658</a>] -         Add event time OVER ROWS BETWEEN UNBOUNDED PRECEDING aggregation to SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5693'>FLINK-5693</a>] -         ChecksumHashCode DataSetAnalytic
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5694'>FLINK-5694</a>] -         Collect DataSetAnalytic
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5716'>FLINK-5716</a>] -         Make streaming SourceContexts aware of source idleness
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5723'>FLINK-5723</a>] -         Use &quot;Used&quot; instead of &quot;Initial&quot; to make taskmanager tag more readable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5729'>FLINK-5729</a>] -         add hostname option in SocketWindowWordCount example to be more convenient
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5767'>FLINK-5767</a>] -         New aggregate function interface and built-in aggregate functions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5768'>FLINK-5768</a>] -         Apply new aggregation functions for datastream and dataset tables
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5777'>FLINK-5777</a>] -         Pass savepoint information to CheckpointingOperation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5794'>FLINK-5794</a>] -         update the documentation  about “UDF/UDTF&quot;  support have parameters constructor.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5795'>FLINK-5795</a>] -         Improve UDF&amp;UDTF to support constructor with parameter
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5798'>FLINK-5798</a>] -         Let the RPCService provide a ScheduledExecutorService
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5799'>FLINK-5799</a>] -         Let RpcService.scheduleRunnable return ScheduledFuture
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5803'>FLINK-5803</a>] -         Add [partitioned] processing time OVER RANGE BETWEEN UNBOUNDED PRECEDING aggregation to SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5804'>FLINK-5804</a>] -         Add [non-partitioned] processing time OVER RANGE BETWEEN UNBOUNDED PRECEDING aggregation to SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5810'>FLINK-5810</a>] -         Harden SlotManager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5821'>FLINK-5821</a>] -         Create StateBackend root interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5822'>FLINK-5822</a>] -         Make Checkpoint Coordinator aware of State Backend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5825'>FLINK-5825</a>] -         In yarn mode, a small pic can not be loaded
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5845'>FLINK-5845</a>] -         CEP: unify key and non-keyed operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5846'>FLINK-5846</a>] -         CEP: make the operators backwards compatible.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5869'>FLINK-5869</a>] -         ExecutionGraph use FailoverCoordinator to manage the failover of execution vertexes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5881'>FLINK-5881</a>] -         ScalarFunction(UDF) should support variable types and variable arguments	
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5882'>FLINK-5882</a>] -         TableFunction (UDTF) should support variable types and variable arguments
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5897'>FLINK-5897</a>] -         Untie Checkpoint Externalization from FileSystems
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5903'>FLINK-5903</a>] -         taskmanager.numberOfTaskSlots and yarn.containers.vcores did not work well in YARN mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5906'>FLINK-5906</a>] -         Add support to register UDAGG in Table and SQL API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5909'>FLINK-5909</a>] -         Interface for GraphAlgorithm results
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5910'>FLINK-5910</a>] -         Framework for Gelly examples
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5911'>FLINK-5911</a>] -         Command-line parameters
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5912'>FLINK-5912</a>] -         Inputs for CSV and graph generators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5913'>FLINK-5913</a>] -         Example drivers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5915'>FLINK-5915</a>] -         Add support for the aggregate on multi fields
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5916'>FLINK-5916</a>] -         make env.java.opts.jobmanager and env.java.opts.taskmanager working in YARN mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5927'>FLINK-5927</a>] -         Remove old Aggregate interface and built-in functions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5956'>FLINK-5956</a>] -         Add retract method into the aggregateFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5963'>FLINK-5963</a>] -         Remove preparation mapper of DataSetAggregate
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5981'>FLINK-5981</a>] -         SSL version and ciper suites cannot be constrained as configured
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5990'>FLINK-5990</a>] -         Add [partitioned] event time OVER ROWS BETWEEN x PRECEDING aggregation to SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6011'>FLINK-6011</a>] -         Support TUMBLE, HOP, SESSION window in streaming SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6012'>FLINK-6012</a>] -         Support WindowStart / WindowEnd functions in streaming SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6020'>FLINK-6020</a>] -         Blob Server cannot handle multiple job submits (with same content) parallelly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6034'>FLINK-6034</a>] -         Add KeyedStateHandle for the snapshots in keyed streams
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6037'>FLINK-6037</a>] -         the estimateRowCount method of DataSetCalc didn&#39;t work in SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6089'>FLINK-6089</a>] -         Implement decoration phase for rewriting predicated logical plan after volcano optimization phase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6107'>FLINK-6107</a>] -         Add custom checkstyle for flink-streaming-java
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6117'>FLINK-6117</a>] -         &#39;zookeeper.sasl.disable&#39;  not takes effet when starting CuratorFramework
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6136'>FLINK-6136</a>] -         Separate EmbeddedNonHaServices and NonHaServices
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6149'>FLINK-6149</a>] -         add additional flink logical relation nodes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6155'>FLINK-6155</a>] -         Allow to specify endpoint names
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6190'>FLINK-6190</a>] -         Write &quot;Serializer Configurations&quot; metainfo along with state
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6191'>FLINK-6191</a>] -         Make non-primitive, internal built-in serializers reconfigurable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6195'>FLINK-6195</a>] -         Move gelly-examples jar from opt to examples
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6198'>FLINK-6198</a>] -         Update the documentation of the CEP library to include all the new features.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6200'>FLINK-6200</a>] -         Add event time OVER RANGE BETWEEN UNBOUNDED PRECEDING aggregation to SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6201'>FLINK-6201</a>] -         move python example files from resources to the examples
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6228'>FLINK-6228</a>] -         Integrating the OVER windows in the Table API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6240'>FLINK-6240</a>] -         codeGen dataStream aggregates that use AggregateAggFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6241'>FLINK-6241</a>] -         codeGen dataStream aggregates that use ProcessFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6242'>FLINK-6242</a>] -         codeGen DataSet Goupingwindow Aggregates
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6257'>FLINK-6257</a>] -         Post-pass OVER windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6261'>FLINK-6261</a>] -         Add support for TUMBLE, HOP, SESSION to batch SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6340'>FLINK-6340</a>] -         Introduce a TerminationFuture for Execution
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6361'>FLINK-6361</a>] -         Finalize the AggregateFunction interface and refactoring built-in aggregates
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6367'>FLINK-6367</a>] -         support custom header settings of allow origin
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6392'>FLINK-6392</a>] -         Change the alias of Window from optional to essential.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6425'>FLINK-6425</a>] -         Integrate serializer reconfiguration into state restore flow to activate serializer upgrades
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6448'>FLINK-6448</a>] -         Web UI TaskManager view: Rename &#39;Free Memory&#39; to &#39;JVM Heap&#39;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6450'>FLINK-6450</a>] -         Web UI Subtasks view for TaskManagers has a misleading name
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6451'>FLINK-6451</a>] -         Web UI: Rename &#39;Metrics&#39; view to &#39;Task Metrics&#39;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6470'>FLINK-6470</a>] -         Add a utility to parse memory sizes with units
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6475'>FLINK-6475</a>] -         Incremental snapshots in RocksDB hold lock during async file upload
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6478'>FLINK-6478</a>] -         Add documentation on how to upgrade serializers for managed state
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6504'>FLINK-6504</a>] -         Lack of synchronization on materializedSstFiles in RocksDBKEyedStateBackend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6527'>FLINK-6527</a>] -         OperatorSubtaskState has empty implementations of (un)/registerSharedStates
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6533'>FLINK-6533</a>] -         Duplicated registration of new shared state when checkpoint confirmations are still pending
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6534'>FLINK-6534</a>] -         SharedStateRegistry is disposing state handles from main thread
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6535'>FLINK-6535</a>] -         JobID should not be part of the registration key to the SharedStateRegistry
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6545'>FLINK-6545</a>] -         Make incremental checkpoints externalizable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6570'>FLINK-6570</a>] -         QueryableStateClient constructor in documentation doesn&#39;t match actual signature
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6618'>FLINK-6618</a>] -         Fix GroupWindowStringExpressionTest testcase bug
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6632'>FLINK-6632</a>] -         Fix parameter case sensitive error for test passing/rejecting filter API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6633'>FLINK-6633</a>] -         Register with shared state registry before adding to CompletedCheckpointStore
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6640'>FLINK-6640</a>] -         Ensure registration of shared state happens before externalizing a checkpoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6650'>FLINK-6650</a>] -         Fix Non-windowed group-aggregate error when using append-table mode.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6676'>FLINK-6676</a>] -         API Migration guide: add QueryableStateClient changes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6677'>FLINK-6677</a>] -         API Migration guide: add Table API changes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6678'>FLINK-6678</a>] -         API Migration guide: add note about removed log4j default logger from core artefacts
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6679'>FLINK-6679</a>] -         Document HeapStatebackend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6680'>FLINK-6680</a>] -         App &amp; Flink migration guide: updates for the 1.3 release
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6681'>FLINK-6681</a>] -         Update &quot;Upgrading the Flink Framework Version&quot; section for 1.2 -&gt; 1.3
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6683'>FLINK-6683</a>] -         building with Scala 2.11 no longer uses change-scala-version.sh
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6700'>FLINK-6700</a>] -         Remove &quot;Download and Compile&quot; from quickstart 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6736'>FLINK-6736</a>] -         Fix UDTF codegen bug when window follow by join( UDTF)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6737'>FLINK-6737</a>] -         Fix over expression parse String error.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6782'>FLINK-6782</a>] -         Update savepoint documentation
</li>
</ul>
                            
<h2>        Bug
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2067'>FLINK-2067</a>] -         Chained streaming operators should not throw chained exceptions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2662'>FLINK-2662</a>] -         CompilerException: &quot;Bug: Plan generation for Unions picked a ship strategy between binary plan operators.&quot;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2814'>FLINK-2814</a>] -         DeltaIteration: DualInputPlanNode cannot be cast to SingleInputPlanNode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3679'>FLINK-3679</a>] -         Allow Kafka consumer to skip corrupted messages
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4148'>FLINK-4148</a>] -         incorrect calculation distance in QuadTree
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4255'>FLINK-4255</a>] -         Unstable test WebRuntimeMonitorITCase.testNoEscape
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4813'>FLINK-4813</a>] -         Having flink-test-utils as a dependency outside Flink fails the build
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4848'>FLINK-4848</a>] -         keystoreFilePath should be checked against null in SSLUtils#createSSLServerContext
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4870'>FLINK-4870</a>] -         ContinuousFileMonitoringFunction does not properly handle absolut Windows paths
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4890'>FLINK-4890</a>] -         FileInputFormatTest#testExcludeFiles fails on Windows OS
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4905'>FLINK-4905</a>] -         Kafka test instability IllegalStateException: Client is not started
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5049'>FLINK-5049</a>] -         Instability in QueryableStateITCase.testQueryableStateWithTaskManagerFailure
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5070'>FLINK-5070</a>] -         Unable to use Scala&#39;s BeanProperty with classes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5101'>FLINK-5101</a>] -         Test CassandraConnectorITCase instable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5118'>FLINK-5118</a>] -         Inconsistent records sent/received metrics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5119'>FLINK-5119</a>] -         Last taskmanager heartbeat not showing in web frontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5122'>FLINK-5122</a>] -         Elasticsearch Sink loses documents when cluster has high load
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5150'>FLINK-5150</a>] -         WebUI metric-related resource leak
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5165'>FLINK-5165</a>] -         Checkpointing tests using FsStatebackend fail on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5214'>FLINK-5214</a>] -         Clean up checkpoint files when failing checkpoint operation on TM
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5229'>FLINK-5229</a>] -         Cleanup StreamTaskStates if a checkpoint operation of a subsequent operator fails 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5247'>FLINK-5247</a>] -         Fix incorrect check in allowedLateness() method. Make it a no-op for non-event time windows.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5267'>FLINK-5267</a>] -         TaskManager logs not scrollable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5298'>FLINK-5298</a>] -         TaskManager crashes when TM log not existant
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5321'>FLINK-5321</a>] -         FlinkMiniCluster does not start Jobmanager MetricQueryService
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5323'>FLINK-5323</a>] -         CheckpointNotifier should be removed from docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5329'>FLINK-5329</a>] -         Metric list is being cut off in the WebFrontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5345'>FLINK-5345</a>] -         IOManager failed to properly clean up temp file directory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5349'>FLINK-5349</a>] -         Fix code sample for Twitter connector
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5350'>FLINK-5350</a>] -         Don&#39;t overwrite existing Jaas config property
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5353'>FLINK-5353</a>] -         Elasticsearch Sink loses well-formed documents when there are malformed documents
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5359'>FLINK-5359</a>] -         Job Exceptions view doesn&#39;t scroll 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5361'>FLINK-5361</a>] -         Flink shouldn&#39;t require Kerberos credentials
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5364'>FLINK-5364</a>] -         Rework JAAS configuration to support user-supplied entries
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5365'>FLINK-5365</a>] -         Mesos AppMaster/TaskManager should obey sigterm
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
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5383'>FLINK-5383</a>] -         TaskManager fails with SIGBUS when loading RocksDB
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5389'>FLINK-5389</a>] -         Fails #testAnswerFailureWhenSavepointReadFails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5390'>FLINK-5390</a>] -         input should be closed in finally block in YarnFlinkApplicationMasterRunner#loadJobGraph()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5392'>FLINK-5392</a>] -         flink-dist build failed when change scala version to 2.11
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5397'>FLINK-5397</a>] -         Fail to deserialize savepoints in v1.1 when there exist missing fields in class serialization descriptors
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5400'>FLINK-5400</a>] -         Add accessor to folding states in RuntimeContext
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5402'>FLINK-5402</a>] -         Fails AkkaRpcServiceTest#testTerminationFuture
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5407'>FLINK-5407</a>] -         Savepoint for iterative Task fails.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5408'>FLINK-5408</a>] -         RocksDB initialization can fail with an UnsatisfiedLinkError in the presence of multiple classloaders
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5419'>FLINK-5419</a>] -         Taskmanager metrics not accessible via REST
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5427'>FLINK-5427</a>] -         Typo in the event_timestamps_watermarks doc
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5432'>FLINK-5432</a>] -         ContinuousFileMonitoringFunction is not monitoring nested files
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5434'>FLINK-5434</a>] -         Remove unsupported project() transformation from Scala DataStream docs
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
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5481'>FLINK-5481</a>] -         Simplify Row creation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5482'>FLINK-5482</a>] -         QueryableStateClient does not recover from a failed lookup due to a non-running job
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5484'>FLINK-5484</a>] -         Kryo serialization changed between 1.1 and 1.2
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5487'>FLINK-5487</a>] -         Proper at-least-once support for ElasticsearchSink
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5489'>FLINK-5489</a>] -         maven release:prepare fails due to invalid JDOM comments in pom.xml
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
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5553'>FLINK-5553</a>] -         Job fails during deployment with IllegalStateException from subpartition request
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5556'>FLINK-5556</a>] -         BarrierBuffer resets bytes written on spiller roll over
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5560'>FLINK-5560</a>] -         Header in checkpoint stats summary misaligned
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5561'>FLINK-5561</a>] -         DataInputDeserializer#available returns one too few
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5562'>FLINK-5562</a>] -         Driver fixes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5577'>FLINK-5577</a>] -         Each time application is submitted to yarn, application id increases by two
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5585'>FLINK-5585</a>] -         NullPointer Exception in JobManager.updateAccumulators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5602'>FLINK-5602</a>] -         Migration with RocksDB job led to NPE for next checkpoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5608'>FLINK-5608</a>] -         Cancel button not always visible
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5612'>FLINK-5612</a>] -         GlobPathFilter not-serializable exception
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5613'>FLINK-5613</a>] -         QueryableState: requesting a non-existing key in RocksDBStateBackend is not consistent with the MemoryStateBackend and FsStateBackend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5616'>FLINK-5616</a>] -         YarnPreConfiguredMasterHaServicesTest fails sometimes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5617'>FLINK-5617</a>] -         Check new public APIs in 1.2 release
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5623'>FLINK-5623</a>] -         TempBarrier dam has been closed
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5626'>FLINK-5626</a>] -         Improve resource release in RocksDBKeyedStateBackend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5628'>FLINK-5628</a>] -         CheckpointStatsTracker implements Serializable but isn&#39;t
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5629'>FLINK-5629</a>] -         Unclosed RandomAccessFile in StaticFileServerHandler#respondAsLeader()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5631'>FLINK-5631</a>] -         [yarn] Support downloading additional jars from non-HDFS paths
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5636'>FLINK-5636</a>] -         IO Metric for StreamTwoInputProcessor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5637'>FLINK-5637</a>] -         Default Flink configuration contains whitespace characters, causing parser WARNings
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5638'>FLINK-5638</a>] -         Deadlock when closing two chained async I/O operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5643'>FLINK-5643</a>] -         StateUtil.discardStateFuture fails when state future contains null value
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5644'>FLINK-5644</a>] -         Task#lastCheckpointSize metric broken
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5645'>FLINK-5645</a>] -         IOMetrics transfer through ExecGraph does not work for failed jobs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5646'>FLINK-5646</a>] -         REST api documentation missing details on jar upload
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5650'>FLINK-5650</a>] -         Flink-python tests executing cost too long time
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5652'>FLINK-5652</a>] -         Memory leak in AsyncDataStream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5660'>FLINK-5660</a>] -         Not properly cleaning PendingCheckpoints up
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5662'>FLINK-5662</a>] -         Alias in front of output fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5663'>FLINK-5663</a>] -         Checkpoint fails because of closed registry
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5666'>FLINK-5666</a>] -         Blob files are not cleaned up from ZK storage directory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5667'>FLINK-5667</a>] -         Possible state data loss when task fails while checkpointing
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5669'>FLINK-5669</a>] -         flink-streaming-contrib DataStreamUtils.collect in local environment mode fails when offline
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5670'>FLINK-5670</a>] -         Local RocksDB directories not cleaned up
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5684'>FLINK-5684</a>] -         Add MacOS section to flink-runtime-web README
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5699'>FLINK-5699</a>] -         Cancel with savepoint fails with a NPE if savepoint target directory not set
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5701'>FLINK-5701</a>] -         FlinkKafkaProducer should check asyncException on checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5708'>FLINK-5708</a>] -         we should remove duplicated configuration options 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5712'>FLINK-5712</a>] -         update several deprecated configuration options 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5739'>FLINK-5739</a>] -         NullPointerException in CliFrontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5747'>FLINK-5747</a>] -         Eager Scheduling should deploy all Tasks together
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5749'>FLINK-5749</a>] -             unset HADOOP_HOME and HADOOP_CONF_DIR to avoid env in build machine failing the UT and IT
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5751'>FLINK-5751</a>] -         404 in documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5759'>FLINK-5759</a>] -         Set an UncaughtExceptionHandler for all Thread Pools in JobManager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5762'>FLINK-5762</a>] -         Protect initializeState() and open() by the same lock.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5771'>FLINK-5771</a>] -         DelimitedInputFormat does not correctly handle multi-byte delimiters
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5773'>FLINK-5773</a>] -         Cannot cast scala.util.Failure to org.apache.flink.runtime.messages.Acknowledge
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5793'>FLINK-5793</a>] -         Running slot may not be add to AllocatedMap in SlotPool
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5796'>FLINK-5796</a>] -         broken links in the docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5797'>FLINK-5797</a>] -         incorrect use of port range selector in BootstrapTool
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5806'>FLINK-5806</a>] -         TaskExecutionState toString format have wrong key
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5811'>FLINK-5811</a>] -         Harden YarnClusterDescriptorTest
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5814'>FLINK-5814</a>] -         flink-dist creates wrong symlink when not used with cleaned before
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5817'>FLINK-5817</a>] -         Fix test concurrent execution failure by test dir conflicts.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5824'>FLINK-5824</a>] -         Fix String/byte conversions without explicit encoding
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5827'>FLINK-5827</a>] -         Exception when do filter after join a udtf which returns a POJO type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5828'>FLINK-5828</a>] -         BlobServer create cache dir has concurrency safety problem
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5830'>FLINK-5830</a>] -         OutOfMemoryError during notify final state in TaskExecutor may cause job stuck
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5836'>FLINK-5836</a>] -         Race condition between slot offering and task deployment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5838'>FLINK-5838</a>] -         Print shell script usage
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5842'>FLINK-5842</a>] -         Wrong &#39;since&#39; version for ElasticSearch 5.x connector
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5849'>FLINK-5849</a>] -         Kafka Consumer checkpointed state may contain undefined offsets
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5864'>FLINK-5864</a>] -         CEP: fix duplicate output patterns problem.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5871'>FLINK-5871</a>] -         Enforce uniqueness of pattern names in CEP.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5872'>FLINK-5872</a>] -         WebUI shows &quot;(null)&quot; root-exception even without exception
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5885'>FLINK-5885</a>] -         Java code snippet instead of scala in documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5890'>FLINK-5890</a>] -         GatherSumApply broken when object reuse enabled
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5899'>FLINK-5899</a>] -         Fix the bug in EventTimeTumblingWindow for non-partialMerge aggregate
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5904'>FLINK-5904</a>] -         jobmanager.heap.mb and taskmanager.heap.mb not work in YARN mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5907'>FLINK-5907</a>] -         RowCsvInputFormat bug on parsing tsv
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5928'>FLINK-5928</a>] -         Externalized checkpoints overwritting each other
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5932'>FLINK-5932</a>] -         Order of legacy vs new state initialization in the AbstractStreamOperator.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5933'>FLINK-5933</a>] -         Allow Evictor for merging windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5934'>FLINK-5934</a>] -         Scheduler in ExecutionGraph null if failure happens in ExecutionGraph.restoreLatestCheckpointedState
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5937'>FLINK-5937</a>] -         Add documentation about the task lifecycle.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5940'>FLINK-5940</a>] -         ZooKeeperCompletedCheckpointStore cannot handle broken state handles
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5942'>FLINK-5942</a>] -         Harden ZooKeeperStateHandleStore to deal with corrupted data
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5945'>FLINK-5945</a>] -         Close function in OuterJoinOperatorBase#executeOnCollections
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5948'>FLINK-5948</a>] -         Error in Python zip_with_index documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5949'>FLINK-5949</a>] -         Flink on YARN checks for Kerberos credentials for non-Kerberos authentication methods
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5955'>FLINK-5955</a>] -         Merging a list of buffered records will have problem when ObjectReuse is turned on
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5962'>FLINK-5962</a>] -         Cancel checkpoint canceller tasks in CheckpointCoordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5965'>FLINK-5965</a>] -         Typo on DropWizard wrappers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5971'>FLINK-5971</a>] -         JobLeaderIdService should time out registered jobs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5972'>FLINK-5972</a>] -         Don&#39;t allow shrinking merging windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5977'>FLINK-5977</a>] -         Rename MAX_ATTEMPTS_HISTORY_SIZE key
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5985'>FLINK-5985</a>] -         Flink treats every task as stateful (making topology changes impossible)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5994'>FLINK-5994</a>] -         Add Janino to flink-table JAR file
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6000'>FLINK-6000</a>] -         Can not start HA cluster with start-cluster.sh
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6001'>FLINK-6001</a>] -         NPE on TumblingEventTimeWindows with ContinuousEventTimeTrigger and allowedLateness
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6002'>FLINK-6002</a>] -         Documentation: &#39;MacOS X&#39; under &#39;Download and Start Flink&#39; in Quickstart page is not rendered correctly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6007'>FLINK-6007</a>] -         ConcurrentModificationException in WatermarkCallbackService
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6010'>FLINK-6010</a>] -         Documentation: correct IntelliJ IDEA Plugins path in &#39;Installing the Scala plugin&#39; section
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6023'>FLINK-6023</a>] -         Fix Scala snippet into Process Function (Low-level Operations) Doc
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6025'>FLINK-6025</a>] -         User code ClassLoader not used when KryoSerializer fallbacks to serialization for copying
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6031'>FLINK-6031</a>] -         Add parameter for per job yarn clusters to control whether the user code jar is included into the system classloader.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6032'>FLINK-6032</a>] -         CEP-Clean up the operator state when not needed.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6040'>FLINK-6040</a>] -         DataStreamUserDefinedFunctionITCase occasionally fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6044'>FLINK-6044</a>] -         TypeSerializerSerializationProxy.read() doesn&#39;t verify the read buffer length
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6051'>FLINK-6051</a>] -         Wrong metric scope names in documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6059'>FLINK-6059</a>] -         Reject DataSet&lt;Row&gt; and DataStream&lt;Row&gt; without RowTypeInformation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6061'>FLINK-6061</a>] -         NPE on TypeSerializer.serialize with a RocksDBStateBackend calling entries() on a keyed state in the open() function
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6078'>FLINK-6078</a>] -         ZooKeeper based high availability services should not close the underlying CuratorFramework
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6079'>FLINK-6079</a>] -         Ineffective null check in FlinkKafkaConsumerBase#open()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6080'>FLINK-6080</a>] -         Unclosed ObjectOutputStream in NFA#serialize()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6084'>FLINK-6084</a>] -         Cassandra connector does not declare all dependencies
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6103'>FLINK-6103</a>] -         LocalFileSystem rename() uses File.renameTo()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6104'>FLINK-6104</a>] -         Resource leak in ListViaRangeSpeedMiniBenchmark
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6123'>FLINK-6123</a>] -         Add support for the NOT pattern.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6129'>FLINK-6129</a>] -         MetricRegistry does not stop query actor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6133'>FLINK-6133</a>] -         fix build status in README.md
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6143'>FLINK-6143</a>] -         Unprotected access to this.flink in LocalExecutor#endSession()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6162'>FLINK-6162</a>] -         Fix bug in ByteArrayOutputStreamWithPos#setPosition
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6170'>FLINK-6170</a>] -         Some checkpoint metrics rely on latest stat snapshot
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6172'>FLINK-6172</a>] -         Potentially unclosed RandomAccessFile in HistoryServerStaticFileServerHandler
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6176'>FLINK-6176</a>] -         Add JARs to CLASSPATH deterministically
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6181'>FLINK-6181</a>] -         Zookeeper scripts use invalid regex
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6182'>FLINK-6182</a>] -         Fix possible NPE in SourceStreamTask
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6183'>FLINK-6183</a>] -         TaskMetricGroup may not be cleanup when Task.run() is never called or exits early
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6194'>FLINK-6194</a>] -         More broken links in docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6197'>FLINK-6197</a>] -         Add support for iterative conditions.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6203'>FLINK-6203</a>] -         DataSet Transformations
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6205'>FLINK-6205</a>] -         Put late elements in side output.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6207'>FLINK-6207</a>] -         Duplicate type serializers for async snapshots of CopyOnWriteStateTable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6210'>FLINK-6210</a>] -         RocksDB instance should be closed in ListViaMergeSpeedMiniBenchmark
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6211'>FLINK-6211</a>] -         Validation error in Kinesis Consumer when using AT_TIMESTAMP as start position
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6217'>FLINK-6217</a>] -         ContaineredTaskManagerParameters sets off heap memory size incorrectly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6246'>FLINK-6246</a>] -         Fix generic type of OutputTag in operator Output
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6256'>FLINK-6256</a>] -         Fix documentation of ProcessFunction.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6259'>FLINK-6259</a>] -         Fix a small spelling error
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6265'>FLINK-6265</a>] -         Fix consecutive() for times() pattern.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6271'>FLINK-6271</a>] -         NumericBetweenParametersProvider NullPointer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6279'>FLINK-6279</a>] -         the digest of VolcanoRuleMatch matched different table sources with same field names may be same
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6282'>FLINK-6282</a>] -         Some words was spelled wrong
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6284'>FLINK-6284</a>] -         Incorrect sorting of completed checkpoints in ZooKeeperCompletedCheckpointStore
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6286'>FLINK-6286</a>] -         hbase command not found error
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6287'>FLINK-6287</a>] -         Flakey JobManagerRegistrationTest
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6290'>FLINK-6290</a>] -         SharedBuffer is improperly released when multiple edges between entries
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6292'>FLINK-6292</a>] -         Travis: transfer.sh not accepting uploads via http:// anymore
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6293'>FLINK-6293</a>] -         Flakey JobManagerITCase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6295'>FLINK-6295</a>] -         Update suspended ExecutionGraph to lower latency
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6298'>FLINK-6298</a>] -         Local execution is not setting RuntimeContext for RichOutputFormat
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6300'>FLINK-6300</a>] -         PID1 of docker images does not behave correctly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6311'>FLINK-6311</a>] -         NPE in FlinkKinesisConsumer if source was closed before run
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6312'>FLINK-6312</a>] -         Update curator version to 2.12.0
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6313'>FLINK-6313</a>] -         Some words was spelled wrong and incorrect LOG.error without print
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6317'>FLINK-6317</a>] -         History server - wrong default directory
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6327'>FLINK-6327</a>] -         Bug in CommonCalc&#39;s estimateRowCount() method
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6328'>FLINK-6328</a>] -         Savepoints must not be counted as retained checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6330'>FLINK-6330</a>] -         Improve Docker documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6341'>FLINK-6341</a>] -         JobManager can go to definite message sending loop when TaskManager registered
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6342'>FLINK-6342</a>] -         Start ZooKeeperLeaderElectionService under lock to avoid race condition
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6356'>FLINK-6356</a>] -         Make times() eager and enable allowing combinations.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6368'>FLINK-6368</a>] -         Grouping keys in stream aggregations have wrong order
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6371'>FLINK-6371</a>] -         Return matched patterns as Map&lt;String, List&lt;T&gt;&gt; instead of Map&lt;String, T&gt; 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6384'>FLINK-6384</a>] -         PythonStreamer does not close python processes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6386'>FLINK-6386</a>] -         Missing bracket in &#39;Compiler Limitation&#39; section
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6394'>FLINK-6394</a>] -         GroupCombine reuses instances even though object reuse is disabled
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6396'>FLINK-6396</a>] -         FsSavepointStreamFactoryTest fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6397'>FLINK-6397</a>] -         MultipleProgramsTestBase does not reset ContextEnvironment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6398'>FLINK-6398</a>] -         RowSerializer&#39;s duplicate should always return a new instance
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6400'>FLINK-6400</a>] -         Lack of protection accessing masterHooks in CheckpointCoordinator#triggerCheckpoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6401'>FLINK-6401</a>] -         RocksDBPerformanceTest.testRocksDbRangeGetPerformance fails on Travis
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6404'>FLINK-6404</a>] -         Ensure PendingCheckpoint is registered when calling Checkpoint Hooks
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6409'>FLINK-6409</a>] -         TUMBLE/HOP/SESSION_START/END do not resolve time field correctly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6410'>FLINK-6410</a>] -         build fails after changing Scala to 2.11
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6411'>FLINK-6411</a>] -         YarnApplicationMasterRunner should not interfere with RunningJobsRegistry
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6415'>FLINK-6415</a>] -         Make sure core Flink artifacts have no specific logger dependency
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6416'>FLINK-6416</a>] -         Potential divide by zero issue in InputGateMetrics#refreshAndGetAvg()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6427'>FLINK-6427</a>] -         BucketingSink does not sync file length in case of cancel
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6435'>FLINK-6435</a>] -         AsyncWaitOperator does not handle exceptions properly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6436'>FLINK-6436</a>] -         Bug in CommonCorrelate&#39;s generateCollector method when using udtf with udf
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6439'>FLINK-6439</a>] -         Unclosed InputStream in OperatorSnapshotUtil#readStateHandle()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6440'>FLINK-6440</a>] -         Noisy logs from metric fetcher
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6445'>FLINK-6445</a>] -         Fix NullPointerException in CEP pattern without condition
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6463'>FLINK-6463</a>] -         Throw exception when NOT-NEXT is after OPTIONAL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6474'>FLINK-6474</a>] -         Potential loss of precision in 32 bit integer multiplication
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6479'>FLINK-6479</a>] -         Fix IndexOutOfBoundsException bug
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6486'>FLINK-6486</a>] -         Pass RowTypeInfo to CodeGenerator instead of CRowTypeInfo 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6491'>FLINK-6491</a>] -         Add QueryConfig to specify state retention time for streaming queries
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6501'>FLINK-6501</a>] -         Make sure NOTICE files are bundled into shaded JAR files
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6506'>FLINK-6506</a>] -         Some tests in flink-tests exceed the memory resources in containerized Travis builds
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6508'>FLINK-6508</a>] -         Include license files of packaged dependencies
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6509'>FLINK-6509</a>] -         TestingListener might miss JobLeader notifications
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6514'>FLINK-6514</a>] -         Cannot start Flink Cluster in standalone mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6515'>FLINK-6515</a>] -         KafkaConsumer checkpointing fails because of ClassLoader issues
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6517'>FLINK-6517</a>] -         Support multiple consecutive windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6520'>FLINK-6520</a>] -         FlinkKafkaConsumer09+ does not overwrite props to disable auto commit offsets when commit mode is OffsetCommitMode.ON_CHECKPOINTS
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6530'>FLINK-6530</a>] -         Unclosed Response in DatadogHttpClient#validateApiKey()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6531'>FLINK-6531</a>] -         Deserialize checkpoint hooks with user classloader
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6536'>FLINK-6536</a>] -         Improve error message in SharedBuffer::put()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6542'>FLINK-6542</a>] -         Non-keyed, non-windowed aggregation fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6548'>FLINK-6548</a>] -         AvroOutputFormatTest fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6561'>FLINK-6561</a>] -         GlobFilePathFilterTest#testExcludeFilenameWithStart fails on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6562'>FLINK-6562</a>] -         Support implicit table references for nested fields in SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6564'>FLINK-6564</a>] -         Build fails on file systems that do not distinguish between upper and lower case
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6574'>FLINK-6574</a>] -         Support nested catalogs in ExternalCatalog
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6578'>FLINK-6578</a>] -         SharedBuffer creates self-loops when having elements with same value/timestamp.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6579'>FLINK-6579</a>] -         Add proper support for BasicArrayTypeInfo
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6580'>FLINK-6580</a>] -         Flink on YARN doesnt start with default parameters
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6581'>FLINK-6581</a>] -         Dynamic property parsing broken for YARN
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6582'>FLINK-6582</a>] -         Project from maven archetype is not buildable by default due to ${scala.binary.version}
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6583'>FLINK-6583</a>] -         Enable QueryConfig in count base GroupWindow
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6585'>FLINK-6585</a>] -         Table examples are not runnable in IDE
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6586'>FLINK-6586</a>] -         InputGateMetrics#refreshAndGetMin returns Integer.MAX_VALUE for local channels
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6587'>FLINK-6587</a>] -         Java Table API cannot parse function names starting with keywords
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6593'>FLINK-6593</a>] -         Fix Bug in ProctimeAttribute or RowtimeAttribute with CodeGenerator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6595'>FLINK-6595</a>] -         Nested SQL queries do not expose proctime / rowtime attributes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6598'>FLINK-6598</a>] -         Remove useless param rowRelDataType of DataStreamGroupAggregate.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6604'>FLINK-6604</a>] -         Remove Java Serialization from the CEP library.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6606'>FLINK-6606</a>] -         Create checkpoint hook with user classloader
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6609'>FLINK-6609</a>] -         Wrong version assignment when multiple TAKEs transitions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6612'>FLINK-6612</a>] -         ZooKeeperStateHandleStore does not guard against concurrent delete operations
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6614'>FLINK-6614</a>] -         Applying function on window auxiliary function fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6628'>FLINK-6628</a>] -         Cannot start taskmanager with cygwin in directory containing spaces
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6629'>FLINK-6629</a>] -         ClusterClient cannot submit jobs to HA cluster if address not set in configuration
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6634'>FLINK-6634</a>] -         NFA serializer does not serialize the ComputationState counter.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6635'>FLINK-6635</a>] -         ClientConnectionTest is broken because the ClusterClient lazily connects to the JobManager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6639'>FLINK-6639</a>] -         Java/Scala code tabs broken in CEP docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6641'>FLINK-6641</a>] -         HA recovery on YARN: ClusterClient calls HighAvailabilityServices#closeAndCleanupAll
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6644'>FLINK-6644</a>] -         Don&#39;t register HUP unix signal handler on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6646'>FLINK-6646</a>] -         YARN session doesn&#39;t work with HA
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6651'>FLINK-6651</a>] -         Clearing registeredStates map should be protected in SharedStateRegistry#clear
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6656'>FLINK-6656</a>] -         Migrate CEP PriorityQueue to MapState
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6662'>FLINK-6662</a>] -         ClassNotFoundException: o.a.f.r.j.t.JobSnapshottingSettings recovering job
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6671'>FLINK-6671</a>] -         RocksDBStateBackendTest.testCancelRunningSnapshot unstable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6702'>FLINK-6702</a>] -         SIGABRT after CEPOperatorTest#testCEPOperatorSerializationWRocksDB() during GC
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6704'>FLINK-6704</a>] -         Cannot disable YARN user jar inclusion
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6714'>FLINK-6714</a>] -         Operator state backend should set user classloader as context classloader when snapshotting
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6753'>FLINK-6753</a>] -         Flaky SqlITCase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6780'>FLINK-6780</a>] -         ExternalTableSource should add time attributes in the row type
</li>
</ul>
                    
<h2>        Improvement
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2211'>FLINK-2211</a>] -         Generalize ALS API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2908'>FLINK-2908</a>] -         Web interface redraw web plan when browser resized
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3123'>FLINK-3123</a>] -         Allow setting custom start-offsets for the Kafka consumer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3150'>FLINK-3150</a>] -         Make YARN container invocation configurable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3163'>FLINK-3163</a>] -         Configure Flink for NUMA systems
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3318'>FLINK-3318</a>] -         Add support for quantifiers to CEP&#39;s pattern API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3347'>FLINK-3347</a>] -         TaskManager (or its ActorSystem) need to restart in case they notice quarantine
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3360'>FLINK-3360</a>] -         Clear up StateBackend, AbstractStateBackend abstractions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3398'>FLINK-3398</a>] -         Flink Kafka consumer should support auto-commit opt-outs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3427'>FLINK-3427</a>] -         Add watermark monitoring to JobManager web frontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3703'>FLINK-3703</a>] -         Add sequence matching semantics to discard matched events
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4288'>FLINK-4288</a>] -         Make it possible to unregister tables
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4326'>FLINK-4326</a>] -         Flink start-up scripts should optionally start services on the foreground
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4396'>FLINK-4396</a>] -         GraphiteReporter class not found at startup of jobmanager
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4410'>FLINK-4410</a>] -         Report more information about operator checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4450'>FLINK-4450</a>] -         update storm version to 1.0.0
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4552'>FLINK-4552</a>] -         Refactor WindowOperator/Trigger Tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4673'>FLINK-4673</a>] -         TypeInfoFactory for Either type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4754'>FLINK-4754</a>] -         Make number of retained checkpoints user configurable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4917'>FLINK-4917</a>] -         Deprecate &quot;CheckpointedAsynchronously&quot; interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4920'>FLINK-4920</a>] -         Add a Scala Function Gauge
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4949'>FLINK-4949</a>] -         Refactor Gelly driver inputs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4953'>FLINK-4953</a>] -         Allow access to &quot;time&quot; in ProcessWindowFunction.Context
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5059'>FLINK-5059</a>] -         only serialise events once in RecordWriter#broadcastEvent
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5066'>FLINK-5066</a>] -         add more efficient isEvent check to EventSerializer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5067'>FLINK-5067</a>] -         Make Flink compile with 1.8 Java compiler
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5113'>FLINK-5113</a>] -         Make all Testing Functions implement CheckpointedFunction Interface.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5129'>FLINK-5129</a>] -         make the BlobServer use a distributed file system
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5153'>FLINK-5153</a>] -         Allow setting custom application tags for Flink on YARN
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5183'>FLINK-5183</a>] -         [py] Support multiple jobs per Python plan file
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5222'>FLINK-5222</a>] -         Rename StateBackend interface to StateBinder
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5237'>FLINK-5237</a>] -         Consolidate and harmonize Window Translation Tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5277'>FLINK-5277</a>] -         missing unit test for ensuring ResultPartition#add always recycles buffers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5280'>FLINK-5280</a>] -         Refactor TableSource
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5306'>FLINK-5306</a>] -         Display checkpointing configuration details in web UI &quot;Configuration&quot; tab
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5331'>FLINK-5331</a>] -         PythonPlanBinderTest idling extremely long
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5348'>FLINK-5348</a>] -         Support custom field names for RowTypeInfo
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5358'>FLINK-5358</a>] -         Support RowTypeInfo extraction in TypeExtractor by Row instance
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5368'>FLINK-5368</a>] -         Let Kafka consumer show something when it fails to read one topic out of topic list
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5377'>FLINK-5377</a>] -         Improve savepoint docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5385'>FLINK-5385</a>] -         Add a help function to create Row
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5388'>FLINK-5388</a>] -         Remove private access of edges and vertices of Gelly Graph class
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5395'>FLINK-5395</a>] -         support locally build distribution by script create_release_files.sh
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5399'>FLINK-5399</a>] -         Add more information to checkpoint result of TriggerSavepointSuccess
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5404'>FLINK-5404</a>] -         Consolidate and update S3 documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5412'>FLINK-5412</a>] -         Enable RocksDB tests on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5414'>FLINK-5414</a>] -         Bump up Calcite version to 1.11
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5415'>FLINK-5415</a>] -         ContinuousFileProcessingTest failed on travis
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5424'>FLINK-5424</a>] -         Improve Restart Strategy Logging
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5438'>FLINK-5438</a>] -         Typo in JobGraph generator Exception 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5442'>FLINK-5442</a>] -         Add test to fix ordinals of serialized enum StateDescriptor.Type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5446'>FLINK-5446</a>] -         System metrics reference incomplete
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5448'>FLINK-5448</a>] -         Fix typo in StateAssignmentOperation Exception
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5451'>FLINK-5451</a>] -         Extend JMX metrics documentation section
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5452'>FLINK-5452</a>] -         Make table unit tests pass under cluster mode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5461'>FLINK-5461</a>] -         Remove Superflous TypeInformation Declaration
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5466'>FLINK-5466</a>] -         Make production environment default in gulpfile
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5480'>FLINK-5480</a>] -         User-provided hashes for operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5485'>FLINK-5485</a>] -         Mark compiled web frontend files as binary when processed by git diff
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5497'>FLINK-5497</a>] -         remove duplicated tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5499'>FLINK-5499</a>] -         Try to reuse the resource location of prior execution attempt in allocating slot
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5503'>FLINK-5503</a>] -         mesos-appmaster.sh script could print return value message
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5507'>FLINK-5507</a>] -         remove queryable list state sink
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5508'>FLINK-5508</a>] -         Remove Mesos dynamic class loading
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5515'>FLINK-5515</a>] -         fix unused kvState.getSerializedValue call in KvStateServerHandler
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5516'>FLINK-5516</a>] -         Hardcoded paths in flink-python/.../PythonPlanBinder.java
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5517'>FLINK-5517</a>] -         Upgrade hbase version to 1.3.0
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5519'>FLINK-5519</a>] -         scala-maven-plugin version all change to 3.2.2
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5521'>FLINK-5521</a>] -         remove unused KvStateRequestSerializer#serializeList
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5522'>FLINK-5522</a>] -         Storm LocalCluster can&#39;t run with powermock
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5524'>FLINK-5524</a>] -         Support early out for code generated conjunctive conditions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5528'>FLINK-5528</a>] -         tests: reduce the retry delay in QueryableStateITCase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5543'>FLINK-5543</a>] -         customCommandLine tips in CliFrontend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5559'>FLINK-5559</a>] -         queryable state: KvStateRequestSerializer#deserializeKeyAndNamespace() throws an IOException without own failure message if deserialisation fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5563'>FLINK-5563</a>] -         Add density to vertex metrics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5574'>FLINK-5574</a>] -         Add checkpoint statistics docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5575'>FLINK-5575</a>] -         in old releases, warn users and guide them to the latest stable docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5576'>FLINK-5576</a>] -         extend deserialization functions of KvStateRequestSerializer to detect unconsumed bytes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5581'>FLINK-5581</a>] -         Improve Kerberos security related documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5583'>FLINK-5583</a>] -         Support flexible error handling in the Kafka consumer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5586'>FLINK-5586</a>] -         Extend TableProgramsTestBase for object reuse modes
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5590'>FLINK-5590</a>] -         Create a proper internal state hierarchy
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5597'>FLINK-5597</a>] -         Improve the LocalClusteringCoefficient documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5598'>FLINK-5598</a>] -         Return jar name when jar is uploaded
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5609'>FLINK-5609</a>] -         Add last update time to docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5610'>FLINK-5610</a>] -         Rename Installation and Setup to Project Setup
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5615'>FLINK-5615</a>] -         queryable state: execute the QueryableStateITCase for all three state back-ends
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5624'>FLINK-5624</a>] -         Support tumbling window on streaming tables in the SQL API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5625'>FLINK-5625</a>] -         Let Date format for timestamp-based start position in Kinesis consumer be configurable.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5630'>FLINK-5630</a>] -         Followups to AggregationFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5632'>FLINK-5632</a>] -         Typo in StreamGraph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5635'>FLINK-5635</a>] -         Improve Docker tooling to make it easier to build images and launch Flink via Docker tools
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5639'>FLINK-5639</a>] -         Clarify License implications of RabbitMQ Connector
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5680'>FLINK-5680</a>] -         Document env.ssh.opts
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5681'>FLINK-5681</a>] -         Make ReaperThread for SafetyNetCloseableRegistry a singleton
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5702'>FLINK-5702</a>] -         Kafka Producer docs should warn if using setLogFailuresOnly, at-least-once is compromised
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5705'>FLINK-5705</a>] -         webmonitor&#39;s request/response use UTF-8 explicitly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5714'>FLINK-5714</a>] -         Use a builder pattern for creating CsvTableSource
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5718'>FLINK-5718</a>] -         Handle JVM Fatal Exceptions in Tasks
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5720'>FLINK-5720</a>] -         Deprecate &quot;Folding&quot; in all of DataStream API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5721'>FLINK-5721</a>] -         Add FoldingState to State Documentation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5722'>FLINK-5722</a>] -         Implement DISTINCT as dedicated operator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5727'>FLINK-5727</a>] -         Unify some API of batch and stream TableEnvironment
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5741'>FLINK-5741</a>] -         Add tests for window function wrappers with RichFunctions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5742'>FLINK-5742</a>] -         Breakpoints on documentation website
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5743'>FLINK-5743</a>] -         Mark WindowedStream.aggregate* methods as PublicEvolving
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5745'>FLINK-5745</a>] -         Set uncaught exception handler for Netty threads
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5748'>FLINK-5748</a>] -         Make the ExecutionGraph&#39;s FutureExecutor a ScheduledExecutionService
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5756'>FLINK-5756</a>] -         When there are many values under the same key in ListState, RocksDBStateBackend performances poor
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5766'>FLINK-5766</a>] -         Unify NoAvailableResourceException handling on ExecutionGraph
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5788'>FLINK-5788</a>] -         Document assumptions about File Systems and persistence
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5792'>FLINK-5792</a>] -         Improve “UDF/UDTF&quot; to support constructor with parameter.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5800'>FLINK-5800</a>] -         Make sure that the CheckpointStreamFactory is instantiated once per operator only
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5805'>FLINK-5805</a>] -         improve docs for ProcessFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5807'>FLINK-5807</a>] -         improved wording for doc home page
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5812'>FLINK-5812</a>] -         Clean up FileSystem
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5819'>FLINK-5819</a>] -         Improve metrics reporting
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5826'>FLINK-5826</a>] -         UDF/UDTF should support variable types and variable arguments
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5837'>FLINK-5837</a>] -         improve readability of the queryable state docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5852'>FLINK-5852</a>] -         Move JSON generation code into static methods
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5854'>FLINK-5854</a>] -         Introduce some Flink-specific base Exception types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5870'>FLINK-5870</a>] -         Make handlers aware of their REST URLs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5876'>FLINK-5876</a>] -         Mention Scala type fallacies for queryable state client serializers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5877'>FLINK-5877</a>] -         Fix Scala snippet in Async I/O API doc
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5887'>FLINK-5887</a>] -         Make CheckpointBarrier type immutable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5894'>FLINK-5894</a>] -         HA docs are misleading re: state backends
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5895'>FLINK-5895</a>] -         Reduce logging aggressiveness of FileSystemSafetyNet
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5917'>FLINK-5917</a>] -         Remove MapState.size()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5921'>FLINK-5921</a>] -         Adapt time mode indicator functions return custom data types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5929'>FLINK-5929</a>] -         Allow Access to Per-Window State in ProcessWindowFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5938'>FLINK-5938</a>] -         Replace ExecutionContext by Executor in Scheduler
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5952'>FLINK-5952</a>] -         JobCancellationWithSavepointHandlersTest uses deprecated JsonNode#getValuesAsText
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5954'>FLINK-5954</a>] -         Always assign names to the window in the Stream SQL API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5969'>FLINK-5969</a>] -         Add savepoint backwards compatibility tests from 1.2 to 1.3
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5974'>FLINK-5974</a>] -         Support Mesos DNS
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5975'>FLINK-5975</a>] -         Mesos should support adding volumes to launched taskManagers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5976'>FLINK-5976</a>] -         Refactoring duplicate Tokenizer in flink-test
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5983'>FLINK-5983</a>] -         Replace for/foreach/map in aggregates by while loops
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5984'>FLINK-5984</a>] -         Add resetAccumulator method for AggregateFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5998'>FLINK-5998</a>] -         Un-fat Hadoop from Flink fat jar
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6005'>FLINK-6005</a>] -         unit test ArrayList initializations without initial size
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6009'>FLINK-6009</a>] -         Deprecate DataSetUtils#checksumHashCode
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6013'>FLINK-6013</a>] -         Add Datadog HTTP metrics reporter
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6018'>FLINK-6018</a>] -         Properly initialise StateDescriptor in AbstractStateBackend.getPartitionedState()
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6033'>FLINK-6033</a>] -         Support UNNEST query in the stream SQL API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6041'>FLINK-6041</a>] -         Move StreamingFunctionUtils to &#39;org.apache.flink.streaming.util&#39;
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6068'>FLINK-6068</a>] -         Support If() as a built-in function of TableAPI
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6071'>FLINK-6071</a>] -         Savepoints should not count in the number of retained checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6076'>FLINK-6076</a>] -         Let the HeartbeatManager interface extend HeartbeatTarget
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6086'>FLINK-6086</a>] -         Rework PythonSender/-Streamer generics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6111'>FLINK-6111</a>] -         Remove sleep after python process generation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6122'>FLINK-6122</a>] -         add TravisCI build status to README.md
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6124'>FLINK-6124</a>] -         support max/min aggregations for string type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6127'>FLINK-6127</a>] -         Add MissingDeprecatedCheck to checkstyle
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6128'>FLINK-6128</a>] -         Optimize JVM options for improve test performance
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6134'>FLINK-6134</a>] -         Set UUID(0L, 0L) as default leader session id
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6138'>FLINK-6138</a>] -         Improve UnboundedNonPartitionedProcessingOverProcessFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6144'>FLINK-6144</a>] -         Port job manager related configuration options to ConfigOption
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6157'>FLINK-6157</a>] -         Make TypeInformation fully serializable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6164'>FLINK-6164</a>] -         Make ProcessWindowFunction a RichFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6212'>FLINK-6212</a>] -         Missing reference to flink-avro dependency
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6223'>FLINK-6223</a>] -         Rework PythonPlanBinder generics
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6229'>FLINK-6229</a>] -         Rework setup&amp;configuration of PythonPlanBinder/operators
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6230'>FLINK-6230</a>] -         Make mmap size configurable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6236'>FLINK-6236</a>] -         Savepoint page needs to include web console possibility
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6247'>FLINK-6247</a>] -         Build a jar-with-dependencies for flink-table and put it into ./opt
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6248'>FLINK-6248</a>] -         Make the optional() available to all offered patterns.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6254'>FLINK-6254</a>] -         Consolidate late data methods on PatternStream and WindowedStream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6267'>FLINK-6267</a>] -         Remove the useless import in FlinkRelBuilder
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6268'>FLINK-6268</a>] -         Object reuse for Either type
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6270'>FLINK-6270</a>] -         Port several network config parameters to ConfigOption
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6274'>FLINK-6274</a>] -         Replace usages of org.codehaus.jackson
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6280'>FLINK-6280</a>] -         Allow logging with Java flags
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6288'>FLINK-6288</a>] -         FlinkKafkaProducer&#39;s custom Partitioner is always invoked with number of partitions of default topic
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6299'>FLINK-6299</a>] -         make all IT cases extend from TestLogger
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6304'>FLINK-6304</a>] -         Clear a lot of useless import
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6307'>FLINK-6307</a>] -         Refactor JDBC tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6324'>FLINK-6324</a>] -         Refine state access methods in OperatorStateStore
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6334'>FLINK-6334</a>] -         Refactoring UDTF interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6337'>FLINK-6337</a>] -         Remove the buffer provider from PartitionRequestServerHandler
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6338'>FLINK-6338</a>] -         SimpleStringUtils should be called StringValueUtils
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6339'>FLINK-6339</a>] -         Remove useless and unused class ConnectorSource
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6381'>FLINK-6381</a>] -         Unnecessary synchronized object in BucketingSink
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6382'>FLINK-6382</a>] -         Support additional types for generated graphs in Gelly examples
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6395'>FLINK-6395</a>] -         TestBases not marked as abstract
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6406'>FLINK-6406</a>] -         Cleanup useless import 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6438'>FLINK-6438</a>] -         Expand docs home page a little
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6443'>FLINK-6443</a>] -         Add more doc links in concepts sections
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6447'>FLINK-6447</a>] -         AWS/EMR docs are out-of-date
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6459'>FLINK-6459</a>] -         Move ACCESS_CONTROL_ALLOW_ORIGIN to JobManagerOptions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6462'>FLINK-6462</a>] -         Add requiresOver interface for  AggregateFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6476'>FLINK-6476</a>] -         Table environment register row data stream
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6482'>FLINK-6482</a>] -         Add nested serializers into configuration snapshots of composite serializers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6512'>FLINK-6512</a>] -         some code examples are poorly formatted
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6513'>FLINK-6513</a>] -         various typos and grammatical flaws
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6519'>FLINK-6519</a>] -         Integrate BlobStore in HighAvailabilityServices lifecycle management
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6551'>FLINK-6551</a>] -         OutputTag name should not be allowed to be empty
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6552'>FLINK-6552</a>] -         Side outputs don&#39;t allow differing output types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6554'>FLINK-6554</a>] -         CompatibilityResult should contain a notCompatible() option
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6555'>FLINK-6555</a>] -         Generalize ConjunctFuture
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6558'>FLINK-6558</a>] -         Yarn tests fail on Windows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6565'>FLINK-6565</a>] -         Improve error messages for state restore failures
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6566'>FLINK-6566</a>] -         Narrow down interface for compatibility hook method in VersionedIOReadableWritable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6589'>FLINK-6589</a>] -         ListSerializer should deserialize as ArrayList with size + 1
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6596'>FLINK-6596</a>] -         Disable javadoc generation in all travis builds
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6600'>FLINK-6600</a>] -         Add key serializer&#39;s config snapshot to KeyedBackendSerializationProxy
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6601'>FLINK-6601</a>] -         Use time indicators in DataStreamLogicalWindowAggregateRule
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6608'>FLINK-6608</a>] -         Relax Kerberos login contexts parsing by trimming whitespaces in contexts list
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6616'>FLINK-6616</a>] -         Clarify provenance of official Docker images
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6653'>FLINK-6653</a>] -         Avoid directly serializing AWS&#39;s Shard class in Kinesis consumer&#39;s checkpoints
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6660'>FLINK-6660</a>] -         expand the streaming connectors overview page 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6674'>FLINK-6674</a>] -         Update release 1.3 docs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6708'>FLINK-6708</a>] -         Don&#39;t let the FlinkYarnSessionCli fail if it cannot retrieve the ClusterStatus
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6766'>FLINK-6766</a>] -         Update documentation with async backends and incremental checkpoints
</li>
</ul>
                
<h2>        New Feature
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-1579'>FLINK-1579</a>] -         Create a Flink History Server
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2168'>FLINK-2168</a>] -         Add HBaseTableSource
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3475'>FLINK-3475</a>] -         DISTINCT aggregate function support for SQL queries
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3695'>FLINK-3695</a>] -         ValueArray types
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3849'>FLINK-3849</a>] -         Add FilterableTableSource interface and translation rule
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3871'>FLINK-3871</a>] -         Add Kafka TableSource with Avro serialization
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4280'>FLINK-4280</a>] -         New Flink-specific option to set starting position of Kafka consumer without respecting external offsets in ZK / Broker
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4460'>FLINK-4460</a>] -         Side Outputs in Flink
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4523'>FLINK-4523</a>] -         Allow Kinesis Consumer to start from specific timestamp / Date
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4604'>FLINK-4604</a>] -         Add support for standard deviation/variance
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4686'>FLINK-4686</a>] -         Add possibility to get column names
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4821'>FLINK-4821</a>] -         Implement rescalable non-partitioned state for Kinesis Connector
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4856'>FLINK-4856</a>] -         Add MapState for keyed streams
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4896'>FLINK-4896</a>] -         PageRank algorithm for directed graphs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4988'>FLINK-4988</a>] -         Elasticsearch 5.x support
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4997'>FLINK-4997</a>] -         Extending Window Function Metadata
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5017'>FLINK-5017</a>] -         Introduce StreamStatus stream element to allow for temporarily idle streaming sources
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5090'>FLINK-5090</a>] -         Expose optionally detailed metrics about network queue lengths
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5157'>FLINK-5157</a>] -         Extending AllWindow Function Metadata
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5265'>FLINK-5265</a>] -         Introduce state handle replication mode for CheckpointCoordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5303'>FLINK-5303</a>] -         Add CUBE/ROLLUP/GROUPING SETS operator in SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5406'>FLINK-5406</a>] -         add normalization phase for predicate logical plan rewriting between decorrelate query phase and volcano optimization phase
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5441'>FLINK-5441</a>] -         Directly allow SQL queries on a Table
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5571'>FLINK-5571</a>] -         add open and close methods for UserDefinedFunction in TableAPI &amp; SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5582'>FLINK-5582</a>] -         Add a general distributive aggregate function
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5692'>FLINK-5692</a>] -         Add an Option to Deactivate Kryo Fallback for Serializers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5698'>FLINK-5698</a>] -         Add NestedFieldsProjectableTableSource interface
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5710'>FLINK-5710</a>] -         Add ProcTime() function to indicate StreamSQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5715'>FLINK-5715</a>] -         Asynchronous snapshotting for HeapKeyedStateBackend
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5884'>FLINK-5884</a>] -         Integrate time indicators for Table API &amp; SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5892'>FLINK-5892</a>] -         Recover job state at the granularity of operator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5941'>FLINK-5941</a>] -         Let handlers take part in job archiving
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5979'>FLINK-5979</a>] -         Backwards compatibility for HeapKeyedStateBackend serialization format (1.2 -&gt; 1.3)
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5991'>FLINK-5991</a>] -         Expose Broadcast Operator State through public APIs
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6047'>FLINK-6047</a>] -         Add support for Retraction in Table API / SQL
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6048'>FLINK-6048</a>] -         Asynchronous snapshots for heap-based operator state backends
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6112'>FLINK-6112</a>] -         Support Calcite 1.12&#39;s new numerical functions
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6139'>FLINK-6139</a>] -         Documentation for building / preparing Flink for MapR
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6165'>FLINK-6165</a>] -         Implement internal continuity for looping states.
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6177'>FLINK-6177</a>] -         Add support for &quot;Distributed Cache&quot; in streaming applications
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6178'>FLINK-6178</a>] -         Allow upgrades to state serializers
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6208'>FLINK-6208</a>] -         Implement skip till next match strategy
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6326'>FLINK-6326</a>] -         add ProjectMergeRule at logical optimization stage
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6336'>FLINK-6336</a>] -         Placement Constraints for Mesos
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6377'>FLINK-6377</a>] -         Support map types in the Table / SQL API
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6390'>FLINK-6390</a>] -         Add Trigger Hooks to the Checkpoint Coordinator
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6393'>FLINK-6393</a>] -         Add Evenly Graph Generator to Flink Gelly
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6483'>FLINK-6483</a>] -         Support time materialization
</li>
</ul>
                                                        
<h2>        Task
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-2883'>FLINK-2883</a>] -         Add documentation to forbid key-modifying ReduceFunction
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-3903'>FLINK-3903</a>] -         Homebrew Installation
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4577'>FLINK-4577</a>] -         Re-enable transparent reshard handling in Kinesis Consumer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4820'>FLINK-4820</a>] -         Slf4j / log4j version upgrade to support dynamic change of log levels --&gt; Make logging framework exchangeable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5074'>FLINK-5074</a>] -         Implement a RunningJobRegistry based on Zookeeper 
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5084'>FLINK-5084</a>] -         Replace Java Table API integration tests by unit tests
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5829'>FLINK-5829</a>] -         Bump Calcite version to 1.12 once available
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6543'>FLINK-6543</a>] -         Deprecate toDataStream
</li>
</ul>
            
<h2>        Test
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5587'>FLINK-5587</a>] -         AsyncWaitOperatorTest timed out on Travis
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5923'>FLINK-5923</a>] -         Test instability in SavepointITCase testTriggerSavepointAndResume
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6175'>FLINK-6175</a>] -         HistoryServerTest.testFullArchiveLifecycle fails
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6471'>FLINK-6471</a>] -         RocksDBStateBackendTest#testCancelRunningSnapshot sometimes fails
</li>
</ul>
        
<h2>        Wish
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4545'>FLINK-4545</a>] -         Flink automatically manages TM network buffer
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-4644'>FLINK-4644</a>] -         Deprecate &quot;flink.base.dir.path&quot; from ConfigConstants
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-5378'>FLINK-5378</a>] -         Update Scopt version to 3.5.0
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6056'>FLINK-6056</a>] -         apache-rat exclude flink directory in tools
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6186'>FLINK-6186</a>] -         Remove unused import
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-6269'>FLINK-6269</a>] -         var could be a val
</li>
</ul>
