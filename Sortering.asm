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
	
newline: .asciiz "\n"	
	
.text						# fuck this fucking piece of fucking goddamn shit
				
main:
	lw	$s1, datalen			# Add 16 to s1, data limit.
	la	$s2, 0				# PrintLoop itterator
	la	$s0, data 			# X array
	la	$s3, data			# Y array.
	li	$s4, 0				# Numb of Y-loops.
	li	$s6, 0				# Numb of X-loops.
	
	
	
		# When I started this only me and god knew what I was thinking.
		# Now only god knows....				
						
	
xLoop:					
	bge	$s6, $s1, printLoop		# If we have gone through 16 loops.
	nop

	lw	$a0, 0($s0)			# Adds x to address a0.	
	lw 	$a1, 0($s0)			# Adds y to address a1.
	jal yLoop
	
		# Fucking shit stuff.
yLoop:
	jal moveY
	
	ble $a1, $a0, SortValues
	nop
	
	beq $s4, $s1, moveX
	nop 
	
	j yLoop					

moveX:
	addi	$s0, $s0, 4			# New x 
	addi	$s6, $s6, 1			# Updates the ammount of sorted values.
	addi	$s4, $zero, 0			# zeroes Y loop.
	jr $ra
	nop


moveY:
	addi	$s3, $s3, 4			# New y
	jr $ra					# Else back to the loop.
	nop

					
	
SortValues:
		
	lw	$t0, 0($s0)			# Loads the temp address.
	lw	$s0, 0($s3)
	lw	$s3, 0($t0)
	
	jr $ra
	nop	
	
	# All below this point works.

printLoop:					# God only knows what this does.
	beq 	$s1, $s2, exit
	nop
	
	lw	$a0, 0($s3)	
	li	$v0, 1
	syscall
	
	la 	$a0, newline
	li 	$v0, 4
	syscall
	
	addi $s2, $s2, 1		# Adds to the itterator 
	addi $s0, $s0, 4		# Moves the offset 4 bytes.
	j printLoop
	nop
	

exit:
	ori	$v0, $zero, 10		# Prepare syscall to exit program cleanly
	syscall				# Go and die!
