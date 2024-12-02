import { readInput, splitIndividualNums } from "../utils";

const input = readInput("day2.txt");
const reports = splitIndividualNums(input)

const reasonableIncrease = (value: number, i: number, report: number[]) =>
    i === 0 || (1 <= value - report[i - 1] && value - report[i - 1] <= 3);

const reasonableDecrease = (value: number, i: number, report: number[]) =>
    i === 0 || (1 <= report[i - 1] - value && report[i - 1] - value <= 3);

const isSafe = (report: number[]) =>
    report.every(reasonableIncrease) || report.every(reasonableDecrease);

const isAlmostSafe = (report: number[]) =>
    report.some((_, i) => isSafe(report.filter((_, j) => i != j)));

export function solvePart1(): number {
    const result = reports
        .filter(isSafe)
        .length;

    return result;
}

export function solvePart2(): number {
    const result = reports
        .filter(isAlmostSafe)
        .length;

    return result;
}
