---
title: "Apache Flinkとは? — アーキテクチャ"
---

<hr/>


Apache Flink は、*有界・非有界* のデータストリーム上のステートフルな計算のためのフレームワークであり、分散処理エンジンです。Flinkは、*一般的なクラスタ環境*で動作し、*メモリ内速度*で計算を実行し、*あらゆる規模*で実行できるように設計されています。

ここでは、Flinkのアーキテクチャの重要な点を説明します。

<!--
<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/flink-home-graphic-update3.png" width="800px" />
</div>
-->

## 非有界と有界データの処理

あらゆる種類のデータは、イベントのストリームとして生成されます。クレジットカードの取引、センサーの測定、機械のログ、またはウェブサイトやモバイルアプリケーション上のユーザーのインタラクションなど、これらのデータはすべてストリームとして生成されます。

データは、*非有界*または*有界*ストリームとして処理することができます。

1. **非有界ストリーム**は、開始点はありますが、終了点は定義されていません。これらのストリームは終了せず、生成されたデータを提供します。非有界ストリームは、継続的に処理されなければなりません。つまり、イベントはインジェストされた後、速やかに処理されなければなりません。入力は非有界で、どの時点でも完了しないため、すべての入力データが到着するのを待つことはできません。非有界データを処理するには、結果の完全性を推論できるように、イベントが発生した順番など、特定の順序でインジェストされている必要があることが多い。

2. **有界ストリーム**には、開始と終了が定義されています。有界ストリームは、計算を実行する前にすべてのデータをインジェストすることで処理できます。有界ストリームの処理には、順序付けされたインジェストは必要ありません。有界ストリームの処理は、バッチ処理としても知られています。

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/bounded-unbounded.png" width="600px" />
</div>

**Apache Flink は非有界データセットと有界データセットの処理を得意としています。** 時間と状態を正確に制御することで、Flink のランタイムは、非有界ストリーム上であらゆる種類のアプリケーションを実行することを可能にします。有界ストリームは、固定サイズのデータセット用に特別に設計されたアルゴリズムとデータ構造によって内部的に処理され、優れた性能を発揮します。

Flinkの上に構築された[ユースケース]({{ site.baseurl }}/usecases.html)を調べて納得してください。

## アプリケーションをどこでも展開

Apache Flink は分散システムであり、アプリケーションを実行するために計算リソースを必要とします。Flink は [Hadoop YARN](https://hadoop.apache.org/docs/stable/hadoop-yarn/hadoop-yarn-site/YARN.html)、[Apache Mesos](https://mesos.apache.org)、[Kubernetes](https://kubernetes.io/) などの一般的なクラスタリソースマネージャと統合されていますが、スタンドアロンクラスタとして動作するように設定することもできます。

Flinkは先に挙げた各リソースマネージャとうまく動作するように設計されています。これはリソースマネージャ固有のデプロイメントモードによって実現されており、Flinkはそれぞれのリソースマネージャとその慣用的な方法で対話できるようになっています。

Flink アプリケーションをデプロイする際、Flink はアプリケーションの設定された並列性に基づいて必要なリソースを自動的に識別し、リソースマネージャに要求します。障害が発生した場合、Flink は新しいリソースを要求して障害のあったコンテナを置き換えます。アプリケーションを送信または制御するためのすべての通信は、RESTコールを介して行われます。これにより、多くの環境でのFlinkの統合が容易になります。


<!-- Add this section once library deployment mode is supported. -->
<!--

Flink features two deployment modes for applications, the *framework mode* and the *library mode*.

* In the **framework deployment mode**, a client submits a Flink application against a running Flink service that takes care of executing the application. This is the common deployment model for most data processing frameworks, query engines, or database systems.

* In the **library deployment mode**, a Flink application is packaged together with the Flink master executables into a (Docker) image. Another job-independent image contains the Flink worker executables. When a container is started from the job image, the Flink master process is started and the embedded application is automatically loaded. Containers started from the worker image, bootstrap Flink worker processes which automatically connect to the master process. A container manager such as Kubernetes monitors the running containers and automatically restarts failed containers. In this mode, you don't have to setup and maintain a Flink service in your cluster. Instead you package Flink as a library with your application. This model is very popular for deploying microservices. 

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/deployment-modes.png" width="600px" />
</div>

-->

## 任意の規模でアプリケーションを実行

Flinkは、ステートフル・ストリーミング・アプリケーションをあらゆる規模で実行できるように設計されています。アプリケーションは、クラスタ内で分散して同時実行される数千のタスクに並列化されています。そのため、アプリケーションはCPU、メインメモリ、ディスク、ネットワークIOを実質的に無制限に利用することができます。さらに、Flinkは非常に大きなアプリケーションの状態を簡単に維持することができます。その非同期かつインクリメンタルなチェックポイントアルゴリズムは、処理のレイテンシへの影響を最小限に抑えながら、正確に一度だけの状態の一貫性を保証します。

本番環境で動作しているFlinkアプリケーションでは、次のような[拡張性の高い数値が報告されています]({{{ site.baseurl }}}/poweredby.html)。

* **1日あたり数兆個のイベント**を処理するアプリケーション。
* **何テラバイトもの状態**を維持するアプリケーション。
* **何千ものコアで動作する** アプリケーション。

## インメモリ性能の活用

ステートフルFlinkアプリケーションは、ローカルステートアクセスに最適化されています。タスクの状態は常にメモリ内に保持され、状態サイズが利用可能なメモリを超える場合は、アクセス効率の高いディスク上のデータ構造に保持されます。そのため、タスクはローカルで、多くの場合インメモリの状態にアクセスすることですべての計算を実行し、非常に低い処理レイテンシを実現します。Flinkは、障害が発生した場合でも、ローカル状態を定期的に非同期的にチェックポイントして耐久性のあるストレージに保存することで、一度きりの状態の一貫性を保証します。

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/local-state.png" width="600px" />
</div>

<hr/>
<div class="row">
  <div class="col-sm-12" style="background-color: #f8f8f8;">
    <h2>
      アーキテクチャ &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/jp/flink-applications.html">アプリケーション</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/jp/flink-operations.html">運用</a>
    </h2>
  </div>
</div>
<hr/>
