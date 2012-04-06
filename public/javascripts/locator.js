function Locator(){
 
  var address;

  (function initializer(){
    geocoder = new google.maps.Geocoder();
    navigator.geolocation.getCurrentPosition(success, error);
  })();

  function bindClickToHideLocation(){
    $('#hide_location').click(function(){
      $('#location').remove();
    });
  }

  function error(msg) {
    errorGettingPosition(msg);
  }

  function success(position) {
    getAddress(position.coords);
  }

  function getAddress(coords) {
    latlng = new google.maps.LatLng(coords.latitude, coords.longitude);
    geocoder.geocode({'latLng': latlng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (results[0]) {
          address = results[0].formatted_address;
          $('#location').html('<div id="location_address">' + results[0].formatted_address + '</div>');
          $('#location').append('<a id="hide_location"><img alt="delete location" src="/images/deletelabel.png"></a>');
          bindClickToHideLocation();
        }
      } else {
        alert("Geocoder failed due to: " + status);
      }
    })
  }

  function errorGettingPosition(err)
  {
    if(err.code==1)
      {
        alert("User denied geolocation.");
      }
      else if(err.code==2)
        {
          alert("Position unavailable.");
        }
        else if(err.code==3)
          {
            alert("Timeout expired.");
          }
          else
            {
              alert("ERROR:"+ err.message);
            }
  }

  function address(){
    return address;
  }

  return{
    address: address
  }

};