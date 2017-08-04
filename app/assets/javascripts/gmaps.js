// This example adds a search box to a map, using the Google Place Autocomplete
// feature. People can enter geographical searches. The search box will return a
// pick list containing a mix of places and predicted search terms.


// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">


var fetchedMarkers = {};
var heatmapData = [];
var heatmap;
var bubble_map = {};
var recentMarker = null;
var editedMarker = null;
var global1 = true;
var markers = [];
var waqiMapOverlay;
var canMark;

// ****************************************************** VARS: MAP ***************************************** //
var map;
var infowindow;
var reverseGC;
// ****************************************************** VARS: UI ***************************************** //
var input
var searchBtn
var searchBox
var myLocationBtn
var cleanAirBtn
var cleanAirBtn2
var signIn;
var dropdown;
var profile;

// ****************************************************** VARS: ICONS ***************************************** //
var icons;
var moldMarker;
var smokeMarker;
var dustMarker;
var dogMarker;
var glutenMarker;
var peanutMarker;
var oakMarker;
var perfumeMarker;
var catMarker;
var beeMarker;
window.fetchMarkers = fetchMarkers;

// ****************************************************** VARS: TRANSLATE ***************************************** //
var right_to_left_languages
var search_in_other_lang

// Page should be in English by default
document.cookie = "googtrans=/en/en;"
document.cookie = "googtrans=/en/en; domain=.c9users.io"
// **** add extra domain when deployed to heroku
// **** also add heroku link to google online 


// Setting the page language to the language selected by the user

// if (user is signed in) {
//   language = users language in database
//   document.cookie = "googtrans=/en/...;"
//   document.cookie = "googtrans=/en/...; domain=.c9users.io"
// }
  
  
// ****************************************************** RUN ***************************************** //
setLanguageVars();
page_trans_work();
setTranslateListner();

setTimeout(function(){
  $("#find-my-location").click();
}, 3000);  



// ****************************************************** METHODS: LOAD/CHANGE ***************************************** //

$(document).ready(initAutocomplete);
$(document).on('page:load', initAutocomplete);
$(document).on('page:change', initAutocomplete);


// ****************************************************** METHODS: INITAUTOCOMPLETE ***************************************** //


function initAutocomplete() {
  mapLoad();
  placeMarkerListener();
  $(document).on('submit', '#markerEdit', function(e){
    e.preventDefault();
    var newTitle = $('#title-edit').val();
    var id = editedMarker.id;
    $.ajax({
      type: "PUT",
      contentType: "application/json; charset=utf-8",
      url: "markers",
      data: JSON.stringify({title: newTitle, id: editedMarker.id}),
      success: function(d){
        console.log(id);
        bubble_map[id].bubble.close();
        fetchMarkers();
        bubble_map[id].bubble.open(map, bubble_map[id].bubble);
        editedMarker = null;
      }
    })
    return false;
  });
}


// ****************************************************** METHODS: MAP ***************************************** //
function mapLoad() {
  if (!map) {
    createMap();
    setMarkerImages();
    createHeatMap();
    setWaqiOverlay();
    infowindow = new google.maps.InfoWindow;
    // Reverse lat/lon city lookup
    reverseGC = new google.maps.Geocoder;
    setUIelements();
    setSettingsLocationAutoComplete();
    
  }
  setMapListeners();
}


function createMap(){
  map = new google.maps.Map(document.getElementById('map'), {
    center: {
      lat: 37.3382,
      lng: -121.8863
    },
    zoom: 13,
    mapTypeId: 'roadmap'
  });
}


function setMapOnAll(map) {
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(map);
    }
    if (heatmap) heatmap.setMap(map);
}

function setMapListeners(){
  google.maps.event.addDomListener(window, "resize", function() {
    var center = map.getCenter();
    google.maps.event.trigger(map, "resize");
    map.setCenter(center); 
  });
  
  google.maps.event.addListener(map, 'dragend', function(){
    console.log('BubbleMap:' + Object.keys(bubble_map).length);
    fetchMarkers();
  })
}



