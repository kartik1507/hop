HOP
======

HOP is a prototype hardware implementation on a RISC V processor and Freecursive ORAM to determine the efficiency of obfuscated programs. This document describes how to install and run a program on HOP.

## Installing HOP
Install the 32 bit RISC-V GNU GCC Compiler Toolchain.

Install Xilinx Vivado.

## Compiling and Running HOP
* Compiling a program

cd examples/sum/

../full_compile.sh sum

* Running the program.

Update paths in the first few lines of obfuscation/oram/Top.v.

Run testCPU.v with the following simulation macros:
MACROSAFE 1
FPGA_MEMORY 1 
SIMULATION_VIVADO 1

## Developed by
1. Kartik Nayak (kartik@cs.umd.edu)
2. Christopher W. Fletcher (cwfletch@illinois.edu)
3. Ling Ren (renling@mit.edu)
