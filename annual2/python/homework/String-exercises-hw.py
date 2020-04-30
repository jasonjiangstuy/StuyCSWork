# String Exercises
# Some of these exercises require repetition, so use WHILE or FOR and not recursion. You may use String methods, unless the problem specifically prohibits it.
# 
# 1a. We can convert one set of characters (lower-case letters) into another (upper-case), so we can convert any set of characters into any other.  Why might we want to do this?  How about encryption?  Let's try to encrypt text the way Julius Caesar probably did (were he to have known English and Python).  We discussed in class the conversion of lower-case characters to upper-case using
# 
# 	before='abcdefghijklmnopqrstuvwxyz'
# 	after ='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
# ...we can just replace those with other sequences.  For instance, Julius' coding converted each letter to a letter 3 places before it: D became A, E became B, Z became W, and A became X, etc.  So, here are the new sequences:
# 
Julius_before='defghijklmnopqrstuvwxyzabcDEFGHIJKLMNOPQRSTUVWXYZABC'
Julius_after ='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
# Create the the function Encrypt(some_text) that takes a string and returns a new string encrypted by replacing each letter with a letter 3 spaces back (using Julius_before and Julius_after). And while you're at it, create Decrypt(encrypted_text) that turns that encrypted text back into the original readable "plain-text".
#
def push(l, direction):
    if direction > 0:
        pointer = Julius_after.index(l)
        return Julius_before[pointer]
    else:
        pointer = Julius_before.index(l)
        return Julius_after[pointer]
    
def Encrypt(text):
    final =""
    for i in text:
        final += push(i, 3)
    return final

def Decrypt(text):
    final =""
    for i in text:
        final += push(i, -3)
    return final

print(Decrypt('defghijklm')) #abcdefghij
print(Encrypt('abcdefghij')) #defghijklm
print(Decrypt(Encrypt('test')))
# 1b. Let's generalize.  You can see that Encrypt() and Decrypt() really just move forward and back 3 spaces.  Create the function ShiftCrypt(some_text,shift) that will shift lower-case letters to other lower-case letters, and upper-case letters to other upper-case letters, by the shift amount.  But use the ASCII code -- with Python's ord() and chr() functions -- to do the shift. Notice that negating the shift amount decrypts whatever was encrypted with shift. Examples:
#
def generalPush(l, direction):
    if ord('a') <= ord(l) <= ord('z'):
        return chr(((ord(l) - ord('a') + direction) % 26) + ord('a'))
    if ord('A') <= ord(l) <= ord('Z'):
        return chr(((ord(l) - ord('A') + direction) % 26) + ord('A'))
#     print(l)
    raise ValueError('char not found')
    
def ShiftCrypt(text, shift):
    final = ""
    for i in text:
#         print(final)
        if i == ' ':
           final += i
           continue
        final += generalPush(i, shift)
#     print(final)
    return final

print(ShiftCrypt('abcDEF',4)) #-> 'efgJKL'
print(ShiftCrypt(ShiftCrypt('sometext',5),-5)) #-> sometext

# 2a. People's names can be spelled with various capitalizations, (for instance: 'John Smith' and 'john smith' and 'JOHN SMITH'), and yet they're all the same name.  Write a function called IsSameName(name1,name2) that will return True if the two names are the same, and False otherwise.
def IsSameName(nO, nT):
    return nO.lower() == nT.lower()

print(IsSameName('John smith', 'JOHN Smith')) # returns True
print(IsSameName('John Smith', "John's Myth"))  # returns False
# 
# 2b.  Create the function CapWord(word) that capitalizes a single word in exactly the same way that the built-in string method s.capitalize() does.  Of course, you may NOT use that built-in string method.

def CapWord(word):
    word = word.lower()
    if len(word) <= 1:
        return word.upper()
    return word[0].upper() + word[1:]

# 2c. Create the function CapName(name) that capitalizes a name consisting of a first name and last name separated by a space.  Example:
def CapName(i):
    things = i.split(" ")
    c = 0
    print(things)
    while (c < len(things)):
        things[c] = CapWord(things[c])
        c += 1
    things = ' '.join(things)
    return things
    
