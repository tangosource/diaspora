describe("app.views.Publisher", function() {
  beforeEach(function() {
    // should be jasmine helper
    loginAs({name: "alice", avatar : {small : "http://avatar.com/photo.jpg"}});

    spec.loadFixture("aspects_index");
    this.view = new app.views.Publisher();
  });

  describe("#open", function() {
    it("removes the 'closed' class from the publisher element", function() {
      expect($(this.view.el)).toHaveClass("closed");
      this.view.open($.Event());
      expect($(this.view.el)).not.toHaveClass("closed");
    });
  });

  describe("#close", function() {
    beforeEach(function() {
      this.view.open($.Event());
    });

    it("removes the 'active' class from the publisher element", function(){
      this.view.close($.Event());
      expect($(this.view.el)).toHaveClass("closed");
    })

    it("resets the element's height", function() {
      $(this.view.el).find("#status_message_fake_text").height(100);
      this.view.close($.Event());
      expect($(this.view.el).find("#status_message_fake_text").attr("style")).not.toContain("height");
    });
  });

  describe("#clear", function() {
    it("calls close", function(){
      spyOn(this.view, "close");

      this.view.clear($.Event());
      expect(this.view.close);
    })

    it("clears all textareas", function(){
      _.each(this.view.$("textarea"), function(element){
        $(element).val('this is some stuff');
        expect($(element).val()).not.toBe("");
      });

      this.view.clear($.Event());

      _.each(this.view.$("textarea"), function(element){
        expect($(element).val()).toBe("");
      });
    })

    it("removes all photos from the dropzone area", function(){
      var self = this;
      _.times(3, function(){
        self.view.$("#photodropzone").append($("<li>"))
      });

      expect(this.view.$("#photodropzone").html()).not.toBe("");
      this.view.clear($.Event());
      expect(this.view.$("#photodropzone").html()).toBe("");
    })

    it("removes all photo values appended by the photo uploader", function(){
      $(this.view.el).prepend("<input name='photos[]' value='3'/>")
      var photoValuesInput = this.view.$("input[name='photos[]']");

      photoValuesInput.val("3")
      this.view.clear($.Event());
      expect(this.view.$("input[name='photos[]']").length).toBe(0);
    })
  });

  describe('#showLocation', function(){
    it("Show location", function(){

      // inserts location to the DOM; it is the location's view element
      setFixtures('<div id="publisher_textarea_wrapper"></container>'); 

      // creates a fake Locator to avoid google API call 
      Google = {};
      Google.Locator = function(){return { getAddress:function(){}}};

      // validates there is not location
      expect($("#location").length).toBe(0);

      // this should create a new location
      this.view.showLocation();

      // validates there is one location created
      expect($("#location").length).toBe(1);
    })
  });

  describe('#destroyLocation', function(){
    it("Destroy location if exists", function(){

      // inserts location to the DOM; it is the location's view element
      setFixtures('<div id="location"></container>'); 

      // creates a new Location view with the #location element
      // with this we avoid unnecessarily to call the google API
      app.views.Location = new Backbone.View({el:"#location"});

      // creates the mock 
      app.views.location = sinon.mock(app.views.Location);
      app.views.location = app.views.location.object;

      // calls the destroy function and test the expected result
      this.view.destroyLocation();
      expect($("#location").length).toBe(0);
    })
  });

  describe('#avoidEnter', function(){
  });
});

