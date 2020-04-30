#     send
#     1ore
# ------------
# ---1oney
# allChar = 'sendmoremoney'
# def setPossibleValues(chars):
#     for i in chars:
#         if not i in possibleValues.keys():
#             possibleValues.update({i: '0123456789'})
#     print(possibleValues)
    
parameters = [
    ('de', 'y'),
    ('nr', 'e'),
    ('eo', 'n'),
    ('sm', 'o'),
    ('', 'm')

            ]

possibleValues = {
    's': ['0123456789'],
    'e': ['0123456789'],
    'n': ['0123456789'],
    'd': ['0123456789'],
    'm': ['1'],
    'o': ['0123456789'],
    'r': ['0123456789'],
    'y': ['0123456789']
    } #letter: 'string of all the numbs it can be'
    
def getPossibleCombos( pew ):
    for i in pew:
        add = i[0] #'de'
        remainder = i[1] #'y'
        addv2 = []
        for i in add:
            addv2.append(possibleValues[i])
        remainderv2 = possibleValues[remainder]
        
    


def crack():
#     setPossibleValues(allChar)
    remander = 0
    getPossibleCombos(parameters)
            

# crack()

def addTogether(s,e,n,d,m,o,r,y):
    send = s*1000 + e*100 + n*10 + d
    more = m*1000 + o*100 + r*10 + e
    money = m*10000 + o*1000 + n*100 + e*10+ y
    solution = send + more == money
#     print(solution)
#     print(send + more)
#     print(money)
    if solution:
        print(send + more)
        print(money)
        return True
    else:
        return False
    
def alldiffrent(s):
    isIn = []
    for i in s:
        if i in isIn:
            return False
        isIn.append(i)
    return True
def easySolution():
    for s in range(10):
        for e in range(10):
            for n in range(10):
                for d in range (10):
                    for m in range (2):
                        for o in range (10):
                            for r in range (10):
                                for y in range (10):
                                    if addTogether(s,e,n,d,m,o,r,y) and alldiffrent([s,e,n,d,m,o,r,y]):
                                        return((s,e,n,d,m,o,r,y))
                
                                
print(easySolution())            

foundanswer = (2, 8, 1, 7, 0, 3, 6, 5)

def testAnswer(final):
    s,e,n,d,m,o,r,y = final
    send = s*1000 + e*100 + n*10 + d
    more = m*1000 + o*100 + r*10 + e
    money = m*10000 + o*1000 + n*100 + e*10+ y
    solution = send + more == money
#     print(solution)
#     print(send + more)
#     print(money)
    print(send + more)
    print(money)


testAnswer(foundanswer)
