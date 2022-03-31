.data
	n:      .word 25 #Declare a new variable/label (n) and set it to 25.

	#Instructions 
	str1: .asciiz "Less than\n"
	str2: .asciiz "Less than or equal to\n"
	str3: .asciiz "Greater than\n"
	str4: .asciiz "Greater than or equal to\n"
	user_input: .asciiz "Enter an integer to compare: "

.text
	#Read integer from user	
	li  $v0, 5
	syscall
	
	#Store user input
	move $s1, $s0
	la $s0, n
	lw $s0, 0($s0)
	
	#Less than 
	slt $t0, $s1, $s0
	bne $t0, $zero, LESS
	
	GREATER:
		li      $v0, 4
		la      $a0, str4
		syscall
		j END
	
	LESS:
		li      $v0, 4
		la      $a0, str1
		syscall
		j END
	
	END:
		li      $v0, 10
		syscall
	
	

