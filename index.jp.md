---
title: "Stateful Computations over Data Streams"
layout: base
---
<div class="row-fluid">

  <div class="col-sm-12">
    <p class="lead" markdown="span">
      **Apache Flink<sup>®</sup> — データストリーム上のステートフルな演算**
    </p>
  </div>

<div class="col-sm-12">
  <hr />
</div>

</div>

<!-- High-level architecture figure -->

<div class="row front-graphic">
  <hr />
  <img src="{{ site.baseurl }}/img/flink-home-graphic.png" width="800px" />
</div>

<!-- Feature grid -->

<!--
<div class="row">
  <div class="col-sm-12">
    <hr />
    <h2><a href="{{ site.baseurl }}/features.html">Features</a></h2>
  </div>
</div>
-->
<div class="row">
  <div class="col-sm-4">
    <div class="panel panel-default">
      <div class="panel-heading">
        <span class="glyphicon glyphicon-th"></span> <b>すべてのユースケース</b>
      </div>
      <div class="panel-body">
        <ul style="font-size: small;">
          <li>イベント駆動アプリケーション</li>
          <li>ストリーム &amp; バッチ分析</li>
          <li>データパイプライン &amp; ETL</li>
        </ul>
        <a href="{{ site.baseurl }}/usecases.html">詳細はこちら</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="panel panel-default">
      <div class="panel-heading">
        <span class="glyphicon glyphicon-ok"></span> <b>正しさの保証</b>
      </div>
      <div class="panel-body">
        <ul style="font-size: small;">
          <li>完全に一度きりの状態の一貫性</li>
          <li>イベント時間処理</li>
          <li>洗練された遅れデータ処理</li>
        </ul>
        <a href="{{ site.baseurl }}/flink-applications.html#building-blocks-for-streaming-applications">詳細はこちら</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="panel panel-default">
      <div class="panel-heading">
        <span class="glyphicon glyphicon glyphicon-sort-by-attributes"></span> <b>多層API</b>
      </div>
      <div class="panel-body">
        <ul style="font-size: small;">
          <li>ストリーム &amp; バッチデータのSQL</li>
          <li>データストリーム API &amp; データセット API</li>
          <li>処理関数 (時間 &amp; 状態)</li>
        </ul>
        <a href="{{ site.baseurl }}/flink-applications.html#layered-apis">詳細はこちら</a>
      </div>
    </div>
  </div>
</div>
<div class="row">
  <div class="col-sm-4">
    <div class="panel panel-default">
      <div class="panel-heading">
        <span class="glyphicon glyphicon-dashboard"></span> <b>運用志向</b>
      </div>
      <div class="panel-body">
        <ul style="font-size: small;">
          <li>柔軟なデプロイ</li>
          <li>高可用性セットアップ</li>
          <li>セーブポイント</li>
        </ul>
        <a href="{{ site.baseurl }}/flink-operations.html">詳細はこちら</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="panel panel-default">
      <div class="panel-heading">
        <span class="glyphicon glyphicon-fullscreen"></span> <b>あらゆるユースケースに対応</b>
      </div>
      <div class="panel-body">
        <ul style="font-size: small;">
          <li>スケールアウトアーキテクチャ</li>
          <li>非常に巨大な状態のサポート</li>
          <li>漸進的なチェックポイント</li>
        </ul>
        <a href="{{ site.baseurl }}/flink-architecture.html#run-applications-at-any-scale">詳細はこちら</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="panel panel-default">
      <div class="panel-heading">
        <span class="glyphicon glyphicon-flash"></span> <b>優れた性能</b>
      </div>
      <div class="panel-body">
        <ul style="font-size: small;">
          <li>低レイテンシ</li>
          <li>高スループット</li>
          <li>インメモリ処理</li>
        </ul>
        <a href="{{ site.baseurl }}/flink-architecture.html#leverage-in-memory-performance">詳細はこちら</a>
      </div>
    </div>
  </div>
</div>

<!-- Powered by section -->

