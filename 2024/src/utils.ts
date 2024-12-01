import * as fs from "fs";

export function readInput(filename: string): string {
    return fs.readFileSync(`inputs/${filename}`, "utf-8").trim();
}
