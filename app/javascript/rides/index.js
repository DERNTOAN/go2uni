function inputShowRides(new_type, other_type){
  let button = document.getElementById(`${new_type}-button`)
  let other_button = document.getElementById(`${other_type}-button`)

  if (button){
    console.log(`.${new_type}-button`);
    let form = document.querySelector(`.${new_type}-form`);
    console.log(form)
    button.addEventListener("click",(event) => {
      event.preventDefault();
      console.log("clicked");
      form.classList.toggle("hidden");
      button.classList.toggle("hidden");
      other_button.classList.toggle("hidden");
    })

    let closer = document.querySelector(`#${new_type}-close-button`)
    closer.addEventListener("click",(event) => {
      form.classList.toggle("hidden");
      button.classList.toggle("hidden");
      other_button.classList.toggle("hidden");

    })
  }



}

export { inputShowRides }
