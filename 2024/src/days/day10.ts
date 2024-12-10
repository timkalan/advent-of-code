import { readInput } from "../utils";

const input = readInput("day10.txt");
const map = input.split("\n").map(row => row.split("").map(Number));

const dirs = [
    [0, -1],
    [0, 1],
    [1, 0],
    [-1, 0],
]

const trailheads = map
    .flatMap((row, rowIndex) =>
        row.map((value, colIndex) => (value === 0 ? [rowIndex, colIndex] : null))
            .filter((position): position is [number, number] => position !== null)
    );

const getPaths = (positions: [number, number][], partTwo: boolean) => {
    const rows = map.length;
    const cols = map[0].length;
    let pathCount = 0;
    let visited: boolean[][] = Array.from({ length: rows }, () => Array(cols).fill(false));

    const dfs = (row: number, col: number, currentNumber: number): void => {
        if (map[row][col] === 9 && !visited[row][col]) {
            pathCount++;
            if (!partTwo) {
                visited[row][col] = true;
            }
            return;
        }

        for (const [dRow, dCol] of dirs) {
            const newRow = row + dRow;
            const newCol = col + dCol;

            if (
                newRow >= 0 &&
                newRow < rows &&
                newCol >= 0 &&
                newCol < cols &&
                !visited[newRow][newCol] &&
                map[newRow][newCol] === currentNumber + 1
            ) {
                dfs(newRow, newCol, currentNumber + 1);
            }
        }
        visited[row][col] = false;
    }

    for (const [startRow, startCol] of positions) {
        dfs(startRow, startCol, 0);
        visited = Array.from({ length: rows }, () => Array(cols).fill(false));
    }

    return pathCount;
}

export function solvePart1(): number {
    const result = getPaths(trailheads, false);
    return result;
}

export function solvePart2(): number {
    const result = getPaths(trailheads, true);
    return result;
}
