#!/usr/bin/python
import sys

f = open(sys.argv[1], "r")
fwrite = open(sys.argv[1] + '.corrected', 'w')
l = f.readline()
i = 0;
j = 0;
oldInt = 0;
oldLen = 0
while l != '':
    #l = l.strip()
    if "Disassembly of section .comment:" in l:
        break
    if l == '':
        fwrite.write(l)
    elif l[0] != ' ':
        fwrite.write(l)
    else:
        oldL = l
        l = l.strip()
        s = l.split()
        cur = s[0][0 : len(s[0]) - 1]
        curInt = int('0x' + s[0][0 : len(s[0]) - 1], 16)
        #print curInt, oldInt
        if (not ((curInt - oldInt == oldLen))) and (cur != '1000'):
            print cur, (curInt - oldInt), oldLen
            print '   0000:	' + ("0" * (curInt - oldInt - oldLen) * 2)
            fwrite.write('    0000:	' + ("0" * (curInt - oldInt - oldLen) * 2) + '    hello\n');
        oldInt = curInt
        oldLen = len(s[1]) / 2
        fwrite.write(oldL)
    l = f.readline()