// ****************************************************** METHODS: UI ***************************************** //

function setUIelements(){
  $('#marker-cta').css('cursor','pointer');
  $('#left-col').css('height', (window.innerHeight).toString());
  $('#right-col').css('height', (window.innerHeight).toString());
  $('#detail-box').css('height', (window.innerHeight - 50 - 50 - 50 - 50).toString());
  $('#detail-box-mask').css('height', (window.innerHeight - 50 - 50 - 50 - 50).toString());
    
  // Create the search box and buttons and link them to the UI elements.
  input = document.getElementById('pac-input');
  searchBtn = document.getElementById('search-button');
  searchBox = new google.maps.places.SearchBox(input);
  myLocationBtn = document.getElementById('find-my-location');
  cleanAirBtn = document.getElementById('clean-air');
  cleanAirBtn2 = document.getElementById('clean-air-button');
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(searchBtn);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(myLocationBtn);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(cleanAirBtn);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(cleanAirBtn2);

  // add listener for airquality button
  cleanAirBtn2.onclick = function() {
    $('#myonoffswitch').trigger("click");
    if (global1) {
      addOverlay();
      global1 = false;
    } else {
      global1 = true;
      removeOverlay(); 
    }
  }  
  
  // Add Sign in and profile icon buttons
  signIn = document.getElementById('log-in')
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(signIn);
  
  dropdown = document.getElementById('profile-click')
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(dropdown)
  
  profile = document.getElementById('profile-icon')
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(profile)

  setUIListerners();
}

function setUIListerners(){
  
  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });
  
  
  searchBox.addListener('places_changed', function() {
    var places = searchBox.getPlaces();

    if (places.length === 0) {
      return;
    }

    markers.forEach(function(marker) {
      marker.setMap(null);
    });
    heatmap.setMap(null);
    markers = [];
    heatmapData = [];

    var bounds = new google.maps.LatLngBounds();
    places.forEach(function(place) {
      if (!place.geometry) {
        console.log("Returned place contains no geometry");
        return;
      }
      var icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "city_data",
        data: JSON.stringify({geo: place.geometry.location, name: place.name}),
        success: function(data){
          $("#city-info").text(JSON.stringify(data));
        }
      });
      
      markers.push(new google.maps.Marker({
        map: map,
        icon: icon,
        title: place.name,
        position: place.geometry.location
      }));

      if (place.geometry.viewport) {
        bounds.union(place.geometry.viewport);
      }
      else {
        bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
    fetchMarkers();
    
  });
  
  
  searchBtn.onclick = function () {
    var searchText = document.getElementById('pac-input');
    
    // Trigerring a search as if enter key pressed
    google.maps.event.trigger(searchText, 'focus');
    google.maps.event.trigger(searchText, 'keydown', {
        keyCode: 13
    });
  }
  
  
  myLocationBtn.onclick = function () {
    var reverseGC = new google.maps.Geocoder;
    
    // Finding user location using google's geolocation
    if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
        
        // Getting current location
        var pos = {lat: position.coords.latitude, lng: position.coords.longitude};
        var loc_curr = {'location': pos};
        
        // infowindow.setPosition(pos);
        // infowindow.setContent('Location found.');
        // infowindow.open(map);
        // map.setCenter(pos);
        
        reverseGC.geocode(loc_curr, function(results, status) {
      
          if (status === 'OK') {
            if (results[1]) {
              
              var specific_address = results[1].formatted_address;
              var city_address = results[1].address_components[1].short_name;
    
              if (!((specific_address === false) || (specific_address.length === 0))) {
                document.getElementById("pac-input").value = specific_address;
                document.getElementById("search-button").onclick();
                document.getElementById("pac-input").value = "";
                
                
                var image = {
                  url: 'https://www.vshoo.com/img/general/login/loading.gif',
                  scaledSize : new google.maps.Size(60, 60)  
                }; 
    
    
                setTimeout( function() {
                  var marker = new google.maps.Marker({
                  position: new google.maps.LatLng(pos.lat, pos.lng),
                  map: map,
                  optimized: false,
                  icon: image
                  // animation: google.maps.Animation.DROP
                })
    
                setTimeout(function() {
                    marker.setMap(null);
                }, 4000);
                
          
                
                }, 800);
                
                
              }
            } else {
              return ('No results found');
            }
          } else {
            return ('Geocoder failed due to: ' + status);
          }
        });
        
        // handling errors
      }, function() {
        

        infoWindow = new google.maps.InfoWindow;
        infoWindow.setPosition(map.getCenter());
        infoWindow.setContent('Location Disabled');
        infoWindow.open(map);
        
        if (infoWindow) {
          setTimeout(function(){
            infoWindow.close();
          }, 3000);
        }
        
      });
    } else {
      handleLocationError(false, infowindow, map.getCenter());
    }
  }
}
  

