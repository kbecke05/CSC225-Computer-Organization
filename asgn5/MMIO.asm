# Names: Chloe Anbarcioglu and Kelly Becker
# Course: CSC 225

.text
.globl readchar

readchar:

lw t0, RCR			# loads RCR address
lw t0, (t0)			# gets value at RCR (bit[0] is one when keyboard has recieved a new char)
andi t0, t0, 1			# finds out if bit[0] is one or not (has keyboard recieved new char?)
beq t0, zero, readchar		# is bit[0] != 1 AKA no new char, repeat loop

lw t0, RDR			# gets address of RDR - bit [7:0] contains last char typed on keyboard
lbu t0, (t0)			# loads input char

jalr zero, ra, 0		# returns from subroutine

.globl printchar

printchar:

lw t6, TDR    			# loads TDR address
add t5, zero, a0 		# moves char to t5 register
sw t5, (t6)			# writes char (store char to TDR location in memory)

jalr zero, ra, 0		# returns from subroutine

.globl printstring 
			
printstring: 

sw ra, printra, t4		# stores printstring ra value

innerloop:

lb a0, (t3)  			# loads byte/char at display chars address pointer 
beqz a0, exit			# if val in address is null (end of string), exit subroutine

jal printchar			# jumps to printchar
addi t3, t3, 1			# increments TDR pointer to next byte/char
b innerloop			# loops

exit:
lw ra, printra			# restores printstring ra value
jalr zero, ra, 0		# returns from subroutine


.data

.globl RCR RDR TCR TDR initstring keypressed savet0 savet3 savet5 savet6 printra initra exceptstring handlerra counter rando

RCR: .word 0xffff0000
RDR: .word 0xffff0004
TCR: .word 0xffff0008
TDR: .word 0xffff000c
initstring: .string "\nInitializing Interrupts\n"
exceptstring: .string "\nUndetermined Exception\n"
keypressed: .string "\nkey pressed is : "

savet0: .word 0x0
savet3: .word 0x0
savet5: .word 0x0
savet6: .word 0x0
printra: .word 0x0
initra: .word 0x0
handlerra: .word 0x0
memra: .word 0x0
counter: .word 0x0
rando: .word 0xDEADBEEF

