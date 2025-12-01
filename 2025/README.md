# Rust AOC cheat sheet

Rust detects files in `src/bin/*.rs` as independent executables. You run them by name.

```bash
# Run normally (debug mode, slower but fast compile)
cargo run --bin day01

# Run with optimizations (if solution takes more than 2 seconds)
cargo run --release --bin day01
```

This runs the `#[test]` block.

```bash
cargo test --bin day01
```
