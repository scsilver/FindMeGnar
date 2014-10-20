////////////////////////////////////////////

//			VARS

////////////////////////////////////////////
var scroll_pos, count = 0;
var scroll_point = 300;
var colors =  ['#CFF09E','#A8DBA8','#0B486B','#CFF09E','#79BD9A','#CFF09E','#3B8686','#CFF09E'];

////////////////////////////////////////////

//			READY

////////////////////////////////////////////
$(function() {
	TweenMax.to('body', 1, {
		backgroundColor: colors[2]
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