// ****************************************************** METHODS: OVERLAYS ***************************************** //

function createHeatMap(){
  heatmap = new google.maps.visualization.HeatmapLayer({
    data: heatmapData,
    map: map
  });
}

function setHeatMapData(data){
  heatmapData = [];
  for (var i=0;i<data.length; i++) {
    var heatmap_marker = data[i];
    heatmapData.push(new google.maps.LatLng(heatmap_marker.lat, heatmap_marker.lng));
  }
}

function setHeatMap(){
  heatmap.setMap(null);
  heatmap = new google.maps.visualization.HeatmapLayer({
    data: heatmapData,
    radius: 50,
    opacity: 0.1,
    gradient: [     
    'rgba(24, 249, 235, 0)',
    '#0fb8ad',
    '#2cb5e8',
    '#1fc8db',
    'rgba(117, 142, 255, 1)',
    'rgba(118, 103, 252, 1)',
    'rgba(101, 84, 249, 1)',
    'rgba(100, 22, 226, 1)'
    ],
    map:map
  });
}

function setWaqiOverlay(){
  waqiMapOverlay = new google.maps.ImageMapType({  
    getTileUrl: function(coord, zoom){  
      return 'https://tiles.waqi.info/tiles/usepa-aqi/' + zoom +"/"+ coord.x + "/" + coord.y + ".png?token=c18b43c1fe86c25643ca8e4fecbc1f23be1cc78a";  
    },  
    name: "Air Quality"
  });  
      
  map.overlayMapTypes.insertAt(0,waqiMapOverlay);  
  removeOverlay()
}


function addOverlay() {
  map.overlayMapTypes.insertAt(1,waqiMapOverlay);
}

function removeOverlay() {
  map.overlayMapTypes.clear();
}


// ****************************************************** METHODS: LOCATION ***************************************** // 


function point2LatLng(point, map) {
  var topRight = map.getProjection().fromLatLngToPoint(map.getBounds().getNorthEast());
  var bottomLeft = map.getProjection().fromLatLngToPoint(map.getBounds().getSouthWest());
  var scale = Math.pow(2, map.getZoom());
  var worldPoint = new google.maps.Point(point.x / scale + bottomLeft.x, point.y / scale + topRight.y);
  return map.getProjection().fromPointToLatLng(worldPoint);
}

function setSettingsLocationAutoComplete(){
  var autocomplete2 = new google.maps.places.Autocomplete(
    /** @type {!HTMLInputElement} */(document.getElementById('autocomplete2')),
    {types: ['geocode']});
  // bias results around current location
  var curr_location = autocomplete2.getPlace();
  autocomplete2.addListener('place_changed', fillInAddress(curr_location)); 
}

// Handle location finder error
function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
          'Error: Could not find location' :
          'Error: Browswer does not support location.');
  infoWindow.open(map);
}


