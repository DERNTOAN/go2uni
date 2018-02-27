function inputShowRides(){
  let ride_button = document.getElementById("new-ride-button")
  if (ride_button){
    console.log(ride_button);
    let form = document.querySelector(".new-ride-form");
    ride_button.addEventListener("click",(event) => {
      event.preventDefault();
      console.log("clicked");
      form.classList.toggle("hidden");
      ride_button.classList.toggle("hidden");
    })

    let closer = document.querySelector("#close-button")
    closer.addEventListener("click",(event) => {
      form.classList.toggle("hidden");
      ride_button.classList.toggle("hidden");
    })
  }



}

export {inputShowRides}
