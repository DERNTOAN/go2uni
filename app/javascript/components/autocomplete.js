function autocomplete(id) {
  document.addEventListener("DOMContentLoaded", function() {
    var rideTo = document.getElementById(id);

    if (rideTo) {
      var autocomplete = new google.maps.places.Autocomplete(rideTo, { types: [ 'geocode' ] });
      rideTo.addEventListener('keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
