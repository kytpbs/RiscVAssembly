.data
	ask_value_1: 
		.asciz "Countdown: "

.text
.globl _start

_start:
_ask_countdown_value:
	lui a0, %hi(ask_value_1)
	addi a0, a0, %lo(ask_value_1)
	li a7, 4 # print string -> prints a0 until null
	ecall

_read_countdown_value:
	li a7, 5 # ReadInt -> outputs to a0
	ecall

_prepare_print:
	li a7, 1 # PrintInt -> prints a0

_for_loop_start:
	ecall # print a0
	addi a0, a0, -1 # i -= 1
	bgt a0, zero, _for_loop_start # if t0 > 0 then target

_exit:
	li a0, 0            # exit code
	li a7, 93           # syscall exit
	ecall
