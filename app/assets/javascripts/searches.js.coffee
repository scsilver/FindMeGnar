# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
// functions
  $( document.body ).on( 'click', '.dropdown-menu li', function( event ) {

     var $target = $( event.currentTarget );

     $target.closest( '.btn-group' )
        .find( '[data-bind="label"]' ).text( $target.text() )
           .end()
        .children( '.dropdown-toggle' ).dropdown( 'toggle' );

     return false;

  });
$(document).ready(ready)
$(document).on('page:load', ready)