// ****************************************************** METHODS: ICONS ***************************************** // 
function setMarkerImages(){
      beeMarker = {
          url: 'https://image.flaticon.com/icons/svg/235/235425.svg', 
          scaledSize : new google.maps.Size(50, 50)
      };
      catMarker = {
        url: 'https://image.flaticon.com/icons/svg/12/12160.svg',
        scaledSize : new google.maps.Size(50, 50)
      };
      perfumeMarker = {
        url: 'https://image.flaticon.com/icons/svg/223/223811.svg',
        scaledSize : new google.maps.Size(50, 50)
      }
      oakMarker = {
        url: 'https://image.flaticon.com/icons/svg/424/424041.svg',
        scaledSize : new google.maps.Size(50, 50)
      }
      peanutMarker = {
        url: 'https://image.flaticon.com/icons/svg/204/204697.svg',
        scaledSize : new google.maps.Size(50, 50)
      }
      glutenMarker = {
        url: 'https://image.flaticon.com/icons/svg/204/204705.svg',
        scaledSize : new google.maps.Size(50, 50)
      }
      dogMarker = {
        url: 'https://image.flaticon.com/icons/svg/91/91544.svg',
        scaledSize : new google.maps.Size(50, 50)
      }
      dustMarker = {
        url: 'https://image.flaticon.com/icons/svg/471/471794.svg',
        scaledSize : new google.maps.Size(50, 50)
      }
      smokeMarker = {
        url: 'https://image.flaticon.com/icons/svg/394/394631.svg',
        scaledSize : new google.maps.Size(50, 50)
      }
      moldMarker = {
        url: 'https://d30y9cdsu7xlg0.cloudfront.net/png/183061-200.png',
        scaledSize : new google.maps.Size(50, 50)
      }
      icons = {
        bees: {
          icon: beeMarker
        },
        cats: {
          icon: catMarker
        },
        perfume: {
          icon: perfumeMarker
        },
        oak: {
          icon: oakMarker
        },
        peanut: {
          icon: peanutMarker
        },
        gluten: {
          icon: glutenMarker
        },
        dog: {
          icon: dogMarker
        },
        dust: {
          icon: dustMarker
        },
        smoke: {
          icon: smokeMarker
        },
        mold: {
          icon: moldMarker
        }
      };
    }

function getIcon(marker) {
  if (marker.title.toLowerCase() in icons) {
    return icons[marker.title.toLowerCase()].icon;
  }
  return null;
}

// ****************************************************** METHODS: MARKERS ***************************************** //

function clearMarkers() {
    setMapOnAll(null);
}

function deleteMarkers() {
    clearMarkers();
    markers = [];
}
  
function deleteMarker(id) {
  $.ajax({
    type: "DELETE",
    contentType: "application/json; charset=utf-8",
    url: "markers",
    data: JSON.stringify({id: id}),
    success: function() {
      if (id in bubble_map) {
        bubble_map[id].bubble.close();
        bubble_map[id].setMap(null);
        delete bubble_map[id]
      }
      fetchMarkers();
    }
  });
}

function setMarkers(data){
  for (var j=0;j<data.length; j++) {
    var user_marker = data[j];

    if (true) {
      var location = {};
      location.lat = parseFloat(user_marker.lat);
      location.lng = parseFloat(user_marker.lng);
      var newContent = createContentString(user_marker);
      var labelClientId = user_marker.client_id
      var customMarker = getIcon(user_marker);
      var marker = new google.maps.Marker({
        label: '',
        position: location,
        map: map,
        icon: customMarker,
        draggable: false
      });
      
      var bubble = new InfoBubble({
        shadowStyle: 0,
        backgroundColor: 'rgba(29, 161, 242, 0.8)',
        borderRadius: 10,
        arrowSize: 10,
        borderWidth: 2,
        borderColor: '#ffffff',
        disableAutoPan: true,
        hideCloseButton: false,
        arrowPosition: 50,
        minWidth: 100,
        minHeight: 75,
        arrowStyle: 0,
        closeSrc: 'https://www.google.com/intl/en_us/mapfiles/close.gif'
      });
      bubble.setContent(newContent[0]);
      marker.bubble = bubble;
      console.log("FETCH");
      console.log(user_marker.id);
      marker.id = user_marker.id;
      bubble_map[user_marker.id] = marker;
      google.maps.event.addListener(marker, 'click', function(){
        this.bubble.open(map, this);
      });
  
      markers.push(marker);
    } 
  }
}

