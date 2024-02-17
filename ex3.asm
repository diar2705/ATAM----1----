.global _start

.section .text
_start:
#your code here


    xor %r10d, %r10d                   

    movl $source_array, %eax
    movl $up_array, %ebx
    movl $down_array, %ecx

    movl (%eax), %r12d
    movl (%eax), %r13d
    xor %r14d, %r14d
forMAX_HW1:
    cmpl %r14d, size
    jmp forMIN_HW1
    cmpl 0(%eax,%r14d,4), %r12d
    jg bigger_HW1
    inc %r14d
    jmp forMAX_HW1

bigger_HW1:
    movl 0(%eax,%r14d,4), %r12d
    inc %r14d
    jmp forMAX_HW1


    xor %r14d, %r14d
forMIN_HW1:
    cmpl %r14d, size
    jmp begin_HW1
    cmpl 0(%eax,%r14d,4), %r13d
    jl smaller_HW1
    inc %r14d
    jmp forMIN_HW1

smaller_HW1:
    movl 0(%eax,%r14d,4), %r13d
    inc %r14d
    jmp forMIN_HW1

begin_HW1:
    inc %r12d
    dec %r13d

forloop_HW1:
    cmp %r10d, size
    jge sucsess_HW1

    cmp %r9d, 0(%eax)
    jge dec_HW1
    cmp 0(%eax), %r8d
    jge inc_HW1

    inc %r10d
    cmp %r10d, size
    jge continue_HW1
    movl 0(%eax), %r11d
    dec %r10d
    cmp %r11d, 4(%eax)
    jge dec_HW1
    jmp inc_HW1

continue_HW1:
    dec %r10d

inc_HW1:
    cmp %r9d, 0(%eax)
    jmp failure_HW1
    movl 0(%eax), %r9d
    movl %r9d, 0(%ebx)
    add $4, %ebx
    add $4, %eax
    inc %r10d
    jmp forloop_HW1

dec_HW1:
    cmp 0(%eax), %r8d
    jmp failure_HW1
    movl 0(%eax), %r8d
    movl %r8d, 0(%ecx)
    add $4, %ecx
    add $4, %eax
    inc %r10d
    jmp forloop_HW1

sucsess_HW1:
    movb $1, bool
    jmp end

failure_HW1:
    movb $0, bool
    jmp end

end:

    