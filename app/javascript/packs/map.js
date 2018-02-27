import GMaps from 'gmaps/gmaps.js';

// var directionsDisplay = new google.maps.DirectionsRenderer();
// var directionsService = new google.maps.DirectionsService();

// function calcRoute(from_lat, from_lng, to_lat, to_lng) {
//   var origin      = new google.maps.LatLng(from_lat, from_lng);
//   var destination = new google.maps.LatLng(to_lat, to_lng);
//   var request = {
//       origin:      origin,
//       destination: destination,
//       travelMode:  google.maps.TravelMode.DRIVING
//   };
//   directionsService.route(request, function(response, status) {
//     if (status == google.maps.DirectionsStatus.OK) {
//       directionsDisplay.setDirections(response);
//     }
//   });
// };

const mapElement = document.getElementById('map');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
  const markers_from = JSON.parse(mapElement.dataset.markers_from);
  const markers_to = JSON.parse(mapElement.dataset.markers_to);

  map.addMarkers(markers_from);
  map.addMarkers(markers_to);



// calcRoute(markers_from[0].lat, markers_from[0].lng, markers_to[0].lat, markers_to[0].lng);

// var handler = Gmaps.build('Google');
// handler.buildMap({ internal: {id: 'directions'}}, function(){
//   directionsDisplay.setMap(handler.getMap());
// })

  // map.addPolylines([{ markers_from[0].lat, markers_from[0].lng }, { markers_to[0].lat, markers_to[0].lng } ]);

  if (markers_from.length === 0) {
    map.setZoom(2);
  } else {
    map.setCenter(markers_from[0].lat, markers_from[0].lng);
    map.setZoom(5);
    map.fitLatLngBounds(markers_from);
  }
}

