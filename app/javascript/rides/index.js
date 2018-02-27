function inputShowRides(){
  let ride_button = document.getElementById("new-ride-button")
  if (ride_button){
    console.log(ride_button);
    ride_button.addEventListener("click",(event) => {
      event.preventDefault();
      console.log("clicked");
      let form = document.querySelector(".new-ride-form");
      form.classList.toggle("hidden")
    })






  }



}

export {inputShowRides}
