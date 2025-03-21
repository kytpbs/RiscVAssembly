$ErrorActionPreference = "Stop"

clang --target=riscv64 -march=rv64gc -mabi=lp64d -mno-relax hello.s -c -o build/hello.o
ld.lld build/hello.o -o build/hello.x
wsl qemu-riscv64 ./build/hello.x