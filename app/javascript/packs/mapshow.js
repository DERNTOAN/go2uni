
const mapElement = document.getElementById('mapshow');

if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const from = JSON.parse(mapElement.dataset.marker_from_driver);
const to = JSON.parse(mapElement.dataset.marker_to);
const passengers = JSON.parse(mapElement.dataset.markers_from_passengers);

console.log(passengers)

const directionsDisplay = new google.maps.DirectionsRenderer();
const directionsService = new google.maps.DirectionsService();

const from_driver      = new google.maps.LatLng(from);
const destination = new google.maps.LatLng(to);

const mapOptions = {
  zoom: 13,
  center: from_driver
}

const map = new google.maps.Map(mapElement, mapOptions);
directionsDisplay.setMap(map);

const request = {
  origin:      from_driver,
  destination: destination,
  travelMode:  google.maps.TravelMode.DRIVING
};

directionsService.route(request, function(response, status) {
  if (status == google.maps.DirectionsStatus.OK) {
    directionsDisplay.setDirections(response);
  }
});

passengers.forEach( (passenger_from) => {
const from_passenger   = new google.maps.LatLng(passenger_from);
const directionsDisplay2 = new google.maps.DirectionsRenderer();
directionsDisplay2.setMap(map);

const DirectionsRendererOptions = {
  strokeColor: "ff0000"
};

directionsDisplay2.setOptions(DirectionsRendererOptions);


  const request_passenger = {
    origin:      from_passenger,
    destination: from_driver,
    travelMode:  google.maps.TravelMode.WALKING
  };

  directionsService.route(request_passenger, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay2.setDirections(response);
    }
  });

});



}
