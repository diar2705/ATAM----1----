    .global_start

    .section.text
_start:
    #your code here
    xor %edx, %edx

forloop_HW1:
    cmp %edx, $9
    jge end_forloop_HW1
    movq vertices(, %edx, 8), %rax
    movl %ecx $1

whileloop_HW1:
    movq 0(%rax, %ecx, 8), %rbx
    cmp %rbx, $0
    je  end_whileloop_HW1
    cmp %rbx, %rax
    je  set_circle_HW1
    cmp %ecx, $9
    jge set_circle_HW1
    inc %ecx
    jmp whileloop_HW1

end_whileloop_HW1:
    inc %edx
    jmp forloop_HW1

end_forloop_HW1:
    movb $-1, (circle)
    ret
set_circle_HW1:
    movb $1, (circle)
    ret