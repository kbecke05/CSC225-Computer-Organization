.globl swap 
.globl selectionSort
 
#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here
addi sp, sp, -32
sw ra, 28 (sp)	#Store ra
sw s0, 24(sp)	#Allocate space for arr
sw s1, 20(sp)	#Allocate space for i
sw s2, 16(sp)	#Allocate space for n
sw s3, 12(sp)	#Allocate space for min
sw s4, 8(sp)  	#Allocate space for j

mv s0, a0 	# move parameters to save registers
mv s1, a1
mv s2, a2


    #/* find the minimum element in the unsorted subarray `[i…n-1]`
    #// and swap it with `arr[i]`  */
#    int j;

#    int min = i;
mv s3, a1   # intialize min (s3) to i

#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
addi s4, s1, 1

forloop:
# j < n
bge s4, s2, endfor

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j] < arr[min]) {
if1: #s0 = arr[], s1 = i, s2 = n, s3 = min, s4 = j, a0 = arr[]

slli t0, s4, 2
add t0, t0, s0  	#load j offset from arr starting address
lw t1, (t0)		#load val at arr[j]
slli t2, s3, 2 		
add t2, t2, s0		#load min offset from arr starting address
lw t3, (t2)		#load val at arr[min]
bge t1, t3, endif1     #if arr[j] is >= arr[min] go back to top of for loop


#            min = j;    /* update the index of minimum element */
mv s3, s4  # set what used to be in t1 (min) to t0(j)

#        }
endif1:

addi s4, s4, 1 		# j++
b forloop		# back to top of for loop

#    }
endfor:
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#    swap(arr, min, i);
#caller setup and subroutine call for swap goes here.

mv a0, s0	# move values to be parameters for the swap function call
mv a1, s3
mv a2, s1
jal ra, swap

#caller teardown for swap goes here (if needed).
 
#    if (i + 1 < n) {

if2:

addi t0, s1, 1		#    i + 1
bge t0, s2, endif2 	#    if (i + 1 < n)


#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.
mv a0, s0 		# move parameters into argument registers to set up for selectionSort call
mv a1, t0 		#we know t0 must be i+1 still
mv a2, s2
jal selectionSort

#caller teardown for selectionSort goes here (if needed).


#    }
endif2:

# callee teardown goes here

lw ra, 28(sp)		#load all saved values back and return
lw s0, 24(sp)	
lw s1, 20(sp)	
lw s2, 16(sp)	
lw s3, 12(sp)	
lw s4, 8(sp)		
addi sp,sp,32	
ret
#}

 

#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap: 
# swap callee setup goes here

addi sp, sp, -16	# make space on the stack for this function
sw ra, 12(sp)		# store ra on the stack

#    int temp = arr[i];

slli t0, a1, 2
add t0, t0, a0  	#load i offset from arr starting address
lw t1, (t0)		# get value at arr[i]

#    arr[i] = arr[j];
slli t2, a2, 2
add t2, t2, a0  	#load j offset from arr starting address
lw t3, (t2)		#get value at arr[j]

sw t3, (t0) 		# store arr[j] contents into arr[i] address

#    arr[j] = temp;
sw t1, (t2)		# store temp (arr[i]) contents into arr[j] address

# swap callee teardown goes here
lw ra, 12(sp)		# load back the ra
addi sp, sp, 16		# reset the stack pointer
ret			# return

#}
