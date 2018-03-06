import { setupMap, showRouteOneCounterpart, showOneLeg } from "./map_toolkit"

function showRouteManyCounterparts(counterpart, map, i) {
  const from = new google.maps.LatLng(counterpart.from);
  const to = new google.maps.LatLng(counterpart.to);
  const from_icon = { scaledSize: { width: 30, height: 30 }, url: "http://res.cloudinary.com/dekx98imz/image/upload/v1520200877/duotone_swim.svg" }

  const from_marker = new google.maps.Marker( { position: from, map: map, icon: from_icon });
  const request_drive = {
    origin:      from,
    destination: to,
    travelMode:  google.maps.TravelMode.DRIVING
  };
  let color = "#0000ff";
  if (counterpart.direction === "to") {
    color = "#ff0000";
  }
  if(i<6) {
    showOneLeg(request_drive, map, color, 0);
    i += 1;
  } else {
    setTimeout(function() {

      showOneLeg(request_drive, map, color, i)
    }, 1000 * i - 5000);
  };

};

function showOneDirectionRoutes(element, mapElement, counterparts) {

  const htmlElement = document.getElementById(element);
  if (htmlElement) {
    if (element === "show-from-button" || element === "show-to-button"){
      let direction = "to";
      if (element === "show-from-button") {
        direction = "from";
      };

      htmlElement.addEventListener("click", (event) => {
        counterparts = counterparts.filter((counterpart) => {
          return counterpart.direction === direction
        });
        let map = setupMapForIndex(mapElement, counterparts);
        let i = 0;
        counterparts.forEach((counterpart) => {
          showRouteManyCounterparts(counterpart, map, i);
          i += 1;
        });

      });

    }

    if (element === "ride_direction_from" || element === "ride_direction_to"){

      let direction = "to";
      if (element === "ride_direction_from") {
        direction = "from";
      };


      htmlElement.addEventListener("click", (event) => {
      const address = document.getElementById("ride_from_address").value;
      console.log(address)

        counterparts = counterparts.filter((counterpart) => {
          return counterpart.direction === direction;
        });
        let map = setupMapForIndex(mapElement, counterparts);
        let i = 0;
        counterparts.forEach((counterpart) => {
          showRouteManyCounterparts(counterpart, map, i);
          i += 1;
        });

      });
    };

  };
};

function setupMapForIndex(mapElement, counterparts) {
  const map_origin      = new google.maps.LatLng(counterparts[0].from);
  const uni      = new google.maps.LatLng({ lat: 49.928771, lng: 11.585840 });
  const to_icon = { scaledSize: { width: 30, height: 30 }, url: "http://res.cloudinary.com/dekx98imz/image/upload/v1519916998/noun_128968_cc.png" }
  const uni_marker = new google.maps.Marker( { position: uni, map: map, icon: to_icon });
  const mapbounds = JSON.parse(mapElement.dataset.mapbounds);
  const minbound      = new google.maps.LatLng(mapbounds.min);
  const maxbound      = new google.maps.LatLng(mapbounds.max);
  const bounds = new google.maps.LatLngBounds(minbound, maxbound);
  const map = setupMap(mapElement, map_origin, 13);
  map.fitBounds(bounds);
  console.log(map);
  return map;
};



const mapElement = document.getElementById('map-rides-index');
if (mapElement) { // don't try to build a map if there's no div#map to inject in


  let counterparts = JSON.parse(mapElement.dataset.counterparts);
let map = setupMapForIndex(mapElement, counterparts);
  //
  let i = 0;
  // counterparts.forEach((counterpart) => {
  //   showRouteManyCounterparts(counterpart, map, i);
  //   i += 1;
  // });
  showOneDirectionRoutes("show-to-button", mapElement, counterparts);
  showOneDirectionRoutes("show-from-button", mapElement, counterparts);
  showOneDirectionRoutes("ride_direction_from", mapElement, counterparts);
  showOneDirectionRoutes("ride_direction_to", mapElement, counterparts);
};


