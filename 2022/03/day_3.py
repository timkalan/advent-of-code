with open('day_3.in') as f:
    rucksacks = f.read().split('\n')
    priorities = list('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')
    priority_both = 0
    priority_group = 0
    group_counter = 0
    group_item = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' 
    for rucksack in rucksacks:
        n_items = len(rucksack)
        comp1 = rucksack[:n_items//2]
        comp2 = rucksack[n_items//2:]
        shared = [char for char in comp1 if char in comp2]
        priority_both += priorities.index(shared[0]) + 1

        group_item = [char for char in group_item if char in rucksack]
        group_counter += 1
        if group_counter == 3:
            priority_group += priorities.index(group_item[0]) + 1
            group_counter = 0
            group_item = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'





print('Part 1:')
print(priority_both)
print()
print('Part 2:')
print(priority_group)