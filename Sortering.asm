# Work to be made.

# Sorting Algorithm
# Peter Håkansson
# Simon Hedström 
# 2014


	.data
datalen:
	.word	0x0010			# 16

	
data:
	.word	0xffff7e81
	.word	0x00000001
	.word	0x00000002
	.word	0xffff0001
	.word	0x00000000
	.word	0x00000001
	.word	0xffffffff
	.word	0x00000000
	.word	0xe3456687
	.word	0xa001aa88
	.word	0xf0e159ea
	.word	0x9152137b
	.word	0xaab385a1
	.word	0x31093c54
	.word	0x42102f37
	.word	0x00ee655b


result: 
	.asciiz	"The sorted list:"
	
dbgp:	.asciiz "Doing sort"
	
newline: .asciiz "\n"	
	
.text					# fuck this fucking piece of fucking goddamn shit
				
main:
	lw	$s1, datalen		# Add 16 to s1, data limit.
	la	$s2, 0			# PrintLoop itterator
	
	la	$s0, data 		# X-Array
	la	$s3, data 		# Y-Array

	li	$s4, 0			# Numb of Y-loops.
	li	$s6, 0			# Numb of X-loops.
	
	# This will use the basic of X and Y.
	# Y will always be X + 1 until it's out of bounds.
	
	
	# When I started this only me and god knew what I was thinking.
	# Now only god knows....				
						
	
xLoop:					
	bge	$s6, 16, printLoop	# If we have gone through 16 loops.
	nop
	
	lw	$a0, 0($s0)		# Adds x to address a0.		
	nop
	
	jal 	yLoop
	nop
	
	# Fucking shit stuff.
			
yLoop:
	jal 	moveY
	nop
	
	lw 	$a1, 0($s3)		# Adds y to address a1.
	nop 
	
	blt 	$a1, $a0, SortValues
	nop
	
	bge 	$s4, 16, moveX		# Culprit...maybe
	nop 
	
	j 	yLoop	
	nop
									

moveX:
	addi	$s0, $s0, 4		# New x 	
	addi	$s6, $s6, 1		# Uppdates the numb of X loops.
	nop
	
	move	$s6, $s4		# Y loop to X loop.
	
	j	xLoop
	nop


moveY:
	addi	$s3, $s3, 4		# New y
	addi	$s4, $s4, 1
	jr 	$ra			# Back to the Future.
	nop

	
SortValues:		
	move	$a0, $t0		# Loads the temp address.
	move	$a1, $a0		# Switches the values.		
	
	sw	$a0, 0($s0)		# Adds the new X-Value to the X-Array
	sw	$t0, 0($s3)		# Adds the new Y-Value to the Y-Array
		
	jr 	$ra
	nop	
	
	
	# All below this point works. (maybe)

printLoop:

	la	$s0, data
	prntbdy:
					# God only knows what this does.
	beq 	$s1, $s2, exit
	nop
	
	lw	$a0, 0($s0)	
	li	$v0, 1
	syscall
	
	la 	$a0, newline
	li 	$v0, 4
	syscall
	
	addi 	$s2, $s2, 1		# Adds to the itterator 
	addi 	$s0, $s0, 4		# Moves the offset 4 bytes.
	j 	prntbdy
	nop
	

exit:
	ori	$v0, $zero, 10		# Prepare syscall to exit program cleanly
	syscall				# Go and die!


	# A long long time ago far far away
	# a programmer student a sat in his chair.
	# Moaning and trying not to sway.
	# Writing good which is good and fair.
	# But all god has an end.
	# He went on a rampage to kill his best friend.
