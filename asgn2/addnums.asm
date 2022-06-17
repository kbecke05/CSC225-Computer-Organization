

.text
.globl main
main:
	andi	x1,x1,0x0  # clear r1
	andi	x4,x4,0x0  # clear r4
	addi	x4,x4,10 # load r4 with #10
	la	x2, tbl    # load @tbl
loop:
	lw	x3,(x2)    # load the next number to be added
	addi	x2,x2,0x4  # increment the pointer
	add	x1,x1,x3   # add the next number to the sum
	addi	x4,x4,-1   # decrement the counter
	bgtz	x4,loop    #do it again if the counter is not yet zero
	
