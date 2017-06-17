var stations = []; // The stations (markers) list
var pos = "";   // the user position
var infowindow = ""; // the infowindow to display each station info
var lastDest = "";

// Initializer callback - Automatically called by the gmaps API
function initMap() {
    var mapStyle = cleanMapStyle();
    var myLatlng = {lat: -23.5505, lng: -46.6333};
    var directionsService = new google.maps.DirectionsService;
    var directionsDisplay = new google.maps.DirectionsRenderer;
    var map = new google.maps.Map(document.getElementById('basic_map'), {
        zoom: 13,
        center: myLatlng,
        styles: mapStyle
    });
    directionsDisplay.setMap(map);
    // the user marker needs to be always on top
    var userM = new google.maps.Marker({
        title: "Você",
        position: myLatlng,
        optimized: false,
        zIndex:99999999
    });
    initializeUserPos(map, userM);
    myPosListener(map, userM);
    userM.addListener('position_changed', function() {
        if(lastDest != ""){
            if(getDistance(userM, lastDest) < 200){
                lastDest = "";
                directionsDisplay.set('directions', null);
                changeOpacity(undefined, 1); // Restore stations opacity
                $("#routeFreeSlot").html("<span class=\"glyphicon glyphicon-map-marker\"></span> Guardar Bike");
            }
        }
    });
    addStations(map, userM);
    map.setCenter(myLatlng);
    // Configure the legend
    var legend = document.getElementById('legend');
    map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(legend);
    // Set the updaters (asynchronously updates the map)
    updLocs(map, userM);
    updStations(map);
    // Listener for the freeSlots button
    freeSlotsListener(directionsService, directionsDisplay);
}

/*==================Stations builder=====================
 * Functions to build the stations from the first time!
 */
// Get the stations from the API, then add into the map
function addStations(mapi){
    $.getJSON("https://api.citybik.es/v2/networks/bikesampa", function(json) {
        json = json['network']['stations'];
        var mkList = {"lat": [], "lng": [], "img": [], "name": [], "free": [], "emptyS": []};
        for (var st of json) {
            var txt = st['free_bikes'] == 0 ?  "/assets/badBike.png" : "/assets/okBike.png";
            mkList["lat"].push(st['latitude']);
            mkList["lng"].push(st['longitude']);
            mkList["img"].push(txt);
            mkList["name"].push(st['name']);
            mkList["free"].push(st['free_bikes']);
            mkList["emptyS"].push(st['empty_slots']);
        }
        addCicloSampa(mapi, mkList);
    });
}
// Helper callback to add stations from the cicloSampa provider
function addCicloSampa(mapi, mkList) {
    $.getJSON("https://api.citybik.es/v2/networks/ciclosampa", function(json) {
        json = json['network']['stations'];
        for (var st of json) {
            var txt = st['free_bikes'] == 0 ?  "/assets/badBike.png" : "/assets/okBike.png";
            mkList["lat"].push(st['latitude']);
            mkList["lng"].push(st['longitude']);
            mkList["img"].push(txt);
            mkList["name"].push(st['name']);
            mkList["free"].push(st['free_bikes']);
            mkList["emptyS"].push(st['empty_slots']);
        }
        setMarkers(mapi, mkList);
    });
}

/* Add the markers to the map */
function setMarkers(mapi, mkList) {
    if(infowindow == ""){
        infowindow = new google.maps.InfoWindow({content: ''});
    }
    for (var i = 0; i < mkList["name"].length; i++) {
        var mk = new google.maps.Marker({
            map: mapi,
            title: mkList["name"][i],
            icon: mkList["img"][i],
            position: new google.maps.LatLng(mkList["lat"][i], mkList["lng"][i])
        });
        var content = createInfo(mkList, i);
        bindInfoWindow(mk, mapi, infowindow, content);
        stations.push(mk);

    }
}

