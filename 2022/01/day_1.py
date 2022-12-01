with open('day_1.in') as f:
    data = f.read().split('\n\n')
    sums = []
    for elf in data:
        calories = elf.split('\n')
        sums.append(sum([int(x) for x in calories]))

print('Part 1:')
print(max(sums))
print()

sums.sort()

print('Part 2:')
print(sum(sums[-3:]))