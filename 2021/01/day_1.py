# prvi del

num_increases = 0
prev = float('inf')

with open('2021/01/day_1.in') as f:
    for line in f:
        if int(line) > prev:
            num_increases += 1
        
        prev = int(line)

with open('2021/01/day_1-1.out', 'w') as w:
    w.write(str(num_increases))

print('done!')


# drugi del

num_increases = 0
nums = []

with open('2021/01/day_1.in') as f:
    for line in f:
        nums.append(int(line))

sums = []
start = 0
end = 3

for el in nums:
    if end > len(nums):
        break
    sums.append(sum(nums[start:end]))
    start += 1 
    end += 1

for i in range(1, len(sums)):
    if sums[i] > sums[i-1]:
        num_increases += 1

with open('2021/01/day_1-2.out', 'w') as w:
    w.write(str(num_increases))

print('done!')