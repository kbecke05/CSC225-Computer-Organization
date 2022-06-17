# Text section included for reference only. DO NOT HAVE A TEXT SECTION OR EXECUTABLE CODE IN YOUR DATAFILE!!!!
#.text
    # la     t0, QuestionTable 		# load start address of questions table to temp 0
    # lw     a0, 0(t0)			# load zero offset of address to a0 to be outputted
    # li     a7, 4			# print string
    # ecall

.data

.globl name
name:  .space 20

#this structure is common in assembly and C. Notice that Q1 is not global, but is an entry in a table. 
#label addresses can be "encoded" as the value of a .word
.globl QuestionTable

QuestionTable:
	.word	Q1 Q2 Q3

Q1:      .string  "\nWhat is the best region of the US?\n   1 - West Coast\n   2 - Midwest\n   3 - Northeast\n   4 - South\n"
Q2:    	 .string  "\nWhat is the best season?\n   1 - Fall\n   2 - Winter\n   3 - Spring\n   4 - Summer\n"
Q3:    	 .string  "\nAre you stressed out right now?\n   1 - Yes\n   2 - No\n   3 - Of course, why would you even ask\n   4 - No, I'm better than other people\n"


.globl AnswerTable

AnswerTable: 
	.word Q1Answ Q2Answ Q3Answ

Q1Answ:  .word    15 7 3 1
Q2Answ:  .word    16 8 6 5 
Q3Answ:  .word    16 11 10 2


.globl ResultTable

ResultTable:
         .word Result1	
         .word Result2
         .word Result3	
         .word Result4	

Result1:	.string  "\nNice job, "
Result2:	.string  "\nSounds like fun, "
Result3:	.string  "\nI think we'd be friends, "
Result4:	.string  "\nYou suck, "


.globl prompt 
prompt: .asciz "Enter Player Name: " 
.globl prompt2 
prompt2: .asciz "Answer: "