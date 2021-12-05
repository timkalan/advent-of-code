lst = []
gamma = ''
epsilon = ''
ones = 0

with open('2021/03/day_3.in') as f:
    for line in f:
        lst.append(line)
        


for i in range(len(lst[0]) - 1):
    ones = 0
    for el in lst:
        if el[i] == '1':
            ones += 1
    if ones > len(lst) / 2:
        gamma += '1'
        epsilon += '0'
    else:
        gamma += '0'
        epsilon += '1'

      

with open('2021/03/day_3-1.out', 'w') as w:
    w.write(str(int(gamma, 2) * int(epsilon, 2)))

print('done!')


def check(lst, i):
    ones = 0
    for el in lst:
        if el[i] == '1':
            ones += 1
    
    if ones >= len(lst) / 2:
        return '1'
    else:
        return '0'


oxy = lst
co2 = lst

for i in range(len(lst[0]) - 1):
    val = check(oxy, i)
    new = []

    if len(oxy) == 0:
        break

    for el in oxy:
        if el[i] == val:
            new.append(el)

    oxy = new



for i in range(len(lst[0]) - 1):
    val = check(co2, i)
    nov = []

    if len(co2) == 1:
        break

    for ele in co2:
        if ele[i] != val:
            nov.append(ele)
    
    co2 = nov


with open('2021/03/day_3-2.out', 'w') as w:
    w.write(str(int(oxy[0], 2) * int(co2[0], 2)))

print('done!')