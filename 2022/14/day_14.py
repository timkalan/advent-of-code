def move_sand(position, rocks):
    x, y = position
    if rocks[x + 1][y] == '.':
        rocks[x + 1][y] = 'o'
        rocks[x][y] = '.'
        return (x + 1, y)
    else:
        if rocks[x + 1][y - 1] == '.':
            rocks[x + 1][y - 1] = 'o'
            rocks[x][y] = '.'
            return (x + 1, y - 1)
        elif rocks[x + 1][y + 1] == '.':
            rocks[x + 1][y + 1] = 'o'
            rocks[x][y] = '.'
            return (x + 1, y + 1)
        else:
            return position
    

with open('day_14.in') as f:
    paths = f.read().split('\n')
    sand_entry = (0, 500)
    paths = [path.split(' -> ') for path in paths]
    rocks = [['.' for i in range(1000)] for j in range(1000)]

    max_x = 0
    for path in paths:
        for i in range(len(path) - 1):
            start_pos = path[i].split(',')
            end_pos = path[i + 1].split(',')

            y1, x1 = int(start_pos[0]), int(start_pos[1])
            y2, x2 = int(end_pos[0]), int(end_pos[1])
            start_x = x1 if x1 < x2 else x2
            end_x = x2 if x2 > x1 else x1
            start_y = y1 if y1 < y2 else y2
            end_y = y2 if y2 > y1 else y1
            max_x = end_x if end_x > max_x else max_x

            for x in range(start_x, end_x + 1):
                for y in range(start_y, end_y + 1):
                    rocks[x][y] = '#'

    rocks = rocks[:max_x + 3]
    rocks[-1] = ['#' for i in range(len(rocks[-1]))]
 
    rocks[sand_entry[0]][sand_entry[1]] = 'o'

    i = 0
    while True:
        position = sand_entry
        new_position = move_sand(position, rocks)
        if position == new_position:
            break
        while new_position != position:
            position = new_position
            new_position = move_sand(position, rocks)
        i += 1


print('Part 1:')
print('code changed')
print()
print('Part 2:')
print(i + 1)

