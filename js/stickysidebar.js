
$(document).ready(function(){

  var sbHeight = $('#sidebar').height();

  function stickSidebar() {    
    var $el = $('.footer'),
        scrollTop = $(this).scrollTop(),
        scrollBot = scrollTop + $(this).height(),
        elTop = $el.offset().top,
        elBottom = elTop + $el.outerHeight(),
        visibleTop = elTop < scrollTop ? scrollTop : elTop,
        visibleBottom = elBottom > scrollBot ? scrollBot : elBottom,
        wHeight = $(this).height(),
        sidebarOverflow = sbHeight - wHeight,
        $sidebar   = $("#sidebar .navbar"),
        distance  = (elTop - scrollTop);
      
    if (wHeight < sbHeight) {

      if (scrollTop > sidebarOverflow && wHeight < distance) {
        $sidebar.css({'position':'fixed','bottom':0 });
      } else if (wHeight >= distance) {
        $sidebar.css({'position':'fixed','bottom':visibleBottom - visibleTop});
      } else {
        $sidebar.css({'position':'static'});
      }

    } else if (wHeight > sbHeight){
      $sidebar.css({'position':'fixed', 'top':0});
    }

  }

$(window).on('scroll resize', stickSidebar);


});
