def manhattan(a, b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])

with open('day_15.in') as f:
    sensors_beacons = f.read().split('\n')
    positions = []

    for sensor_beacon in sensors_beacons:
        sensor_beacon = sensor_beacon.split(': ')

        sensor = sensor_beacon[0].split('at ')[1].split(', ')
        sensorx = int(sensor[0].split('=')[1])
        sensory = int(sensor[1].split('=')[1])

        beacon = sensor_beacon[1].split('at ')[1].split(', ')
        beaconx = int(beacon[0].split('=')[1])
        beacony = int(beacon[1].split('=')[1])

        positions.append(((sensorx, sensory), (beaconx, beacony)))

    y = 2000000

    row = {}
    for sensor, beacon in positions:
        x = sensor[0]
        offset = abs(y - sensor[1])
        coverage = manhattan(sensor, beacon) - offset

        if sensor[1] == y:
            row[x] = 'S'
        if beacon[1] == y:
            row[beacon[0]] = 'B'

        for i in range(x - coverage, x + coverage + 1):
            if i not in row:
                row[i] = '#'
            
full = sum([1 for i in row.values() if i == '#'])

mini = 0
maxi = 4000000

final = []
for sensor, beacon in positions:
    dist = manhattan(sensor, beacon)
    maxx = min(maxi + 1, sensor[0] + 2 + dist)
    minx = max(mini, sensor[0] - 1 - dist)
    maxy = min(maxi + 1, sensor[1] + 2 + dist)
    miny = max(mini, sensor[1] - 1 - dist)

    for x in range(maxx):
        y = dist + 1 - x 
        if y >= miny and y <= maxy:
            
            for sen, bea in positions:
                if manhattan((x, y), sen) <= manhattan(sen, bea):
                    break
            
            final.append((x, y))


print(final)

print('Part 1:')
print(full)
print()
print('Part 2:')
print(final[0][0] * maxi + final[0][1])


