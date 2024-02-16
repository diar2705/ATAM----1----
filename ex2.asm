    .global_start

    .section.text
_start:

    movq vertices, %rax
    movb $-1, circle

All_Vertices_HW1:
    cmp $0, %rax
    je end_HW1
    movq (%rax), %rbx
    cmp $0, %rbx
    je end_HW1

Next_Vertex:
    add $4, %rax
    jmp All_Vertices_HW1

Depth_0_Son_HW1:
    movq (%rbx), %r8x

    cmp $0, %r8x
    jmp Next_Vertex

    cmp %r8x, %rax
    je set_circle_HW1

    jmp Depth_1_Son_HW1

Depth_1_Son_HW1:
    movq (%r8x), %r9x

    cmp $0, %r9x
    jmp Next_Vertex

    cmp %r9x, %rax
    je set_circle_HW1

    jmp Depth_2_Son_HW1

Depth_2_Son_HW1:
    movq (%r9x), %r10x

    cmp $0, %r10x
    jmp Next_Vertex

    cmp %r10x, %rax
    je set_circle_HW1

    jmp Depth_3_Son_HW1

Depth_3_Son_HW1:
    movq (%r10x), %r11x

    cmp $0, %r11x
    jmp Next_Vertex

    cmp %r11x, %rax
    je set_circle_HW1

    jmp Depth_4_Son_HW1

Depth_4_Son_HW1:
    movq (%r11x), %r12x

    cmp $0, %r12x
    jmp Next_Vertex

    cmp %r12x, %rax
    je set_circle_HW1

    jmp Depth_5_Son_HW1

Depth_5_Son_HW1:
    movq (%r12x), %r13x

    cmp $0, %r13x
    jmp Next_Vertex

    cmp %r13x, %rax
    je set_circle_HW1

    jmp Depth_6_Son_HW1

Depth_6_Son_HW1:
    movq (%r13x), %r14x

    cmp $0, %r14x
    jmp Next_Vertex

    cmp %r14x, %rax
    je set_circle_HW1

    jmp Depth_7_Son_HW1
    
Depth_7_Son_HW1:
    movq (%r14x), %r15x

    cmp $0, %r15x
    jmp Next_Vertex

    cmp %r8x, %rax
    je set_circle_HW1

    jmp set_circle_HW1
    

set_circle_HW1:
    movb $1, circle
    ret

end_HW1:
    ret
