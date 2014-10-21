
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require jquery.marquee
//= require 'greensock/TweenMax'
//= require moment


$(function(){
  ////////////////////////////////////////////

//			VARS

////////////////////////////////////////////
var scroll_pos, count = 0;
var scroll_point = 300;
var colors =  ['#ffeead','#ff6f69','#ffcc5c','#88d8b0'];

////////////////////////////////////////////

//			READY

////////////////////////////////////////////
$(function() {
	TweenMax.to('body', 1, {
		backgroundColor: colors[1]
	});

	$('.featured-image').addClass("hidden").viewportChecker({
		classToAdd: 'visible animated fadeInUp', // Class to add to the elements when they are visible
		offset: 100
	});
});

////////////////////////////////////////////

//			SCROLL

////////////////////////////////////////////
$(window).scroll(function(e) {
	scroll_pos = $(this).scrollTop();
	$('.portfolio').each(function(i) {
		if (scroll_pos + 100 > $('.portfolio').outerHeight() * i && scroll_pos <= $('.portfolio').height() * (i + 1)) {
			TweenMax.to('body', 1, {
				backgroundColor: colors[i]
			});
		}
	});

});
});
