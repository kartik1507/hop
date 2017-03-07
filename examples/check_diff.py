#!/usr/bin/python
import sys

f = open(sys.argv[1], "r")
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
        pass
    elif l[0] != ' ':
        pass
    else:
        oldL = l
        l = l.strip()
        s = l.split()
        cur = s[0][0 : len(s[0]) - 1]
        curInt = int('0x' + s[0][0 : len(s[0]) - 1], 16)
        #print curInt, oldInt
        if (not ((curInt - oldInt == oldLen))):
            print cur, (curInt - oldInt), oldLen
        oldInt = curInt
        oldLen = len(s[1]) / 2
    l = f.readline()

