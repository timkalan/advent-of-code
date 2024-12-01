const day = process.argv[2];

if (!day) {
    console.error("Please specify a day to run, e.g., `npm run day 1`");
    process.exit(1);
}

try {
    console.log(`Running Day ${day}...`);
    const solution = require(`./days/day${day}`);
    console.log("Part 1:", solution.solvePart1());
    console.log("Part 2:", solution.solvePart2());
} catch (err) {
    if (err instanceof Error) {
        console.error(`Error loading Day ${day}:`, err.message);
    } else {
        console.error(`An unknown error occurred while loading Day ${day}.`);
    }
    process.exit(1);
}