print(CapName('joHN SMith'))  # returns 'John Smith'
# 
# 3a. Officially, names are often listed with lastname first, as in "Brooks, Peter".  Let's write a function to correct that: FirstLast(name) will be given a string with a lastname followed by a comma and a space, followed by the firstname. It will return a string with the firstname, followed by a space, followed by the lastname. Use string-slicing.  You do not need to use a loop here.  Example:
def FirstLast(string):
    s = string.split(' ')
    s = s[::-1]
    return ', '.join(s).strip(', ')
print(FirstLast('Brooks, Peter'))  # returns 'Peter Brooks'

# 3b. Assume that you have a long string consisting of a sequence of people's "lastname, firstname" pairs terminated by ";" (semi-colons).  Convert them to " firstname lastname" pairs terminated by semi-colons. There can be any number of these name-pairs in the string.  Call it FirstLastSequence(names).  Example:

def FirstLastSequence(string):
    s = string.strip(';').split(';')
    for i in s:
        s[s.index(i)] =  FirstLast(i)
    return ';'.join(s) + ';'
print(FirstLastSequence('Brooks, Peter;Holmes, David;Pascu, Ms.;')) # returns 'Peter Brooks;David Holmes;Ms. Pascu;'
# 4. It is usually important to know what kind of data is inside a file.  The creator of a file usually helps by naming the file with a standard file suffix (like .mp3 or .jpg), to indicate that the file contains music or a picture.  Create the function FileClassifier(filename) that will be given the name of a file, and will return its type.  Note that the filename suffix may be in UPPER-CASE (.JPEG) or lower-case (.jpeg) and should still be classified correctly.   You may use any string methods you find appropriate (or none). Here's how it should classify:
# 
suffixtype = {
'jpg':'picture',
'jpeg':'picture',
'mp3':'music',
'nlogo':'Netlogo',
'py':'Python'
}
def FileClassifier(string):
    throw, throw, extension = string.rpartition('.')
    print(extension)
    return suffixtype[extension.lower()]
print(FileClassifier('StarSpangledBanner.Mp3'))  # returns 'music'
print(FileClassifier('Fred.mp3.JPEG.nlogo'))     # returns 'Netlogo'
#  
# Double Challenge Problem:  Let's work with Caesar ciphers like we did in problem 1b.  This is just a shift of lower-case characters by a certain number of positions (say, n positions), and the same shift of n positions for the upper-case characters as well.  And, of course, no shift for non-lettetrs.  So if we knew what the value of n was, we could decrypt a message that was encrypted using this technique.  Well, what if we have an encrypted message but we don't know what n is?  How can we decrypt such a message?  One way to do that is to make a guess for n and try decrypting the message with that n and see if it looks like something that we can read -- does it have English words?  I am going to give you a quotation from a famous scientist, that's been encryted using the Caesar encryption technique, but I'm not going to give you the value of n.   However, to make the problem harder (this is why I pull down the big bucks), I'm not going to allow you to use your knowledge of English to figure this out.  I will, however, give you another clue: the name of one of the NYC's major professional sports teams is one of the words in the actual quotation. 
# So, here is your task ... the encrypted message is:
# 	Zw z yrmv jvve wlikyvi zk zj sp jkreuzex fe kyv jyflcuvij fw Xzrekj
# You have to write the function TCP(s) which will be given the string above, and will return the original quotation (and copy the quotation into the Comments-to-Teacher).  The algorithm that figures it out will need to include the fact that one of the words in the quotation is the name of a professional NY sports team.  You CANNOT just use your knowledge of English and read the various attempts at decryption and try to visually spot the one that makes sense.  The answer must be found solely by your Python function.  BTW, this is what cryptanalysts do.
sportTeams = ['New York Yankees', 'New York Giants', 'New York Rangers', 'New York Knicks', 'New York Jets', 'New York Mets', 'Brooklyn Nets', 'New York Islanders', 'New Jersey Devils', 'New York Red Bulls', 'New York Liberty', 'Sky Blue FC', 'New York City FC']
def inString(string):
    for i in sportTeams:
        if i in string:
            return True
        for s in i.split():
            if s in string:
                return True
    return False
def TCP(s):
    counter = 0
    while counter <= 26:
        if inString(ShiftCrypt(s, counter)):
            return ShiftCrypt(s, counter)
        counter += 1
    return 'no'

print(TCP('Zw z yrmv jvve wlikyvi zk zj sp jkreuzex fe kyv jyflcuvij fw Xzrekj'))