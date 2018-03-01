

//  Subroutine to compute one travel leg for one counterpart
function setupMap(location, origin, zoom) {
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
      const mapOptions = { zoom: zoom, center: origin,
        mapTypeControlOptions: {
        mapTypeIds: ['roadmap', 'satellite', 'hybrid', 'terrain',
        'styled_map']
        }}

      const map = new google.maps.Map(location, mapOptions);
      //Associate the styled map with the MapTypeId and set it to display.
      map.mapTypes.set('styled_map', styledMapType);
      map.setMapTypeId('styled_map');
    return map
};

function showOneLeg(response, status, map, color) {
  if (status == google.maps.DirectionsStatus.OK) {

    const directionsDisplay = new google.maps.DirectionsRenderer();
    directionsDisplay.setMap(map);

    const DirectionsRendererOptions = {
      polylineOptions: {
        strokeColor: color,
        strokeOpacity: 0.5,
        strokeWeight: 4
      },
      suppressMarkers: true
    };
      // console.log(DirectionsRendererOptions);
      console.log(response)
      directionsDisplay.setOptions(DirectionsRendererOptions);
      directionsDisplay.setDirections(response);
      return response.routes[0].legs.map(leg => leg.duration.value);
    }

  };

function showRouteOneCounterpart(map, from_self, to_self, travel_time, counterpart){
    const directionsService = new google.maps.DirectionsService();

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

    const request_walk_to_dest = {
      origin:      to_counterpart,
      destination: to_self,
      travelMode:  google.maps.TravelMode.WALKING
    };

    const request_drive = {
      origin:      from_counterpart,
      destination: to_counterpart,
      travelMode:  google.maps.TravelMode.DRIVING
    };

    travel_time[counterpart.first_name] = {}
    directionsService.route(request_walk_to_car, function(response, status) {
      const time_walk_to_car = showOneLeg(response, status, map, "#ff0000");
      if(time_walk_to_car) {
        travel_time[counterpart.first_name]['time_walk_to_car'] = time_walk_to_car.reduce((a, b) => a + b, 0);
      }
    });



    directionsService.route(request_walk_to_dest, function(response, status) {
      const time_walk_to_dest = showOneLeg(response, status, map, "#00ff00")
      if(time_walk_to_dest) {

        travel_time[counterpart.first_name]['time_walk_to_dest'] = time_walk_to_dest.reduce((a, b) => a + b, 0);
      }

    });

    directionsService.route(request_drive, function(response, status) {
      const time_drive = showOneLeg(response, status, map, "#0000ff");
      if(time_drive) {

        travel_time[counterpart.first_name]['time_drive'] = time_drive.reduce((a, b) => a + b, 0);
      }
    });}

function drawAllRoutes(from, to) {

  const mapElement = document.getElementById('mapshowmyrequest');
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    const from = JSON.parse(mapElement.dataset.marker_from_self);
    const to = JSON.parse(mapElement.dataset.marker_to);
    const counterparts = JSON.parse(mapElement.dataset.counterparts);

    const from_self      = new google.maps.LatLng(from);
    const to_self      = new google.maps.LatLng(to);

    const self_icon = { url: from.avatar, scaledSize: { width: 70, height: 70 } }
    const dest_icon = { scaledSize: { width: 70, height: 70 }, url: "http://res.cloudinary.com/dekx98imz/image/upload/v1519862978/noun_758530_cc.png" }

    const map = setupMap(mapElement, from_self, 8);
    const self_marker = new google.maps.Marker( { position: from_self, map: map, icon: self_icon } );
    const self_to_marker = new google.maps.Marker( { position: to_self, map: map, icon: dest_icon });
    const travel_time = {};

    counterparts.forEach( (counterpart) => {
      showRouteOneCounterpart(map, from_self, to_self, travel_time, counterpart);
    });
  }
}

function selectRide() {
  drawAllRoutes()
  const mapElement = document.getElementById('mapshowmyrequest');
  if (mapElement) {
    const available_rides = JSON.parse(mapElement.dataset.rides_tags);
    console.log(available_rides)
    available_rides.forEach((select_ride_id) => {
      const selectButton = document.getElementById(select_ride_id);
      console.log(selectButton)
      selectButton.addEventListener("click", (event) => {
        const from = JSON.parse(mapElement.dataset.marker_from_self);
        const to = JSON.parse(mapElement.dataset.marker_to);

        const from_self      = new google.maps.LatLng(from);
        const to_self      = new google.maps.LatLng(to);

        const self_icon = { url: from.avatar, scaledSize: { width: 70, height: 70 } }
        const dest_icon = { scaledSize: { width: 70, height: 70 }, url: "http://res.cloudinary.com/dekx98imz/image/upload/v1519862978/noun_758530_cc.png" }

        const map = setupMap(mapElement, from_self, 8);
        const self_marker = new google.maps.Marker( { position: from_self, map: map, icon: self_icon } );
        const self_to_marker = new google.maps.Marker( { position: to_self, map: map, icon: dest_icon });
        const travel_time = {};
        const counterparts = JSON.parse(mapElement.dataset.counterparts);
        console.log(counterparts)

        // const driver = counterparts.find(function(counterpart) {
        //   counterpart.id ===
        //   return element > 10;
        // });

        showRouteOneCounterpart(map, from_self, to_self, travel_time, driver);

      })

    })
  }


}
selectRide()
