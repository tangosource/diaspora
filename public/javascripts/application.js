$(document).ready( function(){
  $('ul#places_list a.home_selector').click(function(){
    $(this).next().slideToggle('slow');
  })
});
