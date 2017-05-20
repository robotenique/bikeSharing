var zoomLevel = 13;
var handler = Gmaps.build('Google');
handler.buildMap({ internal: {id: 'basic_map'} }, function(){
  // be aware chrome >= 50 requires https for geolocation to work
  handler.map.centerOn(new google.maps.LatLng(-23.5505, -46.6333));
  var markers = handler.addMarkers([
  { lat: 43, lng: 3.5},
  { lat: 45, lng: 4},
  { lat: 47, lng: 3.5},
  { lat: 49, lng: 4},
  { lat: 51, lng: 3.5}
]);
handler.bounds.extendWith(markers);
handler.fitMapToBounds();

  /*if(navigator.geolocation)
    navigator.geolocation.getCurrentPosition(displayCurrLoc);
  */
  handler.getMap().setZoom(zoomLevel);
});

// This should be used when getting the user position
function displayCurrLoc(position){
  var marker = handler.addMarker({
    lat: position.coords.latitude,
    lng: position.coords.longitude
  });
  handler.map.centerOn(marker);
};
