#!/usr/bin/python
import sys
from Crypto.Cipher import AES
from Crypto import Random
from Crypto.Util import Counter

file1 = []
file2 = []
for line in open(sys.argv[1]).readlines():
    file1.append(line)
for line in open(sys.argv[2]).readlines():
    file2.append(line)
key = "000102030405060708090a0b0c0d0e0f".decode("hex")
# ctr should be 128 bits
ctr = 10
cipher = AES.new(key, AES.MODE_ECB)
# print first, second
def xor_strings(xs, ys):
    return "".join(chr(ord(x) ^ ord(y)) for x, y in zip(xs, ys))

target = open(sys.argv[1][:-6] + ".out", 'w')
print sys.argv[1][:-6] + ".out"

for i in range(0, len(file1), 2):
    pt = file2[i + 1].rstrip() + file1[i + 1].rstrip() + file2[i].rstrip() + file1[i].rstrip();
    print pt
    msg = cipher.encrypt(format(ctr, '032x').decode("hex"))
    # print "block cipher output", "".join("{:02x}".format(ord(c)) for c in msg)
    # print format(255, '032x')
    # "8481831381018293bb01819300002197"
    # pt = "8481831381018293bb01819300002197"
    # print "pt", pt
    first = pt.decode("hex")
    second = "".join("{:02x}".format(ord(c)) for c in msg).decode("hex")
    target.write(xor_strings(first, second).encode("hex") + '\n')
    ctr = ctr + 1
