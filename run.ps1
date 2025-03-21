$ErrorActionPreference = "Stop"

clang --target=riscv32 -march=rv32gc -mabi=ilp32d -mno-relax hello.s -c -o hello.o
ld.lld hello.o -o hello
wsl qemu-riscv32 ./hello