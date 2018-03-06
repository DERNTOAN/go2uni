/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 44);
/******/ })
/************************************************************************/
/******/ ({

/***/ 1:
/*!*********************************************!*\
  !*** ./app/javascript/packs/map_toolkit.js ***!
  \*********************************************/
/*! exports provided: setupMap, showRouteOneCounterpart, showOneLeg */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "setupMap", function() { return setupMap; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "showRouteOneCounterpart", function() { return showRouteOneCounterpart; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "showOneLeg", function() { return showOneLeg; });
function setupMap(mapLocation, origin, zoom) {
    var styledMapType = new google.maps.StyledMapType([{
        "featureType": "all",
        "elementType": "all",
        "stylers": [{
            "hue": "#e7ecf0"
        }]
    }, {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [{
            "visibility": "off"
        }]
    }, {
        "featureType": "road",
        "elementType": "all",
        "stylers": [{
            "saturation": -70
        }]
    }, {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [{
            "visibility": "off"
        }]
    }, {
        "featureType": "water",
        "elementType": "all",
        "stylers": [{
            "visibility": "simplified"
        }, {
            "saturation": -60
        }]
    }], { name: 'Styled Map' });

    var mapOptions = {
        zoom: zoom,
        center: origin,
        fullscreenControl: false,
        streetViewControl: false,
        mapTypeControl: false,
        rotateControl: false,
        mapTypeControlOptions: {
            mapTypeIds: ['styled_map']
        }
    };

    var map = new google.maps.Map(mapLocation, mapOptions);
    //Associate the styled map with the MapTypeId and set it to display.
    map.mapTypes.set('styled_map', styledMapType);
    map.setMapTypeId('styled_map');
    return map;
};

function showOneLeg(request, map, color) {

    var directionsService = new google.maps.DirectionsService();
    directionsService.route(request, function (response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            var directionsDisplay = new google.maps.DirectionsRenderer();
            directionsDisplay.setMap(map);
            var DirectionsRendererOptions = {
                preserveViewport: true,
                polylineOptions: {
                    strokeColor: color,
                    strokeOpacity: 0.5,
                    strokeWeight: 4
                },
                suppressMarkers: true
            };
            directionsDisplay.setOptions(DirectionsRendererOptions);
            directionsDisplay.setDirections(response);
        }
    });
};

function showRouteOneCounterpart(map, from_self, to_self, counterpart) {

    var from_counterpart = new google.maps.LatLng(counterpart.from);
    var to_counterpart = new google.maps.LatLng(counterpart.to);

    var counterpart_from_marker = new google.maps.Marker({
        position: from_counterpart,
        map: map,
        icon: {
            url: counterpart.avatar,
            scaledSize: {
                width: 30,
                height: 30
            }
        } });

    var request_walk_to_car = {
        origin: from_self,
        destination: from_counterpart,
        travelMode: google.maps.TravelMode.WALKING
    };

    showOneLeg(request_walk_to_car, map, "#ff0000");

    var request_walk_to_dest = {
        origin: to_counterpart,
        destination: to_self,
        travelMode: google.maps.TravelMode.WALKING
    };
    showOneLeg(request_walk_to_dest, map, "#00ff00");

    var request_drive = {
        origin: from_counterpart,
        destination: to_counterpart,
        travelMode: google.maps.TravelMode.DRIVING
    };
    showOneLeg(request_drive, map, "#0000ff");
};



/***/ }),

/***/ 44:
/*!****************************************************!*\
  !*** ./app/javascript/packs/mapmyrequestsindex.js ***!
  \****************************************************/
/*! no exports provided */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__map_toolkit__ = __webpack_require__(/*! ./map_toolkit */ 1);


var mapElement = document.getElementById('mapmyrequestsindex');
if (mapElement) {
  // don't try to build a map if there's no div#map to inject in
  console.log(mapElement.dataset.markers_from);
  var from = JSON.parse(mapElement.dataset.markers_from)[0];
  var offers = JSON.parse(mapElement.dataset.markers_from);
  var from_self = new google.maps.LatLng(from);
  var mapbounds = JSON.parse(mapElement.dataset.mapbounds);
  var minbound = new google.maps.LatLng(mapbounds.min);
  var maxbound = new google.maps.LatLng(mapbounds.max);
  var bounds = new google.maps.LatLngBounds(minbound, maxbound);

  var map = Object(__WEBPACK_IMPORTED_MODULE_0__map_toolkit__["setupMap"])(mapElement, from_self, 14);
  map.fitBounds(bounds);
  var car_icon = { scaledSize: { width: 30, height: 30 }, url: "https://res.cloudinary.com/dekx98imz/image/upload/v1519916998/noun_128968_cc.png" };

  offers.forEach(function (offer) {
    var from_offer = new google.maps.LatLng(offer);
    var car_marker = new google.maps.Marker({ position: from_offer, map: map, icon: car_icon });
  });
}

/***/ })

/******/ });
//# sourceMappingURL=mapmyrequestsindex-2aab5e7a1e7f44dac9fb.js.map