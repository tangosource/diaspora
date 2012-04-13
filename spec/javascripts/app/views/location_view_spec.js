describe("app.views.Location", function(){
  beforeEach(function(){
    Google = {};
    Google.Locator = function(){return { getAddress:function(){}}};

    this.view = new app.views.Location();
  });

  describe("When it gets instantiated", function(){
    it("creates #location_address", function(){

      this.view.getLocation();

      expect($("#location_address")).toBeTruthy();
      expect($("#location_coords")).toBeTruthy();
      expect($("#hide_location")).toBeTruthy();
    })
  });
});
