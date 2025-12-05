use std::{cmp::max, ops::RangeInclusive, time::Instant};

const INPUT: &str = include_str!("../../inputs/day05.txt");

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
    ranges: Vec<RangeInclusive<usize>>,
    ingredients: Vec<usize>,
}

fn parse(input: &str) -> Input {
    let (top, bottom) = input.split_once("\n\n").unwrap();

    let ranges = top
        .lines()
        .map(|line| {
            let (lower, upper) = line
                .split_once('-')
                .expect("input not in shape of 'num-num'");
            let lower = lower.parse().expect("Lower is not a number");
            let upper = upper.parse().expect("Upper is not a number");
            lower..=upper
        })
        .collect();

    let ingredients = bottom.lines().map(|line| line.parse().unwrap()).collect();

    Input {
        ranges,
        ingredients,
    }
}

fn part1(data: &Input) -> usize {
    data.ingredients
        .iter()
        .filter(|ingredient| data.ranges.iter().any(|range| range.contains(ingredient)))
        .count()
}

fn part2(data: &Input) -> usize {
    // Dumb solution: does not work
    // data.ranges
    //     .iter()
    //     .flat_map(|range| range.clone())
    //     .collect::<HashSet<_>>()
    //     .len()

    // Solution: sort + merge ranges, then add them up
    let mut ranges = data.ranges.clone();
    ranges.sort_by_key(|range| *range.start());
    let mut merged_ranges = Vec::new();
    let mut current = ranges[0].clone();

    for next in ranges.into_iter().skip(1) {
        if next.start() <= &(current.end() + 1) {
            current = *current.start()..=max(*current.end(), *next.end());
        } else {
            merged_ranges.push(current);
            current = next;
        }
    }
    merged_ranges.push(current);

    merged_ranges
        .iter()
        .map(|range| *range.end() - *range.start() + 1)
        .sum()
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = "3-5
10-14
16-20
12-18

1
5
8
11
17
32";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part1(&data), 3);
    }

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part2(&data), 14);
    }
}
