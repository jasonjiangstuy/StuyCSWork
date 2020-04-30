def rev1(l):
    f = []
    for i in l:
        f.insert(0, i)
    return f


def ms(l):
    f = ""
    for i in l:
        f += i
        f += " "
    f = f.strip()
    f += "."
    return f
print(ms(['test', 'swap' , 'this']))