use std::time::Instant;

const INPUT: &str = include_str!("../../inputs/day01.txt");

fn main() {
    let start = Instant::now();

    let data = parse(INPUT);
    println!("Parsing: {:?}", start.elapsed());

    let p1_start = Instant::now();
    let res1 = part1(&data);
    println!("Part 1:  {} (Time: {:?})", res1, p1_start.elapsed());

    let p2_start = Instant::now();
    let res2 = part2(&data);
    println!("Part 2:  {} (Time: {:?})", res2, p2_start.elapsed());
}

type InputType = Vec<(char, usize)>;

fn parse(input: &str) -> InputType {
    input
        .lines()
        .map(|line| (line.chars().next().unwrap(), line[1..].parse().unwrap()))
        .collect()
}

fn part1(input: &InputType) -> usize {
    let (_, zero_hits) = input
        .iter()
        .fold((50isize, 0), |(position, count), (char, n)| {
            let step = *n as isize;
            let raw_position = match char {
                'R' => position + step,
                'L' => position - step,
                _ => position,
            };

            // Clip to 0-100
            let new_position = raw_position.rem_euclid(100);

            let new_count = if new_position == 0 { count + 1 } else { count };
            (new_position, new_count)
        });

    zero_hits
}

fn part2(input: &InputType) -> usize {
    let (_, zero_hits) = input
        .iter()
        .fold((50isize, 0), |(position, count), (char, n)| {
            let step = *n as isize;
            let (new_position, hits) = match char {
                'R' => {
                    let new_position = position + step;
                    let hits = new_position.div_euclid(100) - position.div_euclid(100);
                    (new_position, hits)
                }
                'L' => {
                    let new_position = position - step;
                    let hits = (position - 1).div_euclid(100) - (new_position - 1).div_euclid(100);
                    (new_position, hits)
                }
                _ => (position, 0),
            };

            (new_position, count + hits as usize)
        });

    zero_hits
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT);
        println!("Input: {:?}", data);
        assert_eq!(part1(&data), 3);
    }

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT);
        assert_eq!(part2(&data), 6);
    }
}
