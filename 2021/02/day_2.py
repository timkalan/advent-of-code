
depth = 0
forw = 0
depth2 = 0
aim = 0

with open('2021/02/day_2.in') as f:
    for line in f:
        lst = line.split()
        if lst[0] == 'forward':
            forw += int(lst[1])
            depth2 += int(lst[1]) * aim
        elif lst[0] == 'down':
            depth += int(lst[1])
            aim += int(lst[1])
        else:
            depth -= int(lst[1])
            aim -= int(lst[1])
        
        

with open('2021/02/day_2-1.out', 'w') as w:
    w.write(str(depth * forw))

print('done!')

with open('2021/02/day_2-2.out', 'w') as w:
    w.write(str(depth2 * forw))

print('done!')