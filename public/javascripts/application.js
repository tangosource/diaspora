$(document).ready( function(){

  //Hides all places under Places section in Destinations show
  $('ul#places_list li').hide();

  //Toggles places under Places section in Destinations show
  $('ul#places_list a.home_selector').click(function(){
    $(this).next().slideToggle('slow');
  });

  //Selects the first radio button on /plans
  $('#Subscription_Plan_1').attr('checked', true)

});

$(window).load( function(){
  $("a[href^='http://']").attr("rel","nofollow");
});
