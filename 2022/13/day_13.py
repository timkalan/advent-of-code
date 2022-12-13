def compare_nested_lists(l, r):
    if type(l) == int and type(r) == int:
        return l - r
    if type(l) == list and type(r) == list:
        if len(l) == 0 and len(r) == 0: 
            return 0
        if len(l) == 0:                 
            return -1
        if len(r) == 0:                 
            return 1
        return compare_nested_lists(l[0], r[0]) or compare_nested_lists(l[1:], r[1:])
    return compare_nested_lists([l], r) if type(l) == int else compare_nested_lists(l, [r])


with open('day_13.in') as f:
    packet_pairs = f.read().split('\n\n')
    indices = []
    index = 0
    packets = [[[2]], [[6]]]
    for i in range(len(packet_pairs)):
        pair = packet_pairs[i].split('\n')
        pair[0] = eval(pair[0])
        pair[1] = eval(pair[1])
        packet_pairs[i] = pair

        packets.append(pair[0])
        packets.append(pair[1])

        index += 1
        if compare_nested_lists(pair[0], pair[1]) < 0:
            indices.append(index)

    for i in range(len(packets)):
        for j in range(i + 1, len(packets)):
            if compare_nested_lists(packets[i], packets[j]) > 0:
                packets[i], packets[j] = packets[j], packets[i]

print('Part 1:')
print(sum(indices))
print()
print('Part 2:')
print((packets.index([[2]]) + 1) * (packets.index([[6]]) + 1))


