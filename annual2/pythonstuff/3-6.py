def my2plus(x):
    return x + 2

print(my2plus(3))

def harry(x):
    return x + 2

def cr(x):
    return (x ** (1 / 3))

def hcr(x):
    print(harry(x))
    return cr(harry(x))

print(hcr(25))
print(hcr(-10))
