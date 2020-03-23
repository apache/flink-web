---
layout: post
title: "PyFlink: Introducing Python Support for UDFs in Flink's Table API"
date: 2020-02-23T12:00:00.000Z
authors:
- Jincheng:
  name: "Jincheng Sun"
excerpt: Flink 1.10 extends its support for Python by adding Python UDFs in PyFlink. This post explains how UDFs work in PyFlink and gives some practical examples of how to use UDFs in PyFlink. 
---

Flink 1.9 introduced the Python Table API, allowing developers and data engineers to write Python Table API jobs for Table Transformations and Analysis, such as Python ETL or Aggregate jobs. However, Python users faced some limitations when it came to support for Python UDFs in Flink 1.9, preventing them from extending the system’s built-in functionality. 

In Flink1.10, the community further extended the support for Python by adding Python UDFs in PyFlink. Additionally, both the Python UDF Environment and Dependency Management are now supported, allowing users to import third-party libraries in the UDFs, leveraging Python's rich set of third-party libraries. 


# Python Support for UDFs in Flink 1.10

Before diving into how you can define and use Python UDFs, we explain the motivation and background behind how UDFs work in PyFlink and provide some additional context about the implementation of our approach.

Since Python UDFs cannot directly run in JVM, they are executed within the Python environment, in a Python Process initiated by the Flink operator upon initialization. The Python environment is responsible for launching, managing and tearing down the Python Process. As illustrated in Figure 1 below, several components are involved in the communication between the Flink operator and the Python execution environment:

* **Environment Service**: Responsible for launching and destroying the Python execution environment. 
* **Data Service**: Responsible for transferring the input data and the user-defined function execution results between the Flink operator and the Python execution environment.
* **Logging Service**: Mechanism for logging support for user defined functions. It allows transferring log entries produced by user defined functions to the Flink operator and integrates with Flink’s own logging system. 

<center>
<img src="{{ site.baseurl }}/img/blog/2020-02-23-pyflink-udfs/communication-flink-operator-python-execution-environment.png" width="600px" alt="Communication between the Flink operator and the Python execution environment"/>
</center>
<br>

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
NOTE: Supporting metrics is currently planned for Flink 1.11
</div>

<br>

Figure 2 below describes the high-level flow between initializing and executing UDFs from the Java operator to the Python process. 

<center>
<img src="{{ site.baseurl }}/img/blog/2020-02-23-pyflink-udfs/flow-initialization-execution-python-udfs-flink.png" width="800px" alt="High-level flow between initialization and execution of Python UDFs in Flink 1.10"/>
</center>
<br>

