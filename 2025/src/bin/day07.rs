use std::{
    collections::{HashMap, HashSet},
    time::Instant,
};

const INPUT: &str = include_str!("../../inputs/day07.txt");

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

type InputLine = Vec<char>;

fn parse(input: &str) -> Vec<InputLine> {
    input
        .lines()
        .filter(|l| !l.is_empty())
        .map(|line| line.chars().collect())
        .collect()
}

fn part1(data: &[InputLine]) -> usize {
    let mut beam_positions: HashSet<usize> =
        HashSet::from([data[0].iter().position(|char| *char == 'S').unwrap()]);
    let mut splits = 0;

    for row in data {
        let mut current_beam_positions: HashSet<usize> = HashSet::new();

        for position in &beam_positions {
            match row.get(*position) {
                Some(&'^') => {
                    splits += 1;
                    if *position > 0 {
                        current_beam_positions.insert(position - 1);
                    }
                    if *position < row.len() - 1 {
                        current_beam_positions.insert(position + 1);
                    }
                }
                Some(_) => {
                    current_beam_positions.insert(*position);
                }
                None => {}
            }
        }
        beam_positions = current_beam_positions;
    }
    splits
}

fn part2(data: &[InputLine]) -> usize {
    let mut position_counts: HashMap<usize, usize> = HashMap::new();
    position_counts.insert(data[0].iter().position(|&c| c == 'S').unwrap(), 1);

    for row in data {
        let mut current_counts: HashMap<usize, usize> = HashMap::new();

        for (position, count) in position_counts {
            match row.get(position) {
                Some(&'^') => {
                    if position > 0 {
                        *current_counts.entry(position - 1).or_insert(0) += count;
                    }
                    if position < row.len() - 1 {
                        *current_counts.entry(position + 1).or_insert(0) += count;
                    }
                }
                _ => {
                    *current_counts.entry(position).or_insert(0) += count;
                }
            }
        }
        position_counts = current_counts;
    }

    position_counts.values().sum()
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = ".......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part1(&data), 21);
    }

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part2(&data), 40);
    }
}
