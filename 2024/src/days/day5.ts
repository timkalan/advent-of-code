import { readInput } from "../utils";

const input = readInput("day5.txt");

const rules = input
    .split("\n\n")[0]
    .split("\n")
    .map(row => row.split("|").map(Number));

const updates = input
    .split("\n\n")[1]
    .split("\n")
    .map(row => row.split(",").map(Number));

const checkRule = (update: number[], [before, after]: number[]): boolean => {
    const beforeInd = update.indexOf(before);
    const afterInd = update.indexOf(after);
    return beforeInd < afterInd || beforeInd === -1 || afterInd === -1;
}

const fixRule = (update: number[], [before, after]: number[]): number[] => {
    const beforeInd = update.indexOf(before);
    const afterInd = update.indexOf(after);
    if (beforeInd === -1 || afterInd === -1) return update;

    if (beforeInd > afterInd) {
        const temp = update[beforeInd];
        update[beforeInd] = update[afterInd];
        update[afterInd] = temp;

        return update;
    }
    return update;
}

const fixAllRules = (update: number[]): number[] => {
    //return rules.reduce((newUpdate, rule) => fixRule(newUpdate, rule), update)
    while (!rules.reduce((check, rule) => check && checkRule(update, rule), true)) {
        rules.reduce((newUpdate, rule) => fixRule(newUpdate, rule), update)
    }

    return update;
}

export function solvePart1(): number {
    const result = updates
        .filter(row => rules.reduce((check, rule) => check && checkRule(row, rule), true))
        .map(row => row[Math.floor(row.length / 2)])
        .reduce((sum, val) => sum + val, 0);

    return result;
}

export function solvePart2(): number {
    const result = updates
        .filter(row => !rules.reduce((check, rule) => check && checkRule(row, rule), true))
        .map(row => fixAllRules(row))
        .map(row => row[Math.floor(row.length / 2)])
        .reduce((sum, val) => sum + val, 0);

    return result;
}
