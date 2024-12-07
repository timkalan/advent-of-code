import { readInput } from "../utils";

const input = readInput("day7.txt");

const equations: [number, number[]][] = input
    .split("\n")
    .map(row => row.split(": "))
    .map(row => [+row[0], row[1].split(" ").map(Number)]);

export function solvePart1(): number {
    const canResult = (numbers: number[], target: number): boolean => {
        const tryOps = (index: number, current: number): boolean => {
            if (index === numbers.length) {
                return current === target;
            }
            if (tryOps(index + 1, current + numbers[index])) {
                return true;
            }
            if (tryOps(index + 1, current * numbers[index])) {
                return true;
            }
            return false;
        }
        return tryOps(1, numbers[0]);
    }

    const result = equations
        .filter(([result, operands]) => canResult(operands, result))
        .reduce((sum, [result, _]) => sum + result, 0)

    return result;
}

export function solvePart2(): number {
    const canResult = (numbers: number[], target: number): boolean => {
        const tryOps = (index: number, current: number): boolean => {
            if (index === numbers.length) {
                return current === target;
            }
            const next = numbers[index]
            if (tryOps(index + 1, current + next)) {
                return true;
            }
            if (tryOps(index + 1, current * next)) {
                return true;
            }
            // check also for concatenation
            if (tryOps(index + 1, parseInt(`${current}${next}`, 10))) {
                return true;
            }
            return false;
        }
        return tryOps(1, numbers[0]);
    }

    const result = equations
        .filter(([result, operands]) => canResult(operands, result))
        .reduce((sum, [result, _]) => sum + result, 0)

    return result;
}
