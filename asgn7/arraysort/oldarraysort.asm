.globl swap 
.globl selectionSort
 
#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here
addi sp, sp, -16
sw ra, 12 (sp)
sw a2, 8 (sp)
sw a1, 4 (sp)
sw a0, 0 (sp)

# need to preserve int n (a2) because it gets overriden when calling swap!!!

    #/* find the minimum element in the unsorted subarray `[i…n-1]`
    #// and swap it with `arr[i]`  */
#    int j;
li t0, 0

#    int min = i;
lw t1, 4(sp)

#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
addi t0, t0, 1

forloop:
# j < n
bge t0, a2, endfor

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j] < arr[min]) {
if1:

add t2, t0, a0  	#load j offset from arr starting address
lw t3, (t2) 		#load val at arr[j]
add t2, t1, a0		#load min offset from arr starting address
lw t4, (t2)		#load val at arr[min]
bge t3, t4, endif1     #if arr[j] is >= arr[min] go back to top of for loop


#            min = j;    /* update the index of minimum element */
lw t1, 0(t0)  # set what used to be in t1 (min) to t0(j)

#        }
endif1:

addi t0, t0, 1 		# j++
b forloop		# back to top of for loop

#    }
endfor:
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#    swap(arr, min, i);
#caller setup and subroutine call for swap goes here.

lw a0, 0(sp)
mv a1, t1
lw a2, 4(sp)
jal swap

#caller teardown for swap goes here (if needed).

lw a2, 8 (sp)
lw a1, 4 (sp)
lw a0, 0 (sp)
addi sp, sp, 16 
 
#    if (i + 1 < n) {

if2:

addi t2, a1, 1
bge a2, t2, endif2


#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.

addi t2, t2, 1
# a0 should still be the same
lw a1, 0(t2)
lw a2, 8 (sp)
jal selectionSort

#caller teardown for selectionSort goes here (if needed).

lw a2, 8 (sp)
lw a1, 4 (sp)
lw a0, 0 (sp)
addi sp, sp, 16

#    }
endif2:

	
# callee teardown goes here
lw ra, 12 (sp)
addi sp, sp, 16
ret
#}

 

#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap: 
# swap callee setup goes here

addi sp, sp, -16
sw ra, 12(sp)
sw a2, 8(sp)
sw a1, 4(sp)
sw a0, 0(sp)

#    int temp = arr[i];

add t3, a0, a1  	#load i offset from arr starting address
#    arr[i] = arr[j];
add t4, a0, a2  	#load j offset from arr starting address

#    arr[j] = temp;
sw t4, 4(sp)
sw t3, 8(sp)


# swap callee teardown goes here
lw ra, 12(sp)
lw a2, 8(sp)
lw a1, 4(sp)
lw a0, 0(sp)
addi sp, sp, 16


#}
