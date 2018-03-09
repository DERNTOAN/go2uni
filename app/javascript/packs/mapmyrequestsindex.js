import { setupMap, showRouteOneCounterpart, showOneLeg } from "./map_toolkit"


const mapElement = document.getElementById('mapmyrequestsindex');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
console.log(mapElement.dataset.markers_from)
const from = JSON.parse(mapElement.dataset.markers_from)[0];
const offers = JSON.parse(mapElement.dataset.markers_from);
const from_self      = new google.maps.LatLng(from);
const mapbounds = JSON.parse(mapElement.dataset.mapbounds);
const minbound      = new google.maps.LatLng(mapbounds.min);
const maxbound      = new google.maps.LatLng(mapbounds.max);
const bounds = new google.maps.LatLngBounds(minbound, maxbound);


const map = setupMap(mapElement, from_self, 14);
map.fitBounds(bounds);
const car_icon = { scaledSize: { width: 30, height: 30 }, url: "http://res.cloudinary.com/dlv6654pn/image/upload/v1520588356/map_penguin5.png" }

offers.forEach( (offer) => {
  const from_offer   = new google.maps.LatLng(offer)
  const car_marker = new google.maps.Marker( { position: from_offer, map: map, icon: car_icon });

});


}
