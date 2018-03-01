import {Card, Direction, Stack} from "../swipe/index";


function tinderSwipe(){

  let seats = document.querySelectorAll(".one-seat");
  let seated_counter = 0;

  window.swing = require('swing');
  var Swing = window.swing;
  const cards = [].slice.call(document.querySelectorAll('.swipe-card-element'));



  const config = {
        throwOutConfidence: (xOffset, yOffset, element) => {
                //decide if throw was successful
                const xConfidence = Math.min((Math.abs(xOffset) / element.offsetWidth)*1.5, 1);
                const yConfidence = Math.min((Math.abs(yOffset) / element.offsetHeight)*1.5, 1);
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
    console.log(event);
    console.log(event.target.parentElement.previousElementSibling);
    console.log('Card has been thrown out of the stack.');
    console.log('Throw direction: ' + (event.throwDirection.toString() == Direction.LEFT.toString() ? 'left' : 'right'));


    console.log(event.throwDirection.toString());
    console.log(Direction.LEFT.toString());

    console.log(event.throwDirection == Direction.LEFT);
    console.log(event.throwDirection.toString() == Direction.LEFT.toString());

    if (event.throwDirection.toString() == Direction.LEFT.toString() ){
      console.log("left");
      event.target.parentElement.previousElementSibling.checked = false;
    } else if (event.throwDirection.toString() == Direction.RIGHT.toString()){
      console.log("right");
      event.target.parentElement.previousElementSibling.checked = true;
      let img_html = event.target.firstElementChild.innerHTML;
      seats[seated_counter].innerHTML = img_html;
      seated_counter += 1;
    }
    console.log(event.target.parentElement.previousElementSibling.checked);
    event.target.classList.toggle("hidden");
  });

  // Add event listener for when a card is thrown in the stack, including the spring back into place effect.
  stack.on('throwin', () => {
    console.log('Card has snapped back to the stack.');
  });


}

export {tinderSwipe}
