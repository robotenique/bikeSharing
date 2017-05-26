var zoomLevel = 13;
var sp = new google.maps.LatLng(-23.5505, -46.6333);
var handler = Gmaps.build('Google');
handler.buildMap({ internal: {id: 'basic_map'} }, function(){
    // TODO: Change this to make an Ajax request to get the markers
    var mkList = {"lat": [], "lng": [], "img": [], "name": []};
    var length = 0;
    // Set the global configs to synchronous
    $.ajaxSetup({
        async: false
    });
    $.getJSON("https://api.citybik.es/v2/networks/bikesampa", function(json) {
        json = json['network']['stations'];
        for (var st of json) {
            var txt = st['free_bikes'] == 0 ?  "/assets/badBike.png" : "/assets/okBike.png";
            mkList["lat"].push(st['latitude']);
            mkList["lng"].push(st['longitude']);
            mkList["img"].push(txt);
            mkList["name"].push(st['name']);
            length++;
        }
    });

    $.getJSON("https://api.citybik.es/v2/networks/ciclosampa", function(json) {
        json = json['network']['stations'];
        for (var st of json) {
            var txt = st['free_bikes'] == 0 ?  "/assets/badBike.png" : "/assets/okBike.png";
            mkList["lat"].push(st['latitude']);
            mkList["lng"].push(st['longitude']);
            mkList["img"].push(txt);
            mkList["name"].push(st['name']);
            length++;
        }
    });

    var mList = [];
    for (var i = 0; i < length; i++) {
        mList.push({
          "lat": mkList["lat"][i],
          "lng": mkList["lng"][i],
          "picture": {
            "url": mkList["img"][i],
            "width":  40,
            "height": 40
          },
          "infowindow": mkList["name"][i]
      });
    }
    $.ajaxSetup({
        async: true
    });

    var mkt = handler.addMarkers(mList);
    handler.bounds.extendWith(mkt);
    handler.fitMapToBounds();
    handler.getMap().setZoom(zoomLevel);
    handler.map.centerOn(sp);
    updLocs();
});


function setGeoCookie(position) {
    var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
    document.cookie = "lat_lng=" + escape(cookie_val);
}
var c = 0;
// This should be used when getting the user position
function displayCurrLoc(position){
    c++;
    var marker = window.handler.addMarker({
        lat: position.coords.latitude,
        lng: position.coords.longitude
    });
    window.handler.map.centerOn(marker);
};



//==================Geolocation updater=====================
// Updates the location of the user every 15 seconds
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function updLocs() {
    while(true) {
        getGeoLocation();
        await sleep(15000);
    }
}

function getGeoLocation() {
    if (navigator.geolocation){
        navigator.geolocation.getCurrentPosition(setGeoCookie);
        navigator.geolocation.getCurrentPosition(displayCurrLoc);
    }
}
