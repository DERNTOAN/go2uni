
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

      let self_icon = { url: "http://res.cloudinary.com/dekx98imz/image/upload/v1520200877/duotone_swim.svg",
                        scaledSize: { width: 70, height: 70 }

                      };
      if(from.avatar) {
        self_icon = { url: from.avatar, shape: {coords:[17,17,18],type:'circle'}, scaledSize: { width: 70, height: 70 } }
      }
      let map = setupMap(mapElement, from_self, 14);
      let self_marker = new google.maps.Marker( { position: from_self, map: map, icon: self_icon } );
      const counterparts = JSON.parse(mapElement.dataset.counterparts);
      addMarkersFrom(map, counterparts);

    const available_rides = JSON.parse(mapElement.dataset.rides_tags);
    available_rides.forEach((select_ride_id) => {
      const selectButton = document.getElementById(select_ride_id);
      selectButton.addEventListener("click", (event) => {
        const to = JSON.parse(mapElement.dataset.marker_to);
        const to_self      = new google.maps.LatLng(to);
        const dest_icon = { scaledSize: { width: 70, height: 70 }, url: "http://res.cloudinary.com/dekx98imz/image/upload/v1519862978/noun_758530_cc.png" }
        const self_to_marker = new google.maps.Marker( { position: to_self, map: map, icon: dest_icon });

      const driver = counterparts.find(function(counterpart) {
        return `select-ride-${counterpart.ride_id}` === select_ride_id;
      });
       map = setupMap(mapElement, from_self, map.getZoom());
       self_marker = new google.maps.Marker( { position: from_self, map: map, icon: self_icon } );

      showRouteOneCounterpart(map, from_self, to_self, driver);
      const minbound = new google.maps.LatLng({ lat: Math.max(driver.from.lat, from.lat), lng: Math.min(driver.from.lng, from.lng) } );
      const maxbound = new google.maps.LatLng({ lat: Math.min(driver.from.lat, from.lat), lng: Math.max(driver.from.lng, from.lng) });
      const bounds = new google.maps.LatLngBounds(minbound, maxbound);

      map.fitBounds(bounds);


    })

    })
  }

}
selectRide()
