import * as fs from "fs";

export function readInput(filename: string): string {
    return fs.readFileSync(`inputs/${filename}`, "utf-8").trim();
}

export function splitIndividualNums(str: string): number[][] {
    const result = str
        .split("\n")
        .map(line => line.trim().split(/\s+/).map(Number));

    return result;
}
