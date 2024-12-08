import { readInput } from "../utils";

const input = readInput("day8.txt");

const antennas = input.split("\n").map(row => row.split(""));
const frequencies = Array.from(new Set(antennas.flat().filter(freq => freq !== ".")));

const getAllPositionPairs = (array: string[][], target: string): [[number, number], [number, number]][] => {
    const positions = array
        .flatMap((row, rowIndex) =>
            row.map((element, colIndex) =>
                element === target ? [rowIndex, colIndex] as [number, number] : null
            )
        )
        .filter((position): position is [number, number] => position !== null);

    const pairs: [[number, number], [number, number]][] = [];
    for (let i = 0; i < positions.length; i++) {
        for (let j = i + 1; j < positions.length; j++) {
            pairs.push([positions[i], positions[j]]);
        }
    }

    return pairs;
};

const countUnique = (array: [number, number][]): number => {
    const seen = new Map<string, [number, number]>();
    array.forEach(([x, y]) => {
        const key = `${x},${y}`;
        if (!seen.has(key)) {
            seen.set(key, [x, y]);
        }
    });
    return Array.from(seen.values()).length;
}

export function solvePart1(): number {
    const getAntinodes = (frequency: string): [number, number][] => {
        const antinodes: [number, number][] = [];
        const frequencyPairs = getAllPositionPairs(antennas, frequency);

        for (const pair of frequencyPairs) {
            const diff: [number, number] = [pair[0][0] - pair[1][0], pair[0][1] - pair[1][1]];
            const anti1: [number, number] = [pair[0][0] + diff[0], pair[0][1] + diff[1]];
            const anti2: [number, number] = [pair[1][0] - diff[0], pair[1][1] - diff[1]];

            if (anti1[0] >= 0 && anti1[0] < antennas.length && anti1[1] >= 0 && anti1[1] < antennas[0].length) {
                antinodes.push(anti1);
            }
            if (anti2[0] >= 0 && anti2[0] < antennas.length && anti2[1] >= 0 && anti2[1] < antennas[0].length) {
                antinodes.push(anti2);
            }
        }
        return antinodes;
    }

    const antinodes = frequencies
        .map(freq => getAntinodes(freq))
        .flat()

    return countUnique(antinodes);
}

export function solvePart2(): number {
    const getAntinodes = (frequency: string): [number, number][] => {
        const antinodes: [number, number][] = [];
        const frequencyPairs = getAllPositionPairs(antennas, frequency);

        for (const pair of frequencyPairs) {
            const diff: [number, number] = [pair[0][0] - pair[1][0], pair[0][1] - pair[1][1]];
            let anti1: [number, number] = [pair[0][0], pair[0][1]];
            let anti2: [number, number] = [pair[1][0], pair[1][1]];

            while (anti1[0] >= 0 && anti1[0] < antennas.length && anti1[1] >= 0 && anti1[1] < antennas[0].length) {
                antinodes.push(anti1);
                anti1 = [anti1[0] + diff[0], anti1[1] + diff[1]];
            }

            while (anti2[0] >= 0 && anti2[0] < antennas.length && anti2[1] >= 0 && anti2[1] < antennas[0].length) {
                antinodes.push(anti2);
                anti2 = [anti2[0] - diff[0], anti2[1] - diff[1]];
            }
        }
        return antinodes;
    }
    const antinodes = frequencies
        .map(freq => getAntinodes(freq))
        .flat()

    return countUnique(antinodes);
}
