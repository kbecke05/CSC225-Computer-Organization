# 1.  0xABCDEF00
# 2. to store address of next num in table to be added to sum
# 3. Adderesses are aligned by 4 bytes - skip to next address
# 4. 10 = size of data table/number of numbers to be summed

# x1 = counter/sum/answer
# x2 = the mask
# x4 = result of masking the user input
# x5 = loop counter (32 times)
# x8 = temp for storing inital val and final result to memory

.text
.globl main

main:

andi x1, x1, 0 # clear r1, create counter
addi x2, x0, 1 # create mask at r2
addi x5, x0, 32

li a7, 5 # read user input (int) from console to a0 
ecall 

sw a0, mydata, x8 #store inital value to mydata loc in memory

loop:

while:

bge zero, x5 , endwhile # while the shifted user input still greater than 0

and x4, a0, x2 # mask  user input, store to new register x4
add x1, x1, x4 # add final bit number to counter 
srli a0, a0, 1 # shift the original
addi x5, x5, -1 #decrement the loop counter

b while # unconditional jump to beginning of while loop

endwhile:

sw x1, myrslt, x8 # store the final answer to myrslt loc in memory

#exit the program

.data 

mydata: 
.word 0

myrslt:
.word 0

