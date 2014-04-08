# Sorting Algorithm
# Peter Håkansson
# Simon Hedström 
# 2014


	.data
datalen:
	.word	0x0010		# 16
	
result: 
	.asciiz	"The sorted list:"	

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

	
				
main:
	li	$t0, 	10
	la	$s0, 	data 	# Add the data to adress s0.	
	jal loop
	
loop:
	
	lw	$a0, 0($s0)
	li	$v0, 1
	syscall
	
	add	$s0, $s0, 4
	j loop
	nop


exit:
	ori	$v0, $zero, 10	# Prepare syscall to exit program cleanly
	syscall			# Go and die!