function editMarker(data) {
  var id = data.id;
  bubble_map[id].bubble.close();
  
  var marker = bubble_map[id];
  var bubble = new InfoBubble({
    shadowStyle: 0,
    backgroundColor: 'rgba(29, 161, 242, 0.8)',
    borderRadius: 10,
    arrowSize: 10,
    borderWidth: 2,
    borderColor: '#ffffff',
    disableAutoPan: true,
    hideCloseButton: false,
    arrowPosition: 50,
    maxWidth: '600px',
    minWidth: '600px',
    minHeight: 75,
    height: '100%',
    arrowStyle: 0
  });
  
  bubble.open(map, marker);
  bubble.setContent(getContentS());
  marker.bubble = bubble;
  editedMarker = marker;
  editedMarker.bubble = bubble;
}

function marker_type_in_bounds(marker_types_in_bounds){
  for (var i = 0; i < marker_types_in_bounds.length; i++) {
    var filter_id = 'filter-'+marker_types_in_bounds[i];
    if (! $('#'+filter_id).length) {
      $('#filter-header').append('<div><input type="checkbox" value="'+marker_types_in_bounds[i]+'" class="filter_checkbox" id="'+filter_id+'" checked/><label for="'+filter_id+'">&nbsp&nbsp&nbsp&nbsp'+marker_types_in_bounds[i]+'</div>');
    }
  }
}  
  
  
function fetchMarkers(filtered_allergens={}) { 
  deleteMarkers();
  var bounds = map.getBounds();
  var NECorner = bounds.getNorthEast();
  var SWCorner = bounds.getSouthWest();
  $.ajax({
    type: "GET",
    contentType: "application/json; charset=utf-8",
    url: "markers",
    //data: {bounds :{uplat:NECorner.lat(),downlat:SWCorner.lat(),rightlong:NECorner.lng(),leftlong:SWCorner.lng()}},
    data: {bounds :{uplat:NECorner.lat(),downlat:SWCorner.lat(),rightlong:NECorner.lng(),leftlong:SWCorner.lng()}, filter :filtered_allergens},
    success: function(data){
      setMarkers(data[0]);
      setHeatMapData(data[1]);
      setHeatMap();
      // used for filtering allergens
      marker_type_in_bounds(data[2]);
    }
  })
}

function placeMarkerListener(){
  // allow user to put down a marker
  $('body').delegate('#marker-cta', 'click', function(){
    loggedIn();
    // $("#marker-cta span").text("Click map to place marker, BUT NOW PLACE MARKER ON MAP")
  });


  google.maps.event.addListener(map, 'click', function(event) {
    if (canMark){
      var x = event.pixel.x + 16;
      var y = event.pixel.y + 32;
      var point = {};
      point.x = x;
      point.y = y;
      var latlng = point2LatLng(point, map);
      placeMarker(latlng);  
      canMark = false;
      map.setOptions({ draggableCursor :"auto"});
      $("#marker-cta").css("cursor", "pointer");
      $("#marker-cta span").text("SEARCH BOX, BUT NOW CLICK HERE TO ADD ALLERGEN");
    }
  });
}

