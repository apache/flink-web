var MyApp = {};

$(document).ready(function() {
	
	/* Mobile Menu */
	$(document).on("tap", ".af-mobile-btn", function () {
		
		var element = $(this);
		var spanElement = element.find('span');
		
		if (spanElement.hasClass('glyphicon-plus')) {
			spanElement.removeClass('glyphicon-plus').addClass('glyphicon-minus');
			$('.af-main-nav > ul').show('fast');
		} else {
			spanElement.removeClass('glyphicon-minus').addClass('glyphicon-plus');
			$('.af-main-nav > ul').hide('fast');
		}
		
	});
	
	/* Navigation Menu */
	$(document).on("tap", ".af-nav-links", function(e) {
		e.preventDefault();
		var element = $(this);
		if (element.hasClass("af-opened")) {
			$('.af-dropdown-menu').hide();
			element.removeClass("af-opened");
		} else {
			$('.af-opened').siblings(".af-dropdown-menu").hide();
			$('.af-opened').removeClass("af-opened");
			element.siblings('.af-dropdown-menu').show();
			element.addClass("af-opened");
		}
	});
	
	$(document).on("tap", ".af-front-top", function() {
		$(".af-nav-links").removeClass("af-opened");
		$(".af-dropdown-menu").hide();
	});
});