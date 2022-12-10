with open('day_10.in') as f:
    instructions = f.read().split('\n')
    cycle = 1
    register = 1
    relevant = []
    
    sprite_position = ['#'] * 3 + ['.'] * 37
    crt = [['.' for _ in range(40)] for _ in range(6)]

    for instruction in instructions:
        print(''.join(sprite_position), len(sprite_position), register, cycle)
        if instruction[:4] == 'noop':
            crt[(cycle - 1) // 40][cycle % 40 - 1] = sprite_position[cycle % 40 - 1]
            cycle += 1
            if (cycle + 20) % 40 == 0:
                relevant.append((cycle, register))
        elif instruction[:4] == 'addx':
            val = instruction.split(' ')[1]
            crt[cycle // 40][cycle % 40 - 1] = sprite_position[cycle % 40 - 1]
            cycle += 1
            if (cycle + 20) % 40 == 0:
                relevant.append((cycle, register))
            crt[cycle // 40][cycle % 40 - 1] = sprite_position[cycle % 40 - 1]
            cycle += 1
            register += int(val)
            sprite_position = ['.'] * min((register - 1), 37) + ['#'] * 3 + ['.'] * min((37 - (register - 1)), 37)
            if (cycle + 20) % 40 == 0:
                relevant.append((cycle, register))


total = sum([x[0] * x[1] for x in relevant])

print(sprite_position, len(sprite_position))
print_crt = ''
for row in crt:
    print_crt += ''.join(row) + '\n'

print('Part 1:')
print(total)
print()
print('Part 2:')
print(print_crt)

