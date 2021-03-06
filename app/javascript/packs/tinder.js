import {Card, Direction, Stack} from "../swipe/index";



function tinderSwipe(){
  let right_buttons = document.querySelectorAll(".right-button");
  let left_buttons = document.querySelectorAll(".left-button");
  let segments = document.querySelectorAll(".dynamic");
  let seated_counter = 0;
  const submitButton = document.getElementById("submit-button")
  const noMorePassengerCover = document.querySelector(".no-more-passenger-cover")
  let suggestionsLeft = noMorePassengerCover.dataset.nbsugg;
  window.swing = require('swing');
  var Swing = window.swing;
  const cards = [].slice.call(document.querySelectorAll('.swipe-card-element'));
  const numberOfCards = cards.length;
  let card_counter = 0;
  if (suggestionsLeft == 0) {
  console.log(suggestionsLeft);
    noMorePassengerCover.classList.remove("hidden");
  const returnBtn = document.querySelector(".return-btn")
  returnBtn.classList.remove("hidden");
  };

  const config = {
    throwOutConfidence: (xOffset, yOffset, element) => {
                //decide if throw was successful
                const xConfidence = Math.min((Math.abs(xOffset) / element.offsetWidth)*2, 1);
                const yConfidence = Math.min((Math.abs(yOffset) / element.offsetHeight)*2, 1);
                return Math.max(xConfidence, yConfidence);
              }
            };


  // An instance of the Stack is used to attach event listeners.
  const stack = Swing.Stack(config);

  cards.forEach((targetElement) => {
    // Add card element to the Stack.
    stack.createCard(targetElement);
  });


  // Add event listener for when a card is thrown out of the stack.
  stack.on('throwout', (event) => {
    // e.target Reference to the element that has been thrown out of the stack.
    // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).
    // console.log(event);
    // console.log(event.target.parentElement.previousElementSibling);
    console.log('Card has been thrown out of the stack.');
    console.log('Throw direction: ' + (event.throwDirection.toString() == Direction.LEFT.toString() ? 'left' : 'right'));
    // console.log(event.throwDirection.toString());
    // console.log(Direction.LEFT.toString());

    // console.log(event.throwDirection == Direction.LEFT);
    // console.log(event.throwDirection.toString() == Direction.LEFT.toString());

    if (event.throwDirection.toString() == Direction.LEFT.toString() ){
      if (seated_counter < segments.length){
        console.log("left");
        event.target.parentElement.previousElementSibling.checked = false;
        suggestionsLeft -= 1;


      };
    } else if (event.throwDirection.toString() == Direction.RIGHT.toString()){
      suggestionsLeft -= 1;


      if (seated_counter < segments.length){
        console.log("right");
        console.log(event.target.firstElementChild);
        event.target.firstElementChild.checked = true;
        segments[seated_counter].style = "width: 100%"
        seated_counter += 1;
        submitButton.classList.remove("hidden");

        if (seated_counter === segments.length){
          document.querySelectorAll(".max-passenger-cover").forEach((element) => {
            element.classList.toggle("hidden");
          });
        };
      };
    };

    if (suggestionsLeft === 0) {
      noMorePassengerCover.classList.remove("hidden")
    };
    card_counter += 1;
    // console.log(event.target.parentElement.previousElementSibling.checked);

    // event.target.classList.add("animated2");
    // event.target.classList.add("fadeOutRight");
    setTimeout(function() {
      event.target.style.display = 'none'
    }, 300)


  });

  // Add event listener for when a card is thrown in the stack, including the spring back into place effect.
  stack.on('throwin', () => {
    console.log('Card has snapped back to the stack.');
  });


  if (right_buttons){
    right_buttons.forEach((right_button)=> {
      right_button.addEventListener("click", (event) =>{
        console.log("pressed:", right_button)
        stack.getCard(cards[cards.length - 1 - card_counter]).throwOut(50, 0);
        submitButton.classList.remove("hidden");

      });
    });
  }

  if (left_buttons){
    left_buttons.forEach((left_button)=> {
      left_button.addEventListener("click", (event) =>{
        stack.getCard(cards[cards.length - 1 - card_counter]).throwOut(-50, 0);

      });
    });
  }


}

export {tinderSwipe}

tinderSwipe();
