import sys
import math

correct = '''Correct usage: python3 BaselHw.py filename num [num ...] \nMust only have one or more positive integers'''
# print(sys.argv)
args = sys.argv
args = args[1:]
valid = []
go = True

def WriteToFile(string, filename):
    try:
        f = open(filename, 'w+')
        try:
            f.write(string)
        except:
            print(correct + '; file could not be written to')
    except:
        print(correct + "; invalid filename")
    
    
if len(args) > 1:
    filename = args[0]
    args = args[1:]
    for i in args:
        if i.isdigit():
            valid.append(int(i))
        else:
            go = False
            break
else:
    go = False
    
if go:
    finalString = '''
<html>
<body>
<center>
<h3>The Basel Problem Calculations</h3>
<table border="1">
<tr><b>
<td>N</td><td>Sum</td><td>pi*pi/6</td><td>Difference</td></b></tr>
'''
    for x in valid:
        sum = 0
        for i in range(x):
            sum += (1/(i+1)**2)
            
        piDivided = (math.pi**2) / 6

        finalString += '<tr><td>' + str(x) + '</td><td> ' + str(sum) + '</td><td> ' + str(piDivided) + '</td><td> ' + str(abs(piDivided - sum)) + '</td></tr>'
    finalString += '''
</table>
</center>
</body>
</html>
'''
    WriteToFile(finalString, filename)
else:
    print(correct)
    