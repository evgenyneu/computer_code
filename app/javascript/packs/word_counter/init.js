import {didChangeInput, updateScore} from "./word_counter.js";

/**
 * Initialise the code that calculate numerical score for text
 * entered in a text input and display this score in another HTML element.
 */
export function initPage() {
  var input = document.querySelector(".Quiz-wordInput");
  var scoreElement = document.querySelector(".Quiz-wordScore");

  input.onchange = didChangeInput(scoreElement);
  input.onkeyup = didChangeInput(scoreElement);
  updateScore(scoreElement, input.value);
}

initPage();
