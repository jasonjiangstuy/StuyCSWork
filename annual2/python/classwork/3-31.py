q = 'abcdef'

def sf(letter, offset):
    x = q.find(letter)
    x += offset
    return q[x % len(q)]
    
#sf(letter, offset)
print(sf('a', 60))

l = 'abcdefghijklmnopqrstuvwxyz'
s = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
def uppercase(c):
    final = ""
    x = l.find(c)
    print(x)
    if x != -1:
        return s[x]
    else:
            #print(c)
        return c

print(uppercase('u'))
print(uppercase('L'))