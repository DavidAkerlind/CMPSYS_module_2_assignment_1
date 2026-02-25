# Write a program that asks the user for a year and then prints whether the year is a leap year or
# not. Every year that is exactly divisible by 400, or exactly divisible by four but not by 100, is a
# leap year. Example: If input is 2000 then output is ’yes’ and if input is 1900 then output is ’no’.


	.data
ask: .asciiz "Enter a year (ex 2023): "
p_yes: .asciiz "yes"
p_no: .asciiz "no"

	.text
	.global main

main: 
	
	# Print ask string
	li $v0, 4
	la $a0, ask
	syscall
	
	# Read year in int  -> $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	li, $t5, 400
	div $t0, $t5 		# divisible by 400 = yes
	mfhi $t1			# remainder
	beqz $t1, yes
	
	li $t5, 100
	div $t0, $t5		# divisble by 100 
	mfhi $t2			# remainder
	beqz $t2, no			# If divisible by 100 but not by 400 -> no
	
	li $t5, 4
	div $t0, $t5 		# divisible by 4
	mfhi $t3			# remainder
	beqz $t3, yes		# If divisible by 4 and not by 100 -> yes
	
	j no 
	
yes: 

	# Print yes
	li $v0, 4
	la $a0, p_yes
	syscall
	
	j exit

no: 

	# Print no
	li $v0, 4
	la $a0, p_no
	syscall
	
	j exit
	
exit: 	
	li $v0, 10
	syscall
	
	
