	#
	# Maskinnara programmering, program template



.data
input: .asciiz	"Enter integer: "

.text

main: 

	la	$a0, input		#ladda in input p� a0
	li	$v0, 4			#f�rbered att printa
	syscall
	
	li	$v0 , 5			#L�s integer input
	syscall
	move	$a1, $v0		#Spara resultat i a1
	
	
	la 	$a0, input		#en till integer
	li	$v0 , 4			#printa
	syscall
	
	li	$v0, 5			#L�ser input
	syscall
	move	$a2, $v0		#Spara resultat i a2
	
	
	add	$a0, $a1, $a2		#Spara resultat av a1 och a2 i a0
	li	$v0, 1			#Skriv ut
	syscall
	

exit:
	ori $v0 , $zero, 10
	syscall
	
	












#
#	.data
#hellostring: 	.ascii "Hello World!\n"

#	.text
#main:
#	la	$a0, hellostring	#laddar in hellostring till a0
#	li	$v0, 4			#v0 och 4 g�r s� man printar en string
#	syscall				#det ovan kommer att g�ras
#	
#	
#
#	ori	$v0,$zero,10	# Prepare syscall to exit program cleanly
#	syscall			# Bye!
#
