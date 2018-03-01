
import { setupMap, showRouteOneCounterpart, showOneLeg } from "./map_toolkit"

function addMarkersFrom(map, counterparts) {
  counterparts.forEach( (counterpart) => {
    const counterpart_from      = new google.maps.LatLng(counterpart.from);
    const counterpart_icon = { url: counterpart.avatar, scaledSize: { width: 30, height: 30 } };
    const counterpart_marker = new google.maps.Marker( { position: counterpart_from, map: map, icon: counterpart_icon } );
  });
};

function selectRide() {
  const mapElement = document.getElementById('mapshowmyrequest');
    if (mapElement) { // don't try to build a map if there's no div#map to inject in
      const from = JSON.parse(mapElement.dataset.marker_from_self);
      const from_self      = new google.maps.LatLng(from);
      const self_icon = { url: from.avatar, scaledSize: { width: 70, height: 70 } }
      let map = setupMap(mapElement, from_self, 11);
      let self_marker = new google.maps.Marker( { position: from_self, map: map, icon: self_icon } );
      const counterparts = JSON.parse(mapElement.dataset.counterparts);
      addMarkersFrom(map, counterparts);

    const available_rides = JSON.parse(mapElement.dataset.rides_tags);
    available_rides.forEach((select_ride_id) => {
      const selectButton = document.getElementById(select_ride_id);
      console.log(selectButton)
      selectButton.addEventListener("click", (event) => {
        const to = JSON.parse(mapElement.dataset.marker_to);
        const to_self      = new google.maps.LatLng(to);
        const dest_icon = { scaledSize: { width: 70, height: 70 }, url: "http://res.cloudinary.com/dekx98imz/image/upload/v1519862978/noun_758530_cc.png" }
        const self_to_marker = new google.maps.Marker( { position: to_self, map: map, icon: dest_icon });
        console.log(counterparts)

      const driver = counterparts.find(function(counterpart) {
        return `select-ride-${counterpart.ride_id}` === select_ride_id;
      });
       map = setupMap(mapElement, from_self, map.getZoom());
       self_marker = new google.maps.Marker( { position: from_self, map: map, icon: self_icon } );

      showRouteOneCounterpart(map, from_self, to_self, driver);

    })

    })

  }

}
selectRide()
