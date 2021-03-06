
import { setupMap, showRouteOneCounterpart, showOneLeg } from "./map_toolkit"

function addMarkersFrom(map, counterparts) {
  counterparts.forEach( (counterpart) => {
    const counterpart_from      = new google.maps.LatLng(counterpart.from);
    const counterpart_icon = { url: counterpart.avatar, scaledSize: { width: 40, height: 40 }, optimized: false };
    const counterpart_marker = new google.maps.Marker( { position: counterpart_from, map: map, icon: counterpart_icon , optimized: false });
    const myoverlay = new google.maps.OverlayView();
    myoverlay.draw = function () {
        this.getPanes().markerLayer.id='markerLayer';
    };
    myoverlay.setMap(map);
  });
};

function selectRide() {
  const mapElement = document.getElementById('mapshowmyrequest');
    if (mapElement) { // don't try to build a map if there's no div#map to inject in
      const from = JSON.parse(mapElement.dataset.marker_from_self);
      const from_self      = new google.maps.LatLng(from);
      let self_icon = { url: "http://res.cloudinary.com/dlv6654pn/image/upload/v1520588356/map_penguin5.png", scaledSize: { width: 70, height: 70 } }

      if(from.avatar) {
        self_icon = { url: from.avatar, shape: {coords:[17,17,18],type:'circle'}, scaledSize: { width: 60, height: 60 } }
      }
      let map = setupMap(mapElement, from_self, 15);
      let self_marker = new google.maps.Marker( { position: from_self, map: map, icon: self_icon } );
      const counterparts = JSON.parse(mapElement.dataset.counterparts);
      addMarkersFrom(map, counterparts);

    const available_rides = JSON.parse(mapElement.dataset.rides_tags);
    available_rides.forEach((select_ride_id) => {
      const selectButton = document.getElementById(select_ride_id);
      selectButton.addEventListener("click", (event) => {
        const to = JSON.parse(mapElement.dataset.marker_to);
        const to_self      = new google.maps.LatLng(to);
        const dest_icon = { scaledSize: { width: 60, height: 60 }, url: "http://res.cloudinary.com/dlv6654pn/image/upload/v1520588484/to.png" }
        const self_to_marker = new google.maps.Marker( { position: to_self, map: map, icon: dest_icon, optimized: false });

      const driver = counterparts.find(function(counterpart) {
        return `select-ride-${counterpart.ride_id}` === select_ride_id;
      });
       map = setupMap(mapElement, from_self, map.getZoom());
       self_marker = new google.maps.Marker( { position: from_self, map: map, icon: self_icon, optimized: false } );

      showRouteOneCounterpart(map, from_self, to_self, driver);
      const minbound = new google.maps.LatLng({ lat: Math.max(driver.from.lat, from.lat), lng: Math.min(driver.from.lng, from.lng) } );
      const maxbound = new google.maps.LatLng({ lat: Math.min(driver.from.lat, from.lat), lng: Math.max(driver.from.lng, from.lng) });
      const bounds = new google.maps.LatLngBounds(minbound, maxbound);
      const overlayOneRoute = new google.maps.OverlayView();
      overlayOneRoute.draw = function () {
          this.getPanes().markerLayer.id='markerLayer';
      };
      overlayOneRoute.setMap(map);

      map.fitBounds(bounds);


    })

    })
  }

}
selectRide()
