import { readInput } from "../utils";

type Position = {
    row: number,
    col: number,
}

const directions = [
    [-1, 0],
    [0, 1],
    [1, 0],
    [0, -1]
] as const;

type Direction = typeof directions[number];

type State = {
    numSteps: number,
    direction: Direction,
    position: Position,
}

const input = readInput("day6.txt");

const grid = input
    .split("\n")
    .map(row => row.split(""))

const getPosition = (grid: string[][]): Position => {
    let result = grid
        .map((row, rowIndex) => ({
            row: rowIndex,
            col: row.indexOf("^"),
        }))
        .filter(pos => pos.col > -1)

    if (result === undefined) return { row: -1, col: -1 };

    return result[0];
}

const turnRight = (dir: Direction): Direction => {
    if (dir.every((val, ind) => val === directions[0][ind])) return directions[1];
    if (dir.every((val, ind) => val === directions[1][ind])) return directions[2];
    if (dir.every((val, ind) => val === directions[2][ind])) return directions[3];
    if (dir.every((val, ind) => val === directions[3][ind])) return directions[0];

    return dir;
}

const draw = (grid: string[][], state: State) => {
    const current = grid[state.position.row]?.[state.position.col];
    switch (current) {
        case ".":
            if (state.direction[0] === 0) {
                grid[state.position.row][state.position.col] = "-";
            } else {
                grid[state.position.row][state.position.col] = "|";
            }
            break;
        case "-":
            if (state.direction[0] !== 0) {
                grid[state.position.row][state.position.col] = "+";
            }
            break;
        case "|":
            if (state.direction[1] !== 0) {
                grid[state.position.row][state.position.col] = "+";
            }
        default:
            break;
    }
}

const move = (grid: string[][], state: State): State => {
    let nextPos = {
        row: state.position.row + state.direction[0],
        col: state.position.col + state.direction[1],
    }

    if (grid[nextPos.row]?.[nextPos.col] === "#") {
        state.direction = turnRight(state.direction);
        grid[state.position.row][state.position.col] = "+";
        return state;
    }

    draw(grid, state);

    state.position = nextPos;
    return state;
}

export function solvePart1(): number {

    let state: State = {
        numSteps: 0,
        position: getPosition(grid),
        direction: directions[0]
    }
    while (
        state.position.row > 0 && state.position.col > 0 &&
        state.position.row < grid.length - 1 && state.position.col < grid[0].length - 1
    ) {
        move(grid, state);
    }

    draw(grid, state);
    console.log(grid.map(row => row.join("")).join("\n"));

    return grid.flat().filter(item => item === "^" || item === "|" || item === "-" || item === "+").length;;
}

export function solvePart2(): number {

    let positions = 0;
    let maxSteps = grid.length * grid[0].length;

    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            const grid = input
                .split("\n")
                .map(row => row.split(""))

            if (grid[i][j] === "^") continue;
            grid[i][j] = "#"

            let state: State = {
                numSteps: 0,
                position: getPosition(grid),
                direction: directions[0]
            }
            while (
                state.position.row > 0 && state.position.col > 0 &&
                state.position.row < grid.length - 1 && state.position.col < grid[0].length - 1
            ) {
                move(grid, state);
                state.numSteps++;
                if (state.numSteps > maxSteps) {
                    positions++;
                    break;
                }
            }
        }
    }

    return positions;
}
