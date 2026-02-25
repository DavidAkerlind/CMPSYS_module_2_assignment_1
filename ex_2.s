#Write a program that asks the user for an integer and then prints whether the number is odd or
#even. Example: If input is ’4’ then output is ’even’.


.data 
ask: .asciiz "Enter a integer: "
odd: .asciiz "Number is odd"
even: .asciiz "Number is even"
nl: .asciiz "\n"  # New line string

.text
.globl main

main: 
# Print ask string
li $v0, 4
la $a0, ask
syscall

# Read int from user
li $v0, 5        	# System call for read integer
syscall
move $t0, $v0       # Save input integer in $t0

# calculate if input is even

andi $t1, $t0, 1 # this checks the LSB in $t0 (1=odd, 0=even) assigns the LSB to $t1

beqz $t1, numEVEN

# Print ask string
li $v0, 4
la $a0, odd
syscall
j	exit


numEVEN: 
	# Print even 
	li $v0, 4
	la $a0, even
	syscall
	j	exit
	
exit: 
	# Exit program
	li $v0, 10
	syscall

