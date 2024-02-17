.global _start

.section .text
_start:
#your code here

    movq $source_array, %rax
    movq $down_array, %rbx
    movq $up_array, %rcx
    movl size, %rdx

    movl (%rax), %r8d                       # min value
    xor %r11, %r11                          # index

    movl (%rax), %r9d                       # max value
    xor %r12, %r12                          # index

find_Min_HW1:
    cmp %r11, %rdx
    jge find_Max_HW1

    movl (%rax, %r11, 4), %r13d
    cmp %r13d, %r8d
    jl setLess_HW1

    inc %r11
    jmp find_Min_HW1

setLess_HW1:
    movl %r13d, %r8d
    inc %r11
    jmp find_Min_HW1

find_Max_HW1:
    cmp %r12, %rdx
    jge continue_HW1

    movl (%rax, %r11, 4), %r13d
    cmp %r13d, %r9d
    jg setBigger_HW1

    inc %r12
    jmp find_Max_HW1

setBigger_HW1:
    cmp %r13d, %r9d
    inc %r12
    jmp find_Max_HW1


continue_HW1:
    dec %r8d
    inc %r9d

    xor %r10, %r10                         # index

forloop_HW1:
    cmp %r10, %rdx
    jge sucess_HW1

    movl (%rax, %r11, 4), %r13d
    cmp %r8d, %r13d
    jge insert_down_HW1

    cmp %r13d, %r9d
    jge insert_up_HW1

    inc %r10
    cmp %r10, %rdx
    jge continue_loop_HW1

    movl (%rax, %r10, 4), %r15d
    dec %r10
    cmp %r13d, %r15d
    jge insert_down_HW1
    jmp insert_up_HW1


continue_loop_HW1:
    movl %r13d, (%rcx)
    add $4, %rcx
    jmp forloop_HW1

insert_down_HW1:
    cmp %r13d, %r9d 
    jge fail_HW1

    movl %r13d, (%rbx)
    add $4, %rbx
    jmp forloop_HW1

insert_up_HW1:
    cmp %r8d, %r13d
    jge fail_HW1

    movl %r13d, (%rcx)
    add $4, %rcx
    jmp forloop_HW1

fail_HW1:
    movb $0, (bool)
    jmp end_HW1


sucess_HW1:
    movb $1, (bool)
    jmp end_HW1


end_HW1:



