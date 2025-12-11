use std::collections::HashMap;
use std::time::Instant;

const INPUT: &str = include_str!("../../inputs/day11.txt");

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

type Input = HashMap<String, Vec<String>>;

fn parse(input: &str) -> Input {
    let mut map = HashMap::new();
    input
        .lines()
        .filter(|l| !l.is_empty())
        .map(|line| {
            let (key, rest) = line
                .split_once(':')
                .expect("Line not in 'key: val1 val2' format");
            let values: Vec<String> = rest.split_whitespace().map(|s| s.to_string()).collect();
            (key.to_string(), values)
        })
        .for_each(|(key, values)| {
            map.insert(key, values);
        });
    map
}

fn part1(data: &Input) -> usize {
    fn traverse(node: &str, graph: &Input) -> usize {
        if node == "out" {
            1
        } else if let Some(children) = graph.get(node) {
            let mut total = 0;
            for child in children {
                total += traverse(child, graph);
            }
            total
        } else {
            0
        }
    }
    traverse("you", data)
}

fn part2(data: &Input) -> usize {
    let mut memo: HashMap<(String, bool, bool), usize> = HashMap::new();
    fn traverse(
        node: &str,
        graph: &Input,
        memo: &mut HashMap<(String, bool, bool), usize>,
        has_visited_fft: bool,
        has_visited_dac: bool,
    ) -> usize {
        let current_fft = has_visited_fft || node == "fft";
        let current_dac = has_visited_dac || node == "dac";
        let key = (node.to_string(), current_fft, current_dac);
        if let Some(&cached) = memo.get(&key) {
            return cached;
        }

        if node == "out" {
            if current_dac && current_fft { 1 } else { 0 }
        } else if let Some(children) = graph.get(node) {
            let mut total = 0;
            for child in children {
                total += traverse(child, graph, memo, current_fft, current_dac);
            }
            memo.insert(key, total);
            total
        } else {
            0
        }
    }
    traverse("svr", data, &mut memo, false, false)
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT1: &str = "aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT1.trim());
        assert_eq!(part1(&data), 5);
    }

    const TEST_INPUT2: &str = "svr: aaa bbb
aaa: fft
fft: ccc
bbb: tty
tty: ccc
ccc: ddd eee
ddd: hub
hub: fff
eee: dac
dac: fff
fff: ggg hhh
ggg: out
hhh: out";

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT2.trim());
        assert_eq!(part2(&data), 2);
    }
}
