# Names: Chloe Anbarcioglu and Kelly Becker
# Course: CSC 225

.text
.globl main next loop

main:

lw t0, counter			# loads counter from memory
andi t0, t0, 0			# clears counter
addi t0, t0, 4			# sets counter to 5
sw t0, counter, t4		# stores counter back to memory
jal ra, init			# jumps to initialization
lw t1, rando			# causes exception
lw t0, 0(t0)

next:

li a0, '*'			# loads asterick

loop:

jal printchar			# jumps to printchar
b loop




