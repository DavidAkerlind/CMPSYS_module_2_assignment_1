# Write a program that asks the user for an integer and then adds the number to a sum. The sum
# is printed after each new number. The program ends when the user enters 0.
#
# Example: If input is 1, 2, 3, 4, 5 and 0 then output is 1, 3, 6, 10 and 15



	.data
	
ask: .asciiz "\nEnter a integer (0 to end program): "
sum: .asciiz "Sum: "

	.text
	.global main
	
main: 

# Load previus input 
	li $t0, 0
	
	j L1

L1: 

# Print ask string 
	li $v0, 4
	la $a0, ask
	syscall
	
# Read integer from string  =  $t1
	li $v0, 5
	syscall
	move $t1, $v0
	
	
# Check if input == 0 then exit 
	beqz $t1, exit

# input is not 0 we continue
# add it with the previous sum and store new sum in £t3

	add $t3, $t0, $t1
	
# Print the sum string
	li $v0, 4
	la $a0, sum
	syscall
# Print the new sum int
	li $v0, 1
	move $a0, $t3 
	syscall
	
# Update and Reset values
	move $t0, $t3 	# Update $t0 to the new sum 
	li $t3, 0		# Reset $t3 to 0
	
	j L1 # continue loop

exit: 

	li $v0, 10
	syscall