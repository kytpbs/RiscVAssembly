# Program 16 - Recursive LinkedList.count()

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

	# we are at the end of it and there is no more value to add
	beq a0, zero, _return_a0 # if a0 == zero then _return_a0


	_allocate_stack:
	addi sp, sp, -4 # add 4 bytes of stack space for ret

	_save_to_stack:
	sw ra, 0(sp) # save ra to stack so we can go back to it

	lw t0, 0(a0) # get value
	lw a0, 4(a0) # move a0 to next, to be called later

	# instead of doing call then deciding to increment or not
	bne t0, a1, _dont_increment # if t1 != a1 then _dont_increment

	_increment:
	call count
	addi a0, a0, 1 # increment
	j _return

	_dont_increment:
	call count

	_return:

	lw ra, 0(sp)
	addi sp, sp, 4

	_return_a0:
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
