.globl _start
  
    _start:
        li a0, 1            # file descriptor = 1 (stdout)
        la a1, string       # buffer
        li a2, 14           # size

    _print:
        li a7, 64           # syscall write (64)
        ecall

    _end:

        li a0, 0            # exit code
        li a7, 93           # syscall exit
        ecall


    string:  .asciz "Hello World!\n"