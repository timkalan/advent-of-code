class Grid:
    def __init__(self, size, knots=10):
        self.grid = [['.' for i in range(size + 1)] for j in range(size)]
        self.size = size
        self.knots = [str(i) for i in range(knots)]
        self.grid[size // 2][size // 2] = self.knots[0]
        self.knot_positions = [(size // 2, size // 2) for i in range(knots)]
        self.s_position = (size // 2, size // 2)
        self.knot_histories = [[self.knot_positions[i]] for i in range(knots)]

    def __repr__(self):
        string = ''
        for row in self.grid:
            string += ''.join(row) + '\n'
        return string

    def move(self, direction):
        if direction == 'U':
            self.move_up()
        elif direction == 'D':
            self.move_down()
        elif direction == 'L':
            self.move_left()
        elif direction == 'R':
            self.move_right()

        self.update()

    def move_up(self):
        x, y = self.knot_positions[0]
        if x == 0:
            return
        self.grid[x][y] = '.'
        self.grid[x-1][y] = '0'
        self.knot_positions[0] = (x-1, y)
        for i in range(len(self.knots) - 1):
            if not self.t_next_to_h(i):
                a, b = self.knot_positions[i + 1]
                self.grid[a][b] = '.'
                self.grid[x][y] = int(i + 1)
                self.knot_positions[i + 1] = (x, y)
                self.knot_histories[i + 1].append((x, y))
    
    def move_down(self):
        x, y = self.knot_positions[0]
        if x == self.size-1:
            return
        self.grid[x][y] = '.'
        self.grid[x+1][y] = '0'
        self.knot_positions[0] = (x+1, y)
        for i in range(len(self.knots) - 1):
            if not self.t_next_to_h(i):
                a, b = self.knot_positions[i + 1]
                self.grid[a][b] = '.'
                self.grid[x][y] = int(i + 1)
                self.knot_positions[i + 1] = (x, y)
                self.knot_histories[i + 1].append((x, y))

    def move_left(self):
        x, y = self.knot_positions[0]
        if y == 0:
            return
        self.grid[x][y] = '.'
        self.grid[x][y-1] = '0'
        self.knot_positions[0] = (x, y-1)
        for i in range(len(self.knots) - 1):
            if not self.t_next_to_h(i):
                a, b = self.knot_positions[i + 1]
                self.grid[a][b] = '.'
                self.grid[x][y] = int(i + 1)
                self.knot_positions[i + 1] = (x, y)
                self.knot_histories[i + 1].append((x, y))

    def move_right(self):
        print(self.knot_positions)
        x, y = self.knot_positions[0]
        if y == self.size:
            return
        self.grid[x][y] = '.'
        self.grid[x][y+1] = '0'
        self.knot_positions[0] = (x, y+1)
        for i in range(len(self.knots) - 1):
            if not self.t_next_to_h(i):
                print(i, ' is not next to', i+1)
                print(i, 'is at', self.knot_positions[i])
                print(i+1, 'is at', self.knot_positions[i+1])
                a, b = self.knot_positions[i + 1]
                self.grid[a][b] = '.'
                self.grid[x][y+1] = str(i + 1)
                self.knot_positions[i + 1] = (x, y+1)
                self.knot_histories[i + 1].append((x, y+1))

        
        print(self.knot_positions)

    def t_next_to_h(self, head=0):
        x, y = self.knot_positions[head + 1]
        a, b = self.knot_positions[head]
        if a == x - 1 and b == y:
            return True
        if a == x + 1 and b == y:
            return True
        if a == x and b == y - 1:
            return True
        if a == x and b == y + 1:
            return True
        if a == x - 1 and b == y - 1:
            return True
        if a == x - 1 and b == y + 1:
            return True
        if a == x + 1 and b == y - 1:
            return True
        if a == x + 1 and b == y + 1:
            return True
        if a == x and b == y:
            return True
        
        return False

    def update(self):
        x, y = self.s_position
        self.grid[x][y] = 's'

        for i in range(len(self.knots) - 1, -1, -1):
            x, y = self.knot_positions[i]
            self.grid[x][y] = self.knots[i]

    def print_history(self, knot=1):
        grid = [['.' for i in range(self.size + 1)] for j in range(self.size)]
        for x, y in self.knot_histories[knot]:
            grid[x][y] = '#'
        string = ''
        for row in grid:
            string += ''.join(row) + '\n'  
        # print(string)
        return(grid)



with open('day_9.in') as f:
    moves = f.read().split('\n')
    # print(moves)

grid = Grid(300, 10)

for move in moves:
    direction, count = move.split(' ')
    count = int(count)
    print(direction, count)
    for i in range(count):
        grid.move(direction)
        # print(grid)

hashs = grid.print_history(2)
count = 0
for row in hashs:
    for item in row:
        if item == '#':
            count += 1


print('Part 1:')
print(count)
print()
print('Part 2:')
print()

