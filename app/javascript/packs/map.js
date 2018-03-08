import { setupMap, showRouteOneCounterpart, showOneLeg } from "./map_toolkit"

const mapElement = document.getElementById('map-rides-index');
if (mapElement) { // don't try to build a map if there's no div#map to inject in

const counterparts = JSON.parse(mapElement.dataset.counterparts);
const mapcenter_json = JSON.parse(mapElement.dataset.mapcenter);
const mapcenter      = new google.maps.LatLng(mapcenter_json);
console.log(mapcenter)
const car_icon = { scaledSize: { width: 50, height: 50 }, url: "/assets/map_penguin5.png" }
const mapbounds = JSON.parse(mapElement.dataset.mapbounds);
const minbound      = new google.maps.LatLng(mapbounds.min);
const maxbound      = new google.maps.LatLng(mapbounds.max);
const bounds = new google.maps.LatLngBounds(minbound, maxbound);
const map = setupMap(mapElement, mapcenter, 14);
counterparts.forEach((counterpart) => {

    const from_counterpart   = new google.maps.LatLng(counterpart.from);
    const to_counterpart   = new google.maps.LatLng(counterpart.to);

    const request_drive = {
      origin:      from_counterpart,
      destination: to_counterpart,
      travelMode:  google.maps.TravelMode.DRIVING
    };
    const car_marker = new google.maps.Marker( { position: from_counterpart, map: map, icon: car_icon });
});
};

