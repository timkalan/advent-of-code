from collections import defaultdict


with open('day_8.in') as f:
    commands = f.read().split('\n')
    full_path = []
    directories = defaultdict(int)

    for cmd in commands:
        match cmd.split():
            case ['$', 'cd', '..']:
                full_path.pop()
            case ['$', 'cd', p]:
                full_path.append(p)
            case ['$', 'ls']:
                pass
            case ['dir', p]:
                pass
            case [s, f]:
                directories[tuple(full_path)] += int(s)
                path = full_path[:-1]
                while path:
                    directories[tuple(path)] += int(s)
                    path.pop()


total = sum([_ for _ in directories.values() if _ <= 100000])

needed_space = directories[('/', )] - 40000000
to_delete = min([_ for _ in directories.values() if _ > needed_space])

print(directories[('/', )])

print('Part 1:')
print(total)
print()
print('Part 2:')
print(to_delete)
