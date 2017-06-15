var stations = []; // The stations (markers) list
var pos = "";   // the user position
var infowindow = ""; // the infowindow to display each station info

// Initializer callback - Automatically called by the gmaps API
function initMap() {
    var myLatlng = {lat: -23.5505, lng: -46.6333};
    var map = new google.maps.Map(document.getElementById('basic_map'), {
        zoom: 13,
        center: myLatlng
    });
    // the user marker needs to be always on top
    var userM = new google.maps.Marker({
        title: "Você",
        position: myLatlng,
        optimized: false,
        zIndex:99999999
 });
    addStations(map);
    map.setCenter(myLatlng);
    updLocs(map, userM);
    updStations(map);
    // Configure the legend
    var legend = document.getElementById('legend');
    var div = document.createElement('div');
    div.innerHTML = '<img src="/assets/okBike.png">   ' + "Há bikes livres <br>"+
                    '<img src="/assets/badBike.png">   ' + "Nenhuma bike livre";
    legend.appendChild(div);
    map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(legend);

}

//==================Stations builder=====================
// Functions to build the stations from the first time!

/* Get the stations from the API, then add into the map */
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
/* Helper callback to add stations from the cicloSampa provider */
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
/* Add a click listener to a given marker to display slot info*/
function bindInfoWindow(marker, mapi, infowindow, html) {
    google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(html);
        infowindow.open(mapi, marker);
    });
}
/* Returns the formatted string for a given marker */
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
        mkList = getAPIinfo(mapi);
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
            m.setIcon(mkList["free"][i] == 0 ?  "/assets/badBike.png" : "/assets/okBike.png")
            var content = createInfo(mkList, i);
            bindInfoWindow(m, mapi, infowindow, content);
        }
    }
}

//==================Geolocation updater=====================
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
// Updates the location of the user every 15 seconds
async function updLocs(mapi, userM) {
    while(true) {
        getGeoLocation();
        if (pos != ""){ // Only update the position when we have one!
            userM.setPosition(new google.maps.LatLng(
                              pos.coords.latitude,
                              pos.coords.longitude));
            userM.setMap(mapi);
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
