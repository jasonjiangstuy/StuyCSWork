def sumup(x):
    sum = 0
    
    if isinstance(x, str):
        if x.isnumeric():
            return int(x)
    for i in x:
        if i.isnumeric():
            sum += int(i)
        else:
            return -1
    return sum

def getScores(filename, score='all'):
    import os
    #given filename in this directory
    os.chdir('C:/Users/jason/Downloads')
#     print(os.getcwd())
    try:
        f = open(filename, 'r')
        myFile = f.read()
    except:
        raise ValueError('filename '+ filename + ' not found in ' + os.getcwd())
    
    myFile = myFile.strip()
    eachschool = myFile.split('\n')
    pschools = []
    eachschool.pop(0)
    master = []
    for i in eachschool:
#         print(i)
        temp = []
        
        Name = False
        if '"' in i:
            before, throw, after = i.partition('"')
            name, throw, after = after.partition('"')
            i = before + after
            Name = True
        eles = i.split(',')
        if not Name:
            name = eles[1]
        temp.append(name)
        
        if score == 'all':
            hold = eles[-3:]
        elif score == 'reading':
            hold = eles[-3]
        elif score == 'math':
            hold = eles[-2]
        elif score == 'writing':
            hold = eles[-1]
        sum = sumup(hold)
        if sum == -1:
            continue #scores are not int,, school is invalid
        temp.append(sum)
#         print(temp)
        master.append(temp)
    f.close()
    return master
    

def highlow(filename):
    master = getScores(filename)
#     print(master)
    myMax = max(master, key= lambda x: x[1])
    myMin = min(master, key= lambda x: x[1])
    return myMax[0] + 'is highest with a score of ' + str(myMax[1]) + '\n' + myMin[0] + 'is lowest with a score of ' + str(myMin[1])
    
def nthSchool(filename, whichscore, nth):
    master = getScores(filename, whichscore)
#     print(master)
    final = sorted(master, key=lambda x:x[1])[::-1]
#     print(final)
    return final[nth][::-1]
        
    
print(nthSchool("SAT-2010.csv","writing",11))
print(highlow('SAT-2010.csv'))