function navbarHide(){
  let navbar_button = document.querySelector(".navbar-opener");
  if (navbar_button){
    navbar_button.addEventListener("click",(event)=>{
      console.log("test");
      let navbar = document.querySelector(".navbar-wagon");
      navbar.classList.toggle("hidden");

    })
  }

  let closer_button = document.querySelector(".navbar-closer");
  if (closer_button){
    closer_button.addEventListener("click",(event)=>{
      console.log("test");
      let navbar = document.querySelector(".navbar-wagon");
      navbar.classList.toggle("hidden");

    })
  }

}

export { navbarHide }
