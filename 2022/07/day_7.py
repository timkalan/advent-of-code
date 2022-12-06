with open('day_7.in') as f:
    datastream = f.read()
    n_packet = 0
    n_message = 0
    for i in range(len(datastream)):
        if len(set(datastream[i:i+4])) == 4 and n_packet == 0:
            n_packet = i+4
            
        
        if len(set(datastream[i:i+14])) == 14:
            n_message = i+14
            break
            

            






print('Part 1:')
print(n_packet)
print()
print('Part 2:')
print(n_message)
