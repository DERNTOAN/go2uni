function hideDeclinedOffers() {
  const mapElement = document.getElementById('mapshowmyrequest');
  if (mapElement) {


  const available_rides = JSON.parse(mapElement.dataset.rides_tags);
  console.log(available_rides)
  available_rides.forEach((ride) => {
    const thisRide = document.getElementById(ride);
    const declineBtn = thisRide.querySelector(".decline-btn");
    console.log(declineBtn)
    declineBtn.addEventListener("click", (event) => {
      console.log(declineBtn);
      event.preventDefault();
      event.stopImmediatePropagation();
      thisRide.classList.add("animated");
      thisRide.classList.add("fadeOutLeft")
      setTimeout(function() {
        thisRide.style.display = 'none'
      }, 300)
    const ride = JSON.parse(declineBtn.dataset.ride);
    const offer = JSON.parse(declineBtn.dataset.offer);
    const url = `/rides/${ride}/offers/${offer}?confirmed=false`;
      fetch(url, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          'X-CSRF-Token': document.getElementsByTagName('meta')[19].content
        },
        credentials: 'same-origin'
      })
      .then(response => response.json())
      .then((data) => {
      console.log(data); // Look at local_names.default
      });
    });
  });
};
}


export { hideDeclinedOffers };
