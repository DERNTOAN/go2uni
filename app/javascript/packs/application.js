/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import "bootstrap";
import { inputShowRides } from "../rides/index";
import { autocomplete } from "../components/autocomplete";
import { tinderSwipe } from "../suggestions/tinder"
import {Card, Direction, Stack} from "../swipe/index"
// import { mapshowride } from "./mapshow";

inputShowRides();
autocomplete("ride_from_address");
autocomplete("ride_to_address");
autocomplete("request_from_address");
autocomplete("request_to_address");
// mapshowride();
tinderSwipe();