<div class="row">
  <div class="col-sm-12">
    <br />
    <h2><a href="{{ site.baseurl }}/poweredby.html">Flinkの利用例</a></h2>

  <div class="jcarousel">
    <ul>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/alibaba-logo.png" width="175"  alt="Alibaba" />
          </a></div>

        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/aws-logo.png" width="175"  alt="AWS" />
          </a></div>
            
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/capital-one-logo.png" width="175"  alt="Capital One" />
          </a></div>
         
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/uber-logo.png" width="175" alt="Uber" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/bettercloud-logo.png" width="175" alt="BetterCloud" />
          </a></div>
         
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/bouygues-logo.jpg" width="175"  alt="Bouygues" />
          </a></div>
         
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/comcast-logo.png" width="175" alt="Comcast" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/criteo-logo.png" width="175" alt="Criteo" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/didi-logo.png" width="175" alt="Didi" />
          </a></div>

        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/dtrb-logo.png" width="175" alt="Drivetribe" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/ebay-logo.png" width="175" alt="Ebay" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/ericsson-logo.png" width="175"  alt="Ericsson" />
          </a></div>
         
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/gojek-logo.png" width="175"  alt="Gojek" />
          </a></div>
         
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/huawei-logo.png" width="175" alt="Huawei" />
          </a></div>
        
        </li>       
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/lyft-logo.png" width="175" alt="Lyft" />
          </a></div>
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/king-logo.png" width="175" alt="King" />
          </a></div>
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/klaviyo-logo.png" width="175" alt="Klaviyo" />
          </a></div>
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/kuaishou-logo.jpg" width="175" alt="Kuaishou" />
          </a></div>
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/mediamath-logo.png" width="175" alt="MediaMath" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/mux-logo.png" width="175" alt="Mux" />
          </a></div>        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/oppo-logo.png" width="175" alt="OPPO" />
          </a></div>

        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/otto-group-logo.png" width="175" alt="Otto Group" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/ovh-logo.png" width="175" alt="OVH" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/pinterest-logo.png" width="175" alt="Pinterest" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/razorpay-logo.png" width="175" alt="Razorpay" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/researchgate-logo.png" width="175" alt="ResearchGate" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/sktelecom-logo.png" width="175" alt="SK telecom" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/telefonica-next-logo.png" width="175" alt="Telefonica Next" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/tencent-logo.png" width="175" alt="Tencent" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/vip-logo.png" width="175" alt="Vip" />
          </a></div>

        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/xiaomi-logo.png" width="175" alt="Xiaomi" />
          </a></div>

        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/yelp-logo.png" width="175" alt="Yelp" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/zalando-logo.jpg" width="175" alt="Zalando" />
          </a></div>
          
        </li>
    </ul>
  </div>

  <a href="#" class="jcarousel-control-prev" data-jcarouselcontrol="true"><span class="glyphicon glyphicon-chevron-left"></span></a>
  <a href="#" class="jcarousel-control-next" data-jcarouselcontrol="true"><span class="glyphicon glyphicon-chevron-right"></span></a>

  </div>

</div>

<!-- Events section -->
<div class="row">

<div class="col-sm-12">
  <hr />
</div>

<div class="col-sm-3">

  <h2><a>イベント情報</a></h2>

</div>
<div class="col-sm-9">
  <!-- Flink Forward -->
  <a href="https://flink-forward.org" target="_blank">
    <img style="width: 200px; padding-right: 30px" src="{{ site.baseurl }}/img/flink-forward.png" alt="Flink Forward"/>
  </a>
  <!-- ApacheCon -->
  <a href="https://www.apache.org/events/current-event" target="_blank">
    <img src="https://www.apache.org/events/current-event-234x60.png" alt="ApacheCon"/>
  </a>
</div>

</div>

<!-- Updates section -->

<div class="row">

<div class="col-sm-12">
  <hr />
</div>

<div class="col-sm-3">

  <h2><a href="{{ site.baseurl }}/blog">最新のブログ記事</a></h2>

</div>

<div class="col-sm-9">

  <dl>
    {% for post in site.posts limit:5 %}  
        <dt> <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></dt>
        <dd>{{ post.excerpt }}</dd>
    {% endfor %}
  </dl>

</div>

<!-- Scripts section -->

<script type="text/javascript" src="{{ site.baseurl }}/js/jquery.jcarousel.min.js"></script>

<script type="text/javascript">

  $(window).load(function(){
   $(function() {
        var jcarousel = $('.jcarousel');

        jcarousel
            .on('jcarousel:reload jcarousel:create', function () {
                var carousel = $(this),
                    width = carousel.innerWidth();

                if (width >= 600) {
                    width = width / 4;
                } else if (width >= 350) {
                    width = width / 3;
                }

                carousel.jcarousel('items').css('width', Math.ceil(width) + 'px');
            })
            .jcarousel({
                wrap: 'circular',
                autostart: true
            });

        $('.jcarousel-control-prev')
            .jcarouselControl({
                target: '-=1'
            });

        $('.jcarousel-control-next')
            .jcarouselControl({
                target: '+=1'
            });

        $('.jcarousel-pagination')
            .on('jcarouselpagination:active', 'a', function() {
                $(this).addClass('active');
            })
            .on('jcarouselpagination:inactive', 'a', function() {
                $(this).removeClass('active');
            })
            .on('click', function(e) {
                e.preventDefault();
            })
            .jcarouselPagination({
                perPage: 1,
                item: function(page) {
                    return '<a href="#' + page + '">' + page + '</a>';
                }
            });
    });
  });

</script>
