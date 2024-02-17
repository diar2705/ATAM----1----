.global _start

.section .text
_start:
#your code here

    xor %r10d, %r10d                        % index

    movl $source_array, %rax
    movl $up_array, %rbx
    movl $down_array, %rcx

    movl (%rax), %r8d                       % min value
    xor %r11d, %r11d                        % index

    movl (%rax), %r9d                       % max value
    xor %r12d, %r12d                        % index

find_Min_HW1:
    cmp %r11d, size
    jge find_Max_HW1

    cmp (%rax, %r11d, 4), %r8d
    jl setLess_HW1

    add $4, %rax
    jmp find_Min_HW1

setLess_HW1:
    movl (%rax), %r8d
    add $4, %rax
    jmp find_Min_HW1

find_Max_HW1:
    cmp %r11d, size
    jge continue_HW1

    cmp (%rax), %r9d
    jg setBigger_HW1

    add $4, %rax
    jmp find_Max_HW1

setBigger_HW1:
    movl (%rax), %r9d
    add $4, %rax
    jmp find_Max_HW1


continue_HW1:
    dec %r8d
    inc %r9d


forloop_HW1:
    
