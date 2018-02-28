
function showRoute(response, status, map, color) {
  //   if (status == google.maps.DirectionsStatus.OK) {
  // console.log(response.routes[0].legs.map(leg => leg.duration.value))

  // const directionsDisplay = new google.maps.DirectionsRenderer();
  //     directionsDisplay.setMap(map);

  //     const DirectionsRendererOptions = {
  //       polylineOptions: {
  //         strokeColor: "ff0000",
  //         strokeOpacity: 0.5,
  //         strokeWeight: 4
  //       },
  //       suppressMarkers: true
  //     };
  //     // console.log(DirectionsRendererOptions);
  //     directionsDisplay.setOptions(DirectionsRendererOptions);
  //     directionsDisplay.setDirections(response);
  //   }
  };




const mapElement = document.getElementById('mapshowmyrequest');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const from = JSON.parse(mapElement.dataset.marker_from_self);
const to = JSON.parse(mapElement.dataset.marker_to);
const counterparts = JSON.parse(mapElement.dataset.counterparts);
const directionsService = new google.maps.DirectionsService();

const from_self      = new google.maps.LatLng(from);
const to_self      = new google.maps.LatLng(to);
const destination = new google.maps.LatLng(to);

const mapOptions = {
  zoom: 8,
  center: from_self
}

const self_icon = {
  url: from.avatar,
  scaledSize: {
    width: 70,
    height: 70
  }
}

const map = new google.maps.Map(mapElement, mapOptions);



const self_marker = new google.maps.Marker(
{
  position: from_self,
  map: map,
  icon: self_icon
}

);

const self_to_marker = new google.maps.Marker(
{
  position: to_self,
  map: map,
  icon: self_icon
}

);

const travel_time = {};


counterparts.forEach( (counterpart) => {

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
    }

  });

  const request_walk = {
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

  directionsService.route(request_walk, function(response, status) {
    console.log(counterpart.first_name);
    showRoute(response, status, map, "ff0000")
  });

  directionsService.route(request_drive, function(response, status) {
    showRoute(response, status, map, "0000ff")
  });

  directionsService.route(request_walk_to_dest, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
  console.log(response.routes[0].legs.map(leg => leg.duration.value))

  const directionsDisplay = new google.maps.DirectionsRenderer();
      directionsDisplay.setMap(map);

      const DirectionsRendererOptions = {
        polylineOptions: {
          strokeColor: "ff0000",
          strokeOpacity: 0.5,
          strokeWeight: 4
        },
        suppressMarkers: true
      };
      console.log(DirectionsRendererOptions);
      directionsDisplay.setOptions(DirectionsRendererOptions);
      directionsDisplay.setDirections(response);
    }
  });





});



}
