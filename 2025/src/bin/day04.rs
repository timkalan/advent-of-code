use std::time::Instant;

const INPUT: &str = include_str!("../../inputs/day04.txt");
const DIRS: [(isize, isize); 8] = [
    (-1, 0),
    (-1, 1),
    (0, 1),
    (1, 1),
    (1, 0),
    (1, -1),
    (0, -1),
    (-1, -1),
];

fn main() {
    let start_total = Instant::now();

    let start_parse = Instant::now();
    let data = parse(INPUT);
    println!("Parsing: {:?}", start_parse.elapsed());

    let start_p1 = Instant::now();
    let res1 = part1(&data);
    println!("Part 1:  {} (Time: {:?})", res1, start_p1.elapsed());

    let start_p2 = Instant::now();
    let res2 = part2(&data);
    println!("Part 2:  {} (Time: {:?})", res2, start_p2.elapsed());

    println!("Total:   {:?}", start_total.elapsed());
}

type InputLine = Vec<u8>;

fn parse(input: &str) -> Vec<InputLine> {
    input
        .lines()
        .filter(|l| !l.is_empty())
        .map(|line| line.as_bytes().to_vec())
        .collect()
}

fn count_neighbors(grid: &[InputLine], row: usize, column: usize) -> usize {
    let h = grid.len() as isize;
    let w = grid[0].len() as isize;
    let mut count = 0;

    for (direction_row, direction_column) in DIRS {
        let next_row = row as isize + direction_row;
        let next_column = column as isize + direction_column;

        if next_row >= 0
            && next_row < h
            && next_column >= 0
            && next_column < w
            && grid[next_row as usize][next_column as usize] == b'@'
        {
            count += 1;
        }
    }
    count
}

fn part1(data: &[InputLine]) -> usize {
    let mut result = 0;
    for r in 0..data.len() {
        for c in 0..data[0].len() {
            if data[r][c] != b'@' {
                continue;
            }
            if count_neighbors(data, r, c) < 4 {
                result += 1;
            }
        }
    }
    result
}

fn part2(data: &[InputLine]) -> usize {
    // This function might not be ideal in terms of data copying/moving
    let mut grid = data.to_vec();
    let mut final_result = 0;
    loop {
        let mut result = 0;
        let mut new_grid = grid.clone();
        for r in 0..grid.len() {
            for c in 0..grid[0].len() {
                if grid[r][c] != b'@' {
                    continue;
                }
                if count_neighbors(&grid, r, c) < 4 {
                    result += 1;
                    new_grid[r][c] = b'.';
                }
            }
        }
        if result == 0 {
            break;
        }
        final_result += result;
        grid = new_grid;
    }
    final_result
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = "..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part1(&data), 13);
    }

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part2(&data), 43);
    }
}
