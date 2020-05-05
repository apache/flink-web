---
layout: post
title: "Flink SQL Demo: Building an End-to-End Streaming Application"
date: 2020-05-03T12:00:00.000Z
categories: news
authors:
- jark:
  name: "Jark Wu"
  twitter: "JarkWu"
excerpt: Apache Flink 1.10 has released many exciting new features, including many developments in Flink SQL which is evolving at a fast pace. This article takes a closer look at how to quickly build streaming applications with Flink SQL from a practical point of view.
---

Apache Flink 1.10.0 has released many exciting new features, including many developments in Flink SQL which is evolving at a fast pace. This article takes a closer look at how to quickly build streaming applications with Flink SQL from a practical point of view.

In the following sections, we describe how to integrate Kafka, MySQL, Elasticsearch, and Kibana with Flink SQL to analyze e-commerce user behavior in real-time. All exercises in this article are performed in the Flink SQL CLI, while the entire process uses standard SQL syntax, without a single line of Java or Scala code or IDE installation. The final result of this demo is shown in the following figure:

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-03-flink-sql-demo/image1.png" width="800px" alt="Demo Overview"/>
</center>
<br>

# Preparation

Prepare a Linux or MacOS computer with Docker and Java 8 installed. A Java environment is required because we will install and run a Flink cluster in the host environment, not in a Docker container.

## Use Docker Compose to Start Demo Environment

The components required in this demo (except for Flink) are all managed in containers, so we will use `docker-compose` to start them. First, download the `docker-compose.yml` file that defines the demo environment, for example by running the following commands:

```
mkdir flink-demo; cd flink-demo;
wget https://raw.githubusercontent.com/wuchong/flink-sql-demo/master/docker-compose.yml
```

The Docker Compose environment consists of the following containers:

- **MySQL:** MySQL 5.7 and a `category` table in the database. The `category` table will be joined with data in Kafka to enrich the real-time data.
- **Kafka:** It is mainly used as a data source. The DataGen component automatically writes data into a Kafka topic.
- **Zookeeper:** This component is required by Kafka.
- **Elasticsearch:** It is mainly used as a data sink.
- **Kibana:** It's used to visualize the data in Elasticsearch.
- **DataGen:** It is the data generator. After the container is started, user behavior data is automatically generated and sent to the Kafka topic. By default, 2000 data entries are generated each second for about 1.5 hours. You can modify datagen's `speedup` parameter in `docker-compose.yml` to adjust the generation rate (which takes effect after docker compose is restarted).

**Important:** Before starting the containers, we recommend configuring Docker so that sufficient resources are available and the environment does not become unresponsive. We suggest running Docker at 3-4 GB memory and 3-4 CPU cores.

To start all containers, run the following command in the directory that contains the `docker-compose.yml` file.

```
docker-compose up -d
```

