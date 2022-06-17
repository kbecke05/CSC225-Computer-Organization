.text
andi	x1, x1, 0  	# clear r1
lw	x3, mydata	# get the data
addi	x4, x0, 1	# load the mask into r4
and	x1, x3, x4  	# and r4 and r3, put results in r1
sw	x1, myrslt, x2	# store answer in myrslt	

.data
mydata: 
.word 0x56

myrslt:
.word 0
