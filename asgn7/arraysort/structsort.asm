.globl swap
.globl selectionSort
.globl printArray

#struct def'n for reference
#struct studentNode {
#   char name[6];
#   int studentid;
#   int coursenum;
#};
	
#struct width: 16 

#/* Recursive function to perform selection sort on subarray `arr[i�n-1]` */
#void selectionSort(studentNode arr[], int i, int n) {
selectionSort:
#callee setup goes here

addi sp, sp, -32
sw ra, 28(sp)	#Store ra

sw s0, 24(sp)	#Allocate space struct arr[]
sw s1, 20(sp)	#Allocate space for i
sw s2, 16(sp)	#Allocate space for n
sw s3, 12(sp)	#Allocate space for min

mv s0, a0	# move parameters to save registers
mv s1, a1
mv s2, a2

#    /* find the minimum element in the unsorted subarray `[i�n-1]`
#    // and swap it with `arr[i]`  */
#    int j;
sw s4, 8(sp)  	#Allocate space for j

#    int min = i;
mv s3, a1


#    for (j = i + 1; j < n; j++)    {
for1:

addi s4, s1, 1 		# initialize j as i+1

forloop1:

bge s4, s2, endfor1	# jump when j > n

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j].studentid < arr[min].studentid) {
if1:			 #s0 = struct arr[], s1 = i, s2 = n, s3 = min, s4 = j, a0 = struct arr[]

slli t0, s4, 4
add t0, t0, s0  	#load j offset from arr starting address 
addi t0, t0, 8		#load 8 offset from arr[j] add to get ID num
lw t1, (t0) 		# get ID num value

slli t2, s3, 4 		
add t2, t2, s0		#load min offset from arr starting address
addi t2, t2, 8		#load 8 offset from arr[min] add to get ID num
lw t3, (t2)		#get ID num value

bge t1, t3, endif1     #if arr[j] is >= arr[min] go back to top of for loop

#            min = j;    /* update the index of minimum element */
mv s3, s4 

#        }
endif1:

addi s4, s4, 1 		# j++
b forloop1		# back to top of for loop

endfor1:

#    }

#    /* swap the minimum element in subarray `arr[i�n-1]` with `arr[i] */
#caller setup goes here

mv a0, s0		# move in parameters to set up for swap call
mv a1, s3
mv a2, s1
jal ra, swap

#    swap(arr, min, i);


#caller teardown goes here (if needed)

#    if (i + 1 < n) {
if2:

addi t0, s1, 1		# i + 1
bge t0, s2, endif2 	# if (i + 1 < n)

#caller setup goes here

#        selectionSort(arr, i + 1, n);

mv a0, s0		# move in parameters to set up for selectionSort call
mv a1, t0 	
mv a2, s2
jal selectionSort

#caller teardown goes here (if needed)


#    }
endif2:

#callee teardown goes here (if needed)

lw ra, 28(sp)		# restore all values saved onto the stack 
lw s0, 24(sp)	
lw s1, 20(sp)	
lw s2, 16(sp)	
lw s3, 12(sp)	
lw s4, 8(sp)		
addi sp,sp,32		# reset the stack pointer
ret			# return

#}

#/* Function to print `n` elements of array `arr` */
#void printArray(studentNode arr[], int n) {
printArray: 
#variables: 
#s0 = arr[]
#
#callee setup goes here
addi sp, sp, -16		# make space on the stack and save ra + necessary values
sw ra, 12(sp)
sw s0, 8(sp)
sw s1, 4(sp)

mv s0, a0			# move argument values to saved registers
mv s1, a1

#    int i;
sw s2, 0(sp)			# intialize i

#    for (i = 0; i < n; i++) {
for2:
mv s2, x0			# set i to 0

forloop2:
bge s2, s1, endfor2

#use ecalls to implement printf
#        printf("%d ", arr[i].studentid);
slli t0, s2, 4  	# multiply index by 16
add t1, s0, t0 		# add full index to base address.
addi t1, t1, 8 		# add 8 to get address of student id
lw t2, (t1)		# load student id value

mv a0, t2   		# move value to a0 to be printed
        
li a7, 1
ecall              #print the number

li a0, 0x20
li a7, 11
ecall              # print a space


#        printf("%s ", arr[i].name);

addi t1, t1, -8		# subtract 8 from student id address to get starting address of the name
mv a0, t1   		# move val into a0 to be printed
       
li a7, 4
ecall              #print the number

li a0, 0x20
li a7, 11
ecall              # print a space

#        printf("%d\n", arr[i].coursenum);
addi t1, t1, 12 	# add 12 to same register to get starting add of course num 
lw t4, (t1)		# load course num value
mv a0, t4  		# move val into a0 to be printed
       
li a7, 1
ecall              #print the number

li a0, 0x0a
li a7, 11
ecall              # print a new line

addi s2, s2, 1     # increment i
b forloop2

#    }
endfor2:

#callee teardown goes here
lw ra, 12(sp)		# load back saved values
lw s0, 8(sp)
lw s1, 4(sp)
lw s2, 0(sp)
addi sp, sp, 16		# reset the stack pointer
ret			# return


#}


#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {
swap:
#callee setup goes here
addi sp, sp, -32		# set aside space on the stack
sw ra, 28(sp)			# save all necessary values
sw s0, 24(sp)
sw s1, 20(sp)
sw s2, 16(sp)
sw s3, 12(sp)

#    studentNode temp = arr[i];
slli t0, a1, 4
add t0, t0, a0  	#load i offset from arr starting address
lw t1, (t0) 		#load all the contents of arr[i] node into temp
lw t2, 4(t0) 
lw t3, 8(t0) 
lw t4, 12(t0)  

#    arr[i] = arr[j];
slli t5, a2, 4 		#multiply j by 16 to get correct offset
add t5, t5, a0  	#t5 has address of arr[j]
lw s0, (t5)		# load contents of node at arr[j]
lw s1, 4(t5)
lw s2, 8(t5)
lw s3, 12(t5)

sw s0, (t0)		# store contents of arr[j] to arr[i]
sw s1, 4(t0)
sw s2, 8(t0)
sw s3, 12(t0)

#    arr[j] = temp;
sw t1, (t5)		# store contents of temp to arr[j]
sw t2, 4(t5)
sw t3, 8(t5)
sw t4, 12(t5)

# swap callee teardown goes here
lw ra, 28(sp)		#load back original saved values
lw s0, 24(sp)	
lw s1, 20(sp)	
lw s2, 16(sp)	
lw s3, 12(sp)
addi sp, sp, 32		# reset the stack pointer
ret			# return

#}
