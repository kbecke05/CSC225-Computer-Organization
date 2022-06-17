# This program both prints and read a string from the console.  
# Some people have issues, so make sure this works ok for you.
# Contact me if this program is not working for you reliably.

	.globl main	#main is a label that other programs and files can see.

	.text 	# start of code section
main: 	# programs start at main

	la a0, query	# put the address of the label "query" into a0. Note query hasn't been defined yet.
	li a7, 4 	# putting 4 into a7 is printstring
	ecall      	# issue the system call to print the string
	
	la a0, name	# put the address of the label "name" into a0. Note query hasn't been defined yet.
	li a1, 50	# we dont'want to read more than 50 chars
	li a7, 8 	# putting 4 into a7 is readstring
	ecall      	# issue the system call to read a string from the console. press enter to finish.

	la a0, resp	# put the address of the larespbel "query" into a0. Note query hasn't been defined yet.
	li a7, 4 	# putting 4 into a7 is printstring
	ecall      	# issue the system call to print the string

	la a0, name	# put the address of the label "name" into a0. Note query hasn't been defined yet.
	li a7, 4 	# putting 4 into a7 is readstring
	ecall      	# issue the system call to read a string from the console. press enter to finish.
	
	li a7, 10  # Again we need to indicate what system call we are making and this time we are calling exit(93)
	ecall 

	.data	 	# start of data section
query:	.string "\nHello. What is your name? :"
resp:	.string "\nNice to meet you "
name:	.space 50
