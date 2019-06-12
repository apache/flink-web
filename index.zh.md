---
title: "数据流上的有状态计算"
layout: base
---
<div class="row-fluid">

  <div class="col-sm-12">
    <p class="lead" markdown="span">
      **Apache Flink<sup>®</sup> - 数据流上的有状态计算**
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
    <h2><a href="{{ site.baseurl }}/zh/features.html">Features</a></h2>
  </div>
</div>
-->
<div class="row">
  <div class="col-sm-4">
    <div class="panel panel-default">
      <div class="panel-heading">
        <span class="glyphicon glyphicon-th"></span> <b>所有流式场景</b>
      </div>
      <div class="panel-body">
        <ul style="font-size: small;">
          <li>事件驱动应用</li>
          <li>流批分析</li>
          <li>数据管道 &amp; ETL</li>
        </ul>
        <a href="{{ site.baseurl }}/zh/usecases.html">了解更多</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
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
        <a href="{{ site.baseurl }}/zh/flink-applications.html#building-blocks-for-streaming-applications">了解更多</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="panel panel-default">
      <div class="panel-heading">
        <span class="glyphicon glyphicon glyphicon-sort-by-attributes"></span> <b>分层 API</b>
      </div>
      <div class="panel-body">
        <ul style="font-size: small;">
          <li>SQL on Stream &amp; Batch Data</li>
          <li>DataStream API &amp; DataSet API</li>
          <li>ProcessFunction (Time &amp; State)</li>
        </ul>
        <a href="{{ site.baseurl }}/zh/flink-applications.html#layered-apis">了解更多</a>
      </div>
    </div>
  </div>
</div>
<div class="row">
  <div class="col-sm-4">
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
        <a href="{{ site.baseurl }}/zh/flink-operations.html">了解更多</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
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
        <a href="{{ site.baseurl }}/zh/flink-architecture.html#run-applications-at-any-scale">了解更多</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
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
        <a href="{{ site.baseurl }}/zh/flink-architecture.html#leverage-in-memory-performance">了解更多</a>
      </div>
    </div>
  </div>
</div>

<!-- Powered by section -->

<div class="row">
  <div class="col-sm-12">
    <br />
    <h2><a href="{{ site.baseurl }}/zh/poweredby.html">Apache Flink 用户</a></h2>

  <div class="jcarousel">
    <ul>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/alibaba-logo.png" width="175"  alt="Alibaba" />
          </a></div>
         

        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/aws-logo.png" width="175"  alt="AWS" />
          </a></div>
            
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/capital-one-logo.png" width="175"  alt="Capital One" />
          </a></div>
         
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/uber-logo.png" width="175" alt="Uber" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/bettercloud-logo.png" width="175" alt="BetterCloud" />
          </a></div>
         
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/bouygues-logo.jpg" width="175"  alt="Bouygues" />
          </a></div>
         
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/comcast-logo.png" width="175" alt="Comcast" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/criteo-logo.png" width="175" alt="Criteo" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/dtrb-logo.png" width="175" alt="Drivetribe" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/ebay-logo.png" width="175" alt="Ebay" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/ericsson-logo.png" width="175"  alt="Ericsson" />
          </a></div>
         
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/huawei-logo.png" width="175" alt="Huawei" />
          </a></div>
        
        </li>       
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/lyft-logo.png" width="175" alt="Lyft" />
          </a></div>
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/king-logo.png" width="175" alt="King" />
          </a></div>
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/mediamath-logo.png" width="175" alt="MediaMath" />
          </a></div>
        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/mux-logo.png" width="175" alt="Mux" />
          </a></div>        
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/poweredby.html">
             <img src="{{ site.baseurl }}/img/poweredby/oppo-logo.png" width="175" alt="OPPO" />
          </a></div>

        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/otto-group-logo.png" width="175" alt="Otto Group" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/ovh-logo.png" width="175" alt="OVH" />
          </a></div>
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/researchgate-logo.png" width="175" alt="ResearchGate" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/telefonica-next-logo.png" width="175" alt="Telefonica Next" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/tencent-logo.png" width="175" alt="Tencent" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/yelp-logo.png" width="175" alt="Yelp" />
          </a></div>
          
        </li>
        <li>
          <div><a href="{{ site.baseurl }}/zh/poweredby.html">
            <img src="{{ site.baseurl }}/img/poweredby/zalando-logo.jpg" width="175" alt="Zalando" />
          </a></div>
          
        </li>
    </ul>
  </div>

  <a href="#" class="jcarousel-control-prev" data-jcarouselcontrol="true"><span class="glyphicon glyphicon-chevron-left"></span></a>
  <a href="#" class="jcarousel-control-next" data-jcarouselcontrol="true"><span class="glyphicon glyphicon-chevron-right"></span></a>

  </div>

</div>

<!-- Updates section -->

<div class="row">

<div class="col-sm-12">
  <hr />
</div>

<div class="col-sm-3">

  <h2><a href="{{ site.baseurl }}/blog">最新博客列表</a></h2>

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