function placeMarker(location) {
  var marker = new google.maps.Marker({
    label: "",
    position: location,
    map: map,
    draggable: true
  })
    
  var contentString = $(
    
    "<div id= 'marker-bubble' class='scrollFix'>" + 
      "<form id='markerForm' action='markers' method='POST'>"+
        "<datalist id='options'>"+
          "<option value='Cats'> Cats </option>" +
          "<option value='Bees'> Bees </option>" +
          "<option value='Perfume'> Perfume </option>" +
          "<option value='Oak'> Oak </option>" +
          "<option value='Peanut'> Peanut </option>" +
          "<option value='Gluten'> Gluten </option>" +
          "<option value='Dog'> Dog </option>" +
          "<option value='Dust'> Dust </option>" +
          "<option value='Smoke'> Smoke </option>" +
          "<option value='Mold'> Mold </option>" +
          "</datalist>" +
        "<div id= 'input-title'>Allergen:</div>" +
        "<div id='spacing'></div>"+
        "<input class = 'text-box' type='text' name='title' list='options'>" + 
        "<div id='spacing'></div>"+
        "<div id='spacing'></div>"+
        "<div id='spacing'></div>"+
        //"<input id = 'plus-button' type='submit' value='+'>"+
      "</form>" +
    "</div>"
  );

  var markerInfo = new InfoBubble({
    shadowStyle: 0,
    backgroundColor: 'rgba(29, 161, 242, 0.8)',
    borderRadius: 10,
    arrowSize: 10,
    borderWidth: 2,
    borderColor: '#ffffff',
    disableAutoPan: true,
    hideCloseButton: false,
    arrowPosition: 50,
    maxWidth: '600px',
    minWidth: '600px',
    minHeight: 75,
    height: '100%',
    arrowStyle: 0,
    closeSrc: 'https://www.google.com/intl/en_us/mapfiles/close.gif'
  });


  var infowindow = new google.maps.InfoWindow();
  //infowindow.open(map,marker);
  infowindow.setContent(contentString[0]);
  marker.infowindow = infowindow;
  recentMarker = marker;

  markerInfo.open(map, marker);
  markerInfo.setContent(contentString[0]);
  marker.markerInfo = markerInfo;
  recentMarker = marker;

  google.maps.event.addListener(marker, 'click', function(){
    markerInfo.open(map,marker);
  });
  
  var listenerHandle = google.maps.event.addListener(infowindow, 'closeclick', function(){
    recentMarker.setMap(null);
    recentMarker = null;
  });
  
  // disallow marker spawn if its already here. this means i need the UniqueID 
  
  
  $(document).on('submit', '#markerForm', function(e){
    if (recentMarker != null) {
      e.preventDefault();
      infowindow.close();
      var postData = $(this).serializeArray();
      postData.push({name: "lat", value: location.lat()});
      postData.push({name: "lng", value: location.lng()});
      var convData = {};
      $(postData).each(function(idnex,obj){
        convData[obj.name] = obj.value;
      })
      
    
      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "markers",
        data: JSON.stringify({marker: convData}),
        success: function(d){
          fetchedMarkers[d.id] = true;
          
          var newContent = createContentString(d);
          var customMarker = getIcon(d);
          console.log(recentMarker == null)
          recentMarker.setIcon(customMarker);
          recentMarker.markerInfo.setContent(newContent[0]);
          recentMarker.markerInfo.open(map,recentMarker);
          recentMarker.draggable = false;
          recentMarker = null;
          //google.maps.event.removeEventListener(listenerHandle);
          markers.push(recentMarker);
          
        }
      })
      return false;
    }
  });
  
}

// ****************************************************** METHODS: CONTENT STRINGS ***************************************** //


function getContentS() {
  var contentString = $(
    
    "<div id= 'marker-bubble' class='scrollFix'>" + 
      "<form id='markerEdit' action='markers' method='PUT'>"+
        "<datalist id='options'>"+
          "<option value='Cats'>" +
          "<option value='Bees'>" +
          "<option value='Perfume'>" +
          "<option value='Oak'>" +
          "<option value='Peanut'>" +
          "<option value='Gluten'>" +
          "<option value='Dog'>" +
          "<option value='Dust'>" +
          "<option value='Smoke'>" +
          "<option value='Mold'>" +
          "</datalist>" +
        "<div id= 'input-title'>Allergen:</div>" +
        "<div id='spacing'></div>"+
        "<input id = 'title-edit' class = 'text-box' type='text' name='title' list='options'>" + 
        "<div id='spacing'></div>"+
        "<div id='spacing'></div>"+
        "<div id='spacing'></div>"+
        //"<input id = 'plus-button' type='submit' value='+'>"+
      "</form>" +
    "</div>"
  );
  return contentString[0];
}

