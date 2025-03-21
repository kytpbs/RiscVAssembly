$ErrorActionPreference = "Stop"
$ENV:path += ";C:\llvm\bin" # Add LLVM to PATH, couldn't get PATH to work for some reason...

clang --target=riscv64 -march=rv64gc -mabi=lp64d -mno-relax app.s -c -o build/app.o
ld.lld build/app.o -o build/app.x
wsl qemu-riscv64 ./build/app.x