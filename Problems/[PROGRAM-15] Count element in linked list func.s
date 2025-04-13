# Program 15 - Interative LinkedList.count()

.data
	node0: .word 1, node1
	node1: .word 2, node2
	node2: .word 3, node3
	node3: .word 4, node4

	# add an extra value in between 
	# to see if this is counted or not, since linked lists are not like arrays
	# and can have different elements between them

	value_to_count: .word 4

	node4: .word 4, node5
	node5: .word 5, node6
	node6: .word 6, node7
	node7: .word 7, 0


.text
.globl _start
_start:
j _actual_start

count:
	#Arguments:

	# a0 -> linked list
	# a1 -> value to count

	_prepare_while_loop_1:
	mv t0, a0
	mv a0, zero

	_while_loop_1:
		lw t1, 0(t0)
		lw t0, 4(t0)

		bne t1, a1, L_dont_increment # if t1 != a1 then L_dont_increment
		addi a0, a0, 1
		L_dont_increment:

		bne t0, zero, _while_loop_1

	_exit_while_loop_1:
	ret


_actual_start:
_prepare_values:
	la a0, node0 # pointer to node 0
	lw a1, value_to_count

_call_func:
	call count

_print_a0:
	li a7, 1
	# count_of_ones is already in a0
	ecall

_exit:
	li a7, 93           # syscall exit
	li a0, 0            # exit code
	ecall
