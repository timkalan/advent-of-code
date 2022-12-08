def is_visible(x, y, trees):
    height = int(trees[x][y])
    opts = 4
    for i in range(x+1, len(trees)):
        if int(trees[i][y]) >= height:
            opts -= 1
            break
    
    for i in range(x):
        if int(trees[i][y]) >= height:
            opts -= 1
            break

    for j in range(y+1, len(trees[x])):
        if int(trees[x][j]) >= height:
            opts -= 1
            break

    for j in range(y):
        if int(trees[x][j]) >= height:
            opts -= 1
            break

    if opts == 0:
        return False
    return True

def scenic_score(x, y, trees):
    height = int(trees[x][y])
    left = 0
    right = 0
    up = 0
    down = 0
    for i in range(x+1, len(trees)):
        down += 1
        if int(trees[i][y]) >= height:
            break
    
    for i in range(x-1, -1, -1):
        up += 1
        if int(trees[i][y]) >= height:
            break

    for j in range(y+1, len(trees[x])):
        right += 1
        if int(trees[x][j]) >= height:
            break

    for j in range(y-1, -1, -1):
        left += 1
        if int(trees[x][j]) >= height:
            break

    return up * down * left * right

with open('day_8.in') as f:
    trees = f.read().split('\n')
    count = 0
    scores = []
    for i in range(len(trees)):
        for j in range(len(trees[i])):
            scores.append(scenic_score(i, j, trees))
            if is_visible(i, j, trees):
                count += 1


print('Part 1:')
print(count)
print()
print('Part 2:')
print(max(scores))


