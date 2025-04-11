# Program 8 - sum of array

.data
	array: .word 1, 2, 3, 4, 5
	length: .word 5

.text
.globl _start
_start:
_prepare_values:
	mv t0, zero # t0 = counter

	la s0, array # s0 = array0
	lw s1, length
	
	mv a0, zero # sum

_for_loop1_start:
	bge t0, s1, _exit_for_loop1 # if i >= len(array1) then continue looping, if not go to exit
	addi t0, t0, 1 # i = i+1

	lw t1, 0(s0)
	add a0, a0, t1
	addi s0, s0, 4

	j _for_loop1_start

_exit_for_loop1:

_print_resulted_sum:
	# sum is already in a0
	li a7, 1
	ecall


_exit_for_loop3:
	j _exit


_exit:
	li a7, 93           # syscall exit
	li a0, 0            # exit code
	ecall
