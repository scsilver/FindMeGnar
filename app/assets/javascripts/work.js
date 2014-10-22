////////////////////////////////////////////

//			VARS

////////////////////////////////////////////
var scroll_pos, count = 0;
var scroll_point = 300;
var colors =  ['#2B1C0A','#59569E','#4DB7F9','#CCF6F9','#ECEDED'];

////////////////////////////////////////////

//			READY

////////////////////////////////////////////
$(function() {
	TweenMax.to('body', 1, {
		backgroundColor: colors[0]
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
		if (scroll_pos + 160  > $('.portfolio').outerHeight() * i && scroll_pos <= $('.portfolio').height() * (i + 1)) {
			TweenMax.to('body', 1, {
				backgroundColor: colors[i]
			});
		}
		if (scroll_pos - 50 < $(this).scrollTop() ){
			TweenMax.to('body', 1, {
				backgroundColor: colors[0]
			});
		}
		
	});

});