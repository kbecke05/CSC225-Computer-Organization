        .text

        .globl  main
main:
        addi    sp,sp,-16

#       studentlist = createList(studentArr, SIZE);
        li      a1,10
        la      a0, studentArr
        jal     createList
        sw      a0,12(sp)

#        sort(&studentlist);
        addi    a0,sp,12
        jal     sort

#        printList(studentlist);
        lw      a0,12(sp)
        jal     printList

#       return
        li      a7, 10
        ecall


        .globl  addStudent
# asm is nutty as the struct was passed in the registers.
addStudent:
        addi    sp,sp,-16
        sw      ra,12(sp)
        sw      s0,8(sp)
        sw      s1,4(sp)
        mv      s1,a0
        mv      s0,a1
        li      a0,20
        jal     malloc
        lw      a2,0(s0)
        lw      a3,4(s0)
        lw      a4,8(s0)
        lw      a5,12(s0)
        sw      a2,0(a0)
        sw      a3,4(a0)
        sw      a4,8(a0)
        sw      a5,12(a0)
        sw      s1,16(a0)
        lw      ra,12(sp)
        lw      s0,8(sp)
        lw      s1,4(sp)
        addi    sp,sp,16
        jr      ra

        .globl  createList
createList:
        blez    a1,endcreateList
        addi    sp,sp,-48
        sw      ra,44(sp)
        sw      s0,40(sp)
        sw      s1,36(sp)
        mv      s0,a0
        slli    s1,a1,2
        add     s1,s1,a1
        slli    s1,s1,2
        add     s1,a0,s1
        li      a0,0
cloop:
        lw      a1,0(s0)
        lw      a2,4(s0)
        lw      a3,8(s0)
        lw      a4,12(s0)
        lw      a5,16(s0)
        sw      a1,0(sp)
        sw      a2,4(sp)
        sw      a3,8(sp)
        sw      a4,12(sp)
        sw      a5,16(sp)
        mv      a1,sp
        jal     addStudent
        addi    s0,s0,20
        bne     s0,s1,cloop
        lw      ra,44(sp)
        lw      s0,40(sp)
        lw      s1,36(sp)
        addi    sp,sp,48
        jr      ra
endcreateList:
        li      a0,0
        ret

        .globl  printList
printList:
        beqz    a0,endprintList
        addi    sp,sp,-16
        sw      ra,12(sp)
        sw      s0,8(sp)
        mv      s0,a0

        lw      a0,8(s0)
        jal     printint
        li      a0, 0x20
        jal     printchar
        mv      a0,s0
        jal     printstring
        li      a0, 0x20
        jal     printchar
        lw      a0,12(s0)
        jal     printint
        li      a0, '\n'
        jal     printchar
        lw      a0,16(s0)
        jal     printList
        lw      ra,12(sp)
        lw      s0,8(sp)
        addi    sp,sp,16
        jr      ra

endprintList:
        ret

#essentially swizzles the next pointers of the args.
        .globl  swapNodes
swapNodes:
        sw      a2,0(a0)
        sw      a1,16(a3)
        lw      a5,16(a2)
        lw      a4,16(a1)
        sw      a4,16(a2)
        sw      a5,16(a1)
        ret

        .globl  sort
sort:
        addi    sp,sp,-16
        sw      ra,12(sp)
        sw      s0,8(sp)
        mv      s0,a0
        lw      a0,0(a0)
        beqz    a0,sortbasecase
        jal     recurSelectionSort
        sw      a0,0(s0)
sortbasecase:
        lw      ra,12(sp)
        lw      s0,8(sp)
        addi    sp,sp,16
        jr      ra


        .globl malloc
malloc:
# loosely simulates sbrk system call
# a0 = amount of memory in bytes
# a0 = address to the allocated block
        li      a7, 9
        ecall
        ret

        .globl printchar
printchar:
        li      a7, 11
        ecall
        ret

        .globl printint
printint:
        li      a7, 1
        ecall
        ret

        .globl printstring
printstring:
        li      a7, 4
        ecall
        ret

        .globl  studentArr
        .data
studentArr:
        .string "Dougy"
        .word   13
        .word   2122
        .word   0
        .string "Timmy"
        .word   15
        .word   2122
        .word   0
        .string "Emily"
        .word   18
        .word   2123
        .word   0
        .string "Jimmy"
        .word   14
        .word   2120
        .word   0
        .string "Kimmy"
        .word   11
        .word   2123
        .word   0
        .string "Carlo"
        .word   19
        .word   2123
        .word   0
        .string "Vicky"
        .word   22
        .word   2120
        .word   0
        .string "Anton"
        .word   12
        .word   2322
        .word   0
        .string "Brady"
        .word   10
        .word   2120
        .word   0
        .string "Sonya"
        .word   16
        .word   2123
        .word   0
