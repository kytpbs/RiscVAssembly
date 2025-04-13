# Program 11 - Print number of nodes in a linked list

.data
	node0: .word 1, node1
	node1: .word 2, node2
	node2: .word 3, node3
	node3: .word 4, node4
	# add an extra value in between 
	# to see if this is counted or not, since linked lists
	# are not like arrays and can have different elements between them
	random_in_between: .word 2
	node4: .word 4, node5
	node5: .word 4, node6
	node6: .word 4, node7
	node7: .word 5, 0

.text
.globl _start
_start:

_prepare_values:
	la s0, node0 # pointer to node0
	mv a0, zero # counter

_while_loop1_start:
	addi a0, a0, 1 # increment counter for each node we visit
	lw t0, 0(s0) # value of node
	lw s0, 4(s0) # move pointer to next node
	beq s0, zero, _exit_loop1 # if s0 == zero then _exit_loop1
	j _while_loop1_start

_exit_loop1:
	li a7, 1

_print_a0:
	li a7, 1
	# count_of_ones is already in a0
	ecall

_exit:
	li a7, 93           # syscall exit
	li a0, 0            # exit code
	ecall
