        .globl  recurSelectionSort
        
recurSelectionSort:

addi sp, sp, -32
sw ra, 28(sp)
sw s0, 24(sp)
sw s1, 20(sp)
sw s2, 16(sp)
sw s3, 12(sp)
sw s4, 8(sp)

#struct Node* recurSelectionSort(struct Node* head) {

mv s0, a0

#       if (head->next == NULL)

addi t0, s0, 16
lw t0, (t0)
bne t0, zero, end

#               return head;


#       struct Node* min = head;
mv s1, a0


#       struct Node* beforeMin = NULL;
mv s2, zero

#       struct Node* ptr;

#       for (ptr = head; ptr->next != NULL; ptr = ptr->next) {
forinit: #s0=head, s1=min, s2=beforeMin, s3 = ptr
mv s3, s0

forloop:
addi t1, s3, 16
lw t1, (t1)
beqz t0, endfor

#               if (ptr->next->studentid < min->studentid ) {
ifmin:
addi t2, s3, 16
addi t2, t2, 8
lw t3, (t2)
addi t4, s1, 8
lw t5, (t4)
bge t3, t5, endifmin

#                       min = ptr->next;

addi t2, s3, 16
mv s3, t2

#                       beforeMin = ptr;
mv s2, s3
endifmin:

lw t6, (t2)
sw t6, (s3)

b forloop
#               }



endfor:
#       }


if2: #s0=head, s1=min, s2=beforeMin, s3 = ptr
#       if (min != head)
beq s1, s0, endif2

#               swapNodes(&head, head, min, beforeMin);
sw s3, 4(sp)  

mv a1, s3
mv a2, s0
mv a3, s1
mv a4, s2
jal swapNodes

endif2:
#       head->next = recurSelectionSort(head->next);
addi t2, s0, 16
lw t3, (t2)

mv a0, t3
jal recurSelectionSort

end:

lw ra, 28(sp)
lw s0, 24(sp)	
lw s1, 20(sp)	
lw s2, 16(sp)	
lw s3, 12(sp)	
lw s4, 8(sp)		
addi sp, sp, 32	
ret

#       return head;



#}