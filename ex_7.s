# Write a program that asks the user for n integers and then prints the largest and the smallest
# numbers. Arrays are not allowed. n is a global variable initialized to 10. 
#Example: If input is 1, 2, 3, 4, 5, 6, 7, 8, 9 and 10 then output is 10 and 1.



	.data
	
ask: .asciiz "\nEnter 10 integergers seperated by pressing [ENTER]: "
space: .asciiz " <--largest |and| samllest--> "


n: .word 10


	.text
	.global main
	
main: 
	
# Print ask string 
	li $v0, 4
	la $a0, ask
	syscall

# Initialize n and start comp value
	li $t0, 11		# n
	li $t1, 0		# smallest  (start) $t1
	li $t2, 1		# largest 	(start	$t2
	
	# Read integer from user  =  $t3
	li $v0, 5
	syscall
	move $t3, $v0
	move $t1, $t3 # set the first value to the smallest
	move $t2, $t3 # set the first value to the largest
	
	
	j L1
L1: 

# Decrease index and check if <= 1
	addi $t0, $t0, -1
	ble $t0, 1, exit 
# Print ask string 
	li $v0, 4
	la $a0, ask
	syscall
	
	
# Read integer from user  =  $t3
	li $v0, 5
	syscall
	move $t3, $v0
	
# Compare input to largest and smallest
	blt $t3, $t1, updt_small
	bgt $t3, $t2,  updt_large
	
# Loop again
	j L1

updt_small:
	move $t1, $t3
	j L1


updt_large: 

	move $t2, $t3
	j L1

exit:  # Print and Exit program

	li $v0, 1
	move $a0, $t2 	# Print largest
	syscall
	
	li $v0, 4
	la $a0, space 	# Print spacing
	syscall
	
	li $v0, 1
	move $a0, $t1 	# Print smallest
	syscall
	
	li $v0, 10 		# End program
	syscall
