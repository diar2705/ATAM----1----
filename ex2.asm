    .global_start

    .section.text
_start:
    #your code here
    xor %rsi, %rsi

forloop_HW1:
    cmp %rsi, $9
    jge end_forloop_HW1
    movq vertices(, %rsi, 8), %rax
    movb %rdi $1

whileloop_HW1:
    movq 0(%rax, %rdi, 8), %rbx
    cmp %rbx, $0
    je  end_whileloop_HW1
    cmp %rbx, %rax
    je  set_circle_HW1
    cmp %rdi, $9
    jge set_circle_HW1
    inc %rdi
    jmp whileloop_HW1

end_whileloop_HW1:
    inc %rsi
    jmp forloop_HW1

end_forloop_HW1:
    movb $-1, (circle)
    ret
set_circle_HW1:
    movb $1, (circle)
    ret