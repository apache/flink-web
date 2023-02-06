---
authors:
- name: Jeff Zhang
  twitter: zjffdu
  zjffdu: null
date: "2020-06-23T08:00:00Z"
title: Flink on Zeppelin Notebooks for Interactive Data Analysis - Part 2
---

In a previous post, we introduced the basics of Flink on Zeppelin and how to do Streaming ETL. In this second part of the "Flink on Zeppelin" series of posts, I will share how to 
perform streaming data visualization via Flink on Zeppelin and how to use Apache Flink UDFs in Zeppelin. 

# Streaming Data Visualization

With [Zeppelin](https://zeppelin.apache.org/), you can build a real time streaming dashboard without writing any line of javascript/html/css code.

Overall, Zeppelin supports 3 kinds of streaming data analytics:

* Single Mode
* Update Mode
* Append Mode

### Single Mode
Single mode is used for cases when the result of a SQL statement is always one row, such as the following example. 
The output format is translated in HTML, and you can specify a paragraph local property template for the final output content template. 
And you can use `{i}` as placeholder for the {i}th column of the result.

<center>
<img src="/img/blog/2020-06-23-flink-on-zeppelin-part2/flink_single_mode.gif" width="80%" alt="Single Mode"/>
</center>

### Update Mode
Update mode is suitable for the cases when the output format is more than one row, 
and will always be continuously updated. Here’s one example where we use ``GROUP BY``.

<center>
<img src="/img/blog/2020-06-23-flink-on-zeppelin-part2/flink_update_mode.gif" width="80%" alt="Update Mode"/>
</center>

### Append Mode
Append mode is suitable for the cases when the output data is always appended. 
For instance, the example below uses a tumble window.

<center>
<img src="/img/blog/2020-06-23-flink-on-zeppelin-part2/flink_append_mode.gif" width="80%" alt="Append Mode"/>
</center>

# UDF

SQL is a very powerful language, especially in expressing data flow. But most of the time, you need to handle complicated business logic that cannot be expressed by SQL.
In these cases UDFs (user-defined functions) come particularly handy. In Zeppelin, you can write Scala or Python UDFs, while you can also import Scala, Python and Java UDFs.
Here are 2 examples of Scala and Python UDFs:

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

After you define the UDFs, you can use them directly in SQL:

* Use Scala UDF in SQL

<center>
<img src="/img/blog/2020-06-23-flink-on-zeppelin-part2/flink_scala_udf.png" width="100%" alt="Scala UDF"/>
</center>

* Use Python UDF in SQL

<center>
<img src="/img/blog/2020-06-23-flink-on-zeppelin-part2/flink_python_udf.png" width="100%" alt="Python UDF"/>
</center>

# Summary

In this post, we explained how to perform streaming data visualization via Flink on Zeppelin and how to use UDFs. 
Besides that, you can do more in Zeppelin with Flink, such as batch processing, Hive integration and more.
You can check the following articles for more details and here's a list of [Flink on Zeppelin tutorial videos](https://www.youtube.com/watch?v=YxPo0Fosjjg&list=PL4oy12nnS7FFtg3KV1iS5vDb0pTz12VcX) for your reference.

# References

* [Apache Zeppelin official website](http://zeppelin.apache.org)
* Flink on Zeppelin tutorials - [Part 1](https://medium.com/@zjffdu/flink-on-zeppelin-part-1-get-started-2591aaa6aa47)
* Flink on Zeppelin tutorials - [Part 2](https://medium.com/@zjffdu/flink-on-zeppelin-part-2-batch-711731df5ad9)
* Flink on Zeppelin tutorials - [Part 3](https://medium.com/@zjffdu/flink-on-zeppelin-part-3-streaming-5fca1e16754)
* Flink on Zeppelin tutorials - [Part 4](https://medium.com/@zjffdu/flink-on-zeppelin-part-4-advanced-usage-998b74908cd9)
* [Flink on Zeppelin tutorial videos](https://www.youtube.com/watch?v=YxPo0Fosjjg&list=PL4oy12nnS7FFtg3KV1iS5vDb0pTz12VcX) 
