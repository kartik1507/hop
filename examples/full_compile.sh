#~/riscvgnutoolchain/riscv/bin/riscv32-unknown-elf-gcc -Wl,-Ttext,0x1008 -O2 $1.c -o $1.out
#~/riscvgnutoolchain/riscv/bin/riscv32-unknown-elf-objdump  -D --disassemble-zeroes --insn-width=4 $1.out > $1.out.dump
#~/code/scratch/26/get_opcodes.py $1.out.o2.dump

~/riscvgnutoolchain/riscv/bin/riscv32-unknown-elf-gcc -Wl,-Ttext,0x1000 -O2 $1.c -o $1.out
~/riscvgnutoolchain/riscv/bin/riscv32-unknown-elf-objdump  -D --disassemble-zeroes --insn-width=4 $1.out > $1.out.dump
../use_annotation.py $1.out.dump
echo 'check diff'
../correct_diff.py $1.out.dump.spld
echo '---'
../get_opcodes.py $1.out.dump.spld.corrected
file=`wc -l opcode_$1_0.out`
echo $file | awk '{print $1;}' > temp
(echo "obase=16"; cat temp) | bc > lines.out
# echo "obase=16; $lines" | bc
