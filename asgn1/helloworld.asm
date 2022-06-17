	.globl main	#main is a label that other programs and files can see.

	.data  		# this part (section) of the program is data
str:	.string "Hello World!\n" # Copy the string "Hello World!\n" into memory 

	.text	# Tell the assembler that we are writing code (text) now 
main: # Make a label to say where our program should start from

	la a0, str	#la means to Load Address loads the address of "str" into a0.
	li a7, 4	# a7 is what determines which system call we are calling and we what to call printstring (4)
	ecall   	# actually issue the call

	li a7, 10	# Again we need to indicate what system call we are making and this time we are calling exit(10)
	ecall 
#end of program (this line isn't necessary but a comment sometimes helps make it clear)
