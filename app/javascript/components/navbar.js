function navbarHide(){
  let navbar_button = document.querySelector(".navbar-opener");
  if (navbar_button){
    navbar_button.addEventListener("click",(event)=>{
      console.log("test");
      let navbar = document.querySelector(".navbar-wagon");
      navbar.classList.remove("hidden");
      navbar.classList.remove("slideOutUp");

    })
  }

  let closer_button = document.querySelector(".navbar-closer");
  if (closer_button){
    closer_button.addEventListener("click",(event)=>{
      console.log("test");
      let navbar = document.querySelector(".navbar-wagon");
      navbar.classList.toggle("slideOutUp");

    })
  }

}

export { navbarHide }
