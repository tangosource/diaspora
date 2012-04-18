app.views.Location = Backbone.View.extend({

  el: "#location",

  initialize: function(){
    this.render();
    this.getLocation();
  },

  render: function(){
    $(this.el).append('<img alt="delete location" src="/assets/ajax-loader.gif">');
  },

  getLocation: function(e){
    element = this.el;

    locator = new Google.Locator;
    locator.getAddress(function(address, latlng){
      $(element).html('<input id="location_address" value="' + address + '"/>');
      $('#location_coords').val(latlng.Ya + "," + latlng.Za);
      $(element).append('<a id="hide_location"><img alt="delete location" src="/assets/deletelabel.png"></a>');
    });
  },
});

