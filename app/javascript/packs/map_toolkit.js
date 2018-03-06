function setupMap(mapLocation, origin, zoom) {
  const styledMapType = new google.maps.StyledMapType(
    [
    {
        "featureType": "all",
        "elementType": "all",
        "stylers": [
            {
                "hue": "#e7ecf0"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
            {
                "saturation": -70
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "simplified"
            },
            {
                "saturation": -60
            }
        ]
    }
],
    {name: 'Styled Map'});



    const mapOptions = {
      zoom: zoom,
      center: origin,
      fullscreenControl: false,
      streetViewControl: false,
      mapTypeControl: false,
      rotateControl: false,
      mapTypeControlOptions: {
        mapTypeIds: ['styled_map']
      }
    }

  const map = new google.maps.Map(mapLocation, mapOptions);
  //Associate the styled map with the MapTypeId and set it to display.
  map.mapTypes.set('styled_map', styledMapType);
  map.setMapTypeId('styled_map');
  return map;
};


function showOneLeg(request, map, color, i) {

  const directionsService = new google.maps.DirectionsService();
  directionsService.route(request, function(response, status) {
    console.log(status)
  if (status == google.maps.DirectionsStatus.OK) {
    const directionsDisplay = new google.maps.DirectionsRenderer();
    directionsDisplay.setMap(map);
    const DirectionsRendererOptions = {
      preserveViewport: true,
      polylineOptions: {
        strokeColor: color,
        strokeOpacity: 0.5,
        strokeWeight: 4
      },
      suppressMarkers: true
    };
    directionsDisplay.setOptions(DirectionsRendererOptions);
    directionsDisplay.setDirections(response);
    }
  });
};



function showRouteOneCounterpart(map, from_self, to_self, counterpart){

    const from_counterpart   = new google.maps.LatLng(counterpart.from);
    const to_counterpart   = new google.maps.LatLng(counterpart.to);

    const counterpart_from_marker = new google.maps.Marker({
      position: from_counterpart,
      map: map,
      icon: {
        url: counterpart.avatar,
        scaledSize: {
          width: 30,
          height: 30
        }
      }});

    const request_walk_to_car = {
      origin:      from_self,
      destination: from_counterpart,
      travelMode:  google.maps.TravelMode.WALKING
    };

    showOneLeg(request_walk_to_car, map, "#ff0000");

    const request_walk_to_dest = {
      origin:      to_counterpart,
      destination: to_self,
      travelMode:  google.maps.TravelMode.WALKING
    };
    showOneLeg(request_walk_to_dest, map, "#00ff00");

    const request_drive = {
      origin:      from_counterpart,
      destination: to_counterpart,
      travelMode:  google.maps.TravelMode.DRIVING
    };
    showOneLeg(request_drive, map, "#0000ff");

};


export { setupMap, showRouteOneCounterpart, showOneLeg };
