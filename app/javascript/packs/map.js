import { setupMap, showRouteOneCounterpart, showOneLeg } from "./map_toolkit"

const mapElement = document.getElementById('map-rides-index');
if (mapElement) { // don't try to build a map if there's no div#map to inject in

const counterparts = JSON.parse(mapElement.dataset.counterparts);
const map_origin      = new google.maps.LatLng(counterparts[0].from);
const car_icon = { scaledSize: { width: 30, height: 30 }, url: "https://res.cloudinary.com/dekx98imz/image/upload/v1519916998/noun_128968_cc.png" }
const map = setupMap(mapElement, map_origin, 8);

counterparts.forEach((counterpart) => {

    const from_counterpart   = new google.maps.LatLng(counterpart.from);
    const to_counterpart   = new google.maps.LatLng(counterpart.to);

    const request_drive = {
      origin:      from_counterpart,
      destination: to_counterpart,
      travelMode:  google.maps.TravelMode.DRIVING
    };
    const car_marker = new google.maps.Marker( { position: from_counterpart, map: map, icon: car_icon });
    // showOneLeg(request_drive, map, "#00ff00");
});
};

