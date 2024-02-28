const fs = require("fs");

const games = fs
  .readFileSync("day_02.in", "utf8")
  .split("\n")
  .filter((word) => word.length > 0)
  .map((word) => word.split(": "))
  .map((list) => list[1].trim().split("; "))
  .map((list) => list.map((item) => item.split(", ")));

const bag = { red: 12, green: 13, blue: 14 };

let part_one = [];
let part_two = [];

for (let i = 0; i < games.length; i++) {
  let game = games[i];
  let possible = true;
  let min_needed = { red: 0, green: 0, blue: 0 };
  for (let j = 0; j < game.length; j++) {
    let round = game[j];
    for (let k = 0; k < round.length; k++) {
      let showed = parseInt(round[k].split(" ")[0]);
      let color = round[k].split(" ")[1];

      if (min_needed[color] < showed) {
        min_needed[color] = showed;
      }
      if (bag[color] < showed) {
        possible = false;
      }
    }
  }
  if (possible) {
    part_one.push(i + 1);
  }
  part_two.push(min_needed.red * min_needed.green * min_needed.blue);
}

console.log(part_one.reduce((a, b) => a + b, 0));
console.log(part_two.reduce((a, b) => a + b, 0));
