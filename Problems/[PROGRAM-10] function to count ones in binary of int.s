# Program 10 - Count the number of ones in binary representation

.data
	integer: .word 255 #0xFF -> 0b11111111 -> 8

.text
.globl _start
_start:
j _prepare_values

count_ones_in_binary:
	# /*
	#	count the number of ones in binary
	#
	#	Arguemnts:
	#		a0 -> the number to count
	#	
	#	Return:
	#		a0 -> the number of 1's from argument
	# */

	_prepare_for_loop1:
		mv t0, zero # counter
		li t1, 32 # 32 bits in int
		
		mv t2, a0 # t2 = the number we find ones of
		mv a0, zero # a0 = the number of ones
	
	_for_loop1_start:
		bge t0, t1 _for_loop1_exit # if i >= 32 then continue looping, if not go to exit
		addi t0, t0, 1 # i += 1
		andi t3, t2, 1 # t3 = number & 0b01 -> either 1 or 0
		add a0, a0, t3 # a0 += t3 (which is 0 or 1)
		srli t2, t2, 1 # t2 = t2 << 1

		j _for_loop1_start

	_for_loop1_exit:
		ret

_prepare_values:
	lw a0, integer


call_the_function:
	# a0 = the binary value we want to count
	call count_ones_in_binary # call the function
	# a0 = the number of ones


_print_all_ones:
	li a7, 1
	# count_of_ones is already in a0
	ecall

_exit:
	li a7, 93           # syscall exit
	li a0, 0            # exit code
	ecall
