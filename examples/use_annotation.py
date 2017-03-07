#!/usr/bin/python
import sys

f = open(sys.argv[1], "r")
l = f.readline()
out = open(sys.argv[1] + '.spld', 'w')
i = 0;
j = 0;
while l != '':
    #if len(l.split()) >= 3 and l.split()[2][0] == 'b':
     #   print l.split()[2]
    if l == '':
        out.write(l);
    elif l[0] != ' ':
        out.write(l);
    elif len(l.split()) >= 5 and 'ScratchPadLoad' in l.split()[4]:
        temp = l.split()[4]
        temp2 = temp.split('_')[1]
        isReplaceable = '0';
        if (len(temp.split('_')) == 3):
            isReplaceable = temp.split('_')[2][0]
            memSize = temp2[0 : len(temp2)]
        else:
            memSize = temp2[0 : len(temp2) - 1]
        print isReplaceable
        if (isReplaceable != '0') and (isReplaceable != '1'):
            print "check value isReplaceable = ", isReplaceable
        # print temp2
        print memSize
        tempList = list(l)
        splitL = l.split()
        loadInstruction = isReplaceable + '{0:016b}'.format(int(memSize)) + '011000000000011'
        loadInstructionInHex = '%0*x' % ((len(loadInstruction) + 3) // 4, int(loadInstruction, 2))
        for i in range(10, 18):
            tempList[i] = loadInstructionInHex[i - 10]
        splitL[1] = '  ' + loadInstructionInHex
        # for i in range(0, 12):
        splitL[2] = '             '
        splitL[3] = ''
        splitL[4] = ''
        toWrite = []
        # toWrite.append(''.join(tempList[0 : 30]))
        toWrite.append(' '.join(splitL))

        # we need to read memSize amount of information in all
        # search for which register contains the information until a branch appears
        l = f.readline()
        while (l.split()[2] != 'sw'): # this will be the imemdiate next instruction
            toWrite.append(l);
            l = f.readline();
        ret = []
        operand = l.split()[3]
        ret.append('spld ' + operand[len(operand) - 3 : len(operand) - 1] + ',' + operand.split(',')[1].split('(')[0])
        # if (operand.split(',')[0] != operand.split(',')[1]):
            # print 'unequal entries on mv?'
        # ret.append('spld ' + operand.split(',')[1])
        print loadInstructionInHex
        toWrite[0] = '  ' + toWrite[0]
        toWrite[0] += ret[0]
        toWrite[0] += ',' + memSize + '\n'
        for stat in toWrite:
            out.write(stat)
        out.write(l)
        # _17bits__ 011 00000 0000011
        """
        while len(l.split()) >= 3 and l.split()[2][0] != 'b':
            if l.split()[2] == 'lw':
                operand = l.split()[3]
                ret.append('spld ' + operand[len(operand) - 3 : len(operand) - 1] + ',' + operand.split(',')[1].split('(')[0])
                print operand[len(operand) - 3 : len(operand) - 1] + ',' + operand.split(',')[1].split('(')[0]
            toWrite.append(l)
            l = f.readline()
        print ret[0]
        toWrite[0] += ret[0]
        toWrite[0] += ',' + memSize + '\n'
        for stat in toWrite:
            out.write(stat)
        out.write(l)
        """
    else:
        out.write(l)
    l = f.readline()
    if (l.find('Disassembly of section .comment:') != -1):
        break

out.close()
