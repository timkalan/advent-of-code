import { readInput, splitIndividualNums } from "../utils";

const input = readInput("day1.txt");

const [column1, column2] = splitIndividualNums(input)
    .reduce<[number[], number[]]>(
        ([col1, col2], [val1, val2]) => [[...col1, val1], [...col2, val2]],
        [[], []]
    );

export function solvePart1(): number {
    const sortedColumn1 = column1.sort((a, b) => a - b)
    const sortedColumn2 = column2.sort((a, b) => a - b)

    const result = sortedColumn1
        .reduce((sum, val, idx) => sum + Math.abs(val - sortedColumn2[idx]), 0)

    return result;
}

export function solvePart2(): number {

    const occurences = column2
        .reduce((counts, val) => {
            counts.set(val, (counts.get(val) ?? 0) + 1);
            return counts;
        }, new Map<number, number>());

    const result = column1
        .reduce((sum, val) => sum + val * (occurences.get(val) ?? 0), 0);

    return result;
}
