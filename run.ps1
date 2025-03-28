$ErrorActionPreference = "Stop"
$ENV:path += ";C:\llvm\bin" # Add LLVM to PATH, couldn't get PATH to work for some reason...

clang --target=riscv32 -march=rv32gc -mabi=ilp32d -mno-relax app.s -c -o build/app.o
ld.lld build/app.o -o build/app.x
wsl whisper --newlib --log --stdin /dev/stdin --stdout /dev/stdout --stderr /dev/stderr ./build/app.x