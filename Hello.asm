
		# Maskinnara programmering, program template
	
		.data

hw: 	.asciiz	"Enter Input: "
space: 	.asciiz	" "		# a space to use between numbers
		.text

	 	
main:
	# input 	= a1
	# multiplier 	= a2

	la	$a2, 0		# address 0 in a2
	la	$a0, hw		# address hw to a0
	li	$v0, 4		# preparing to print the string
	
	syscall			# does what v0 says.
	
	li	$v0, 5		# change to read_integer
	syscall			# does what v0 says.
	move	$a1, $v0	# moves the input to a1
	
			
loop:	
	beq 	$a2, 13, exit	# If a2 == 12
	mul	$a0, $a1, $a2	# multiplies a2 with a1		(a0 == a1 * a2)
	add	$a2, $a2, 1	# adds 1 to a2			(a2++)
	li	$v0, 1		# Time to print the shit
	
	syscall			# does what v0 says.
	
	la	$a0, space	# sets adress to the space variable
	li	$v0, 4		# preparing to print the string
	syscall			# does what v0 says.
	
	j loop			# goto the loop	
			
	
exit:
	ori	$v0, $zero, 10	# Prepare syscall to exit program cleanly
	syscall			# Bye!
	

	
	
	#
	#	OLD CODE BELLOW
	#
	#	:::ADDITION:::
	#	li 	$v0, 1		#put 1 in v0 to print integer
	#	add	$a0, $a1, $a2	#adds the addresses a1, a2 to a0	
	#	syscall
	#
	#
	#
	#
	#	:::HELLO WORLD:::
	#
	#	li	$v0, 4		#put in 4 to v0 (print string)
	#	la	$a0, hw		#adds the string to a0
	#	syscall
	#
	#
	
