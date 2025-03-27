.data
	ask_value_1: 
		.asciz "Countup value: "

.text
.globl _start

_start:
_ask_countup_value:
	lui a0, %hi(ask_value_1)
	addi a0, a0, %lo(ask_value_1)
	li a7, 4 # print string -> prints a0 until null
	ecall

_read_countup_value:
	li a7, 5 # ReadInt -> outputs to a0
	ecall

_prepare_values:
	mv t0, a0 # t0 = a0 = countup
	mv t1, zero # t1 -> counter = zero
	mv a0, zero # a0 = sum -> starts at 0

_for_loop_start:
	addi t1, t1, 1 # t1 += 1
	add a0, a0, t1 # t1 += a0
	blt t1, t0, _for_loop_start # if t1 < t0 then continue

_print_value:
	li a7, 1 # PrintInt -> prints a0
	ecall # a0 is already sum value


_exit:
	li a0, 0            # exit code
	li a7, 93           # syscall exit
	ecall
