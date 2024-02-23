// read lines in day_01.in

const fs = require("fs");

// PART ONE

function getDigits(string) {
  const first = string.match(/\d/);
  const last = string.split("").reverse().join("").match(/\d/);
  return parseInt(first + last);
}

const part_one = fs
  .readFileSync("day_01.in", "utf8")
  .split("\n")
  .filter((word) => word.length > 0)
  .map((line) => getDigits(line))
  .reduce((acc, el) => acc + el, 0);

console.log(part_one);

// PART TWO

const digits = [
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
];

function getDigits2(string) {
  const num_digit = string.match(/\d/);
  const num_digit_index = string.indexOf(num_digit);
  const last_num = string.split("").reverse().join("").match(/\d/);
  const last_num_index = string.lastIndexOf(last_num);

  let word_digit = "";
  let word_digit_index = string.length;
  let last_word = "";
  let last_word_index = 0;

  for (let i = 0; i < digits.length; i++) {
    const index = string.indexOf(digits[i]);
    if (index !== -1 && index < word_digit_index) {
      word_digit = digits[i];
      word_digit_index = index;
    }

    const last_index = string.lastIndexOf(digits[i]);
    if (last_index !== -1 && last_index > last_word_index) {
      last_word = digits[i];
      last_word_index = last_index;
    }
  }

  let first_digit;
  let last_digit;
  if (word_digit_index < num_digit_index || num_digit == null) {
    first_digit = digits.indexOf(word_digit) + 1;
  } else {
    first_digit = parseInt(num_digit);
  }

  if (last_word_index > last_num_index || last_num == null) {
    last_digit = digits.indexOf(last_word) + 1;
  } else {
    last_digit = parseInt(last_num);
  }

  return parseInt(first_digit.toString() + last_digit.toString());
}

const part_two = fs
  .readFileSync("day_01.in", "utf8")
  .split("\n")
  .filter((word) => word.length > 0)
  .map((line) => getDigits2(line))
  .reduce((acc, el) => acc + el, 0);

console.log(part_two);
