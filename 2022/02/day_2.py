with open('day_2.in') as f:
    data = f.read().split('\n')
    score = 0
    needed = 0
    for match in data:
        players = match.split(' ')
        if players[0] == 'A':
            if players[1] == 'X':
                partial = 4
                needed += 3
            elif players[1] == 'Y':
                partial = 8
                needed += 4
            elif players[1] == 'Z':
                partial = 3
                needed += 8
        elif players[0] == 'B':
            if players[1] == 'X':
                partial = 1
                needed += 1
            elif players[1] == 'Y':
                partial = 5
                needed += 5
            elif players[1] == 'Z':
                partial = 9
                needed += 9
        elif players[0] == 'C':
            if players[1] == 'X':
                partial = 7
                needed += 2
            elif players[1] == 'Y':
                partial = 2
                needed += 6
            elif players[1] == 'Z':
                partial = 6
                needed += 7
            

        score += partial

print('Part 1:')
print(score)
print()
print('Part 2:')
print(needed)
