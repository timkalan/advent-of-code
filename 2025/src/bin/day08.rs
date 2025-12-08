use std::str::FromStr;
use std::time::Instant;

const INPUT: &str = include_str!("../../inputs/day08.txt");

fn main() {
    let start_total = Instant::now();

    let start_parse = Instant::now();
    let data = parse(INPUT);
    println!("Parsing: {:?}", start_parse.elapsed());

    let start_p1 = Instant::now();
    let res1 = part1(&data, 1000);
    println!("Part 1:  {} (Time: {:?})", res1, start_p1.elapsed());

    let start_p2 = Instant::now();
    let res2 = part2(&data);
    println!("Part 2:  {} (Time: {:?})", res2, start_p2.elapsed());

    println!("Total:   {:?}", start_total.elapsed());
}

struct UnionFind {
    parents: Vec<usize>,
    sizes: Vec<usize>,
    island_count: usize,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        Self {
            parents: (0..n).collect(),
            sizes: vec![1; n],
            island_count: n,
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parents[i] == i {
            return i;
        }
        let root = self.find(self.parents[i]);
        self.parents[i] = root;
        root
    }

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            self.parents[root_j] = root_i;
            self.sizes[root_i] += self.sizes[root_j];
            self.sizes[root_j] = 0;
            self.island_count -= 1;
        }
    }

    fn is_fully_connected(&self) -> bool {
        self.island_count == 1
    }
}

struct Input {
    points: Vec<(usize, usize, usize)>,
    edges: Vec<(u64, usize, usize)>,
}

fn parse(input: &str) -> Input {
    let points: Vec<(usize, usize, usize)> = input
        .lines()
        .filter(|l| !l.is_empty())
        .map(|line| {
            let parts: Vec<&str> = line.split(',').collect();
            (
                usize::from_str(parts[0].trim()).unwrap(),
                usize::from_str(parts[1].trim()).unwrap(),
                usize::from_str(parts[2].trim()).unwrap(),
            )
        })
        .collect();

    let n = points.len();

    let mut edges: Vec<(u64, usize, usize)> = Vec::new();
    for i in 0..n {
        for j in (i + 1)..n {
            edges.push((
                ((points[i].0 as i64 - points[j].0 as i64).pow(2)
                    + (points[i].1 as i64 - points[j].1 as i64).pow(2)
                    + (points[i].2 as i64 - points[j].2 as i64).pow(2)) as u64,
                i,
                j,
            ));
        }
    }
    edges.sort_by_key(|element| element.0);

    Input { points, edges }
}

fn part1(data: &Input, iterations: usize) -> usize {
    let mut union_find = UnionFind::new(data.points.len());

    for edge in data.edges.iter().take(iterations) {
        union_find.union(edge.1, edge.2);
    }

    union_find.sizes.sort_unstable_by(|a, b| b.cmp(a));
    union_find.sizes.iter().take(3).product()
}

fn part2(data: &Input) -> usize {
    let mut union_find = UnionFind::new(data.points.len());

    let mut result = 0;
    for edge in &data.edges {
        union_find.union(edge.1, edge.2);

        if union_find.is_fully_connected() {
            result = data.points[edge.1].0 * data.points[edge.2].0;
            break;
        }
    }
    result
}

#[cfg(test)]
mod tests {
    use super::*;

    const TEST_INPUT: &str = "162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689";

    #[test]
    fn test_part1() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part1(&data, 10), 40);
    }

    #[test]
    fn test_part2() {
        let data = parse(TEST_INPUT.trim());
        assert_eq!(part2(&data), 25272);
    }
}
