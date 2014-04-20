# Work to be made.

# Sorting Algorithm
# Peter Håkansson
# Simon Hedström 
# 2014


	.data
directory: .asciiz "random.asm"
	
	
datalen:
	#.word	0x0010			# 16

	
data:
	#.word	0xffff7e81
	#.word	0x00000001
	#.word	0x00000002
	#.word	0xffff0001
	#.word	0x00000000
	#.word	0x00000001
	#.word	0xffffffff
	#.word	0x00000000
	#.word	0xe3456687
	#.word	0xa001aa88
	#.word	0xf0e159ea
	#.word	0x9152137b
	#.word	0xaab385a1
	#.word	0x31093c54
	#.word	0x42102f37
	#.word	0x00ee655b
data1:
	#.word	1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
	


result: 
	.asciiz	"The sorted list:\n"
	
dbgp:	.asciiz "Doing sort"
	
newline: .asciiz "\n"
inputInstruction: .asciiz "Enter the file you want to sort (it has to be in the same dir as this file.):"
buffer : .space 68


	
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
	move	$s0, $a0
	
	jal readLoop
	nop
		
	lw	$s3, 0($s0)		# Add 16 to s1, data limit.
	la	$s5, 0			# PrintLoop itterator
	
	lw 	$s1, 4($s0)		#Vet inte om det här funkar tbh
	lw	$t7 , 4($s0)
	#add	$s1, $0, $s0		# SortPosition-Array
	#add	$t7, $0, $s0		# Lowest value position.

	li	$s4, 0			# Numb of Y-loops.
	li	$s2, 0			# iMin.
	li	$s6, 0			# Numb of X-loops.
	li	$t3, 0			# Loop for reading from a file

	jal	xLoop

readLoop:
	
	
	#Open a file to read
	li	$v0, 13			#Call to open a file
	la	$a0, directory		#Reads the user input file
	li	$a1, 0 			#Open for reading
	li	$a2, 0			#Might not be needed
	syscall
	move	$t1, $v0   	   	# save the file descriptor
	
	#Time to read the file
	li	$v0, 14			#Call to read a file
	move	$a0 , $t1		#File descriptor
	la	$a1, ($s0)		#A1 gets the adress of the buffer
	li	$a2, 68			#Hardcoded buffersize
	syscall

	
	#Time to close it
	li	$v0 , 16		#Call to close a file
	move	$a0, $t1		#File descriptor to close
	syscall
	nop
	jr	$ra
	nop
		
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

	la	$s1, buffer	
	la	$a0, result
	li	$v0, 4
	syscall
	
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
