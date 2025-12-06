use std::time::Instant;

const INPUT: &str = include_str!("../../inputs/day06.txt");

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

#[derive(Debug, Clone)]
struct Input {
    grid: Vec<Vec<char>>,
    operators: Vec<char>,
}

fn parse(input: &str) -> Input {
    let lines: Vec<&str> = input.lines().filter(|l| !l.trim().is_empty()).collect();

    // Thank god Rust has methods for anything, god forbid indexing into a Vec
    let (operators, grid) = lines.split_last().unwrap();

    let operators = operators
        .chars()
        .filter(|char| !char.is_whitespace())
        .collect();

    let grid = grid.iter().map(|line| line.chars().collect()).collect();

    Input { grid, operators }
}

fn part1(data: &Input) -> usize {
    // Parse the grid of chars into a matrix of numbers
    let numbers: Vec<Vec<usize>> = data
        .grid
        .iter()
        .map(|row| {
            row.iter()
                .collect::<String>()
                .split_whitespace()
                .filter_map(|number| number.parse().ok())
                .collect()
        })
        .collect();

    // Iterate through the columns and operate
    // let mut answers: Vec<usize> = Vec::new();
    // for c in 0..numbers[0].len() {
    //     let operator = data.operators[c];
    //     let mut result = if operator == '+' { 0 } else { 1 };
    //     for row in &numbers {
    //         let value = row[c];
    //         match operator {
    //             '*' => result *= value,
    //             '+' => result += value,
    //             _ => panic!("Unknown operator"),
    //         }
    //     }
    //     answers.push(result);
    // }
    // answers.iter().sum()

    // Iterate through the columns, functional style
    (0..numbers[0].len())
        .map(|column| {
            let operator = data.operators[column];

            (0..numbers.len()).fold(if operator == '+' { 0 } else { 1 }, |acc, row| {
                let value = numbers[row][column];
                match operator {
                    '*' => acc * value,
                    '+' => acc + value,
                    _ => panic!("Unknown operator"),
                }
            })
        })
        .sum()
}

fn part2(data: &Input) -> usize {
    let mut total_sum = 0;

    // Identify blocks (groups of columns)
    let mut blocks: Vec<Vec<usize>> = Vec::new();
    let mut current_block: Vec<usize> = Vec::new();

    for x in 0..data.grid[0].len() {
        let is_empty_column = data.grid.iter().all(|row| row[x] == ' ');

        if is_empty_column {
            if !current_block.is_empty() {
                blocks.push(current_block.clone());
                current_block.clear();
            }
        } else {
            current_block.push(x);
        }
    }
    if !current_block.is_empty() {
        blocks.push(current_block);
    }

    // Process blocks
    for (i, block_indices) in blocks.iter().enumerate() {
        let op = data.operators.get(i).unwrap();
        let mut numbers = Vec::new();

        for &col_idx in block_indices.iter() {
            let mut num_str = String::new();
            for row in &data.grid {
                let col = row[col_idx];
                if col.is_ascii_digit() {
                    num_str.push(col);
                }
            }

            numbers.push(num_str.parse().unwrap());
        }

        let result = match op {
            '*' => numbers.iter().product::<usize>(),
            '+' => numbers.iter().sum::<usize>(),
            _ => 0,
        };

        total_sum += result;
    }

    total_sum
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = "123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  ";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part1(&data), 4277556);
    }

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part2(&data), 3263827);
    }
}
