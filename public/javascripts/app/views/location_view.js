app.views.Location = Backbone.View.extend({

  el: "#location",

  events: {
    "click #locator" : "getLocation"
  },

  initialize: function(){

    this.render();
    view = this;
    $('#locator').click(view.getLocation());
  },

  render: function(){
    $(this.el).append('<div id="location_address"><img alt="delete location" src="/images/ajax-loader.gif"></div>');
  },

  getLocation: function(e){
    locator = new Google.Locator;

    locator.getAddress(function(address, latlng){
      $('#location').html('<input id="location_address" value="' + address + '"/>');
      $('#location_coords').val(latlng.Ya + "," + latlng.Za);
      $('#location').append('<a id="hide_location"><img alt="delete location" src="/images/deletelabel.png"></a>');
    });
  },

  removeLocation: function(){
    var self = this;
  },

  addLocation: function(){
    var self = this;
  }

});