function getContent() {
  var contentString = $(
    "<div id= 'marker-bubble' class='scrollFix'>" + 
      "<form id='markerForm' action='markers' method='POST'>"+
        "<datalist id='options'>"+
          "<option value='Cats'> Cats </option>" +
          "<option value='Bees'> Bees </option>" +
          "<option value='Perfume'> Perfume </option>" +
          "<option value='Oak'> Oak </option>" +
          "<option value='Peanut'> Peanut </option>" +
          "<option value='Gluten'> Gluten </option>" +
          "<option value='Dog'> Dog </option>" +
          "<option value='Dust'> Dust </option>" +
          "<option value='Smoke'> Smoke </option>" +
          "<option value='Mold'> Mold </option>" +
          "</datalist>" +
        "<div id= 'input-title'>Allergen:</div>" +
        "<div id='spacing'></div>"+
        "<input class = 'text-box' type='text' name='title' list='options'>" + 
        "<div id='spacing'></div>"+
        "<div id='spacing'></div>"+
        "<div id='spacing'></div>"+
        //"<input id = 'plus-button' type='submit' value='+'>"+
      "</form>" +
    "</div>"
  );
  return contentString[0];
}

function createContentString(data){
  var title = data.title;
  var editBtn = document.createElement("button");
  editBtn.innerHTML = "Edit";
  editBtn.classList.add('edit-btn')
  var deleteBtn = document.createElement("button");
  deleteBtn.innerHTML = "";
  deleteBtn.classList.add('remove-btn');
  google.maps.event.addDomListener(editBtn,'click', function(){
    editMarker(data);
  })
  google.maps.event.addDomListener(deleteBtn,'click', function(){
    deleteMarker(data.id);
  })
  var contentString ="<div id= 'marker-bubble' class='scrollFix'>"+
                      "<div class='marker-title'>" + 
                        title +
                        "<div id = 'spacing'></div>";
                      
  var content = $(contentString);

  var divBar = document.createElement("div");
  divBar.classList.add('edit-delete');
  var deletePos = document.createElement("div");
  deletePos.classList.add('delete-pos');
  var editPos = document.createElement("div");
  editPos.classList.add('edit-pos');
  
  deletePos.appendChild(deleteBtn);
  editPos.appendChild(editBtn);
  divBar.appendChild(editPos);
  divBar.appendChild(deletePos);
  content.append(divBar);

  content.append('</div></div>')
  return content;
}


// ****************************************************** METHODS: PROFILE ***************************************** //


function loggedIn(){
  canMark = false;
    $.ajax({
    type: "GET",
    contentType: "application/json; charset=utf-8",
    url: "authcheck",
    data: {},
    success: function(data){
      if (data.authorized && recentMarker === null){
        map.setOptions({ draggableCursor :"url(https://maps.google.com/mapfiles/ms/micons/red-dot.png), auto"});
        $("#marker-cta").css("cursor", "url(https://maps.google.com/mapfiles/ms/micons/red-dot.png), auto");
        canMark = true;  
      } else {
        canMark = false;
        window.location.href = '/auth/google_oauth2';
      }
    }
  });
}


// ****************************************************** METHODS: TRANSLATE ***************************************** //

