Google = {};

Google.Locator = function (){

  function getCoordinates(callback){
    navigator.geolocation.getCurrentPosition(function(position){
      return callback(position.coords);
    }, errorGettingPosition);
  };

  function getAddress(callback){
    geocoder = new google.maps.Geocoder();
    getCoordinates(function(coordinates){
      latlng = new google.maps.LatLng(coordinates.latitude, coordinates.longitude);
      geocoder.geocode({'latLng': latlng}, function(results, status) {
        var return_value;
        if (status == google.maps.GeocoderStatus.OK) {
          if (results[0]) {
            address = results[0].formatted_address;
            coords = latlng;
          };
        } else {
          return_value = "Geocoder failed due to: " + status;
        };
        return callback(address, coords)
      });
    });
  };

  function errorGettingPosition(err) {
    $("#location").remove();
  };

  return{
    getAddress: getAddress
  };

};
