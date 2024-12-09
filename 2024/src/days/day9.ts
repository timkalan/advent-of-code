import { readInput } from "../utils";

const input = readInput("day9.txt");

const disk = input.split("").map(Number);

const diskToBlocks = (disk: number[]): string[] => {
    let blocks: string[] = [];
    let fileId = 0;
    for (let i = 0; i < disk.length; i += 2) {
        blocks = blocks.concat(Array(disk[i]).fill(fileId));
        if (i + 1 < disk.length) {
            blocks = blocks.concat(Array(disk[i + 1]).fill("."));
        }
        fileId++;
    }
    return blocks;
}

export function solvePart1(): number {
    const moveFiles = (blocks: string[]) => {
        let offset = 1;
        for (let i = 0; i < blocks.length; i++) {
            if (blocks[i] === ".") {
                while (blocks[blocks.length - offset] === ".") {
                    offset++;
                }
                blocks[i] = blocks[blocks.length - offset];
                blocks[blocks.length - offset] = ".";
                offset++;

            }
            if (i >= blocks.length - offset) {
                break;
            }
        }
    }
    const blocks = diskToBlocks(disk);
    moveFiles(blocks);

    const result = blocks
        .filter(el => el !== ".")
        .map(Number)
        .reduce((sum, val, idx) => sum + (val * idx), 0)
    return result;
}

export function solvePart2(): number {
    const moveFiles = (blocks: string[]) => {
        const getChunks = (blocks: string[]): [number, number][] => {
            const chunks: [number, number][] = [];
            let i = 0;
            while (i < blocks.length) {
                if (blocks[i] !== ".") {
                    const start = i;
                    let count = 0;
                    while (i < blocks.length && blocks[i] === blocks[start]) {
                        count++;
                        i++;
                    }
                    chunks.push([start, count]);
                } else {
                    i++;
                }
            }
            return chunks;
        };

        const findLeftmostSpot = (blocks: string[], size: number): number => {
            let freeCount = 0;
            for (let i = 0; i < blocks.length; i++) {
                if (blocks[i] === ".") {
                    freeCount++;
                    if (freeCount === size) {
                        return i - size + 1;
                    }
                } else {
                    freeCount = 0;
                }
            }
            return -1;
        };

        const chunks = getChunks(blocks);

        for (const [startIdx, size] of chunks.reverse()) {
            const startPos = findLeftmostSpot(blocks, size);
            if (startPos !== -1 && startPos < startIdx) {
                const char = blocks[startIdx];
                for (let i = 0; i < size; i++) {
                    blocks[startPos + i] = char;
                }
                for (let i = startIdx; i < startIdx + size; i++) {
                    blocks[i] = ".";
                }
            }
        }
    };

    const blocks = diskToBlocks(disk);
    moveFiles(blocks);

    const result = blocks
        .map(val => {
            if (val === ".") return "0";
            else return val;
        })
        .map(Number)
        .reduce((sum, val, idx) => sum + (val * idx), 0)
    return result;
}
