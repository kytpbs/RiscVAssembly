$ErrorActionPreference = "Stop"

clang --target=riscv64 -march=rv64gc -mabi=lp64d -mno-relax hello.s -c -o hello.o
ld.lld hello.o -o hello
wsl qemu-riscv64 ./hello