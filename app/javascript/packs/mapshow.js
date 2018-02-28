const mapElement = document.getElementById('mapshow');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const from = JSON.parse(mapElement.dataset.marker_from_driver);
const to = JSON.parse(mapElement.dataset.marker_to);
const passengers = JSON.parse(mapElement.dataset.passengers);

const directionsDisplay = new google.maps.DirectionsRenderer();
const directionsService = new google.maps.DirectionsService();

const from_driver      = new google.maps.LatLng(from);
const destination = new google.maps.LatLng(to);

const mapOptions = {
  zoom: 11,
  center: from_driver,
  fullscreenControl: false, streetViewControl: false, mapTypeControl: false,
  rotateControl: false
}

const driver_icon = {
  url: "http://res.cloudinary.com/dekx98imz/image/upload/v1519828601/noun_128968_cc.png",
  scaledSize: {
    width: 50,
    height: 50
  }
}


const map = new google.maps.Map(mapElement, mapOptions);
directionsDisplay.setMap(map);

const driver = new google.maps.Marker({
  position: from_driver,
  map: map,
  animation: google.maps.Animation.BOUNCE,
  icon: driver_icon
});

console.log(driver_icon)
const request = {
  origin:      from_driver,
  destination: destination,
  travelMode:  google.maps.TravelMode.DRIVING
};

directionsService.route(request, function(response, status) {
  if (status == google.maps.DirectionsStatus.OK) {
    directionsDisplay.setDirections(response);
    directionsDisplay.setOptions({suppressMarkers: true})

  }
});

passengers.forEach( (passenger) => {
const from_passenger   = new google.maps.LatLng(passenger.from);


const icon = {
  url: passenger.avatar,
  scaledSize: {
    width: 80,
    height: 80
  }
}

const passager_from_marker = new google.maps.Marker({
  position: from_passenger,
  map: map,
  animation: google.maps.Animation.BOUNCE,
  icon: icon
});

const directionsDisplay2 = new google.maps.DirectionsRenderer();
directionsDisplay2.setMap(map);

const polylineOptions = {
  strokeColor: "#ff0000",
  strokeOpacity: 0.5,
  strokeWeight: 4
};

// const markerOptions = {
//   animation: google.maps.Animation.BOUNCE,
//   icon: passenger.avatar, width: 100
// };

const DirectionsRendererOptions = {
  polylineOptions: polylineOptions,
  suppressMarkers: true
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
