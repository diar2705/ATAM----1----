.global _start

.section .text
_start:
#your code here

    movq $source_array, %rax
    movq $down_array, %rbx
    movq $up_array, %rcx
    movl size, %edx

    movl (%rax), %r8d                       # min value

    movl (%rax), %r9d                       # max value

find_Min_HW1:
    cmp %r11d, %edx
    jge find_Max_HW1

    movl (%rax), %r13d
    cmp %r13d, %r8d
    jl setLess_HW1

    add $4, %rax
    jmp find_Min_HW1

setLess_HW1:
    movl %r13d, %r8d
    add $4, %rax
    jmp find_Min_HW1

find_Max_HW1:
    cmp %r12d, %edx
    jge continue_HW1

    movl (%rax), %r13d
    cmp %r13d, %r9d
    jg setBigger_HW1

    add $4, %rax
    jmp find_Max_HW1

setBigger_HW1:
    cmp %r13d, %r9d
    add $4, %rax
    jmp find_Max_HW1


continue_HW1:
    dec %r8d
    inc %r9d

    movq $source_array, %rax
    xor %r10d, %r10d                         # index

forloop_HW1:
    cmp %r10d, %edx
    jge sucess_HW1

    movl (%rax), %r13d
    cmp %r8d, %r13d
    jge insert_down_HW1

    cmp %r13d, %r9d
    jge insert_up_HW1

    inc %r10d
    cmp %r10d, %edx
    jge continue_loop_HW1

    movl 4(%rax), %r15d
    dec %r10d
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
    inc %r10d
    add $4, %rax
    jmp forloop_HW1

insert_up_HW1:
    cmp %r8d, %r13d
    jge fail_HW1

    movl %r13d, (%rcx)
    add $4, %rcx
    inc %r10d
    add $4, %rax
    jmp forloop_HW1

fail_HW1:
    movb $0, (bool)
    jmp end_HW1


sucess_HW1:
    movb $1, (bool)
    jmp end_HW1


end_HW1:



