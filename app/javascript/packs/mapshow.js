import { setupMap, showRouteOneCounterpart, showOneLeg } from "./map_toolkit"


const mapElement = document.getElementById('mapshow');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
const from = JSON.parse(mapElement.dataset.marker_from_self);
const to = JSON.parse(mapElement.dataset.marker_to);
const counterparts = JSON.parse(mapElement.dataset.counterparts);
const from_self      = new google.maps.LatLng(from);
const destination = new google.maps.LatLng(to);
const self_icon = { url: "http://res.cloudinary.com/dlv6654pn/image/upload/v1520588356/map_penguin5.png", scaledSize: { width: 50, height: 50 } };
const map = setupMap(mapElement, from_self, 14);


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
      width: 40,
      height: 40
    }
  }
  if (counterpart.avatar) {

  const counterpart_from_marker = new google.maps.Marker({
    position: from_counterpart,
    map: map,
    icon: counterpart_icon,
    optimized: false

  });
  }
  else {
      const counterpart_from_marker = new google.maps.Marker({
    position: from_counterpart,
    map: map,
    icon: self_icon,
    optimized: false

  });

  }

});
const myoverlay = new google.maps.OverlayView();
    myoverlay.draw = function () {
        this.getPanes().markerLayer.id='markerLayer';
    };
myoverlay.setMap(map);

}
