use std::time::Instant;

const INPUT: &str = include_str!("../../inputs/day03.txt");

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

type InputLine = String;

fn parse(input: &str) -> Vec<InputLine> {
    input
        .lines()
        .filter(|l| !l.is_empty())
        .map(|line| line.to_string())
        .collect()
}

fn find_max_jolt(jolts: &str, length: usize) -> Option<usize> {
    if length == 0 {
        return Some(0);
    }
    for digit in (0..=9).rev() {
        let target_char = std::char::from_digit(digit, 10).unwrap();

        if let Some(index) = jolts.find(target_char) {
            let remaining_jolts = &jolts[index + 1..];

            if let Some(best_tail) = find_max_jolt(remaining_jolts, length - 1) {
                let val = 10_usize.pow((length - 1) as u32);

                return Some((digit as usize * val) + best_tail);
            }
        }
    }
    None
}

fn part1(data: &[InputLine]) -> usize {
    data.iter()
        .map(|jolts| {
            // Slow and dumb double for loop
            // let mut biggest = "00".to_string();
            // for i in 0..jolts.len() {
            //     for j in (i + 1)..jolts.len() {
            //         let candidate = format!(
            //             "{}{}",
            //             jolts.chars().nth(i).unwrap(),
            //             jolts.chars().nth(j).unwrap()
            //         );
            //         if candidate >= biggest {
            //             biggest = candidate;
            //         }
            //     }
            // }

            // Right idea, but non recursive
            // biggest.parse::<usize>().unwrap()
            // for tens in (0..=9).rev() {
            //     let target_char = std::char::from_digit(tens, 10).unwrap();
            //
            //     if let Some(index) = jolts.find(target_char) {
            //         // If the digit is the very last char, it can't be a 10s digit.
            //         if index == jolts.len() - 1 {
            //             continue;
            //         }
            //
            //         let remaining_jolts = &jolts[index + 1..];
            //
            //         if let Some(ones_char) = remaining_jolts.chars().max() {
            //             let ones = ones_char.to_digit(10).unwrap();
            //
            //             return (tens * 10 + ones) as usize;
            //         }
            //     }
            // }
            // 0

            // Recursive solution
            find_max_jolt(jolts, 2).unwrap()
        })
        .sum()
}

fn part2(data: &[InputLine]) -> usize {
    data.iter()
        .map(|jolts| find_max_jolt(jolts, 12).unwrap() as usize)
        .sum()
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = "987654321111111
811111111111119
234234234234278
818181911112111";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part1(&data), 357);
    }

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part2(&data), 3121910778619);
    }
}