function page_trans_work() {
  var other_way = false;
  for (var i = 0; i < right_to_left_languages.length; i++) {
     if (String(document.cookie).indexOf("/en/"+right_to_left_languages[i]) > -1) {
      other_way = true;
    }
  }
  
  if (other_way === true) {
      $("#right-col").insertAfter("#left-col");
   // $("#pac-input").css('text-align','right');
   // $("#search-button").css('right','611px !important');

 	  document.getElementById("rolling-rolling-rolling").innerHTML = '<marquee behavior="scroll" direction="right" scrollamount="5" ><div id = "spare_alert" > High pollen levels in Berkeley, CA </div></marquee>'
  } else {
    $("#left-col").insertAfter("#right-col");
    $("#pac-input").css('text-align','left');

 	  document.getElementById("rolling-rolling-rolling").innerHTML = '<marquee behavior="scroll" direction="left" scrollamount="5" ><div id = "spare_alert" > High pollen levels in Berkeley, CA </div></marquee>'
  }
  
  
  setTimeout(function(){
    if (search_in_other_lang.hasOwnProperty(String(document.cookie).slice(14, 16))) {
      document.getElementById("pac-input").placeholder = search_in_other_lang[String(document.cookie).slice(14, 16)];
    }
  }, 1000);
}


// ****************************************************** METHODS: TRANSLATE ***************************************** //

function setLanguageVars(){
  right_to_left_languages = ["ar", "az", "fa", "jw", "kk", "ku", 
  "ms", "ml", "ps", "pa", "sd", "so", "iw", "yi", "ur"];
  
  search_in_other_lang = {
  	"af": "Soek","sq": "kërkim","am": "ፈልግ","ar": "بحث","hy": "Որոնում","az": "Axtarış","eu": "Search","be": "пошук",
  	"bn": "অনুসন্ধান","bs": "Pretraga","bg": "Търсене","ca": "Cerca","ceb": "Pagpangita","ny": "Sakani","zh-CN": "搜索",
  	"zh-TW": "搜索","co": "Ricerca","hr": "traži","cs": "Vyhledávání","da": "Søg","nl": "Zoeken","en": "Search","eo": "Serĉu",
  	"et": "Otsing","tl": "Paghahanap","fi": "Haku","fr": "Recherche","fy": "Search","gl": "Busca","ka": "ძებნა","de": "Suche",
  	"el": "έρευνα","gu": "શોધ","ht": "Search","ha": "Search","haw": "Search","iw": "חיפוש","hi": "खोज","hmn": "Nrhiav",
  	"hu": "Keresés","is": "Leit","ig": "Search","id": "Pencarian","ga": "Cuardach","it": "Ricerca","ja": "検索","jw": "Search",
  	"kn": "ಹುಡುಕು","kk": "іздеу","km": "ស្វែងរក","ko": "수색","ku": "Search","ky": "издөө","lo": "ຄົ້ນຫາ","la": "Quaerere","lv": "Meklēšana",
  	"lt": "Paieška","lb": "Sich","mk": "Барај","mg": "Search","ms": "Carian","ml": "തിരയൽ","mt": "Fittex","mi": "Rapu","mr": "शोध",
  	"mn": "хайх","my": "ရှာဖှေ","ne": "खोज","no": "Søk","ps": "لټون","fa": "جستجو","pl": "Poszukiwanie","pt": "Pesquisa","pa": "ਖੋਜ",
  	"ro": "Căutare","ru": "поиск","sm": "Suʻe","gd": "Rannsachadh","sr": "претраживање","st": "Search","sn": "kutsvaka","sd": "ڳولا",
  	"si": "සොයන්න","sk": "Vyhľadávanie","sl": "Iskanje","so": "Search","es": "Búsqueda","su": "Neangan","sw": "Search","sv": "Sök",
  	"tg": "кофтуков","ta": "தேடல்","te": "శోధన","th": "ค้นหา","tr": "Arama","uk": "пошук","ur": "تلاش کریں","uz": "Qidiruv",
  	"vi": "Tìm kiếm","cy": "Chwilio","xh": "Search","yi": "זוכן","yo": "Search","zu": "Ukucinga"
  };
}

function setTranslateListner(){
  $("body").on("change", "#google_translate_element select", function (e) {
    // change data base language for user
    // user.language = $(".goog-te-combo").val() 
    
    // now change current pages language
    document.cookie = "googtrans=/en/" + $(".goog-te-combo").val() + ";";
    document.cookie = "googtrans=/en/" + $(".goog-te-combo").val() + ";domain=.c9users.io"
    page_trans_work();
  });  
}

      
