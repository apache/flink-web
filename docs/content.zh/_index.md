---
title: Apache Flink Documentation 
type: docs
bookToc: false
---
<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

# Apache Flink® - 数据流上的有状态计算

{{< img src="/img/flink-home-graphic.png" width="800px" >}}

{{< columns >}} <!-- begin columns block -->
<div class="panel panel-default">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-th"></span> <b>所有流式场景</b>
    </div>
    <div class="panel-body">
        <ul style="font-size: small;">
            <li>事件驱动应用</li>
            <li>流批分析</li>
            <li>数据管道 & ETL</li>
            </ul>
        <a href={{< relref "use-cases" >}}>了解更多</a>
    </div>
</div>

<---> <!-- magic separator, between columns -->
<div class="panel panel-default">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-ok"></span> <b>正确性保证</b>
    </div>
    <div class="panel-body">
        <ul style="font-size: small;">
            <li>Exactly-once 状态一致性</li>
            <li>事件时间处理</li>
            <li>成熟的迟到数据处理</li>
        </ul>
    <a href="{{< relref "what-is-flink/flink-applications" >}}#building-blocks-for-streaming-applications">了解更多</a>
    </div>
</div>

<---> <!-- magic separator, between columns -->
<div class="panel panel-default">
    <div class="panel-heading">
        <span class="glyphicon glyphicon glyphicon-sort-by-attributes"></span> <b>分层 API</b>
    </div>
    <div class="panel-body">
        <ul style="font-size: small;">
            <li>SQL on Stream & Batch Data</li>
            <li>DataStream API & DataSet API</li>
            <li>ProcessFunction (Time & State)</li>
        </ul>
    <a href="{{< relref "what-is-flink/flink-applications" >}}#layered-apis">了解更多</a>
    </div>
</div>
{{< /columns >}}

{{< columns >}} <!-- begin columns block -->
<div class="panel panel-default">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-dashboard"></span> <b>聚焦运维</b>
    </div>
    <div class="panel-body">
        <ul style="font-size: small;">
            <li>灵活部署</li>
            <li>高可用</li>
            <li>保存点</li>
        </ul>
    <a href="{{< relref "what-is-flink/flink-operations" >}}">了解更多</a>
    </div>
</div>

<---> <!-- magic separator, between columns -->
<div class="panel panel-default">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-fullscreen"></span> <b>大规模计算</b>
    </div>
    <div class="panel-body">
        <ul style="font-size: small;">
            <li>水平扩展架构</li>
            <li>支持超大状态</li>
            <li>增量检查点机制</li>
        </ul>
    <a href="{{< relref "what-is-flink/flink-architecture" >}}#run-applications-at-any-scale">了解更多</a>
    </div>
</div>

<---> <!-- magic separator, between columns -->
<div class="panel panel-default">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-flash"></span> <b>性能卓越</b>
    </div>
    <div class="panel-body">
        <ul style="font-size: small;">
            <li>低延迟</li>
            <li>高吞吐</li>
            <li>内存计算</li>
        </ul>
    <a href="{{< relref "what-is-flink/flink-architecture" >}}#leverage-in-memory-performance">了解更多</a>
    </div>
</div>
{{< /columns >}}

## 最新博客列表

{{< recent_posts >}}
