import { readInput } from "../utils";

const input = readInput("day3.txt");

const pattern = /mul\((\d{1,3}),(\d{1,3})\)/g;

const multiply = (str: string[]) => str
    .map(expr => expr.slice(4, -1).split(",").map(Number))
    .reduce((sum, vals) => sum + (vals[0] * vals[1]), 0);

export function solvePart1(): number {
    const result = multiply(input.match(pattern)!)

    return result;
}

export function solvePart2(): number {
    const sections = input
        .split("do()")
        .map(section => section.split("don't()")[0])

    const result = sections
        .map(section => multiply(section.match(pattern)!))
        .reduce((sum, val) => sum + val, 0);

    return result;
}
