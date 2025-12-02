use std::ops::RangeInclusive;
use std::time::Instant;

const INPUT: &str = include_str!("../../inputs/day02.txt");

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

type InputLine = RangeInclusive<usize>;

fn parse(input: &str) -> Vec<InputLine> {
    input
        .split(',')
        .map(|line| line.trim())
        .filter(|line| !line.is_empty())
        .map(|line| {
            let (lower, upper) = line
                .split_once('-')
                .expect("input not in shape of 'num-num'");
            let lower = lower.parse().expect("Lower is not a number");
            let upper = upper.parse().expect("Upper is not a number");
            lower..=upper
        })
        .collect()
}

fn part1(data: &[InputLine]) -> usize {
    data.iter()
        .flat_map(|range| range.clone())
        .filter(|candidate| {
            let digits = candidate.ilog10() + 1;
            if digits % 2 != 0 {
                return false;
            }

            let divisor = 10_usize.pow(digits / 2);

            let left = candidate / divisor;
            let right = candidate % divisor;

            left == right
        })
        .sum()
}

fn part2(data: &[InputLine]) -> usize {
    data.iter()
        .flat_map(|range| range.clone())
        .filter(|candidate| {
            let string = candidate.to_string();
            let bytes = string.as_bytes();
            let len = bytes.len();

            // Are all chunks the same for any of the patterns?
            (1..=len / 2).any(|pattern_len| {
                if len % pattern_len != 0 {
                    return false;
                }

                let mut chunks = bytes.chunks(pattern_len);
                let first = chunks.next().unwrap();
                chunks.all(|c| c == first)
            })
        })
        .sum()
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part1(&data), 1227775554);
    }

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part2(&data), 4174379265);
    }
}
