import CountUp from "countup.js"
const numAnim = new CountUp("bayreuth-counter", 15, 61, 0, 120,{useEasing: false});
if (!numAnim.error) {
    numAnim.start();
} else {
    console.error(numAnim.error);
}

const numAnim3 = new CountUp("aachen-counter", 11, 39, 0, 140,{useEasing: false});
if (!numAnim3.error) {
    numAnim3.start();
} else {
    console.error(numAnim3.error);
}

const numAnim2 = new CountUp("braunschweig-counter", 10, 33, 0,130,{useEasing: false});
if (!numAnim2.error) {
    numAnim2.start();
} else {
    console.error(numAnim2.error);
}
