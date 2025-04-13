# Program 17 - Recursive Tree Node Count

.data
	root: .word 0, node1, node2
	node1: .word 0, node11, node12
	node11: .word 0, node111, 0
	node111: .word 0, 0, 0
	node12: .word 0, 0, 0
	node2: .word 0, node21, node22
	node21: .word 0, 0, 0
	node22: .word 0, 0, 0

#           root(0)
#          /       \
#  node1(0)         node2(0)
# /        \           /     \
# node11(0) node12(0) node21(0) node22(0)
#   /
#node111(0)

# Total of 8 nodes


.text
.globl _start
_start:
j _actual_start

node_count:
	#Arguments:

	# a0 -> binary tree


	_allocate_stack:
	addi sp, sp, -16 # add 16 bytes of stack space for values

	_save_to_stack:
	# save ra and s0 - s2 because they are calle saved
	sw ra, 0(sp) # save ra to stack so we can go back to it
	sw s0, 4(sp) # save s0 to stack so we can go back to it
	sw s1, 8(sp) # save s1 to stack so we can go back to it
	sw s2, 12(sp) # save s2 to stack so we can go back to it

	L_prepare_values:
	lw t0, 0(a0) # get node value
	lw s0, 4(a0) # left node
	lw s1, 8(a0) # right node
	li s2, 1 # node count and + 1 because of us

	beq s0, zero, _no_left
	mv a0, s0
	call node_count
	add s2, s2, a0 # count += node_count(node.left)

	_no_left:
	# continue running and add nothing

	beq s1, zero, _no_right
	mv a0, s1
	call node_count
	add s2, s2, a0 # count += node_count(node.right)

	_no_right:
	# continue running and add nothing

	_return:
	# return the count value stored in s2
	mv a0, s2

	# load the saved values back
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	addi sp, sp, 16

	_return_a0:
	ret


_actual_start:
_prepare_values:
	la a0, root # pointer to node 0

_call_func:
	call node_count

_print_a0:
	li a7, 1
	# count_of_ones is already in a0
	ecall

_exit:
	li a7, 93           # syscall exit
	li a0, 0            # exit code
	ecall
