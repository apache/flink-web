---
title: "Apache Flinkとは? — アプリケーション"
---

<hr/>


Apache Flink は、非有界あるいは有界データストリーム上でのステートフルな計算のためのフレームワークです。Flink は抽象度の異なる複数の API を提供し、一般的なユースケースのための専用ライブラリを提供しています。

ここでは、Flinkの使いやすく表現力豊かなAPIとライブラリを紹介します。

## ストリーミングアプリケーションのためのビルディングブロック

ストリーム処理フレームワークで構築・実行できるアプリケーションの種類は、フレームワークがどれだけ *ストリーム*, *状態*, *時間* を制御できるかによって定義されます。以下では、ストリーム処理アプリケーションのためのこれらのビルディングブロックを説明し、それらを扱うためのFlinkのアプローチを説明します。

### ストリーム

明らかに、ストリームはストリーム処理の基本的な側面です。しかし、ストリームは、ストリームがどのように処理できるか、またどのように処理すべきかに影響を与える異なる特性を持つことがあります。Flink は、あらゆる種類のストリームを処理できる汎用性の高い処理フレームワークです。

* **有界**ストリームと**非有界**ストリーム。ストリームは、非有界と有界、つまり固定サイズのデータセットになります。Flinkには、非有界ストリームを処理するための洗練された機能がありますが、有界ストリームを効率的に処理するための専用の演算子も用意されています。
* **リアルタイム**および**記録された**ストリーム。すべてのデータはストリームとして生成されます。データを処理するには2つの方法があります。生成されたデータをリアルタイムで処理する方法と、ストリームをファイルシステムやオブジェクトストアなどのストレージシステムに永続化し、後で処理する方法です。Flinkアプリケーションは、記録されたストリームまたはリアルタイムのストリームを処理することができます。

### 状態

すべての非自明(non-trivial)なストリーミング・アプリケーションはステートフルです。つまり、個々のイベントに変換を適用するアプリケーションだけがステートを必要としません。基本的なビジネスロジックを実行するアプリケーションは、次のイベントを受信したときや、特定の時間が経過した後など、後の時点でそれらにアクセスするために、イベントや中間結果を記憶しておく必要があります。

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/function-state.png" width="350px" />
</div>

アプリケーションの状態はFlinkの中では一流の市民(first-class citizen)です。Flinkが提供するすべての機能をステートハンドリングの文脈で見ることでそれがわかります。

