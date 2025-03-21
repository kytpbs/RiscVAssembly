.data
	.asciz "Please enter your year of birth\n" # 0x10010 #32 chars

.text
	lui a0, 0x10010
	li, a7, 4 # print string -> prints a0 until null
	ecall

_read_value:
	li a7, 5 # ReadInt -> outputs to a0
	ecall

_print_age:
	li t1, 2025
	sub a0, t1, a0
	li a7, 1 # PrintInt -> prints a0
	ecall

_exit:
	li a0, 0            # exit code
	li a7, 93           # syscall exit
	ecall
