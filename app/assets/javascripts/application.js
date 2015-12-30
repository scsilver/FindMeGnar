
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
//= require jquery.turbolinks
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.marquee
//= require 'greensock/TweenMax'
//= require moment
//= require turbolinks
//= require ajaxify_rails

//= require_self
//= require_tree .




$(function(){
  $( document.body ).on( 'click', '.dropdown-menu li', function( event ) {

    var $target = $( event.currentTarget );
    $target.closest( '.btn-group' )
       .find( '[data-bind="label"]' ).text( $target.text() )
          .end()
       .children( '.dropdown-toggle' ).dropdown( 'toggle' );



    return false;

 });
});
$(":checked").change(function(){
  debugger;
  if($(this).is(':checked')){
    var w = $(window).width();

    $(".site-wrap").width(w-150);

} else {
  var w = $(window).width();

  $(".site-wrap").width(w);
}


});

$(window).ready(function(){
   var h = $(window).height();

   $(".site-wrap").height(h-66);


  // jQuery methods go here...

});
$(window).resize(function(){
   var h = $(window).height();
   $(".site-wrap").height(h-66);

  // jQuery methods go here...

});
