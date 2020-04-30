def maxHailRange(low,high):
  a = []
  for i in range(low, high + 1):
    a.append(hailLen(i))
  x = a.index(max(a))
  print(a)
  try:
    while a[x] == a[x + 1]:
      x += 1
  except:
    pass
  return(x + low)


def hailLen(n, *args):
  if args:
    x = args[0]
  else:
    x = 0
  x += 1
  if n == 1:
    return(x)
  else:
    if n % 2 == 1:
      return(hailLen((3*n+1), x))
    else:
      return(hailLen((n/2), x))



print(maxHailRange(15, 20))
# print(maxHail(19))
# → 8
