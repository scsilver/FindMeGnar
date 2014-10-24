////////////////////////////////////////////

//			VARS

////////////////////////////////////////////
var scroll_pos, count = 0;
var scroll_point = 300;
var colors =  ['#00A8C6','#F9F2E7','#40C0CB',,'#AEE239','#8FBE00'];

////////////////////////////////////////////

//			READY

////////////////////////////////////////////
/*$(function() {
	TweenMax.to('body', 1, {
		backgroundColor: colors[1]
	});

	$('.featured-image').addClass("hidden").viewportChecker({
		classToAdd: 'visible animated fadeInUp', 
		offset: 100
	});
});


$(window).scroll(function(e) {
	scroll_pos = $(this).scrollTop();
	
	$(colors).each(function(i) {
		if (scroll_pos > ($('.container-fluid').outerHeight()-$(window).height())/5 * i ){
			TweenMax.to('.container-fluid', 1, {
				backgroundColor: colors[i]
			});
		}
	
	});

});/*