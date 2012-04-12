app.views.Location = Backbone.View.extend({

  el: "#location",

  initialize: function(){
    this.render();
    this.getLocation();
  },

  render: function(){
    $(this.el).append('<div id="location_address"><img alt="delete location" src="/images/ajax-loader.gif"></div>');
  },

  getLocation: function(e){
    element = this.el;

    locator = new Google.Locator;
    locator.getAddress(function(address, latlng){
      $(element).html('<input id="location_address" value="' + address + '"/>');
      $('#location_coords').val(latlng.Ya + "," + latlng.Za);
      $(element).append('<a id="hide_location"><img alt="delete location" src="/images/deletelabel.png"></a>');
    });
  },
});

