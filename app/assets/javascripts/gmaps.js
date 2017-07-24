// This example adds a search box to a map, using the Google Place Autocomplete
// feature. People can enter geographical searches. The search box will return a
// pick list containing a mix of places and predicted search terms.


// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">


var fetchedMarkers = {};
var heatmapData = [];
var bubble_map = {};



function initAutocomplete() {
  
  function point2LatLng(point, map) {
    var topRight = map.getProjection().fromLatLngToPoint(map.getBounds().getNorthEast());
    var bottomLeft = map.getProjection().fromLatLngToPoint(map.getBounds().getSouthWest());
    var scale = Math.pow(2, map.getZoom());
    var worldPoint = new google.maps.Point(point.x / scale + bottomLeft.x, point.y / scale + topRight.y);
    return map.getProjection().fromPointToLatLng(worldPoint);
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
      data: {bounds :{uplat:NECorner.lat(),downlat:SWCorner.lat(),rightlong:NECorner.lng(),leftlong:SWCorner.lng()}, filter :filtered_allergens},
      success: function(data){
        // used for filtering allergens
        var i;
        var marker_types_in_bounds = data[2];
        for (i = 0; i < marker_types_in_bounds.length; i++) {
          filter_id = 'filter-'+marker_types_in_bounds[i];
          if (! $('#'+filter_id).length) {
            $('#filter-header').append('<div><input type="checkbox" value="'+marker_types_in_bounds[i]+'" class="filter_checkbox" id="'+filter_id+'" checked/><label for="'+filter_id+'">&nbsp&nbsp&nbsp&nbsp'+marker_types_in_bounds[i]+'</div>');
          }
        }
        //
        
        heatmapData = [];
        // if (data.length > 1){
          // var client_id = data[0].client_id;
          for (var i=0;i<data[1].length; i++) {
            var heatmap_marker = data[1][i];
            heatmapData.push(new google.maps.LatLng(heatmap_marker.lat, heatmap_marker.lng));
          }
          
          for (var i=0;i<data[0].length; i++) {
          
            
            var user_marker = data[0][i];
        
            if (true) {
              // if (id != client_id){
              // } else {
                var location = {};
                location.lat = parseFloat(user_marker.lat);
                location.lng = parseFloat(user_marker.lng);
                var newContent = createContentString(user_marker);
                var labelClientId = user_marker.client_id
                var customMarker = getIcon(user_marker);
                
                var marker = new google.maps.Marker({
                      //label: labelClientId.toString(),
                      label: '',
                      position: location,
                      map: map,
                      icon: customMarker,
                      draggable: false,
                });
                bubble = new InfoBubble({
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
                  arrowStyle: 0});
                bubble.setContent(newContent[0]);
                marker.bubble = bubble;
               
                marker.id = user_marker.id;
                bubble_map[user_marker.id] = marker;
                

                
                google.maps.event.addListener(marker, 'click', function(){
                  this.bubble.open(map, this);
                });
              // }
              
              markers.push(marker);
            } 
         }
        // }
          var heatmap = new google.maps.visualization.HeatmapLayer({
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
            'rgba(100, 22, 226, 1)',
          
            ],
            map:map
          });

      }
    })
  }
  window.fetchMarkers = fetchMarkers;
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
          }
          
          fetchMarkers();
          
        }
    });
  }
  function getIcon(marker) {
    if (marker.title.toLowerCase() in icons) {
      return icons[marker.title.toLowerCase()].icon;
    }
    return null;
  }
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {
      lat: 37.8716,
      lng: -122.2727
    },
    zoom: 13,
    mapTypeId: 'roadmap'
  });
  
  var infowindow = new google.maps.InfoWindow;
    
  // Reverse lat/lon city lookup
  var reverseGC = new google.maps.Geocoder;

  
    // Handle location finder error
    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
     infoWindow.setPosition(pos);
     infoWindow.setContent(browserHasGeolocation ?
              'Error: Could not find location' :
              'Error: Browswer does not support location.');
     infoWindow.open(map);
     }
  

  google.maps.event.addDomListener(window, "resize", function() {
   var center = map.getCenter();
   google.maps.event.trigger(map, "resize");
   map.setCenter(center); 
  });
  
  var heatmap = new google.maps.visualization.HeatmapLayer({
    data: heatmapData,
    map: map
  });
  
  $('#marker-cta').css('cursor','pointer');
  
  $('#left-col').css('height', (window.innerHeight).toString());
  $('#right-col').css('height', (window.innerHeight).toString());
  $('#detail-box').css('height', (window.innerHeight - 50 - 50 - 50 - 50).toString());
  $('#detail-box-mask').css('height', (window.innerHeight - 50 - 50 - 50 - 50).toString());
    
    
  
  
  // Create the search box and link it to the UI element.
  var input = document.getElementById('pac-input');
  var searchBtn = document.getElementById('search-button');
  var searchBox = new google.maps.places.SearchBox(input);
  var myLocationBtn = document.getElementById('find-my-location');

  
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(searchBtn);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(myLocationBtn);


  //var markerEnabler = document.getElementById('marker-cta');
  //map.controls[google.maps.ControlPosition.LEFT_TOP].push(markerEnabler);
  
  // Added Sign in and profile icon buttons
  var signIn = document.getElementById('log-in')
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(signIn);
  
  var dropdown = document.getElementById('profile-click')
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(dropdown)
  
  
  var profile = document.getElementById('profile-icon')
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(profile)


  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });

  google.maps.event.addListener(map, 'dragend', function(){
    fetchMarkers();
  })



  var markers = [];

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
    
              if (!((specific_address == false) || (specific_address.length == 0))) {
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
                  icon: image,
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
        handleLocationError(true, infowindow, map.getCenter());
      });
    } else {
      handleLocationError(false, infowindow, map.getCenter());
    }
  }

  
  var canMark = false;
  
  function loggedIn(){
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
 
 // CHANGE TO SEARCH BOX
 
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
  
  var recentMarker = null;



  function createContentString(data){
    var title = data.title;
    var ncontent=document.createElement('div'),
    button;
    button=ncontent.appendChild(document.createElement('input'));
    button.id = 'edit-delete'
    button.type='button';
    button.value='delete'
    google.maps.event.addDomListener(button,'click', function(){
      deleteMarker(data.id);
    })
    var contentString ="<div id= 'marker-bubble' class='scrollFix'>"+
                        "<div class='marker-title'>" + 
                          title +
                          "<div id = 'spacing'></div>";
                        
    var content = $(contentString);
    content.append(ncontent);
    content.append('</div></div>')
    return content;
  }

  
  var beeMarker = {
      url: 'https://image.flaticon.com/icons/svg/235/235425.svg', 
      scaledSize : new google.maps.Size(50, 50)
  };
  var catMarker = {
    url: 'https://image.flaticon.com/icons/svg/12/12160.svg',
    scaledSize : new google.maps.Size(50, 50)
  };
  var perfumeMarker = {
    url: 'https://image.flaticon.com/icons/svg/223/223811.svg',
    scaledSize : new google.maps.Size(50, 50)
  }
  var oakMarker = {
    url: 'https://image.flaticon.com/icons/svg/424/424041.svg',
    scaledSize : new google.maps.Size(50, 50)
  }
  var peanutMarker = {
    url: 'https://image.flaticon.com/icons/svg/204/204697.svg',
    scaledSize : new google.maps.Size(50, 50)
  }
  var glutenMarker = {
    url: 'https://image.flaticon.com/icons/svg/204/204705.svg',
    scaledSize : new google.maps.Size(50, 50)
  }
  var dogMarker = {
    url: 'https://image.flaticon.com/icons/svg/91/91544.svg',
    scaledSize : new google.maps.Size(50, 50)
  }
  var dustMarker = {
    url: 'https://image.flaticon.com/icons/svg/471/471794.svg',
    scaledSize : new google.maps.Size(50, 50)
  }
  var smokeMarker = {
    url: 'https://image.flaticon.com/icons/svg/394/394631.svg',
    scaledSize : new google.maps.Size(50, 50)
  }
  var moldMarker = {
    url: 'https://d30y9cdsu7xlg0.cloudfront.net/png/183061-200.png',
    scaledSize : new google.maps.Size(50, 50)
  }
  
  
  var icons = {
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

  
  function placeMarker(location) {
    var marker = new google.maps.Marker({
      label: "",
      position: location,
      map: map,
      draggable: true,
    })
    
    var contentString = $(
      
      "<div id='wrap'>" + 
        "<form id='markerForm' action='markers' method='POST'>"+
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
      arrowStyle: 0
      
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
          recentMarker.markerInfo.setContent(newContent[0]);
          recentMarker.setIcon(customMarker);
          recentMarker.markerInfo.open(map,recentMarker);
          recentMarker.draggable = false;
          recentMarker = null;
          google.maps.event.removeEventListener(listenerHandle);
          markers.push(recentMarker);
        }
      })
      return false;
    });
  }
  

  
  // maybe just send a list of attributes to tell javascript to use....? 
  function setMapOnAll(map) {
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(map);
    }
    heatmap.setMap(map);
  }
  
  function clearMarkers() {
    setMapOnAll(null);
  }

  function deleteMarkers() {
    clearMarkers();
    markers = [];
  }

}


$(document).ready(initAutocomplete);
$(document).on('page:load', initAutocomplete);
$(document).on('page:change', initAutocomplete);





