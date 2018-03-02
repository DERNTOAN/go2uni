function setupMap(mapLocation, origin, zoom) {
  const styledMapType = new google.maps.StyledMapType(
    [
    {
      "elementType": "geometry",
      "stylers": [
      {
        "color": "#ebe3cd"
      }
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
      {
        "color": "#523735"
      }
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
      {
        "color": "#f5f1e6"
      }
      ]
    },
    {
      "featureType": "administrative",
      "elementType": "geometry.stroke",
      "stylers": [
      {
        "color": "#c9b2a6"
      }
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "stylers": [
      {
        "visibility": "off"
      }
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "geometry.stroke",
      "stylers": [
      {
        "color": "#dcd2be"
      }
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [
      {
        "color": "#ae9e90"
      }
      ]
    },
    {
      "featureType": "administrative.neighborhood",
      "stylers": [
      {
        "visibility": "off"
      }
      ]
    },
    {
      "featureType": "landscape.natural",
      "elementType": "geometry",
      "stylers": [
      {
        "color": "#dfd2ae"
      }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [
      {
        "color": "#dfd2ae"
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
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
      {
        "color": "#93817c"
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
      "featureType": "poi.park",
      "elementType": "geometry.fill",
      "stylers": [
      {
        "color": "#a5b076"
      }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text",
      "stylers": [
      {
        "visibility": "off"
      }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
      {
        "color": "#447530"
      }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
      {
        "color": "#f5f1e6"
      }
      ]
    },
    {
      "featureType": "road",
      "elementType": "labels",
      "stylers": [
      {
        "visibility": "off"
      }
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry",
      "stylers": [
      {
        "color": "#fdfcf8"
      }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
      {
        "color": "#f8c967"
      }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry.stroke",
      "stylers": [
      {
        "color": "#e9bc62"
      }
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry",
      "stylers": [
      {
        "color": "#e98d58"
      }
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry.stroke",
      "stylers": [
      {
        "color": "#db8555"
      }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
      {
        "color": "#806b63"
      }
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [
      {
        "color": "#dfd2ae"
      }
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "labels.text.fill",
      "stylers": [
      {
        "color": "#8f7d77"
      }
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "labels.text.stroke",
      "stylers": [
      {
        "color": "#ebe3cd"
      }
      ]
    },
    {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [
      {
        "color": "#dfd2ae"
      }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry.fill",
      "stylers": [
      {
        "color": "#b9d3c2"
      }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text",
      "stylers": [
      {
        "visibility": "off"
      }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
      {
        "color": "#92998d"
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


function showOneLeg(request, map, color) {

  const directionsService = new google.maps.DirectionsService();
  directionsService.route(request, function(response, status) {
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
