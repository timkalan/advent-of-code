class Monkey:

    def __init__(self, starting_items, operation, test, true_monkey, false_monkey):
        self.items = starting_items
        self.operation = operation
        self.test = test
        self.true_monkey = true_monkey
        self.false_monkey = false_monkey
        self.inspect_count = 0

    def operate(self, item):
        py_op = self.operation.split('= ')[1]
        py_op = py_op.split(' ')
        if py_op[1] == '+':
            if py_op[2].isdigit():
                item += int(py_op[2])
            else:
                item += item
        elif py_op[1] == '*':
            if py_op[2].isdigit():
                item *= int(py_op[2])
            else:
                item *= item

        item = item // 3
        return item

    def operate2(self, item):
        py_op = self.operation.split('= ')[1]
        py_op = py_op.split(' ')
        if py_op[1] == '+':
            if py_op[2].isdigit():
                item += int(py_op[2])
            else:
                item += item
        elif py_op[1] == '*':
            if py_op[2].isdigit():
                item *= int(py_op[2])
            else:
                item *= item

        item = item % M
        return item

    def test_item(self, item):
        if item % self.test == 0:
            return True
        else:
            return False

    
def play_round(monkey_list):
    for monkey in monkey_list:
        for item in monkey.items:
            operated = monkey.operate(item)
            monkey.inspect_count += 1
            if monkey.test_item(operated):
                monkey_list[monkey.true_monkey].items.append(operated)
            else:
                monkey_list[monkey.false_monkey].items.append(operated)
        
        monkey.items = []

def play_round2(monkey_list):
    for monkey in monkey_list:
        for item in monkey.items:
            operated = monkey.operate2(item)
            monkey.inspect_count += 1
            if monkey.test_item(operated):
                monkey_list[monkey.true_monkey].items.append(operated)
            else:
                monkey_list[monkey.false_monkey].items.append(operated)
        
        monkey.items = []


with open('day_11.in') as f:
    monkeys = f.read().split('\n\n')
    monkey_objs = []
    for monkey in monkeys:
        for line in monkey.split('\n'):
            if line.startswith('  Starting'):
                starting_items = line.split(':')[1].strip().split(', ')
            if line.startswith('  Operation'):
                operation = line.split(': ')[1]
            if line.startswith('  Test'):
                test = int(line.split(' ')[5])
            if line.startswith('    If true'):
                true_monkey = int(line.split(' ')[-1])
            if line.startswith('    If false'):
                false_monkey = int(line.split(' ')[-1])
            
        starting_items = [int(item) for item in starting_items]
        monkey_objs.append(Monkey(starting_items, operation, test, true_monkey, false_monkey))

M = 1
for obj in monkey_objs:
    M *= obj.test

for i in range(10000):
    play_round2(monkey_objs)

totals = []
for obj in monkey_objs:
    print(obj.inspect_count)
    totals.append(obj.inspect_count)

totals.sort(reverse=True)

monkey_business = totals[0] * totals[1]






print('Part 1:')
print(monkey_business)
print()
print('Part 2:')
print()