* **複数のステートプリミティブ**. Flinkは、アトミック値、リスト、マップなど、さまざまなデータ構造に対応したステートプリミティブを提供しています。開発者は、関数のアクセスパターンに基づいて、最も効率的なステートプリミティブを選択することができます。
* **プラガブルステートバックエンド**。アプリケーションの状態は、プラグ可能なステートバックエンドで管理され、チェックポイントされます。Flinkには、メモリや[RocksDB](https://rocksdb.org/)にステートを保存するさまざまなステートバックエンドが用意されています。カスタムのステートバックエンドをプラグインすることも可能です。
* **完全に一度だけの状態の一貫性**。Flinkのチェックポイントとリカバリーアルゴリズムは、障害が発生した場合でもアプリケーションの状態の一貫性を保証します。したがって、障害は透過的に処理され、アプリケーションの正しさに影響を与えません。
* **非常に大規模なステート**。Flinkは、非同期かつインクリメンタルなチェックポイントアルゴリズムにより、数テラバイト規模のアプリケーションの状態を維持することができます。
* **スケーラブルアプリケーション**。Flinkは、ステートフルアプリケーションのスケーリングをサポートしています。

### 時間

時間は、ストリーミングアプリケーションのもう一つの重要な要素です。各イベントは特定の時点で生成されるため、ほとんどのイベントストリームは固有の時間セマンティクスを持っています。さらに、ウィンドウ集約、セッション化、パターン検出、時間ベースの結合など、多くの一般的なストリーム計算は時間に基づいています。ストリーム処理の重要な側面は、アプリケーションが時間をどのように測定するか、すなわち、イベント時間と処理時間の違いです。

Flinkは、時間に関連した豊富な機能を提供します。

* **イベントタイムモード**。イベントタイムセマンティクスでストリームを処理するアプリケーションは、イベントのタイムスタンプに基づいて結果を計算します。これにより、イベントタイム処理では、記録されたイベントとリアルタイムのイベントのどちらが処理されるかに関係なく、正確で一貫性のある結果を得ることができます。
* **ウォーターマークのサポート**。Flinkは、イベントタイム・アプリケーションで時間を推論するためにウォーターマークを採用しています。ウォーターマークは、結果の待ち時間と完全性をトレードオフするための柔軟なメカニズムでもあります。
* **レイトデータ処理**。ウォーターマークを使用してイベントタイムモードでストリームを処理する場合、関連するすべてのイベントが到着する前に計算が完了してしまうことがあります。このようなイベントはレイトイベントと呼ばれます。Flink には、サイド出力を介した再ルーティングや、以前に完了した結果の更新など、遅延イベントを処理するための複数のオプションが用意されています。
* **処理時間モード**。イベントタイムモードに加えて、Flinkはプロセッシングタイムセマンティクスをサポートしており、プロセッシングマシンのウォールクロック時間にトリガーされて計算を実行します。処理時間モードは、近似的な結果を許容できる厳格な低レイテンシ要件を持つ特定のアプリケーションに適しています。

## 多層API

Flinkは3層のAPIを提供しています。それぞれのAPIは、簡潔さと表現力の間で異なるトレードオフを提供し、異なるユースケースをターゲットにしています。

<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/api-stack.png" width="500px" />
</div>

各APIを簡単に紹介し、そのアプリケーションについて説明し、コード例を示します。

### プロセス関数

[プロセス関数](https://ci.apache.org/projects/flink/flink-docs-stable/dev/stream/operators/process_function.html)は、Flinkが提供する最も表現力豊かな関数インタフェースです。Flinkは、1つまたは2つの入力ストリームからの個々のイベントや、ウィンドウ内でグループ化されたイベントを処理するためのプロセス関数を提供しています。プロセス関数は、時間や状態を細かく制御することができます。プロセス関数は、その状態を任意に変更したり、将来的にコールバック関数をトリガーするタイマーを登録したりすることができます。したがって、プロセス関数は、多くの[ステートフルイベントドリブンアプリケーション]({{ site.baseurl }}/usecases.html#eventDrivenApps)で必要とされる複雑なイベントごとのビジネスロジックを実装することができます。

以下の例は、`KeyedStream` を操作して `START` イベントと `END` イベントをマッチさせる `KeyedProcessFunction` を示す。`START` イベントを受信すると、この関数はその状態のタイムスタンプを記憶し、4時間後のタイマーを登録します。タイマーが起動する前に `END` イベントを受信した場合、関数は `END` イベントと `START` イベントの間の時間を計算し、状態をクリアして値を返します。そうでない場合は、タイマーは単にタイマーを起動して状態をクリアするだけである。

{% highlight java %}
/**
 * Matches keyed START and END events and computes the difference between 
 * both elements' timestamps. The first String field is the key attribute, 
 * the second String attribute marks START and END events.
 */
public static class StartEndDuration
    extends KeyedProcessFunction<String, Tuple2<String, String>, Tuple2<String, Long>> {

  private ValueState<Long> startTime;

  @Override
  public void open(Configuration conf) {
    // obtain state handle
    startTime = getRuntimeContext()
      .getState(new ValueStateDescriptor<Long>("startTime", Long.class));
  }

  /** Called for each processed event. */
  @Override
  public void processElement(
      Tuple2<String, String> in,
      Context ctx,
      Collector<Tuple2<String, Long>> out) throws Exception {

    switch (in.f1) {
      case "START":
        // set the start time if we receive a start event.
        startTime.update(ctx.timestamp());
        // register a timer in four hours from the start event.
        ctx.timerService()
          .registerEventTimeTimer(ctx.timestamp() + 4 * 60 * 60 * 1000);
        break;
      case "END":
        // emit the duration between start and end event
        Long sTime = startTime.value();
        if (sTime != null) {
          out.collect(Tuple2.of(in.f0, ctx.timestamp() - sTime));
          // clear the state
          startTime.clear();
        }
      default:
        // do nothing
    }
  }

  /** Called when a timer fires. */
  @Override
  public void onTimer(
      long timestamp,
      OnTimerContext ctx,
      Collector<Tuple2<String, Long>> out) {

    // Timeout interval exceeded. Cleaning up the state.
    startTime.clear();
  }
}
{% endhighlight %}

この例は `KeyedProcessFunction` の表現力を示していますが、かなり冗長なインターフェイスであることも強調しています。

### データストリームAPI

[データストリームAPI](https://ci.apache.org/projects/flink/flink-docs-stable/dev/datastream_api.html)は、ウィンドウ表示や記録時変換、外部データストアへの問い合わせによるイベントのエンリッチ化など、多くの一般的なストリーム処理操作のためのプリミティブを提供する。データストリームAPIはJavaとScalaで利用可能であり、`map()`, `reduce()`, `aggregate()`などの関数をベースにしている。関数はインターフェイスを拡張して定義するか、JavaやScalaのラムダ関数として定義することができます。

次の例では、クリックストリームをセッション化し、セッションごとのクリック数をカウントする方法を示しています。

{% highlight java %}
// a stream of website clicks
DataStream<Click> clicks = ...

DataStream<Tuple2<String, Long>> result = clicks
  // project clicks to userId and add a 1 for counting
  .map(
    // define function by implementing the MapFunction interface.
    new MapFunction<Click, Tuple2<String, Long>>() {
      @Override
      public Tuple2<String, Long> map(Click click) {
        return Tuple2.of(click.userId, 1L);
      }
    })
  // key by userId (field 0)
  .keyBy(0)
  // define session window with 30 minute gap
  .window(EventTimeSessionWindows.withGap(Time.minutes(30L)))
  // count clicks per session. Define function as lambda function.
  .reduce((a, b) -> Tuple2.of(a.f0, a.f1 + b.f1));
{% endhighlight %}

### SQL &amp; テーブル API

Flinkには、[テーブルAPIとSQL](https://ci.apache.org/projects/flink/flink-docs-stable/dev/table/index.html)という2つのリレーショナルAPIがあります。どちらのAPIもバッチ処理とストリーム処理のための統一されたAPIです。つまり、クエリは、非有界のリアルタイムストリームまたは有界の記録されたストリームに対して同じセマンティクスで実行され、同じ結果が得られます。テーブルAPIとSQLは、解析、検証、クエリの最適化のために[Apache Calcite](https://calcite.apache.org)を活用しています。これらは、DataStreamおよびDataSet APIとシームレスに統合することができ、ユーザー定義のスカラー関数、集約関数、テーブル値関数をサポートしています。

FlinkのリレーショナルAPIは、[データ分析]({{ site.baseurl }}/usecases.html#analytics)、[データパイプライン、ETLアプリケーション]({{ site.baseurl }}/usecases.html#pipelines)の定義を容易にするように設計されています。

次の例は、クリックストリームをセッション化し、セッションごとのクリック数をカウントするSQLクエリです。これは、DataStream APIの例と同じユースケースです。

~~~sql
SELECT userId, COUNT(*)
FROM clicks
GROUP BY SESSION(clicktime, INTERVAL '30' MINUTE), userId
~~~

## ライブラリ

Flinkには、一般的なデータ処理のユースケースに対応したいくつかのライブラリが用意されています。これらのライブラリは通常、APIに組み込まれており、完全に自己完結しているわけではありません。したがって、これらのライブラリはAPIのすべての機能を利用したり、他のライブラリと統合したりすることができます。

* **[Complex Event Processing (CEP)](https://ci.apache.org/projects/flink/flink-docs-stable/dev/libs/cep.html)**。パターン検出は、イベントストリーム処理の非常に一般的なユースケースです。FlinkのCEPライブラリは、イベントのパターンを指定するためのAPIを提供します（正規表現やステートマシンを考えてください）。CEP ライブラリは Flink の DataStream API と統合されており、パターンは DataStream 上で評価されます。CEPライブラリのアプリケーションには、ネットワーク侵入検知、ビジネスプロセス監視、不正検知などがあります。
  
* **[データセットAPI](https://ci.apache.org/projects/flink/flink-docs-stable/dev/batch/index.html)**。DataSet APIは、バッチ処理アプリケーションのためのFlinkのコアAPIです。DataSet APIのプリミティブには、*map*、*reduce*、*(outer) join*、*co-group*、および*iterate*が含まれます。すべての操作は、メモリ内のシリアル化されたデータを操作するアルゴリズムとデータ構造によってバックアップされており、データサイズがメモリバジェットを超えた場合にはディスクに転送されます。FlinkのデータセットAPIのデータ処理アルゴリズムは、ハイブリッドハッシュ結合や外部マージソートなどの伝統的なデータベース演算子に触発されています。
  
* **[Gelly](https://ci.apache.org/projects/flink/flink-docs-stable/dev/libs/gelly/index.html)**。Gellyはスケーラブルなグラフ処理と分析のためのライブラリです。GellyはDataSet APIの上に実装され、統合されています。したがって、スケーラブルでロバストな演算子の恩恵を受けます。Gellyはラベルの伝播、三角形の列挙、ページランクのような[組み込みアルゴリズム](https://ci.apache.org/projects/flink/flink-docs-stable/dev/libs/gelly/library_methods.html)を特徴としていますが、カスタムグラフアルゴリズムの実装を容易にする[グラフAPI](https://ci.apache.org/projects/flink/flink-docs-stable/dev/libs/gelly/graph_api.html)も提供しています。

<hr/>
<div class="row">
  <div class="col-sm-12" style="background-color: #f8f8f8;">
    <h2>
      <a href="{{ site.baseurl }}/jp/flink-architecture.html">アーキテクチャ</a> &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      アプリケーション &nbsp;
      <span class="glyphicon glyphicon-chevron-right"></span> &nbsp;
      <a href="{{ site.baseurl }}/jp/flink-operations.html">運用</a>
    </h2>
  </div>
</div>
<hr/>
