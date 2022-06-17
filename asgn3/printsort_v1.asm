 #t0 = x5 = memory label counter
 #t1 = enter key value
 #t2 = val at t0
 #t3 = 127 num of ascii values
 #t4 = ascii counter val
 
 .text
 
main:

init1: # reading chars and storing to memory
 	
      	 la t0, input #store address of start of string
      	 li t1, 0x0a #store enter key value for comparison
      	
         # Prompt for the string to enter
         li a7, 4
         la a0, prompt
         ecall
         
readstore: 
	#ecall - read the char
	li a7, 12
	ecall
	#check whether the char is the enter key
	beq a0, t1, init2
	#if it's not, then i want to store to memory
	sb a0, 0(t0)
	#go to the next place in memory
	addi t0, t0, 1
	#go back to checking if its the enter key or not
	b readstore
	#if it is exit the loop and move to part2 
	
         
init2:  #reading chars from memory and printing them

	 sb zero, 0(t0) #store zero at end of string to reset
	 la t0, input #store address of start of string
	 addi t3, zero, 127 #load num ascii vals
	 andi t4, t4, 0 #create counter at t4
	 #addi t4, t4, 0x61
	 
         
         # Output "Alphabetized word: "
         li a7, 4 #load print string command
         la a0, output # load prompt to be outputted
         ecall
         
         
         
loadprint:  
	 lb t2, 0(t0) #store value at t0 to register t2
	 
	 beq t3, t4, newline #if reach the end of ascii table, go to newline then main
	 
	 innerloop:
	 lb t2, 0(t0) #store value at t0 to register t2
	 beqz t2, incrementasciicounter # if char at counter == null char, EXIT to main
	 
	 if:
	 beq t2, t4, outputchar #if val @ pointer == ascii val 
	 
	 addi t0, t0, 1 #increment counter pointer by 1 byte
         b innerloop
	 
         outputchar:
         li a7, 11 #load print char command to a7
         add a0, zero, t2 # load char at counter to a0 
         ecall
         addi t0, t0, 1 #increment counter pointer by 1 byte
         b innerloop
         
         incrementasciicounter:
         addi t4, t4, 1 #increment ascii counter
         la t0, input #reset store address of start of string
         b loadprint
         
newline:
	li a7, 11 #print char command
	addi a0, zero, 0x0A #load enter key to be printed
	ecall
	b main #branch to main
         
      .data
      input:     .space 20
      prompt:    .asciz "Enter word: "
      output:    .asciz "Alphabetized word: "