This command automatically starts all the containers defined in the Docker Compose configuration in a detached mode. Run `docker ps` to check whether the five containers are running properly. You can also visit [http://localhost:5601/](http://localhost:5601/) to see if Kibana is running normally.

Don’t forget to run the following command to stop all containers after you finished the tutorial:

```
docker-compose down
```

## Download and Install Flink Cluster

We recommend to manually download and install Flink on your host system, instead of starting Flink through Docker because you’ll get a more intuitive understanding of the components, dependencies, and scripts of Flink.

1. Download and decompress [Apache Flink 1.10.0](https://www.apache.org/dist/flink/flink-1.10.0/flink-1.10.0-bin-scala_2.11.tgz) into the `flink-1.10.0` directory:
2. Go to the `flink-1.10.0` directory by running `cd flink-1.10.0`.
3. Run the following command to download the JAR dependency package and copy it to the `lib/` directory.

    ```
wget -P ./lib/ https://repo1.maven.org/maven2/org/apache/flink/flink-json/1.10.0/flink-json-1.10.0.jar | \
    wget -P ./lib/ https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-kafka_2.11/1.10.0/flink-sql-connector-kafka_2.11-1.10.0.jar | \
    wget -P ./lib/ https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-elasticsearch6_2.11/1.10.0/flink-sql-connector-elasticsearch6_2.11-1.10.0.jar | \
    wget -P ./lib/ https://repo1.maven.org/maven2/org/apache/flink/flink-jdbc_2.11/1.10.0/flink-jdbc_2.11-1.10.0.jar | \
    wget -P ./lib/ https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.48/mysql-connector-java-5.1.48.jar
```

4. In `conf/flink-conf.yaml`, set `taskmanager.numberOfTaskSlots` to `10`, since during this demo we will be launching multiple jobs.
5. Run `./bin/start-cluster.sh` to start the cluster. Check that Flink is up and running by accessing the Flink Web UI at [http://localhost:8081](http://localhost:8081). The number of available slots should be 10.
<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-03-flink-sql-demo/image2.png" width="800px" alt="Demo Overview"/>
</center>
<br>
6. Run `bin/sql-client.sh embedded` to start the SQL CLI. You will see the following squirrel welcome page.

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-03-flink-sql-demo/image3.png" width="800px" alt="Flink SQL CLI welcome page"/>
</center>
<br>

# Create a Kafka table using DDL

The Datagen container continuously writes events into the Kafka `user_behavior` topic. This data contains the user behavior on the day of November 27, 2017 (behaviors include “click”, “like”, “purchase” and “add to shopping cart” events). Each row represents a user behavior event, with the user ID, product ID, product category ID, event type, and timestamp in JSON format. Note that the dataset is from the [Alibaba Cloud Tianchi public dataset](https://tianchi.aliyun.com/dataset/dataDetail?dataId=649).

In the directory that contains `docker-compose.yml`, run the following command to view the first 10 data entries generated in the Kafka topic:

```
docker-compose exec kafka bash -c 'kafka-console-consumer.sh --topic user_behavior --bootstrap-server kafka:9094 --from-beginning --max-messages 10'

{"user_id": "952483", "item_id":"310884", "category_id": "4580532", "behavior": "pv", "ts": "2017-11-27T00:00:00Z"}
{"user_id": "794777", "item_id":"5119439", "category_id": "982926", "behavior": "pv", "ts": "2017-11-27T00:00:00Z"}
...
```

In order to make the events in the Kafka topic accessible to Flink SQL, we run the following DDL statement to create a table that connects to the topic in the Kafka cluster:

```sql
CREATE TABLE user_behavior (
    user_id BIGINT,
    item_id BIGINT,
    category_id BIGINT,
    behavior STRING,
    ts TIMESTAMP(3),
    proctime AS PROCTIME(),   -- generates processing-time attribute using computed column
    WATERMARK FOR ts AS ts - INTERVAL '5' SECOND  -- defines watermark on ts column, marks ts as event-time attribute
) WITH (
    'connector.type' = 'kafka',  -- using kafka connector
    'connector.version' = 'universal',  -- kafka version, universal supports Kafka 0.11+
    'connector.topic' = 'user_behavior',  -- kafka topic
    'connector.startup-mode' = 'earliest-offset',  -- reading from the beginning
    'connector.properties.zookeeper.connect' = 'localhost:2181',  -- zookeeper address
    'connector.properties.bootstrap.servers' = 'localhost:9092',  -- kafka broker address
    'format.type' = 'json'  -- the data format is json
);
```

The above snippet declares five fields based on the data format. In addition, it uses the computed column syntax and built-in `PROCTIME()` function to declare a virtual column that generates the processing-time attribute. It also uses the WATERMARK syntax to declare the watermark strategy on the `ts` field (tolerate 5-seconds out-of-order). Therefore, the `ts` field becomes an event-time attribute. For more information about time attributes and DDL syntax, see the following official documents:

- [For time attributes](https://ci.apache.org/projects/flink/flink-docs-release-1.10/dev/table/streaming/time_attributes.html)
- [For SQL DDL](https://ci.apache.org/projects/flink/flink-docs-release-1.10/dev/table/sql/create.html#create-table)

After creating the `user_behavior` table in the SQL CLI, run `show tables;` and `describe user_behavior;` to see registered tables and table details. Also, run the command `SELECT * FROM user_behavior;` directly in the SQL CLI to preview the data (press `q` to exit).

Next, we discover more about Flink SQL through three real-world scenarios.

# Hourly Trading Volume

## Create Elasticsearch table using DDL

Let’s create an Elasticsearch result table in the SQL CLI. We need two columns in this case: `hour_of_day` and `buy_cnt` (trading volume).

```sql
CREATE TABLE buy_cnt_per_hour (
    hour_of_day BIGINT,
    buy_cnt BIGINT
) WITH (
    'connector.type' = 'elasticsearch', -- using elasticsearch connector
    'connector.version' = '6',  -- elasticsearch version, 6 supports both 6+ and 7+
    'connector.hosts' = 'http://localhost:9200',  -- elasticsearch address
    'connector.index' = 'buy_cnt_per_hour',  -- elasticsearch index name, similar to database table name
    'connector.document-type' = 'user_behavior', -- elasticsearch type name
    'connector.bulk-flush.max-actions' = '1',  -- refresh for every row
    'format.type' = 'json',  -- output data in json format
    'update-mode' = 'append'
);
```

There is no need to create the `buy_cnt_per_hour` index in Elasticsearch in advance since Elasticsearch will automatically create the index if it does not exist.

## Submit a Query

The hourly trading volume is the number of "buy" behaviors completed each hour. Therefore, we can use a TUMBLE window function to assign data into hourly windows. Then, we count the number of “buy” records in each window. To implement this, we can filter out the "buy" data first and then apply `COUNT(*)`.

```sql
INSERT INTO buy_cnt_per_hour
SELECT HOUR(TUMBLE_START(ts, INTERVAL '1' HOUR)), COUNT(*)
FROM user_behavior
WHERE behavior = 'buy'
GROUP BY TUMBLE(ts, INTERVAL '1' HOUR);
```

Here, we use the built-in `HOUR` function to extract the value for each hour in the day from a `TIMESTAMP` column. Use `INSERT INTO` to start a Flink SQL job that continuously writes results into the Elasticsearch `buy_cnt_per_hour` index. The Elasticearch result table can be seen as a materialized view of the query. You can find more information about Flink’s window aggregation in the [Apache Flink documentation](https://ci.apache.org/projects/flink/flink-docs-release-1.10/dev/table/sql/queries.html#group-windows).

After running the previous query in the Flink SQL CLI, we can observe the submitted task on the Flink Web UI. This task is a streaming task and therefore runs continuously.

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-03-flink-sql-demo/image4.png" width="800px" alt="Flink Dashboard"/>
</center>
<br>

## Using Kibana to Visualize Results

Access Kibana at [http://localhost:5601](http://localhost:5601). First, configure an index pattern by clicking "Management" in the left-side toolbar and find "Index Patterns". Next, click "Create Index Pattern" and enter the full index name `buy_cnt_per_hour` to create the index pattern. After creating the index pattern, we can explore data in Kibana.

Note: since we are using the TUMBLE window of one hour here, it might take about four minutes between the time that containers started and until the first row is emitted. Until then the index does not exist and Kibana is unable to find the index.

Click "Discover" in the left-side toolbar. Kibana lists the content of the created index.

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-03-flink-sql-demo/image5.png" width="800px" alt="Kibana Discover"/>
</center>
<br>

Next, create a dashboard to display various views. Click "Dashboard" on the left side of the page to create a dashboard named "User Behavior Analysis". Then, click "Create New" to create a new view. Select "Area" (area graph), then select the `buy_cnt_per_hour` index, and draw the trading volume area chart as illustrated in the configuration on the left side of the following diagram. Apply the changes by clicking the “▶” play button. Then, save it as "Hourly Trading Volume".

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-03-flink-sql-demo/image6.png" width="800px" alt="Hourly Trading Volume"/>
</center>
<br>

You can see that during the early morning hours the number of transactions have the lowest value for the entire day.

As real-time data is added into the indices, you can enable auto-refresh in Kibana to see real-time visualization changes and updates. You can do so by clicking the time picker and entering a refresh interval (e.g. 3 seconds) in the “Refresh every” field.

# Cumulative number of Unique Visitors every 10-min

Another interesting visualization is the cumulative number of unique visitors (UV). For example, the number of UV at 10:00 represents the total number of UV from 00:00 to 10:00. Therefore, the curve is monotonically increasing.

Let’s create another Elasticsearch table in the SQL CLI to store the UV results. This table has two columns: time and cumulative UVs.

```sql
CREATE TABLE cumulative_uv (
    time_str STRING,
    uv BIGINT
) WITH (
    'connector.type' = 'elasticsearch',
    'connector.version' = '6',
    'connector.hosts' = 'http://localhost:9200',
    'connector.index' = 'cumulative_uv',
    'connector.document-type' = 'user_behavior',
    'format.type' = 'json',
    'update-mode' = 'upsert'
);
```

We can use SQL’s OVER and WINDOW clauses to calculate the cumulative UVs (the number of UVs from 00:00 to current record) and the time point of the current record. Here, the built-in `COUNT(DISTINCT user_id)` is used to count the number of UVs. Flink SQL has significant performance improvements for COUNT DISTINCT.

```sql
CREATE VIEW uv_per_10min AS
SELECT
  MAX(SUBSTR(DATE_FORMAT(ts, 'HH:mm'),1,4) || '0') OVER w AS time_str,
  COUNT(DISTINCT user_id) OVER w AS uv
FROM user_behavior
WINDOW w AS (ORDER BY proctime ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW);
```

We use SUBSTR, `DATE_FORMAT`, and `||` functions to convert a TIMESTAMP field into a 10-minute interval time string, such as 12:10, 12:20. You can find more information about Flink's support for [OVER WINDOW](https://ci.apache.org/projects/flink/flink-docs-release-1.10/dev/table/sql/queries.html#aggregations) in the Apache Flink documentation.

Additionally, we use the `CREATE VIEW` syntax to register the query as a logical view, allowing us to easily reference this query in subsequent queries and simplify nested queries. Please note that creating a logical view does not trigger the execution of the job and the view results are not persisted. Therefore, this statement is lightweight and does not have additional overhead.

However, `uv_per_10min` generates an output row for each input row. We can perform an aggregation after `uv_per_10min` to group data by `time_str`, so that only one row is stored in Elasticsearch for every 10 minutes. This can greatly ease the workload of Elasticsearch.

```sql
INSERT INTO cumulative_uv
SELECT time_str, MAX(uv)
FROM uv_per_10min
GROUP BY time_str;
```

After submitting this query, we create a `cumulative_uv` index pattern in Kibana. We then create a "Line" (line graph) on the dashboard, by selecting the `cumulative_uv` index, and drawing the cumulative UV curve according to the configuration on the left side of the following figure before finally, saving the curve.

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-03-flink-sql-demo/image7.png" width="800px" alt="Cumulative Unique Visitors every 10-min"/>
</center>
<br>

# Top Categories

The last visualization represents the category rankings to inform us on the most popular categories in our e-commerce site. Since our data source offers events for more than 5,000 categories without providing any additional significance to our analytics, we would like to reduce it so that it only includes the top-level categories. We will use the data in our MySQL database by joining it as a dimension table with our Kafka events to map sub-categories to top-level categories.

Create a table in the SQL CLI to make the data in MySQL accessible to Flink SQL.

```sql
CREATE TABLE category_dim (
    sub_category_id BIGINT,
    parent_category_id BIGINT
) WITH (
    'connector.type' = 'jdbc',
    'connector.url' = 'jdbc:mysql://localhost:3306/flink',
    'connector.table' = 'category',
    'connector.driver' = 'com.mysql.jdbc.Driver',
    'connector.username' = 'root',
    'connector.password' = '123456',
    'connector.lookup.cache.max-rows' = '5000',
    'connector.lookup.cache.ttl' = '10min'
);
```

The underlying of JDBC connectors implements `LookupableTableSource` interface, so the created JDBC table `category_dim` can be used as a temporal table (aka. lookup table) out-of-the-box in the data enrichment.

In addition, create an Elasticsearch table to store the category statistics.

```sql
CREATE TABLE top_category (
    category_name STRING,
    buy_cnt BIGINT
) WITH (
    'connector.type' = 'elasticsearch',
    'connector.version' = '6',
    'connector.hosts' = 'http://localhost:9200',
    'connector.index' = 'top_category',
    'connector.document-type' = 'user_behavior',
    'format.type' = 'json',
    'update-mode' = 'upsert'
);
```

In order to enrich the category names, we use Flink SQL’s temporal table joins to join a dimension table. You can access more information about [temporal joins](https://ci.apache.org/projects/flink/flink-docs-release-1.10/dev/table/streaming/joins.html#join-with-a-temporal-table) in the Flink documentation:


```sql
CREATE VIEW rich_user_behavior AS
SELECT U.user_id, U.item_id, U.behavior,
  CASE C.parent_category_id
    WHEN 1 THEN 'Clothing & Shoes'
    WHEN 2 THEN 'Home & Kitchens'
    WHEN 3 THEN 'Books'
    WHEN 4 THEN 'Electronics'
    WHEN 5 THEN 'Tools'
    WHEN 6 THEN 'Cell Phones'
    WHEN 7 THEN 'Sports & Outdoors'
    WHEN 8 THEN 'Foods'
    ELSE 'Others'
  END AS category_name
FROM user_behavior AS U LEFT JOIN category_dim FOR SYSTEM_TIME AS OF U.proctime AS C
ON U.category_id = C.sub_category_id;
```

Finally, we group the dimensional table by category name to count the number of `buy` events and we write the result to Elasticsearch’s `top_category` index.

```sql
INSERT INTO top_category
SELECT category_name, COUNT(*) buy_cnt
FROM rich_user_behavior
WHERE behavior = 'buy'
GROUP BY category_name;
```

After submitting the query, we create a `top_category` index pattern in Kibana. We then  create a "Horizontal Bar" (bar graph) on the dashboard, by selecting the `top_category` index and drawing the category ranking according to the configuration on the left side of the following diagram before finally saving the list.

<center>
<img src="{{ site.baseurl }}/img/blog/2020-05-03-flink-sql-demo/image8.png" width="800px" alt="Top Categories"/>
</center>
<br>

As illustrated in the diagram, the categories of clothing and shoes exceed by far other categories on the e-commerce website.

We have now implemented three practical applications and created charts for them. We now return to the dashboard page and to drag and drop each view and give our dashboard a more formal and intuitive style, as illustrated at the beginning of this article. Of course, Kibana also provides a rich set of graphics and visualization features, and the user_behavior logs contain a lot more interesting information to explore. With the use of Flink SQL you can analyze data in more dimensions, while using Kibana allows you to display more views and observe real-time changes in its charts!

# Summary

In the previous sections we described how to use Flink SQL to integrate Kafka, MySQL, Elasticsearch, and Kibana to quickly build a real-time analytics application. The entire process can be completed using standard SQL syntax, without a line of Java or Scala code. We hope that this article provides some clear and practical examples of the convenience and power of Flink SQL, featuring, among others, an easy connection to various external systems, native support for event time and out-of-order handling, dimension table joins and a wide range of built-in functions. We hope you have fun following the examples in the article!
