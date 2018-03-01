import { setupMap, showRouteOneCounterpart, showOneLeg } from "./map_toolkit"


const mapElement = document.getElementById('mapshow');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
const from = JSON.parse(mapElement.dataset.marker_from_self);
const to = JSON.parse(mapElement.dataset.marker_to);
const counterparts = JSON.parse(mapElement.dataset.counterparts);
const from_self      = new google.maps.LatLng(from);
const destination = new google.maps.LatLng(to);
const self_icon = { url: "https://res.cloudinary.com/dekx98imz/image/upload/v1519916998/noun_128968_cc.png", scaledSize: { width: 50, height: 50 } }
const map = setupMap(mapElement, from_self, 8)
const self_marker = new google.maps.Marker({ position: from_self, map: map, icon: self_icon });

const request = { origin: from_self, destination: destination, travelMode:  google.maps.TravelMode.DRIVING };

showOneLeg(request, map, "#0000ff");

counterparts.forEach( (counterpart) => {
  const from_counterpart   = new google.maps.LatLng(counterpart.from);
  const request_counterpart = {
    origin:      from_counterpart,
    destination: from_self,
    travelMode:  google.maps.TravelMode.WALKING
  };

  showOneLeg(request_counterpart, map, "#ff0000");

  const counterpart_icon = {
    url: counterpart.avatar,
    scaledSize: {
      width: 30,
      height: 30
    }
  }
  const counterpart_from_marker = new google.maps.Marker({
    position: from_counterpart,
    map: map,
    icon: counterpart_icon
  });

});



}
