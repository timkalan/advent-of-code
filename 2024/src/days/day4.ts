import { readInput } from "../utils";

const grid = readInput("day4.txt")
    .split("\n")
    .map(row => row.split(""));

export function solvePart1(): number {
    const directions = [
        [0, 1],
        [1, 0],
        [0, -1],
        [-1, 0],
        [1, 1],
        [-1, 1],
        [1, -1],
        [-1, -1],
    ]
    // finds all XMAS from given position
    const countXMAS = (i: number, j: number): number => {
        let numXMAS = 0;

        for (const [di, dj] of directions) {
            // fancy js/ts edge case array checking
            if (
                (grid[i]?.[j] === "X") &&
                (grid[i + di]?.[j + dj] === "M") &&
                (grid[i + di * 2]?.[j + dj * 2] === "A") &&
                (grid[i + di * 3]?.[j + dj * 3] === "S")
            ) numXMAS++;
        }
        return numXMAS;
    }

    let result = 0;
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            result += countXMAS(i, j);
        }
    }
    return result;
}

export function solvePart2(): number {
    // checks if X can be found from given position
    const checkX = (i: number, j: number): number => {
        const diags = [
            [[i - 1, j - 1], [i + 1, j + 1]],
            [[i - 1, j + 1], [i + 1, j - 1]]
        ]
        return Number(
            (grid[i]?.[j] === "A") &&
            (
                (grid[diags[0][0][0]]?.[diags[0][0][1]] === "M" && grid[diags[0][1][0]]?.[diags[0][1][1]] === "S") ||
                (grid[diags[0][0][0]]?.[diags[0][0][1]] === "S" && grid[diags[0][1][0]]?.[diags[0][1][1]] === "M")
            ) &&
            (
                (grid[diags[1][0][0]]?.[diags[1][0][1]] === "M" && grid[diags[1][1][0]]?.[diags[1][1][1]] === "S") ||
                (grid[diags[1][0][0]]?.[diags[1][0][1]] === "S" && grid[diags[1][1][0]]?.[diags[1][1][1]] === "M")
            )
        )
    }

    let result = 0;
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[i].length; j++) {
            result += checkX(i, j);
        }
    }
    return result;
}
