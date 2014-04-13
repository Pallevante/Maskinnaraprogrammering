# Work to be made.

# Sorting Algorithm
# Peter H�kansson
# Simon Hedstr�m 
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
	la	$s0, data 			# Add the data to address s0.
	la	$s3, data			# Add the data to address s3.
	li	$s4, 0				# SortLoop itterator
	la	$s6, 0				# Number of loops.
	
	
	
	
		# When I started this only me and god knew what I was thinking.
		# Now only god knows....				
						
	
sortLoop:
					
	beq	$s6, 16, printLoop		# If we have gone through 16 loops.
	nop
	
	addi	$s0, $s0, 4			# Itterates 4 bytes.
	nop
	
	bgt	$s3, $s0, moveCheckValue	# If greater then we don't need to check the next value
	nop		
	
	blt	$s3, $s0, checkItterator	# if less than check Itterator	
	nop


moveCheckValue:
	addi	$s3, $s3, 4			# New checkValue. 
	j sortLoop
	nop


checkItterator:
	beq	$s4, 16, addToSorted		# Checks if the iterator is done. If done add value to new list.
	nop
	
	j sortLoop				# Else back to the loop.
	nop
	
	
	
addToSorted:
	sw	$s5, 0($s3)			# Adds the value to a new array.
	
	move	$s4, $zero			# Makes the itterator 0 again.
	
	addi	$s5, $s5, 4			# Moves the sorted_list offset 4 bytes.
	addi	$s6, $s6, 1			# Updates the ammount of sorted values.
	
	j moveCheckValue
	nop	




printLoop:					# God only knows what this does.
	beq 	$s1, $s2, exit
	
	lw	$a0, 0($s3)	
	li	$v0, 1
	syscall
	
	la 	$a0, newline
	li 	$v0, 4
	syscall
	
	addi $s2, $s2, 1		# Adds to the itterator 
	addi $s0, $s0, 4		# Moves the offset 4 bytes.
	j printLoop
	

exit:
	ori	$v0, $zero, 10		# Prepare syscall to exit program cleanly
	syscall				# Go and die!
