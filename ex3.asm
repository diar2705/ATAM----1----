.global _start

.section .text
_start:
#your code here
    orl $0x7fffffff, %r8d
    orl $0x80000000, %r9d

    xor %r10d, %r10d                    ; counter for he loop (index for source_array)

    movl source_array, %eax
    movl up_array, %ebx
    movl down_array, %ecx

forloop_HW1:
    cmp %r10d, size
    jge sucsess_HW1

    cmp %r9d, 0(%eax)
    jge inc_HW1
    cmp 0(%eax), %r8d
    jge dec_HW1

    inc %r10d
    cmp %r10d, size
    jge continue_HW1
    cmp 0(%eax), 4(%eax)
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
    ret

failure_HW1:
    movb $0, bool
    ret