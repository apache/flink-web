---
layout: post
title:  "Flink on Zeppelin Notebooks for Interactive Data Analysis - Part 2"
date:   2020-05-25T08:00:00.000Z
categories: ecosystem
authors:
- zjffdu:
  name: "Jeff Zhang"
  twitter: "zjffdu"
---

In the last post, I introduce the basics of Flink on Zeppelin and how to do Streaming ETL. This is part-2 where I would talk about how to 
do streaming data visualization via Flink on Zeppelin and how to use flink UDF in Zeppelin. 

# Streaming Data Visualization

In Zeppelin, you can build a realtime streaming dashboard without writing any line of javascript/html/css code.
Overall Zeppelin supports 3 kinds of streaming data analytics:
* Single
* Update
* Append

### Single Mode
Single mode is for the case when the result of sql statement is always one row, such as the following example. 
The output format is HTML, and you can specify paragraph local property template for the final output content template. 
And you can use {i} as placeholder for the ith column of result.

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-25-flink-on-zeppelin-part2/flink_single_mode.gif" width="80%" alt="Single Mode"/>
</center>

### Update Mode
Update mode is suitable for the case when the output is more than one rows, 
and always will be updated continuously. Here’s one example where we use group by.

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-25-flink-on-zeppelin-part2/flink_update_mode.gif" width="80%" alt="Update Mode"/>
</center>

### Append Mode
Append mode is suitable for the scenario where output data is always appended. 
E.g. the following example which use tumble window.

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-25-flink-on-zeppelin-part2/flink_append_mode.gif" width="80%" alt="Append Mode"/>
</center>

# UDF

SQL is powerful, especially in expressing data flow. But most of time, you need to handle complicated business logic that can not be expressed by SQL.
In these cases, you will need UDF (user defined function). In Zeppelin, you can write Scala, Python UDF, and also import Scala, Python and Java UDF.
Here're 2 examples of Scala and Python UDF.

* Scala UDF

```scala
%flink

class ScalaUpper extends ScalarFunction {
def eval(str: String) = str.toUpperCase
}
btenv.registerFunction("scala_upper", new ScalaUpper())

```
 
* Python UDF

```python

%flink.pyflink

class PythonUpper(ScalarFunction):
def eval(self, s):
 return s.upper()

bt_env.register_function("python_upper", udf(PythonUpper(), DataTypes.STRING(), DataTypes.STRING()))

```

After you define the UDF, you can use them directly in SQL. e.g.

* Use Scala UDF in SQL

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-25-flink-on-zeppelin-part2/flink_scala_udf.png" width="100%" alt="Scala UDF"/>
</center>

* Use Python UDF in SQL

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-25-flink-on-zeppelin-part2/flink_python_udf.png" width="100%" alt="Python UDF"/>
</center>

# Summary

In this post, I show you how to do streaming data visualization via Flink on Zeppelin and how to use UDF. 
Besides that, you can do more in Zeppelin with Flink, such as batch processing, hive integration and etc.
You can check the following articles for more details and here's a list of [Flink on Zeppelin tutorial videos](https://www.youtube.com/watch?v=YxPo0Fosjjg&list=PL4oy12nnS7FFtg3KV1iS5vDb0pTz12VcX) for your reference.

# References

* [Apache Zeppelin official website](http://zeppelin.apache.org)
* Flink on Zeppelin tutorials - [Part 1](https://medium.com/@zjffdu/flink-on-zeppelin-part-1-get-started-2591aaa6aa47)
* Flink on Zeppelin tutorials - [Part 2](https://medium.com/@zjffdu/flink-on-zeppelin-part-2-batch-711731df5ad9)
* Flink on Zeppelin tutorials - [Part 3](https://medium.com/@zjffdu/flink-on-zeppelin-part-3-streaming-5fca1e16754)
* Flink on Zeppelin tutorials - [Part 4](https://medium.com/@zjffdu/flink-on-zeppelin-part-4-advanced-usage-998b74908cd9)
* [Flink on Zeppelin tutorial videos](https://www.youtube.com/watch?v=YxPo0Fosjjg&list=PL4oy12nnS7FFtg3KV1iS5vDb0pTz12VcX) 
