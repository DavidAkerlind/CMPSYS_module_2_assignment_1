# Write a program that asks the user for an integer (n) and then calculates 1 + 2 + 3 + · · · until
# the sum exceeds n. Thereafter the sum and the last added number should be printed. 
#Example:
# If input is 100 then output is 105 and 14, and if input is 50 then output is 55 and 10.


	.data
	
ask: .asciiz "Enter a integer: "
space: .asciiz " and "


	.text
	.global main

main: 

# print ask string
	li $v0, 4
	la $a0, ask
	syscall
	
# read integer from user

	li $v0, 5
	syscall
	move $t0, $v0
	li $t1, 1
	j L1
	
# loop that goes on until its grater than user input
L1: 
	
	add $t2, $t1, $t2 # $t2 will increase by 1 each loop
	
	add $t3, $t3, $t2
	bgt $t3, $t0, end_loop
	
	j L1
	
end_loop: 

# print the sum
	li $v0, 1
	move $a0, $t3
	syscall
	
# print space string
	li $v0, 4
	la $a0, space
	syscall
	
# print the last added number
	li $v0, 1
	move $a0, $t2
	syscall

# exit program
	j exit

exit: 	
	li $v0, 10
	syscall


	

	
	
	
	