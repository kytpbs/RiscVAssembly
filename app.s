.data
	int: .word 6
	odd_string: .asciz "odd"
	even_string: .asciz "even"


.text
.globl _start
_start:
_prepare_values:
	lw a0, int # load the integer
	# is 0b01 which means if the last bit is 1 it will return one, if its 0 it will return 0
	andi a0, a0, 1 # a0 & 0b01
	li t0, 1
	beq a0, t0, _is_even # if a0 (our number) == 0 then go to _is_even
	# we didn't branch to is_odd which means its even
_is_odd:
	la a0, odd_string
	j _print
_is_even:
	la a0, even_string 
_print:
	ori
	li a7, 4 # printString -> print a0
	ecall

_exit:
	li a7, 93 # syscall exit
	li a0, 0 # exit code
	ecall