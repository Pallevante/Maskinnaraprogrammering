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
data1:
	.word	1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
	
	

result: 
	.asciiz	"The sorted list:\n"
	
dbgp:	.asciiz "Doing sort"
	
newline: .asciiz "\n"	
inputInstruction: .asciiz "Enter the file you want to sort (it has to be in the same dir as this file.):"
directory: .asciiz "random.asm"
buffer : .space 64
	
.text					
				
main:

	# Print instructions
	la	$a0, inputInstruction
	li	$v0, 4
	syscall

	# Read filename
	li	$v0, 8
	la	$a0, buffer
	li	$a1, 20
	syscall
	
	# Dunno....
	
	li	$v0, 13				#Call to open a file
	la	$a0, directory			#Reads file random.asm
	li	$a1, 0 				#Open for reading
	li	$a2, 0
	syscall
	
	move $s0, $v0      			# save the file descriptor
		
		
	lw	$s3, datalen		# Add 16 to s1, data limit.
	la	$s5, 0			# PrintLoop itterator
	
	
	add	$s1, $0, $s0		# SortPosition-Array
	add	$t7, $0, $s0		# Lowest value position.

	li	$s4, 0			# Numb of Y-loops.
	li	$s2, 0			# iMin.
	li	$s6, 0			# Numb of X-loops.

	syscall
	move	$t1, $v0   	   		# save the file descriptor
	
	#Time to read the file
	
	jal	readLoop


readLoop:
	
	#addi	$t3, $t3, 1
	#addi	$t1, $t1, 4
	
	#If we have gone 16 loops (might change) we want to close the file 
	#bge	$t3, 16, closeFile
	#nop
	
	li	$v0, 14			#Call to read a file
	move	$a0 , $s6		#File descriptor
	syscall
	la	$s0, buffer		#Make space
	#sw	$s0, 0($t1)
	#j	readLoop
	
closeFile:
	li	$v0 , 16		#Call to close a file
	move	$a0, $t1		#File descriptor to close
	syscall

		
xLoop:	
	# If we have gone through 16 loops.				
	bge	$s6, $s3, printLoop	
	nop
	
	# Adds x to address s2.	
	lw	$s2, 0($s1)			

		
			
	yLoop:
		# New y
		addi	$s0, $s0, 4	
		addi	$s4, $s4, 1
		
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
	addi	$s6, $s6, 1		# Updates the xLoop count
	add	$s0, $0, $s1		# New startPosition for loop based on startPosition for sortloop
	
	
	add	$s4, $s6, $0		# Set Y loop to X loop.
	
	j	xLoop
	nop

	
SortValues:		
	lw	$t0, 0($s1)		
	nop
	
	
	# If lowest number is the same as the number on position to be sorted
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
		
	

printLoop:
<<<<<<< HEAD
	la	$s1, ($s0)	
	prntbdy:
=======

	la	$s1, data	
	la	$a0, result
	li	$v0, 4
	syscall
>>>>>>> 6cc9d6c33bce425e596b944873a213a4536de541
	
	prntbdy:
		
	# Prints all the values in the sorted list.					
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
	syscall				# Exit
