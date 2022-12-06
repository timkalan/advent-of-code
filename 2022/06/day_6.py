import re
import copy

def follow_instruction(stacks, instruction):
    to_move = int(instruction[0])
    start = int(instruction[1]) - 1
    end = int(instruction[2]) - 1

    starting_stack = stacks[start]
    ending_stack = stacks[end]

    for _ in range(to_move):
        ending_stack.append(starting_stack.pop())


def follow_instruction_9001(stacks, instruction):
    to_move = int(instruction[0])
    start = int(instruction[1]) - 1
    end = int(instruction[2]) - 1

    starting_stack = stacks[start]
    ending_stack = stacks[end]

    movement = []
    for _ in range(to_move):
        movement.insert(0, starting_stack.pop())
    

    ending_stack.extend(movement)

with open('day_6.in') as f:
    positions, instructions = f.read().split('\n\n')
    positions = positions.split('\n')
    stacks = [[] for _ in range((len(positions[0]) + 1) // 4)]
    for row in positions[:-1]:
        last_letter = False
        stack_count = 0
        for i, char in enumerate(row):
            if char not in '[ ]':
                stacks[stack_count].insert(0, char)
            if (i+1) % 4 == 0:
                stack_count += 1 

    instructions = instructions.split('\n')
    instructions = [re.findall(r'\d+', instruction) for instruction in instructions ]

    stacks9001 = copy.deepcopy(stacks)

    for instruction in instructions:
        follow_instruction(stacks, instruction)

    tops = ''.join([stack[-1] for stack in stacks])

    for instruction in instructions:
        follow_instruction_9001(stacks9001, instruction)

    tops9001 = ''.join([stack[-1] for stack in stacks9001])






print('Part 1:')
print(tops)
print()
print('Part 2:')
print(tops9001)
