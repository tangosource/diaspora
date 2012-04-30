describe("Locator using OSM", function(){
  var osmlocator = new OSM.Locator();

  navigator.geolocation['getCurrentPosition'] = function(position){
    return position({
      position: {
        coords:{
          latitude: "38.8950849", 
          longitude: "-77.0365515"
        }}
    });
  };

  //You can add those fields that you need to check
  $.getJSON = function(data){
    return data({
      display_name: "Zero Milestone, Ellipse Road Northwest, Foggy Bottom, Farragut Square, Washington, Montgomery, District of Columbia, 20006, United States of America",
      position:{
        coords:{
          latitude: "38.8950849", 
          longitude: "-77.0365515"
        }}
    });
  }    

  var browser_navigator = navigator.geolocation.getCurrentPosition(function(coords){return coords});
  var data = $.getJSON(function(data){return data});

  it("should return an especific position with navigator method", function(){
    expect(browser_navigator.position.coords.latitude).toEqual("38.8950849");
    expect(browser_navigator.position.coords.longitude).toEqual("-77.0365515");
  });
  it("should return an especific display name and position using getJSON method using OSM service", function(){
    expect(data.display_name).toEqual("Zero Milestone, Ellipse Road Northwest, Foggy Bottom, Farragut Square, Washington, Montgomery, District of Columbia, 20006, United States of America");
    expect(data.position.coords.latitude).toEqual("38.8950849");
    expect(data.position.coords.longitude).toEqual("-77.0365515");
  });
});
