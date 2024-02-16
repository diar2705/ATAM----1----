.global _start

.section .text
_start:
#your code here
    or %ecx, 0x7fffffff
    or %edx, 0x80000000

    xor %esl, %esl

    xor %r8d, %r8d
    xor %r9d, %r9d

forloop_HW1:
    cmp %esl, (size)
    jge sucsess_HW1

    movq source_array(, %esl, 8), %eax

    inc %esl
    cmp %esl, (size)
    jge inc_HW1
    movq source_array(, %esl, 8), %ebx

    cmp %edx, %eax
    jge dec_HW1

    cmp %eax, %ecx
    jge inc_HW1

    cmp %eax, %ebx
    jge dec_HW1
    jmp inc_HW1

inc_HW1:
    cmp %edx, %eax
    jge failure_HW1

    movq %edx, %eax
    movq %eax, up_array(, %r8d, 8)
    inc %r8d
    jmp forloop_HW1

dec_HW1:
    cmp %eax, %ecx
    jge failure_HW1

    movq %ecx, %eax
    movq %eax, down_array(, %r9d, 8)
    inc %r9d
    jmp forloop_HW1

sucsess_HW1:
    movb $1, bool
    ret

failure_HW1:
    movb $0, bool
    ret

