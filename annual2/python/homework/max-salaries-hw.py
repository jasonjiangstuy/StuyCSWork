def MaxSalary(filename):
    import os
    #given filename in current directory
    print(os.getcwd())
    try:
        f = open(filename, 'r')
        myFile = f.read()
        myFile = myFile.strip()
        eachPerson = myFile.split('\n')
        eachSalary = []
        for i in eachPerson:
            temp = []
            for x in i.split(','):
                if x.isnumeric():
                    temp.append(float(x))
                else:
                    temp.append(x)
            eachSalary.append(temp)
        eachSalary.pop(0)
#         print(eachSalary)
        final = max(eachSalary, key=lambda x: x[-1])
        final.pop(1)
        return final
        f.close()
    except:
        raise ValueError('filename not found in ' + os.getcwd())
    
print(MaxSalary('salaries.csv')) 