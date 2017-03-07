#!/usr/bin/python
import sys

f = open(sys.argv[1], "r")
l = f.readline()
out0 = open('opcode_' + sys.argv[1].split('.')[0] + '_0.out', 'w')
out1 = open('opcode_' + sys.argv[1].split('.')[0] + '_1.out', 'w')
i = 0;
j = 0;
data_start = False
st = ""
final_st = ""
while l != '':
    #l = l.strip()
    if "Disassembly of section .comment:" in l:
        if st != "":
            print "check st ", st
        break
    if l == '':
        pass
    elif l[0] != ' ':
        pass
    else:
        oldL = l
        l = l.strip()
        """
        if data_start == False:
            if i % 2 == 0:
                out0.write(l[7:15])
                out0.write("\n")
            else:
                out1.write(l[7:15])
                out1.write("\n")
            i = i + 1;
        else:
            print l[7:11]
            if j % 4 == 0:
                out0.write(l[7:11])
            elif j % 4 == 1:
                out0.write(l[7:11])
                out0.write("\n")
            elif j % 4 == 2:
                out1.write(l[7:11])
            elif j % 4 == 3:
                out1.write(l[7:11])
                out1.write("\n")
            j = j + 1;"""
        s = l.split()
        st = s[1] + st
        if len(st) >= 8:
            final_st = final_st + st[len(st) - 8 : len(st)]
            st = st[0 : len(st) - 8]
            if len(st) != 0 and len(st) != 4:
                print st, len(st)
    l = f.readline()

for i in range(0, len(final_st), 16):
#for (i = 0; i < len(st); i = i + 16):
    out0.write(final_st[i : i + 8])
    out0.write("\n")
    out1.write(final_st[i + 8 : i + 16])
    out1.write("\n")
if (len(final_st) / 16) % 2 != 0:
    out0.write("00000000\n")
    out1.write("00000000\n")
out0.close()
out1.close()
