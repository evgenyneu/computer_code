
/**
 * A function that returns a callback that is used as a handler
 * * onchange and keyup events of HTML text input element.
 *
 * @param  scoreElement Element displaying the score (a div element, for example)
 */
export function didChangeInput(scoreElement) {
  return (event) => updateScore(scoreElement, event.target.value);
}

/**
 * Calculate numerical score of a single letter.
 *
 * @param  {string} letter One character
 * @return {number}        A number corresponding to the character.
 */
export function letterScore(letter) {
  letter = letter.toLowerCase();
  const code = letter.charCodeAt(0);

  if (code >= 49 && code <= 57) {
    // Numbers 1...9
    return code - 48;
  } else if (code >= 97 && code <= 122) {
    // Letters a...z
    return code - 96;
  } else {
    return 0;
  }
}

/**
 * Calculate numerical score given a string of text.
 *
 * @param  {string} text A string of text
 * @return {number}      A numerical score for the string.
 */
export function textScore(text) {
  let result = 0;

  for (let letter of text) {
    result += letterScore(letter);
  }

  return result;
}


/**
 * Updates the text of `scoreElement` with numerical score of `text` string.
 */
export function updateScore(scoreElement, text) {
  scoreElement.innerHTML = textScore(text);
}