//==================InfoWindow creator=====================
//Add a click listener to a given marker to display slot info
function bindInfoWindow(marker, mapi, infowindow, html) {
    google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(html);
        infowindow.open(mapi, marker);
    });
}
// Returns the formatted string for a given marker
function createInfo(mkList, i) {
    var bik = mkList["free"][i] != 1 ? " bikes livres" : " bike livre";
    var slot = mkList["emptyS"][i] != 1 ? " slots livres" : " slot livre";
    var c1 = mkList["free"][i] > 2 ? "green" : "red";
    var content ='<h3>'+mkList["name"][i]+'</h3>'+
    '<p><font size="3" color=\"'+c1+'\"><b>'+mkList["free"][i]+bik+'</b></font><br>'+
    '<font size="3" color="MidnightBlue"><b>'+mkList["emptyS"][i]+slot+'</b><br></p>';
    return content;
}

//==================Stations updater=====================
// Update the stations from the API every 30 seconds
async function updStations(mapi){
    while(true) {
        getAPIinfo(mapi);
        await sleep(10000);
    }
}
// Get the API info
function getAPIinfo(mapi) {
    $.getJSON("https://api.citybik.es/v2/networks/bikesampa", function(json) {
        json = json['network']['stations'];
        var mkList = {"lat": [], "lng": [], "img": [], "name": [], "free": [], "emptyS": []};
        for (var st of json) {
            var txt = st['free_bikes'] == 0 ?  "/assets/badBike.png" : "/assets/okBike.png";
            mkList["img"].push(txt);
            mkList["name"].push(st['name']);
            mkList["free"].push(st['free_bikes']);
            mkList["emptyS"].push(st['empty_slots']);
        }
        getCicloSampa(mkList, mapi);
    });

}
// Ciclo Sampa helper
function getCicloSampa(mkList, mapi){
    $.getJSON("https://api.citybik.es/v2/networks/ciclosampa", function(json) {
        json = json['network']['stations'];
        for (var st of json) {
            var txt = st['free_bikes'] == 0 ?  "/assets/badBike.png" : "/assets/okBike.png";
            mkList["img"].push(txt);
            mkList["name"].push(st['name']);
            mkList["free"].push(st['free_bikes']);
            mkList["emptyS"].push(st['empty_slots']);
        }
        updMarkers(mkList, mapi);
    });
}
// Update the information if needed
function updMarkers(mkList, mapi) {
    if(stations.length > 0){
        for (var i = 0; i < stations.length; i++) {
            var m = stations[i];
            if(mkList["free"][i] != undefined) {
                m.setIcon(mkList["free"][i] == 0 ?  "/assets/badBike.png" : "/assets/okBike.png")
                var content = createInfo(mkList, i);
                bindInfoWindow(m, mapi, infowindow, content);
            }
        }
    }
}

//==================Geolocation updater=====================
// Initializes the user position for the first time
function initializeUserPos(mapi, userM) {
    if (navigator.geolocation){
        navigator.geolocation.getCurrentPosition(function(position){
            var nPos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            userM.setPosition(nPos);
            userM.setMap(mapi);
            mapi.setCenter(nPos);
        });
    }
}
// Sleep helper function
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
// Updates the location of the user every 15 seconds
async function updLocs(mapi, userM) {
    while(true) {
        getGeoLocation();
        // Only update the position when we have one, and it has changed!
        if (pos != "" && (userM.getPosition().lat() != pos.coords.latitude ||
            userM.getPosition().lng() != pos.coords.longitude)){
            userM.setPosition(new google.maps.LatLng(
                              pos.coords.latitude,
                              pos.coords.longitude));
            if(userM.getMap() != mapi){userM.setMap(mapi);}
        }
        await sleep(15000);
    }
}
// get the geolocation and pass to callbacks
function getGeoLocation() {
    if (navigator.geolocation){
        navigator.geolocation.getCurrentPosition(setGeoCookie);
        navigator.geolocation.getCurrentPosition(displayCurrLoc);
    }
}
// Geolocation helper callbacks
function setGeoCookie(position) {
    var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
    document.cookie = "lat_lng=" + escape(cookie_val);
}
// This should be used when getting the user position
function displayCurrLoc(position){
    pos = position;
}

