$(document).ready( function(){

  //Hides all places under Places section in Destinations show
  $('ul#places_list li').hide();

  //Toggles places under Places section in Destinations show
  $('ul#places_list a.home_selector').click(function(){
    $(this).next().slideToggle('slow');
  });

  $("a[href^='http://']").attr("rel","nofollow");
  $("a[href^='http://']").css("background-color","yellow");
});
