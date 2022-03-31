.data
	userInput: .asciiz "Please enter a number: "
	evenSum: .asciiz "\nSum of even numbers is: "
    	oddSum: .asciiz "\nSum of odd numbers is: "
.text
	li $s0, 0 #use register s0 for even sum
	li $s1, 0 #use register s1 for odd sum

#function to ask user for input and keep repeating 
MAIN:
    	li $v0, 4
    	la $a0, userInput
    	syscall #this syscall will print userInput 

    	li $v0, 5
    	syscall #this syscall will read the integer

    	beq $v0, 0, EXIT #When user inputs 0 program will stop and print sums
    	
    	move $t1, $v0 #Use register $t1 to store the user's integer. This will be the Divident aka numerator
    	
    	#Use while loop to calculate division using repeated subtraction
    	while:
    		blt $t1, 2, exit #Branch if the remainder if less than the divisor
    	 	addi $t1, $t1, -2 #Subtract 2 to check if the remainder will be 1 or 0
    	 	j while
    	exit: 
    		beq $t1, 0, EVEN #if the remainder is 0 it means the number is even
    		beq $t1, 1, ODD #if the remainder is 1 it means the number is odd
    		blt $t1, 0, NEGATIVE #if the remainder is negative convert to postive
 
NEGATIVE:
	#make the number postive and go back to loop to determine if it's odd or even
	mul $t1, $t1, -1
    	
    	j while
	
EVEN:
	#calculate even sum in this function
	add $s0, $s0, $v0
    	
    	j MAIN
	
ODD:
	#calculate odd sum in this function
    	add $s1, $s1, $v0
    	
    	j MAIN

#Function to print sums
EXIT:
   	#Print the even sum
    	li $v0, 4
    	la $a0, evenSum
    	syscall 
    	move $a0, $s0
    	la $v0, 1
    	syscall
    	
    	#Print the odd sum
    	li $v0, 4
    	la $a0, oddSum
    	syscall
    	move $a0, $s1
    	la $v0, 1
    	syscall
    	
    	#TERMINATE PROGRAM
    	li $v0, 10
    	syscall 