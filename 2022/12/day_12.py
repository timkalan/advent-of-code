def get_moves(square, pos=(0, 0)):
    opts = []
    elev = elevations[square[pos[0]][pos[1]]]
    for i, j in [(1, 0), (0, 1), (0, -1), (-1, 0)]:
        if pos[0] + i < 0 or pos[0] + i >= len(square):
            continue
        if pos[1] + j < 0 or pos[1] + j >= len(square[0]):
            continue

        target = elevations[square[pos[0] + i][pos[1] + j]]
        if target <= elev + 1:
            opts.append((pos[0] + i, pos[1] + j))

    return opts

def get_moves2(square, pos=(0, 0)):
    opts = []
    elev = elevations[square[pos[0]][pos[1]]]
    for i, j in [(1, 0), (0, 1), (0, -1), (-1, 0)]:
        if pos[0] + i < 0 or pos[0] + i >= len(square):
            continue
        if pos[1] + j < 0 or pos[1] + j >= len(square[0]):
            continue

        target = elevations[square[pos[0] + i][pos[1] + j]]
        if target >= elev - 1:
            opts.append((pos[0] + i, pos[1] + j))

    return opts


def dijkstra(moves, start):
    distances = {node: float('inf') for node in moves}
    distances[start] = 0
    previous = {node: None for node in moves}
    Q = list(moves)

    while Q:
        u = min(Q, key=lambda x: distances[x])
        Q.remove(u)

        for v in moves[u]:
            alt = distances[u] + 1
            if alt < distances[v]:
                distances[v] = alt
                previous[v] = u

    return distances, previous

def reconstruct_path(previous, start, end):
    current = end
    path = []
    while current != start:
        path.append(current)
        current = previous[current]
    path.append(start)
    path.reverse()
    return path



with open('day_12.in') as f:
    square = f.read().split('\n')

    elevations = {letter: number for number, letter in enumerate('abcdefghijklmnopqrstuvwxyz')}
    elevations['S'] = 0
    elevations['E'] = 25

    moves1 = {}
    moves2 = {}
    start = (0, 0)
    end = (0, 0)
    options = []
    for i in range(len(square)):
        for j in range(len(square[0])):
            moves1[(i, j)] = get_moves(square, (i, j))
            moves2[(i, j)] = get_moves2(square, (i, j))
            if square[i][j] == 'S':
                start = (i, j)
            if square[i][j] == 'E':
                end = (i, j)
            if square[i][j] == 'a':
                options.append((i, j))
    
dist, previous = dijkstra(moves1, start)
# path = reconstruct_path(previous, start, end)

dists, _ = dijkstra(moves2, end)
mini = 440
for option in options:
    if dists[option] < mini:
        mini = dists[option]

print('Part 1:')
print(dist[end])
print()
print('Part 2:')
print(mini)

