describe("Locator", function(){

  it("should return an especific address and a coords with OSM", function(){
 
    var osmlocator = new OSM.Locator();

    navigator.geolocation['getCurrentPosition'] = function(cb){
      return cb({
        coords:{
          latitude: "38.8950849", 
          longitude: "-77.0365515"
        }
      });
    };

    osmlocator.getAddress = function(cb){
      return cb({
        "place_id": "6624001",
        "licence": "Data Copyright OpenStreetMap Contributors, Some Rights Reserved. CC-BY-SA 2.0.",
        "osm_type": "node",
        "osm_id": "622025590",
        "lat": "38.8950849",
        "lon": "-77.0365515",
        "display_name": "Zero Milestone, Ellipse Road Northwest, Foggy Bottom, Farragut Square, Washington, Montgomery, District of Columbia, 20006, United States of America",
        "address":{
          "highway": "Zero Milestone",
          "road": "Ellipse Road Northwest",
          "place": "Foggy Bottom",
          "suburb": "Farragut Square",
          "city": "Washington",
          "county": "Montgomery",
          "state": "District of Columbia",
          "postcode": "20006",
          "country": "United States of America",
          "country_code":"us"
        }
      });
    };

    var position = navigator.geolocation.getCurrentPosition(function(coords){return coords});
    var osmlocation = osmlocator.getAddress(function(address){return address});
    expect(position.coords.latitude).toBe("38.8950849");
    expect(position.coords.longitude).toBe("-77.0365515");

    expect(osmlocation.display_name).toBe("Zero Milestone, Ellipse Road Northwest, Foggy Bottom, Farragut Square, Washington, Montgomery, District of Columbia, 20006, United States of America");
    expect(osmlocation.lat).toBe("38.8950849");
    expect(osmlocation.lon).toBe("-77.0365515");
    expect(osmlocation.address.city).toBe("Washington");
    expect(osmlocation.address.country).toBe("United States of America");
  });
});
