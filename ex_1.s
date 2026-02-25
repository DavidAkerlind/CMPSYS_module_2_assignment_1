# Exercise 1
# Write a program that asks the user for a letter between 'b' and 'y' 
# and then prints the letters that come before and after.
# Example: If input is 'g' then output is 'f' and 'h'.

.data 
ask: .asciiz "Enter a letter between 'b' and 'y': "
space: .asciiz "\n"  # Space between output letters

.text
.globl main

main: 
# Print ask string
li $v0, 4
la $a0, ask
syscall

# Read character from user
li $v0, 12        	# System call for read character
syscall
move $t0, $v0       # Save input character in $t0

# Print space
li $v0, 4 			# system call for printing a string
la $t4, space 
move $a0, $t4       # Print a space
syscall

# Calculate before and after letters
addi $t1, $t0, -1  # Previous letter (before)
addi $t2, $t0, 1   # Next letter (after)

# Print before letter
li $v0, 11         # System call for print character
move $a0, $t1      # Load before letter
syscall

# Print after letter
li $v0, 11
move $a0, $t2      # Load after letter
syscall

# Exit program
li $v0, 10
syscall