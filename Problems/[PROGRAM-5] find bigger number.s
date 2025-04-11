.data
	ask_value_1: 
		.asciz "Enter the first value: "
	ask_value_2: 
		.asciz "Enter the second value: "

.text
.globl _start

_start:
_ask_first_value:
	lui a0, %hi(ask_value_1)
	addi a0, a0, %lo(ask_value_1)
	li a7, 4 # print string -> prints a0 until null
	ecall

_read_first_value:
	li a7, 5 # ReadInt -> outputs to a0
	ecall
	mv t0, a0

_ask_second_value:
	lui a0, %hi(ask_value_2)
	addi a0, a0, %lo(ask_value_2)
	li a7, 4 # print string -> prints a0 until null
	ecall

_read_second_value:
	li a7, 5 # ReadInt -> outputs to a0
	ecall
	mv t1, a0

_find_bigger_value:
	bge t1, t0, _smaller_value
	mv a0, t0
	j _print_a0_int 

_smaller_value:
	mv a0, t1

_print_a0_int:
	li a7, 1 # PrintInt -> prints a0
	ecall

_exit:
	li a0, 0            # exit code
	li a7, 93           # syscall exit
	ecall
