



var App = {
 
  
  initAutocomplete: function() {
    var autocomplete2 = new google.maps.places.Autocomplete(
    /** @type {!HTMLInputElement} */(document.getElementById('autocomplete2')),
    {types: ['geocode']});
    var place = autocomplete2.getPlace(); autocomplete2.addListener('place_changed', fillInAddress(place));
    
    window.fetchMarkers = App.fetchMarkers;
    
  },
  
  point2LatLng: function(point, map) {
    var topRight = map.getProjection().fromLatLngToPoint(map.getBounds().getNorthEast());
    var bottomLeft = map.getProjection().fromLatLngToPoint(map.getBounds().getSouthWest());
    var scale = Math.pow(2, map.getZoom());
    var worldPoint = new google.maps.Point(point.x / scale + bottomLeft.x, point.y / scale + topRight.y);
    return map.getProjection().fromPointToLatLng(worldPoint);
  },
  
  fetchMarkers: function (filtered_allergens={}) {
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
        
        // used for filtering allergens
        var i;
        var marker_types_in_bounds = data[2];
        for (i = 0; i < marker_types_in_bounds.length; i++) {
          filter_id = 'filter-'+marker_types_in_bounds[i];
          if (! $('#'+filter_id).length) {
            $('#filter-header').append('<div><input type="checkbox" value="'+marker_types_in_bounds[i]+'" class="filter_checkbox" id="'+filter_id+'" checked/><label for="'+filter_id+'">&nbsp&nbsp&nbsp&nbsp'+marker_types_in_bounds[i]+'</div>');
          }
        }
        
        
        heatmapData = [];
        // if (data.length > 1){
          // var client_id = data[0].client_id;
          for (var i=0;i<data[1].length; i++) {
            var heatmap_marker = data[1][i];
            heatmapData.push(new google.maps.LatLng(heatmap_marker.lat, heatmap_marker.lng));
          }
          
          for (var j=0;j<data[0].length; j++) {
          
            
            var user_marker = data[0][j];
        
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
                      draggable: false
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
            'rgba(100, 22, 226, 1)'
          
            ],
            map:map
          });

      }
    })
  },

  
  
}