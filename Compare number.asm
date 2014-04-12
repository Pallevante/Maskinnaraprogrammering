# Jämför två tal

.data

input : .asciiz "Enter an integer: "
greater: .asciiz "The bigger number is: "

.text

main:

	la	$a0, input		#Ladda in input
	li	$v0, 4			#Skrivt ut
	syscall
	
	li	$v0, 5			#Läs in integer
	syscall
	move	$a1, $v0		#Spara resultat i a1
	
	
	la 	$a0, input		#en till integer
	li	$v0 , 4			#printa
	syscall
	
	li	$v0, 5			#Läser input
	syscall
	move	$a2, $v0		#Spara resultat i a2
	nop
	
	bge	$a1, $a2, bigger	#om a1 är större hoppa till bigger annars gå vidare
	nop
	
	la	$a0, greater
	li	$v0, 4
	syscall				#Skriv ut greater
	
	la	$a0, ($a2)
	li	$v0, 1
	syscall				#skriv ut andra integern
	jal 	exit

bigger: 
	la	$a0, greater		#ladda in greater
	li	$v0 , 4
	syscall				#skriv ut
	
	la	$a0, ($a1)
	li	$v0, 1
	syscall				#skriv ut första integern
	
exit:
	ori $v0 , $zero, 10		#avsluta
	syscall
