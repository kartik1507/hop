HOP
======

HOP is a prototype hardware implementation on a RISC V processor and Freecursive ORAM to determine the efficiency of obfuscated programs. This document describes how to install and run a program on HOP.

## Installing HOP
`git clone https://github.com/kartik1507/hop.git`

Install the 32 bit RISC-V GNU GCC Compiler Toolchain. This will install the toolchain at /opt/riscv.

`cd hop/scripts`

`./install_riscv_gnu_toolchain.sh`

Install Xilinx Vivado 2015.2 - HL WebPack. This will install Vivado at /opt/Xilinx/ and start it for the first time.

`./install_vivado`

## Removing installation files
1. Run `./cleanup.sh` to remove build files
2. After a successful Vivado installation, run:

`sudo rm /opt/Xilinx/Vivado/2015.2/scripts/init.tcl`

## Obtaining a free Vivado license
1. Visit [Xilinx getlicense webpage](https://www.xilinx.com/getlicense)
2. Obtain a license for "Vivado Design Suite: HL WebPACK 2015 and Earlier License"
3. In Vivado, install license at Help -> ManageLicense

## Compiling and Running HOP
* Compiling a program

`cd examples/sum/`

`../full_compile.sh sum`

(the first parameter is the name of the C file without the .c extension)

* Running the program.

Update paths in the first few lines of `obfuscation/oram/Top.v` to reflect the files in examples/sum/.
Run Flow -> Run Simulation -> Run Behavioral Simulation

## Developed by
1. Kartik Nayak (kartik@cs.umd.edu)
2. Christopher W. Fletcher (cwfletch@illinois.edu)
3. Ling Ren (renling@mit.edu)
