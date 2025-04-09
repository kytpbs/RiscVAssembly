# array.intersection

.data
	array1: .word 1, 2, 3, 11, 13
	length1: .word 5
	array2: .word 5, 4, 3, 11, 17
	length2: .word 5

		.align 4
	resultArr: .space 40 # sizeof(int) * resultLen = 4 * resultLen = 4 * 5
	resultLength: .word 10


.text
.globl _start
_start:
_prepare_values:
	mv t0, zero # t0 = counter
	mv t1, zero # t1 = counter
	

	la s0, array1 # s0 = array1
	lw s1, length1

	la s2, array2 # s2 = array2
	lw s3, length2

	la s4, resultArr # s4 = int[4]
	li s5, 0

_for_loop1_start:
	bge t0, s1, _exit_for_loop1 # if i >= len(array1) then continue looping, if not go to exit
	addi t0, t0, 1 # i = i+1
	lw a0, 0(s0) # a0 = array1[i]
	addi s0, s0, 4 # increment array1 pointer

	_for_loop_1_prepare:
		li t1, 0 # j = 0
		la s2, array2 # s1 = array2
	_for_loop2_start:
		addi t1, t1, 1 # j = j + 1
		bge t1, s3, _exit_for_loop2 # exit loop
		lw a1, 0(s2) # a1 = array2[i]
		addi s2, s2, 4 # increment array 2 pointer
		beq a0, a1, _is_eq # if a0 == a1 then is_eq
		j _else
		_is_eq:
			sw a1, 0(s4) # store to result arr
			addi s4, s4, 4 # increment result arr
			addi s5, s5, 1 # increment lenght counter
		_else:
		j _for_loop2_start

	_exit_for_loop2:


	j _for_loop1_start
_exit_for_loop1:

_print_result_arr:
_prepare_values2:
	mv t0, zero # t0 = counter
	la s4, resultArr # s4 = resultArr # reset to 0
	li a7, 1 # PrintInt -> print a0

_for_loop3_start:
	bge t0, s5 _exit_for_loop3 # if i > len(resultArr) exit_loop_1
	addi t0, t0, 1 # i += 1
	lw a0, 0(s4)
	addi s4, s4, 4 # increment s4
	ecall # print(resultArr[i])
	j _for_loop3_start


_exit_for_loop3:
	j _exit


_exit:
	li a7, 93           # syscall exit
	li a0, 0            # exit code
	ecall
