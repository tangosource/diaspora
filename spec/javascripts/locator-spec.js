describe("Locator", function(){
  it("should return an address and a coords", function(){

    google = { 
      maps: { 
        Geocoder: function(){},
        LatLng: function(){},
        geocode: function(){}
      }
    };

    navigator = { 
      geolocation: { 
        getCurrentPosition: function(){},
      }
    };

    sinon.stub(navigator.geolocation, "getCurrentPosition", function(){return {lat: "1", lng: "-1"}});

    //sinon.stub(google.maps, "Geocoder", function(){});
    sinon.stub(google.maps, "LatLng", function(){return {coords: "1,-1"}});




    locator = new Google.Locator;
    locator.getAddress(function(){});
    //expect(locator.getAddress()).toEquals();
  })
});
