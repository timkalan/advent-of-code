use std::str::FromStr;
use std::time::Instant;

const INPUT: &str = include_str!("../../inputs/day09.txt");

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
struct InputLine {
    x: usize,
    y: usize,
}

fn parse(input: &str) -> Vec<InputLine> {
    input
        .lines()
        .filter(|l| !l.is_empty())
        .map(|line| {
            let (x, y) = line.split_once(',').unwrap();
            InputLine {
                x: usize::from_str(x).unwrap(),
                y: usize::from_str(y).unwrap(),
            }
        })
        .collect()
}

fn part1(data: &[InputLine]) -> usize {
    let mut largest_area = 0;
    for point1 in data {
        for point2 in data {
            let area = (point1.x as isize - point2.x as isize + 1).abs()
                * (point1.y as isize - point2.y as isize + 1).abs();
            if area as usize > largest_area {
                largest_area = area as usize;
            }
        }
    }
    largest_area
}

fn part2(data: &[InputLine]) -> usize {
    todo!("This is kinda hard");
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = "7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part1(&data), 50);
    }

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part2(&data), 24);
    }
}
