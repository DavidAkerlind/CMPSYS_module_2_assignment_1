	.data
	
ask: .asciiz "\nEnter the number you are searching for: "
searching: .asciiz "searching....."
found_p: .asciiz "\nThe position of the number is: "
missing_p: .asciiz "\nNumber is missing"
array: .word 5, 7, 1, 9, 2, 4, 8, 3, 6
size: .word 9

	.text
	.include "print.s"
	.globl main
	
main: 

# Load varaibles in to safe registers
	la $s0, array           # $s0 = base address of array
    lw $s1, size            # $s1 = array size
    
	
	subu $sp, $sp, 16 # 4 words	in stackpointer bu moving the stackpinter backwards
	la $a0, ask
	jal print
	addu $sp, $sp, 16 # restore stackpointer after print.s subrutinte
	
# Read integer from user
	li $v0, 5
	syscall
	move $s2, $v0 			# $s2 = target
	
	
# Call search function (passing 3 arguments)
	move $a0, $s0		# prepare $a0 with array (base)
	move $a1, $s1		# prepare $a1 with size of array 
	move $a2, $s2		# prepare $a2 with a target value
	jal search
	
	j exit
	
search:
# Save retrun adress
	subu $sp, $sp, 32		# make space for 6 words	in stackpointer 
	sw $ra, 0($sp)	  		# store the seach-subrutine (this one) return adress
	
	li $t0, 0               # $t0 = index counter (starts at 0)
	
# Take out the arguments passed and store them in temporary registers that can be changed 
    move $t1, $a0           # $t1 = base address of array = array = $t1
    move $t2, $a1           # $t2 = array size
    move $t3, $a2           # $t3 = target value
	
	j search_loop

search_loop:
	beq $t0, $t2, missing 	# index = size we have gone trough the whole list 
	
	lw $t4, 0($t1) 			# $t4 = array[index]
	
	beq $t4, $t3, found     # if equal means element found


	addi $t0, $t0, 1		#  index++
	addi $t1, $t1, 4		# move to next number in array (4 bytes)
	
	j search_loop
	

found: 

	move $s3, $t0 # move the index in $t0 to a safe place $s3
	
	subu $sp, $sp, 16 # 4 words	in stackpointer (make space for print)
	la $a0, found_p
	jal print
	addu $sp, $sp, 16 # restore space stack after print
	
	# Print the index
    li $v0, 1
    move $a0, $s3        
    syscall
	
	jal search_return
	

missing: 
	subu $sp, $sp, 16 # 4 words	in stackpointer
	la $a0, missing_p
	jal print
	addu $sp, $sp, 16
	
	jal search_return
	
search_return:
    # Restore return address and return
    lw $ra, 0($sp)    # we stored this in the beginning of the search subroutine
    jr $ra
    
    
exit: 
	li $v0, 10
	syscall
