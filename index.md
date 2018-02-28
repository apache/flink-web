---
title: "Scalable Stream and Batch Data Processing"
layout: base
---
<div class="row-fluid">

  <div class="col-sm-10 col-sm-offset-1 homecontent">
    <p class="lead" markdown="span">Apache Flink® is an open-source stream processing framework for **distributed, high-performing, always-available,** and **accurate** data streaming applications.</p>
    <a href="{{ site.baseurl }}/introduction.html" class="btn btn-default btn-intro">Introduction to Flink</a>
  </div>

<div class="col-sm-12">
  <hr />
</div>

</div>



<div class="row front-graphic">
  <img src="{{ site.baseurl }}/img/flink-home-graphic-update.svg" width="700px" />
</div>

<!-- Updates section -->

<div class="row-fluid">

<div class="col-sm-12">
  <hr />
</div>

<div class="col-sm-3">

  <h2>Latest Blog Posts</h2>

</div>

<div class="col-sm-9">

  <dl>
    {% for post in site.posts limit:5 %}  
        <dt> <a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></dt>
        <dd>{{ post.excerpt }}</dd>
    {% endfor %}
  </dl>

</div>

<!-- Powered by section -->

<div class="row-fluid">
  <div class="col-sm-12">


  <hr />
    <h2><a href="{{ site.baseurl }}/poweredby.html">Powered by Flink</a></h2>



  <div class="jcarousel">
    <ul>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/alibaba-logo.png" width="175"  alt="Alibaba" /></div>
         

        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/ericsson-logo.png" width="175"  alt="Ericsson" /></div>
         
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/capital-one-logo.png" width="175"  alt="Capital One" /></div>
         
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/uber-logo.png" width="175" alt="Uber" /></div>
          
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/bettercloud-logo.png" width="175" alt="BetterCloud" /></div>
         
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/bouygues-logo.jpg" width="175"  alt="Bouygues" /></div>
         
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/dtrb-logo.png" width="175" alt="Drivetribe" /></div>
         
        </li>
        
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/king-logo.png" width="175" alt="King" /></div>
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/mediamath-logo.png" width="175" alt="MediaMath" /></div>
        
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/mux-logo.png" width="175" alt="Mux" /></div>        
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/otto-group-logo.png" width="175" alt="Otto Group" /></div>
          
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/researchgate-logo.png" width="175" alt="ResearchGate" /></div>
          
        </li>
         <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/telefonica-next-logo.png" width="175" alt="Telefonica Next" /></div>
          
        </li>
        <li>
          <div><img src="{{ site.baseurl }}/img/poweredby/zalando-logo.jpg" width="175" alt="Zalando" /></div>
          
        </li>
    </ul>
  </div>

  <a href="#" class="jcarousel-control-prev" data-jcarouselcontrol="true"><span class="glyphicon glyphicon-chevron-left"></span></a>
  <a href="#" class="jcarousel-control-next" data-jcarouselcontrol="true"><span class="glyphicon glyphicon-chevron-right"></span></a>

  </div>

</div>

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
