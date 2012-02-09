$(document).ready( function(){
  $('ul#places_list li').click(function(){
    //alert('asdf');
    $(this).children().slideToggle('slow');
  })
});