/* THIS IS IMPORTANT! RAILS turbolinks duplicate the gmaps script insertion,
 * breaking a lot of the functionality on page reload. THIS makes sure to include
 * the script only once, as expected!
 */
if(window.google){
  initMap();
} else{
  $.ajax('//maps.google.com/maps/api/js?key=AIzaSyBaPMPea6wsfaG4aAfW1LCMX5CeE1rvy-0&callback=initMap', {
    crossDomain: true,
    dataType: 'script'
  });
}

//==================Helper functions=====================
// Returns the user position if defined. Returns undefined if not
function getUserPos(){
    if (pos != ""){
        return pos;
    }
    else{
        return undefined;
    }
}
/* Listener to the freeSlots button. Makes a request to the controller
 * to get the nearest station with free slots
 */
function freeSlotsListener(directionsService, directionsDisplay){
    $("#routeFreeSlot").click(function(){
        if(lastDest != "") {
            lastDest = "";
            directionsDisplay.set('directions', null);
            changeOpacity(undefined, 1); // Restore stations opacity
            $("#routeFreeSlot").html("<span class=\"glyphicon glyphicon-map-marker\"></span> Guardar Bike");
            return;
        }
        if(pos != undefined){
            $.ajax({
                url: "/api/free_slots.json",
                data: {pos: pos},
                dataType: "json",
            }).done(function(response) {
                if(response.success){
                    destination = obtainStation(response.destStation);
                    if(destination != undefined){
                        calculateAndPlot(directionsService, directionsDisplay, destination);
                        changeOpacity(destination, 0.5);
                    }
                    $("#routeFreeSlot").html("<span class=\"glyphicon glyphicon-ban-circle\"></span> Apagar rota");
                }
                else{
                    window.alert("Não há estações com slots livres! D:");
                }
            });
        }
        else{
            window.alert("Precisamos da sua posição...");
        }
    });
}
// Send the specifications to gmaps, calculate and plot the route
function calculateAndPlot(directionsService, directionsDisplay, end) {
    directionsService.route({
         origin: new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude),
         destination: end.getPosition(),
         travelMode: 'BICYCLING'
       }, function(response, status) {
         if (status === 'OK') {
           directionsDisplay.setDirections(response);
           lastDest = end;
         } else {
           window.alert('Houve falha no cálculo da rota devido a ' + status);
         }
       });
}
// Get the station instance in the map (a marker) which name is mySt
function obtainStation(mySt){
    if(stations.length > 0){
        for (st of stations) {
            if(mySt == st.getTitle()){
                return st;
            }
        }
        return undefined;
    }
}
// Get the distance between source and destination
function getDistance(source, destination) {
    s = source.getPosition()
    d = destination.getPosition()
  return google.maps.geometry.spherical.computeDistanceBetween(
    new google.maps.LatLng(s.lat(), s.lng()),
    new google.maps.LatLng(d.lat(), d.lng())
  );
}
// Return the style of the map used
function cleanMapStyle() {
    return [
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
];
}
// Change the opacity of every station but the "thisStation". if undefined, change everything
function changeOpacity(thisStation, opc) {
    if(thisStation == undefined){thisName = "";}
    else{thisName = thisStation.getTitle();}
    for (var i = 0; i < stations.length; i++) {
        var m = stations[i];
        if(m.getTitle() != thisName) {
            m.setOpacity(opc);
        }
    }
}
// Listener to the 'myPosition' button
function myPosListener(mapi, userM){
    $("#myPosition").click(function(){
        if (navigator.geolocation){
            navigator.geolocation.getCurrentPosition(function(position){
                var nPos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
                userM.setPosition(nPos);
                if(userM.getMap() != mapi) {userM.setMap(mapi);}
                mapi.setCenter(nPos);
            });
        }
    });
}
