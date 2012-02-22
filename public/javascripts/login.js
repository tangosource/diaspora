jQuery.fn.center = function () {
  this.css("position","absolute");
  this.css("top", ( $(window).height() - this.height() ) / 2+$(window).scrollTop() + "px");
  this.css("left", ( $(window).width() - this.width() ) / 2+$(window).scrollLeft() + "px");
  return this;
}

$(document).ready( function(){
  var username = $("#user_username"),
      password = $("#user_password"),
      forgotPass = $("#forgot_password_link"),
      controls = $("#controls");

  username.focus();
  $("form").submit(function(){
    $('#asterisk').addClass('rideSpinners');
    forgotPass.addClass('hidden');
    controls.addClass('hidden');
  });
});

