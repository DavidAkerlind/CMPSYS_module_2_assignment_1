#Write a program that asks the user for an integer (brutto) and then prints the netto, calculated
#according to the following pseudocode, where threshold = 204000, low = 30 and high = 50.

#if brutto <= threshold
#netto = brutto - (brutto * low) / 100
#else
#netto = brutto - (threshold * low) / 100 - ((brutto - threshold) * high) / 100

#Example: If input is 40000 then output is 28000 and if input is 800000 then output is 440800.

	.data
ask: .asciiz "Type and integer (brutto): "
threshold: .word 204000
high: .word 50
low: .word 30
netto: .word 0

	.text
	.global main
	
main: 

# Load constants into registers
	lw $t0, threshold	# $t0 = threshold (204000)
	lw $t1, low			# $t1 = low (30)
	lw $t2, high		# $t2 = high (50)
	li $t3, 100			# $t3 = 100 (divisor)

# Print ask string
	li $v0, 4
	la $a0, ask
	syscall

# Read int from user
	li $v0, 5        	# System call for read integer
	syscall
	move $t4, $v0       # Save input integer brutto in $t4 


	bgt $t4, $t0, high_calc # if greater than jump to hiCALC, netto = brutto - (brutto * low) / 100
	# netto = brutto - (brutto * low) / 100
	mul $t5, $t4, $t1   # brutto * low = $t5
	
	div $t5, $t3 	    # (brutto * low) / 100 = lo
	mflo $t6 	 		# lo = $t6
	
	sub $t7, $t4, $t6 	# ( (brutto * low) / 100 ) - brutto = $t7
	
	
	sw $t7, netto
	j	exit


high_calc: #netto = brutto - (threshold * low) / 100 - ((brutto - threshold) * high) / 100
	
	# First part  brutto - (threshold * low) / 100
	mul $t5, $t0, $t1   #(threshold * low) = $t5
	div $t5, $t3 	    # (threshold * low) / 100 = lo
	mflo $t6		    # lot6 = $t6
	
	sub $s0, $t4, $t6   # $s1 brutto - (threshold * low) / 100
	
	

	# Second part: ((brutto - threshold) * high) / 100
	sub $t8, $t4, $t0	# $t8 = brutto - threshold
	mul $t9, $t8, $t2	# $t9 = (brutto - threshold) * high
	div $t9, $t3		# divide by 100
	mflo $s1			# $s0 = ((brutto - threshold) * high) / 100
	
	
	# Calculate netto = first_part - second_part 
	sub $s2, $s0, $s1	# subtract second_part
	
	add $t7, $s2, $zero # move netto to $t7
	
	j	exit
	
	
exit: # Print and exit program
	
	# Print netto string
	li $v0, 1
	move $a0, $t7
	syscall

	li $v0, 10
	syscall
