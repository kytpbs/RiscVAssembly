# Program 13 - Recursive Function of linked list node count

.data
	node0: .word 1, node1
	node1: .word 2, node2
	node2: .word 3, node3
	node3: .word 4, node4
	# add an extra value in between 
	# to see if this is counted or not, since linked lists
	# are not like arrays and can have different elements between them
	random_in_between: .word 2
	node4: .word 5, node5
	node5: .word 6, node6
	node6: .word 7, node7
	node7: .word 8, 0

.text
.globl _start
_start:
j _actual_start

number_of_items:
	_allocate_stack:
	addi sp, sp, -4 # add 4 bytes of stack space for ret
	
	_save_to_stack:
	sw ra, 0(sp) # save ra to stack so we can go back to it
	
	# a0 is some node
	lw t0 0(a0) # value
	lw a0 4(a0) # iterate nodes in a0

	## if our result was already NULL a0 will be 0 and we just want to return 0
	beq a0, zero, _return_a0

	# recursivly re-call ourselves with the next node in a0
	call number_of_items

	addi a0, a0, 1 # increment node counter

	lw ra, 0(sp)
	addi sp, sp, 4
	_return_a0:
	ret

_actual_start:
_prepare_values:
	la a0, node0 # pointer to node 0

_call_func:
	call number_of_items

_print_a0:
	li a7, 1
	# count_of_ones is already in a0
	ecall

_exit:
	li a7, 93           # syscall exit
	li a0, 0            # exit code
	ecall
