# s1 = total point counter
# s2 = starting address of answer table
# t0 = temp for storing user name chars (name_prompt) need to reset @ end
# t2 = temp for comparing result values
# t3 = temp for storing offset in point_val
# t6 = temp for holding question table address, then for result table address
# a1 = address of start of answer table for each question


main:

la a0, name		# load location to store name to a0 as parameter for name_prompt
jal name_prompt		# prompt for and store user name
and s1, s1, zero	# reset counter

la t6, QuestionTable	# t6 contains the starting address of the question list
la s2, AnswerTable	# s2 contains the starting address of the answer list

# QUESTION 1

li a7, 4		# display question 1
lw a0, 0(t6)		# access first element in Question Table
ecall

jal int_answer		# Get answer, as an integer between 1-4, for question 1. Output to a0
lw a1, 0(s2)		# load address of table of answer values for question 1 to a1 as parameter for point_val
jal point_val		# Determine the points for the answer. Input from a0 and a1, Output to a0
add s1, s1, a0		# Increment the total points.

# QUESTION 2

li a7, 4		# display question 2
lw a0, 4(t6)		# get starting address of question 2
ecall

jal int_answer		# Get answer, as an integer between 1-4, for question 2.
lw a1, 4(s2)		# load address of table of answer values for question 2 to a1 as parameter for point_val
jal point_val		# Determine the points for the answer 
add, s1, s1, a0		# Increment the total points.

# QUESTION 3

li a7, 4		# display question 3
lw a0, 8(t6)		# get starting address of question 3
ecall

jal int_answer		# Get answer, as an integer between 1-4, for question 3.
lw a1, 8(s2)		# load address of table of answer values for question 3 to a1 as parameter for point_val
jal point_val		# Determine the points for the answer 
add, s1, s1, a0		# Increment the total points.

# RESULT		
			
jal get_result		# get result including user's name
			# return address of correct result based on point number to a0


b main			# unconditionally return to start of program (restart new quiz in endless loop)








# SUBROUTINES


name_prompt: #args: location to put user name (a0), returns: address of correct result

	mv t0, a0 		#store loc to put user name in temp register
	li t1, 0x0a 		#store enter key value for comparison

	li a7, 4		#output the prompt "Enter Player Name: "
        la a0, prompt
        ecall

	readstorename: 

	li a7, 12 		# ecall - read the char
	ecall
	beq a0, t1, exit	# check whether the char is the null (end of string), if it is, exit back to main
	sb a0, 0(t0)		# if it's not, then to store to memory
	addi t0, t0, 1		# go to the next place in memory
	b readstorename
	
	exit:
	sb x0, 0(t0) 		# store null char
	ret			# return to place in main

int_answer: #args: prompt user for int answer to questions, returns: answer as int in a0. RESET MODIFIED REGISTERS

li a7, 4		#output the prompt "Answer: "
la a0, prompt2
ecall

li a7, 5		# read int answer from user, store to a0
ecall

ret 			# exit subroutine and return to place in main




point_val: #args: answer as int in a0, returns: point val for answer in a0

# store answer value in a0  ---> location of point val = mem loc of point val w/ offset 4*answer (4 = word size)
# store memory locations of first answer in a1

addi t4, zero, 4	# load val 4 to t4 because each int in table is size of a word
addi a0, a0 ,-1 	# decrement a0 by 1 to make answers 0,1,2,3 for indexing purposes

mul a0, a0, t4		# mult int answer by 4 to get word address of corresponding point val
add t3, a0, a1		# load the offset val to t3
lb a0, 0(t3)		# load int val offset from address of first answer to a0 to be returned
	

ret 			#exit subroutine and return to place in main




get_result:

la t6, ResultTable	# load starting address of result table

result1:		# if s1 (total points) between 0-15, print Result 1
addi t2, zero, 15 	# give value 15 a label for comparison
bge s1, t2, result2	# if val greater than 15, go to next result

li a7, 4		# display result 1
lw a0, 0(t6)		# access first element in Result Table
ecall

b final_exit		# go to print new line and return to main

result2:		# if s1 between 16-30, return address of Result 2
addi t2, zero, 30 	# give value 30 a label for comparison
bge s1, t2, result3	# if val greater than 30, go to next result

li a7, 4		# display result 2
lw a0, 4(t6)		# access second element in Result Table
ecall

b final_exit		# go to print new line and return to main

result3:		# if s1 between 31-45, return address of Result 3
addi t2, zero, 45	# give value 45 a label for comparison
bge s1, t2, result4	# if val greater than 45, go to next result

li a7, 4		# display result 3
lw a0, 8(t6)		# access third element in Result Table
ecall

b final_exit		# go to print new line and return to main

result4:		# if s1 greater than 45, return address of Result 4

li a7, 4		# display result 4
lw a0, 12(t6)		# access fourth element in Result Table
ecall     


final_exit:

li a7, 4		#print name
la a0, name		#reset t0 to starting address of name in memory
ecall

li a7, 11 		#print char command
addi a0, zero, 0x0A 	#load enter key to be printed to create new line
ecall

ret			# return to main function


