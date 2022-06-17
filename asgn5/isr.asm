# Names: Chloe Anbarcioglu and Kelly Becker
# Course: CSC 225

text:

.globl init

init:

sw ra, initra, t4   		# stores init ra value
 
la t3, initstring		# loads initstring address
jal ra, printstring		# calls print string (a0 = address of string to be printed?)

la t0, handler 			# sets handler's address to temp register to access
csrrw zero, 5, t0		# loads handler address to utvec register AKA set handler address
lw t4, RCR			# loads RCR address to temp register
addi t3, zero, 2		# sets bit 1 to val 1 to enable send/recieve device interrupts
sw t3, (t4) 			# stores new val back to RCR location in memory
addi t3, zero, 0X100	
csrrs zero, 4, t3  		# sets the uie value with sign extended 0x100 immediate to set bit 8 to 1 
				# (i.e. Enable global/cpu to recieve device interrupts)
csrrsi zero, 0, 1		# sets interrupt enable bit in ustatus to turn on interrupt checking

lw ra, initra			# restores init ra value
jalr zero, ra, 0		# returns from subroutine

handler:

sw, t0, savet0, t4		# stores temp

# exception
csrrs t0, 66, zero		# loads ucause val in temp
andi t0, t0, 1			# checks to see if exception or interrupt
bgtz t0, except			# if exception, branches to except

# interrupt
sw ra, handlerra, t4 		# stores handler ra value

# stores temps
sw t3, savet3, t4 
sw t5, savet5, t4
sw t6, savet6, t4

la t3, keypressed		# loads keypressed string
jal ra, printstring		# jumps to printstring

lw t3, RDR			# gets address of RDR - bit [7:0] contains last char typed on keyboard
lw a0, (t3)			# loads char into RDR
jal ra, printchar		# jumps to printchar
li a0, '\n'			# loads new line
jal ra, printchar		# jumps to printchar

lw t0, counter			# loads counter
beqz t0, exit			# if counter == zero, jump back to main

lw t1, RDR			# gets address of RDR - bit [7:0] contains last char typed on keyboard
lw a0, (t3)			# loads char into RDR

restores:

addi t0, t0, -1			# decrements the counter
sw t0, counter, t4		# updates decremented counter in memory

lw ra, handlerra		# restores handler ra value

# restores temps
lw t3, savet3
lw t5, savet5
lw t6, savet6

uret				# returns to uepc (main)

except:

sw t3, savet3, t4 		# stores temp

la t3, exceptstring		# loads keypressed string
jal ra, printstring		# jumps to printstring

# restores temps
lw, t0, savet0		
lw t3, savet3

la t0, next			# loads address of .text label loop
csrrw zero, 65, t0		# sets uepc to temp val
uret				# returns to uepc val

exit:

la t0, main			# loads address of .text label main
csrrw zero, 65, t0		# sets uepc to temp val
uret				# returns to uepc val