The high-level flow can be summarized in two parts:
1. Initialization of the Python execution environment.
  * The Python UDF Runner starts the gRPC services, such as the data service, logging service, etc.
  * The Python UDF Runner launches the Python execution environment in a separate process.
  * The Python worker registers to `PythonUserDefinedFunctionRunner`.
  * The Python UDF Runner sends the user defined functions to be executed in the Python worker.
  * The Python worker transforms the user defined functions to Beam operations. (Note that we leverage the power of [Beam’s Portability Framework](https://beam.apache.org/roadmap/portability/) to execute the Python UDF.)
  * The Python worker establishes the gRPC connections, such as the data connection, logging connection, etc.

2. Processing of the input elements.
  * The Python UDF Runner sends the input elements via the gRPC data service to the Python worker for execution.
  * The Python use defined function can access the state via gRPC state service during execution.
  * The Python user defined function can also aggregate the logging and metrics to the Python UDF Runner via the gRPC logging service and the metrics service during execution.
  * The execution results are finally sent to the Python UDF Runner via the gRPC data service.


# How to use PyFlink with UDFs in Flink 1.10

This section provides some Python user defined function (UDF) examples, including how to install PyFlink, how to define/register/invoke UDFs in PyFlink and how to execute the job.


### Install PyFlink
Using Python in Apache Flink requires installing PyFlink. PyFlink is available through PyPi and can be easily installed using pip: 

```python
// create and configure Pulsar consumer
PulsarSourceBuilder<String>builder = PulsarSourceBuilder  
  .builder(new SimpleStringSchema()) 
  .serviceUrl(serviceUrl)
  .topic(inputTopic)
  .subsciptionName(subscription);
SourceFunction<String> src = builder.build();
// ingest DataStream with Pulsar consumer
DataStream<String> words = env.addSource(src);
```
<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
Please note that Python 3.5 or higher is required to install and run PyFlink
</div>

<br>

### Define a Python UDF

There are many ways to define a Python scalar function, besides extending the base class `ScalarFunction`. The following example shows the different ways of defining a Python scalar function that takes two columns of `BIGINT` as input parameters and returns the sum of them as the result.

```python
# option 1: extending the base class `ScalarFunction`
class Add(ScalarFunction):
  def eval(self, i, j):
    return i + j

add = udf(Add(), [DataTypes.BIGINT(), DataTypes.BIGINT()], DataTypes.BIGINT())

# option 2: Python function
@udf(input_types=[DataTypes.BIGINT(), DataTypes.BIGINT()], result_type=DataTypes.BIGINT())
def add(i, j):
  return i + j

# option 3: lambda function
add = udf(lambda i, j: i + j, [DataTypes.BIGINT(), DataTypes.BIGINT()], DataTypes.BIGINT())

# option 4: callable function
class CallableAdd(object):
  def __call__(self, i, j):
    return i + j

add = udf(CallableAdd(), [DataTypes.BIGINT(), DataTypes.BIGINT()], DataTypes.BIGINT())

# option 5: partial function
def partial_add(i, j, k):
  return i + j + k

add = udf(functools.partial(partial_add, k=1), [DataTypes.BIGINT(), DataTypes.BIGINT()],
          DataTypes.BIGINT())
```

### Register a Python UDF

```python
# register the Python function
table_env.register_function("add", add)
```

### Invoke a Python UDF

```python
# use the function in Python Table API
my_table.select("add(a, b)")
```

Below, you can find a complete example of using Python UDF.

```python
from pyflink.datastream import StreamExecutionEnvironment
from pyflink.table import StreamTableEnvironment, DataTypes
from pyflink.table.descriptors import Schema, OldCsv, FileSystem
from pyflink.table.udf import udf

env = StreamExecutionEnvironment.get_execution_environment()
env.set_parallelism(1)
t_env = StreamTableEnvironment.create(env)

t_env.register_function("add", udf(lambda i, j: i + j, [DataTypes.BIGINT(), DataTypes.BIGINT()], DataTypes.BIGINT()))

t_env.connect(FileSystem().path('/tmp/input')) \
    .with_format(OldCsv()
                 .field('a', DataTypes.BIGINT())
                 .field('b', DataTypes.BIGINT())) \
    .with_schema(Schema()
                 .field('a', DataTypes.BIGINT())
                 .field('b', DataTypes.BIGINT())) \
    .create_temporary_table('mySource')

t_env.connect(FileSystem().path('/tmp/output')) \
    .with_format(OldCsv()
                 .field('sum', DataTypes.BIGINT())) \
    .with_schema(Schema()
                 .field('sum', DataTypes.BIGINT())) \
    .create_temporary_table('mySink')

t_env.from_path('mySource')\
    .select("add(a, b)") \
    .insert_into('mySink')

t_env.execute("tutorial_job")
```

### Submit the job

Firstly, you need to prepare the input data in the “/tmp/input” file. For example,

`$ echo "1,2" > /tmp/input`

Next, you can run this example on the command line,

`$ python python_udf_sum.py`

The command builds and runs the Python Table API program in a local mini-cluster. You can also submit the Python Table API program to a remote cluster using different command lines, (see more details [here](https://ci.apache.org/projects/flink/flink-docs-master/ops/cli.html#job-submission-examples)).

Finally, you can see the execution result on the command line:

`$ cat /tmp/output
 3`


### Python UDF dependency management

In many cases, you would like to import third-party dependencies in the Python UDF. The example below provides detailed guidance on how to manage such dependencies.

Suppose you want to use the `mpmath` to perform the sum of the example above. The Python UDF may look like:

```python
@udf(input_types=[DataTypes.BIGINT(), DataTypes.BIGINT()], result_type=DataTypes.BIGINT())
def add(i, j):
    from mpmath import fadd # add third-party dependency
    return int(fadd(1, 2))
```

To make it available on the worker node that does not contain the dependency, you can specify the dependencies with the following API:

```python
# echo mpmath==1.1.0 > requirements.txt
# pip download -d cached_dir -r requirements.txt --no-binary :all:
t_env.set_python_requirements("/path/of/requirements.txt", "/path/of/cached_dir")
```

A `requirements.txt` file that defines the third-party dependencies is used. If the dependencies cannot be accessed in the cluster, then you can specify a directory containing the installation packages of these dependencies by using the parameter "`requirements_cached_dir`", as illustrated in the example above. The dependencies will be uploaded to the cluster and installed offline. 

Below, we showcase a complete example of using dependency management for Python UDFs in Flink 1.10.

```python
from pyflink.datastream import StreamExecutionEnvironment
from pyflink.table import StreamTableEnvironment, DataTypes
from pyflink.table.descriptors import Schema, OldCsv, FileSystem
from pyflink.table.udf import udf

env = StreamExecutionEnvironment.get_execution_environment()
env.set_parallelism(1)
t_env = StreamTableEnvironment.create(env)

@udf(input_types=[DataTypes.BIGINT(), DataTypes.BIGINT()], result_type=DataTypes.BIGINT())
def add(i, j):
    from mpmath import fadd
    return int(fadd(1, 2))

t_env.set_python_requirements("/tmp/requirements.txt", "/tmp/cached_dir")
t_env.register_function("add", add)

t_env.connect(FileSystem().path('/tmp/input')) \
    .with_format(OldCsv()
                 .field('a', DataTypes.BIGINT())
                 .field('b', DataTypes.BIGINT())) \
    .with_schema(Schema()
                 .field('a', DataTypes.BIGINT())
                 .field('b', DataTypes.BIGINT())) \
    .create_temporary_table('mySource')

t_env.connect(FileSystem().path('/tmp/output')) \
    .with_format(OldCsv()
                 .field('sum', DataTypes.BIGINT())) \
    .with_schema(Schema()
                 .field('sum', DataTypes.BIGINT())) \
    .create_temporary_table('mySink')

t_env.from_path('mySource')\
    .select("add(a, b)") \
    .insert_into('mySink')

t_env.execute("tutorial_job")
```

### Submit the job

Firstly, you need to prepare input data in the “/tmp/input” file. For example,

`$ echo "1,2" > /tmp/input`

Secondly, you can prepare the dependency requirements file and the cache dir,

`$ echo "mpmath==1.1.0" > /tmp/requirements.txt
 $ pip download -d /tmp/cached_dir -r /tmp/requirements.txt --no-binary :all:`

Next, you can run this example on the command line,

`$ python python_udf_sum.py`

Finally, you can see the execution result on the command line:

`$ cat /tmp/output
 3`


# Conclusion & Upcoming work

In this blog post, we introduced the architecture of Python UDFs in PyFlink and provided some examples on how to define, register and invoke UDFs. Flink 1.10 brings Python support in the framework to new levels, allowing Python users to write even more magic with their preferred language. The community is actively working towards continuously improving the functionality and performance of PyFlink. Future work in upcoming releases will introduce support for Pandas UDFs in scalar and aggregate functions, add support to use Python UDFs through the SQL client to further expand the usage scope of Python UDFs and finally work towards even more performance improvements. To find more information about the upcoming work with Python in Apache Flink you can join the [discussion](http://apache-flink-user-mailing-list-archive.2336050.n4.nabble.com/DISCUSS-What-parts-of-the-Python-API-should-we-focus-on-next-td31731.html) on the Apache Flink mailing and share your suggestions and thoughts with the community.
