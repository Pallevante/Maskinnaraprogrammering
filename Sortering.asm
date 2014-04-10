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

sorted_list:
	

result: 
	.asciiz	"The sorted list:"
	
newline: .asciiz "\n"	
	
.text						# fuck this fucking piece of fucking goddamn shit
				
main:
	lw	$s1, datalen			# Add 16 to s1, data limit.
	la	$s2, 0				
	la	$s0, data 			# Add the data to address s0.
	la	$s3, data			# Add the data to address s3.
	li	$s4, 0
	la	$s5, sorted_list		# Init the new list.

	
		# When I started this only me and god knew what I was thinking.
		# Now only god knows....				
						
	
sortLoop:
	
	bgt	$s3, $s0, moveCheckValue	# If greater then we don't need to check the next value
	j sortLoop
	nop
	
	
	
	blt	$s3, $s0, checkItterator	# if less than check Itterator	
	addi	$s0, $s0, 4			# itterates 4 bytes.	
	j sortLoop
	nop


moveCheckValue:
	addi	$s3, $s3, 4			# New checkValue. 
	j sortLoop
	nop


checkItterator:
	beq	$s4, 16, addToSorted		# Checks if the iterator is done. If done add value to new list.
	j sortLoop
	nop
	
addToSorted:
	move	$s5, $s3
	j moveCheckValue
	nop	




printLoop:					# God only knows what this does.
	beq 	$s1, $s2, exit
	
	lw	$a0, 0($s5)	
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
