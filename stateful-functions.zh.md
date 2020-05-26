---
title: "什么是有状态的函数？"
---
<div class="row-fluid">

  <div class="col-sm-12">
    <p class="lead" markdown="span">
      **有状态的函数 — Apache Flink上事件驱动的应用程序<sup>®</sup>**
    </p>
  </div>
<div class="col-sm-12">
  <hr />
</div>

</div>

有状态函数是一种API，可 **简化构建分布式有状态应用程序**。 它基于具有持久状态的算子，可以在强大的一致性保证下进行动态交互。

<div style="line-height:60%;">
    <br>
</div>

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/stateful-functions/statefun-overview.png" width="650px"/>
</div>

### 有状态的函数应用

一个 _有状态的函数_ 是存在于表示实体的多个实例中的一小段逻辑/代码 — 类似于 [执行器](https://www.brianstorti.com/the-actor-model/)。 函数是通过消息调用的:

<div class="jumbotron" style="height:auto;padding-top: 18px;padding-bottom: 12px;">
  <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> 有状态的</b></p> 
  <p style="font-size:100%;">函数具有嵌入的、容错的状态，像变量一样在本地访问。</p>
  <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> 虚拟的</b></p> 
  <p style="font-size:100%;">与FaaS非常类似，函数不保留资源——不活跃的函数不消耗CPU/内存。</p>
</div>

应用程序由具有多种功能的 _模块_ 组成，可以与以下模块任意交互：

<div class="jumbotron" style="height:auto;padding-top: 18px;padding-bottom: 12px;">
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> 精确一次语义</b></p> 
    <p style="font-size:100%;">状态和消息传递密切相关，提供了精确一次消息/状态语义。</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> 逻辑寻址</b></p> 
    <p style="font-size:100%;">函数通过逻辑地址相互发送消息，不需要服务发现。</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon glyphicon-check"></span><b> 动态和循环消息传递</b></p> 
    <p style="font-size:100%;">消息传递模式不需要预先定义为(<i>动态</i>)数据流，也不限于DAGs (<i>循环</i>)。</p>
</div>

<hr />

## 为无服务器架构构建的运行时

有状态函数运行时的设计目的是提供一组属性，类似于描述 [无服务器函数](https://martinfowler.com/articles/serverless.html)的特性，但应用于有状态问题。

<div style="line-height:60%;">
    <br>
</div>

<!-- Remote Execution -->
<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/stateful-functions/statefun-remote.png" width="600px"/>
</div>

运行时基于Apache Flink<sup>®</sup>, 设计原则如下:

<div class="jumbotron" style="height:auto;padding-top: 18px;padding-bottom: 12px;">
    <p style="font-size:100%;"><span class="glyphicon glyphicon-edit"></span><b> 逻辑计算/状态协同定位:</b></p> 
    <p style="font-size:100%;">消息传递、状态访问/更新和函数调用被紧密地管理在一起。这确保了开箱即用的高级一致性。</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon-edit"></span><b> 物理计算/状态分离:</b></p> 
    <p style="font-size:100%;"> 函数可以远程执行，消息和状态访问作为调用请求的一部分提供。通过这种方式，可以像无状态流程一样管理功能，并支持快速扩展、滚动升级和其他常见的操作模式。</p>
    <p style="font-size:100%;"><span class="glyphicon glyphicon-edit"></span><b> 语言独立性:</b></p> 
    <p style="font-size:100%;">函数调用使用简单的基于HTTP/ grpc的协议，因此函数可以很容易地在各种语言中实现。</p>
</div>

这使得在 **Kubernetes部署** 、**FaaS平台** 或 **后台(微)服务** 上执行函数成为可能，同时在函数之间提供一致的状态和轻量级消息传递。 

<hr />

## 主要好处

<div style="line-height:60%;">
    <br>
</div>

<!-- Product Marketing Properties -->
<div class="row">
  <!-- Arbitrary Messaging -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop3.png" alt="Arbitrary Messaging" width="90" height="90">
      <h3>动态消息</h3>
    </div>
    <p align="justify">该API允许你构建和组合需要动态进行通信的函数。与经典流处理拓扑的非循环特性相比，这提供了更大的灵活性。</p>
    <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-statefun-docs-stable/concepts/application-building-blocks.html#stateful-functions">了解更多</a></p>
  </div>
  <!-- Consistent State -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop1.png" alt="Consistent State" width="90" height="90">
      <h3>一致的状态</h3>
      <p align="justify">函数可以保持持久的本地状态，并与函数之间的消息传递进行集成。这为你提供了精确一次状态访问/更新的效果，并保证开箱即用的高效消息传递。</p>
      <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-statefun-docs-stable/concepts/application-building-blocks.html#persisted-states">了解更多</a></p>
    </div>
  </div>
  <!-- Multi-language Support -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop4.png" alt="Multi-language Support" width="90" height="90">
      <h3>多语言支持</h3>
    </div>
    <p align="justify">函数可以在任何能够处理HTTP请求或启动gRPC服务器的编程语言中实现，并且最初支持Python。更多的sdk将被添加到像Go, Javascript和Rust这样的语言中。
    </p>
    <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-statefun-docs-stable/sdk/modules.html#modules">了解更多</a></p>
  </div>
</div>

<hr />

<div class="row">
  <!-- No Database Required -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop5.png" alt="No Database Required" width="90" height="90">
      <h3>无需数据库</h3>
    </div>
    <p align="justify">基于Apache Flink健壮的分布式快照模型构建状态持久能力和容错能力，只需要一个简单的blob存储层(如S3、GCS、HDFS)来存储状态快照。</p>
    <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-docs-stable/internals/stream_checkpointing.html">了解更多</a></p>
  </div>
  <!-- Cloud Native -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop6.png" alt="Ecosystem Integration" width="90" height="90">
      <h3>原生云</h3>
    </div>
    <p align="justify">有状态函数的状态和组合方法可以与Kubernetes、Knative和AWS Lambda等现代无服务器平台的功能相结合。</p>
    <p align="justify" href="https://thenewstack.io/10-key-attributes-of-cloud-native-applications/"><a href="">了解更多</a></p>
  </div>
  <!-- "Stateless" Operation -->
  <div class="col-lg-4">
    <div class="text-center">
      <img class="img-circle" src="{{ site.baseurl }}/img/stateful-functions/statefun-prop2.png" alt="Stateless Operation" width="90" height="90">
      <h3>“无状态”操作</h3>
    </div>
    <p align="justify">状态访问是函数调用的一部分，因此有状态函数应用程序的行为类似于无状态流程，可以简单快捷的进行管理，比如快速伸缩、归零和滚动/零停机升级。
    </p>
    <p align="justify"><a href="https://ci.apache.org/projects/flink/flink-statefun-docs-stable/concepts/logical.html#function-lifecycle">了解更多</a></p>
  </div>
</div>

<hr />

## 一个例子:用于欺诈检测的事务评分

<div style="line-height:60%;">
    <br>
</div>

<div class="row">
    <div class="col-sm-5">
      <img src="{{ site.baseurl }}/img/stateful-functions/model-score.svg" width="350px"/>
    </div>
    <div class="col-sm-7">
      <p>设想这样一个应用程序，它接收财务信息，并为每个超过给定阈值的欺诈评分(即欺诈)的交易发出警报。要用<b>有状态函数构建</b>这个例子，可以定义四个不同的函数，每个函数跟踪自己的状态: </p>
      <p><b>欺诈计数:</b> 跟踪在一个滚动的30天期间对一个帐户进行的欺诈交易的报告总数。</p>
      <p><b>商家计分器:</b> 返回每个依赖于第三方服务的商家的信任度得分。</p>
      <p><b>事务管理器:</b> 丰富交易记录以创建用于评分的特征向量，并发出欺诈警报事件。</p>
      <p><b>模型:</b> 根据事务管理器输入的特征向量对事务进行评分。</p>
    </div>
</div>

<div style="line-height:60%;">
    <br>
</div>

**跟踪虚假报告**

应用程序的入口点是“欺诈确认”和“交易”[_入口_](https://ci.apache.org/projects/flink/flink-statefun-docs-stable/concepts/application-building-blocks.html#event-ingress)(例如Kafka主题)。当事件从“欺诈确认”流入时，“欺诈计数”函数增加其内部计数器，并在此状态设置30天过期计时器。在这里，将存在多个“欺诈计数”实例——例如，每个客户帐户一个。30天后，“欺诈计数”函数将收到一条过期消息(来自自身)并清除其状态。

**丰富交易并评分**

在接收到来自“交易”入口的事件时，“事务管理器”函数给“欺诈计数”发送消息，获取客户账户当前上报的欺诈案件数量;它还会向“商家计分器”发送消息，显示交易商人的可信度得分。“事务管理器”创建一个特征向量，其中包含所报告的欺诈案件的数量和随后发送到“模型”函数的客户帐户的商家得分。

**发出警报**

根据发送回“事务管理器”的分数，如果超过给定阈值，它可能向“警报用户”[_出口_](https://ci.apache.org/projects/flink/flink-statefun-docs-stable/concepts/application-building-blocks.html#event-egress) 发出警报事件。

<hr />

## 了解更多

如果您觉得这些想法很有趣，可以尝试一下有状态函数并参与其中!请参阅[入门](https://ci.apache.org/projects/flink/flink-statefun-docs-stable/getting-started/project-setup.html)部分的演练和[文档](https://ci.apache.org/projects/flink/flink-statefun-docs-stable/)，以更深入地了解有状态函数的内部原理。

<div style="line-height:60%;">
    <br>
</div>

<a href="https://github.com/apache/flink-statefun"><img src="{{ site.baseurl }}/img/stateful-functions/github-logo-link.png" class="rounded-circle" width="20px" height="20px"></a> <small>GitHub仓库</small>

<a href="https://ci.apache.org/projects/flink/flink-statefun-docs-stable/"><img src="{{ site.baseurl }}/img/stateful-functions/favicon.png" class="rounded-circle" width="20px" height="20px"></a> <small>StateFun文档</small>

<a href="https://twitter.com/statefun_io"><img src="{{ site.baseurl }}/img/stateful-functions/twitter-logo-link.png" class="rounded-circle" width="20px" height="20px"></a> <small>StateFun Twitter</small>

<!-- Gimmick to make the last link work -->
<a href="https://twitter.com/statefun_io"><img src="{{ site.baseurl }}/img/stateful-functions/twitter-logo-link.png" class="rounded-circle" width="0px" height="0px"></a> <small></small>

<hr />

<div class="row">
    <div class="col-sm-5">
      <h3>如果想快速浏览，</h3>
      watch <a href="https://youtu.be/fCeHCMJXXM0">参看这个会话</a>.
    </div>
    <div class="col-sm-7">
      <div class="bs-example" data-example-id="responsive-embed-16by9-iframe-youtube">
        <div class="embed-responsive embed-responsive-16by9">
          <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/fCeHCMJXXM0" allowfullscreen></iframe>" allowfullscreen></iframe>
        </div>
      </div>
    </div>
</div>
