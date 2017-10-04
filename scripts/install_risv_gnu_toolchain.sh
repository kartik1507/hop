sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev git
mkdir build
cd build
git clone https://github.com/riscv/riscv-gnu-toolchain.git
cd riscv-gnu-toolchain/
git reset --hard b22a5e2cf0dc314d350cbf91e9ef0c0041ddcab2
mkdir build
cd build/
mkdir ~/hop/build/riscv
../configure --prefix=~/hop/build/riscv --disable-float --disable-atomic --with-xlen=32 --with-arch=I
make
