.data
	array: .word 1, 2, 3, 11, 13, 21, 25
	length: .word 7


.text
.globl _start


_start:
_prepare_values:
	la a0, array # a0 = array
	lw t1, length
	mv t0, zero # t0 = counter

_for_loop_start:
	addi t0, t0, 1 # i = i+1
	bge t0, t1, _print_one # end of for loop
	lw s0, 0(a0) # array[i], 0 due to array pointer increasing
	lw s1, 4(a0) # array[i + 1], 4 -> word size
	addi a0, a0, 4 # increment array pointer
	bge s1, s0, _for_loop_start # if s1 >= s0 then continue looping, if not print zero
	# it was less which means we continue and print 0
_print_zero:
	li a7, 1 # PrintInt -> prints a0
	li a0, 0 # print 0
	ecall # a0 is already sum value
	j _exit


_print_one:
	li a7, 1 # PrintInt -> print a0
	li a0, 1 # print 0
	ecall

_exit:
	li a7, 93           # syscall exit
	li a0, 0            # exit code
	ecall
