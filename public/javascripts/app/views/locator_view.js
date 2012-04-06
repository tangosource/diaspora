app.views.Locator = Backbone.View.extend({

  el: "#location",

  events: {
    "click #locator" : "getLocation"
  },

  initialize: function(){

    this.collection = new app.models.Location;
    this.collection.bind('add', this.addLocation);

    this.render();
    view = this;
    $('#locator').click(view.getLocation());
  },

  render: function(){
    $(this.el).append('<div id="location_address"><img alt="delete location" src="/images/ajax-loader.gif"></div>');
  },

  getLocation: function(e){
    lc = new Locator();
  },

  addLocation: function(){
    var self = this;
  }

});
