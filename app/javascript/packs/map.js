import GMaps from 'gmaps/gmaps.js';


const mapElement = document.getElementById('map');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
const markers_from = JSON.parse(mapElement.dataset.markers_from);
const markers_to = JSON.parse(mapElement.dataset.markers_to);

if (markers_from.length === 1) {
  const from = markers_from[0];
  const to = markers_to[0];
  map.addMarker(from);
  map.addMarker(to);
  console.log(from.lat);

  const directionsDisplay = new google.maps.DirectionsRenderer();
const directionsService = new google.maps.DirectionsService();

  const origin      = new google.maps.LatLng(from.lat, from.lng);
  const destination = new google.maps.LatLng(to.lat, to.lng);

  const request = {
    origin:      origin,
    destination: destination,
    travelMode:  google.maps.TravelMode.DRIVING
  };
console.log(request)

  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      console.log(map)
      directionsDisplay.setDirections(response);
      directionsDisplay.setMap(map);
}
});


}

else {

  map.addMarkers(markers_from );
  map.addMarkers(markers_to);

}

  if (markers_from.length === 0) {
    map.setZoom(2);
  } else {
    map.setCenter(markers_from[0].lat, markers_from[0].lng);
    map.setZoom(5);
    map.fitLatLngBounds(markers_from);
  }
}

