$(document).ready( function(){

  //Hides all places under Places section in Destinations show
  $('ul#places_list li').hide();

  //Toggles places under Places section in Destinations show
  $('ul#places_list a.home_selector').click(function(){
    $(this).next().slideToggle('slow');
  });

});

$(window).load( function(){
  $("a[href^='http://']").attr("rel","nofollow");
});
