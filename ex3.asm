.global _start

.section .text
_start:
#your code here

    movq $source_array, %rax
    movq $source_array, %r14
    movq $source_array, %rsi
    movq $down_array, %rbx
    movq $up_array, %rcx
    movl size, %edx

    movl (%rax), %r8d                       # min value
    xor %r11d, %r11d

    movl (%rax), %r9d                       # max value
    xor %r12d, %r12d

    movb $0, (bool)

find_Min_HW1:
    cmpl %edx, %r11d
    jge find_Max_HW1

    movl (%rax), %r13d
    cmpl %r8d, %r13d
    jl setLess_HW1

    add $4, %rax
    inc %r11d
    jmp find_Min_HW1

setLess_HW1:
    movl %r13d, %r8d
    add $4, %rax
    inc %r11d
    jmp find_Min_HW1

find_Max_HW1:
    cmpl %edx, %r12d
    jge continue_HW1

    movl (%rsi), %r13d
    cmpl %r9d, %r13d
    jg setBigger_HW1

    add $4, %rsi
    inc %r12d
    jmp find_Max_HW1

setBigger_HW1:
    cmpl %r9d, %r13d
    add $4, %rsi
    inc %r12d
    jmp find_Max_HW1


continue_HW1:
    dec %r8d
    inc %r9d
    xor %r10d, %r10d                         # index

forloop_HW1:
    cmpl %edx, %r10d
    jge sucess_HW1

    movl (%r14), %r13d
    cmpl %r13d, %r8d
    jge insert_down_HW1

    cmpl %r13d, %r9d
    jle insert_up_HW1

    inc %r10d
    cmpl %edx, %r10d
    jge continue_loop_HW1

    movl 4(%r14), %r15d
    dec %r10d
    cmpl %r15d, %r13d
    jge insert_down_HW1
    jmp insert_up_HW1


continue_loop_HW1:
    movl %r13d, (%rcx)
    add $4, %rcx
    jmp forloop_HW1

insert_down_HW1:
    cmpl %r13d, %r9d 
    jle end_HW1

    movl %r13d, (%rbx)
    movl %r13d, %r9d
    add $4, %rbx
    inc %r10d
    add $4, %r14
    jmp forloop_HW1

insert_up_HW1:
    cmpl %r13d, %r8d
    jge end_HW1

    movl %r13d, (%rcx)
    movl %r13d, %r8d
    add $4, %rcx
    inc %r10d
    add $4, %r14
    jmp forloop_HW1


sucess_HW1:
    movb $1, (bool)
    jmp end_HW1


end_HW1:



