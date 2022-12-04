with open('day_4.in') as f:
    pairs = f.read().split('\n')
    counter = 0
    counter_overlap = 0
    for pair in pairs:
        pair = pair.split(',')
        indices0 = pair[0].split('-')
        indices1 = pair[1].split('-')
        if int(indices0[1]) >= int(indices1[1]) and int(indices0[0]) <= int(indices1[0]):
            counter += 1
        elif int(indices0[1]) <= int(indices1[1]) and int(indices0[0]) >= int(indices1[0]):
            counter += 1

        if int(indices0[1]) >= int(indices1[1]) and int(indices0[0]) <= int(indices1[1]):
            counter_overlap += 1
        elif int(indices0[1]) <= int(indices1[1]) and int(indices0[1]) >= int(indices1[0]):
            counter_overlap += 1
        





print('Part 1:')
print(counter)
print()
print('Part 2:')
print(counter_overlap)
