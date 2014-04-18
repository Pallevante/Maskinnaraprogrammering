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
data1:
	.word	16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1
	
	

result: 
	.asciiz	"The sorted list:\n"
	
dbgp:	.asciiz "Doing sort"
	
newline: .asciiz "\n"	
	
.text					# fuck this fucking piece of fucking goddamn shit
				
main:
	lw	$s3, datalen		# Add 16 to s1, data limit.
	la	$s5, 0			# PrintLoop itterator
	
	la	$s0, data 		# loopArray
	la	$s1, data		# SortPosition-Array
	la	$t7, data		# Lowest value position.

	li	$s4, 0			# Numb of Y-loops.
	li	$s2, 0			# iMin.
	li	$s6, 0			# Numb of X-loops.


		
xLoop:	
	# If we have gone through 16 loops.				
	bge	$s6, $s3, printLoop	
	nop
	
	# Adds x to address s2.	
	lw	$s2, 0($s1)			

		
	# Fucking shit stuff.
			
	yLoop:
		# New y
		addi	$s0, $s0, 4	
		addi	$s4, $s4, 1
		# Culprit...maybe
		bge 	$s4, $s3, SortValues		
		nop 
		
		# Adds y to address a1.
		lw 	$s7, 0($s0)		
		nop 
	
		ble 	$s7, $s2, SwitchValues
		nop			
		
		j 	yLoop	
		nop
		
									

moveX:
	addi	$s1, $s1, 4		# New startPosition for sortLoop.
	nop
	addi	$s6, $s6, 1		# Uppdates the numb of X loops.
	add	$s0, $0, $s1		# New startPosition for loop based on startPosition for sortloop
	
	
	add	$s4, $s6, $0		# Y loop to X loop.
	
	j	xLoop
	nop

	
SortValues:		
	lw	$t0, 0($s1)		
	nop
	
	
	# Detta här var orsaken till att 9 blev 16.
	beq	$s2, $t0, moveX
	nop
	
	
	
	sw	$t0, 0($t7)		# Adds the replaced value to looparray.
	sw	$s2, 0($s1)		# Adds the new min to the sorted array
		
	j	moveX
	nop	

SwitchValues:
	add	$s2, $0, $s7		# Changes the iMin value.
	add	$t7, $0, $s0
	bge	$s4, $s3, SortValues
	nop	
	j	yLoop
	nop
		
	
	# All below this point works. (maybe)

printLoop:

	la	$s1, data	
	la	$a0, result
	li	$v0, 4
	syscall
	
	prntbdy:
					# God only knows what this does.
	bge 	$s5, $s3, exit
	nop
	
	lw	$a0, 0($s1)	
	li	$v0, 1
	syscall
	
	la 	$a0, newline
	li 	$v0, 4
	syscall
	
	addi 	$s5, $s5, 1		# Adds to the itterator 
	addi 	$s1, $s1, 4		# Moves the offset 4 bytes.
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
