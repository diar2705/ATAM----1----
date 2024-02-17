.global _start

.section .text
_start:

    movq $vertices, %rax
    movb $-1, (circle)

All_Vertices_HW1:
    movq (%rax), %rbx

    cmpq $0, %rbx
    je end_HW1

    jmp Depth_0_Son_HW1 


Depth_0_Son_HW1:
    movq (%rbx), %r8

    cmpq $0, %r8
    je Next_Neighbor_0_HW1

    cmp (%rax), %r8
    je set_circle_HW1

    jmp Depth_1_Son_HW1

Next_Neighbor_0_HW1:
    addq $8, %rax
    jmp All_Vertices_HW1


Depth_1_Son_HW1:
    movq (%r8), %r9

    cmpq $0, %r9
    je Next_Neighbor_1_HW1

    cmpq (%rax), %r9
    je set_circle_HW1

    jmp Depth_2_Son_HW1

Next_Neighbor_1_HW1:
    addq $8, %rbx
    jmp Depth_0_Son_HW1


Depth_2_Son_HW1:
    movq (%r9), %r10

    cmpq $0, %r10
    je Next_Neighbor_2_HW1

    cmpq (%rax), %r10
    je set_circle_HW1

    jmp Depth_3_Son_HW1

Next_Neighbor_2_HW1:
    addq $8, %r8
    jmp Depth_1_Son_HW1


Depth_3_Son_HW1:
    movq (%r10), %r11

    cmpq $0, %r11
    je Next_Neighbor_3_HW1

    cmpq (%rax), %r11
    je set_circle_HW1

    jmp Depth_4_Son_HW1

Next_Neighbor_3_HW1:
    addq $8, %r9
    jmp Depth_2_Son_HW1


Depth_4_Son_HW1:
    movq (%r11), %r12

    cmpq $0, %r12
    je Next_Neighbor_4_HW1

    cmpq (%rax), %r12
    je set_circle_HW1

    jmp Depth_5_Son_HW1

Next_Neighbor_4_HW1:
    addq $8, %r10
    jmp Depth_3_Son_HW1


Depth_5_Son_HW1:
    movq (%r12), %r13

    cmpq $0, %r13
    je Next_Neighbor_5_HW1

    cmpq (%rax), %r13
    je set_circle_HW1

    jmp Depth_6_Son_HW1

Next_Neighbor_5_HW1:
    addq $8, %r11
    jmp Depth_4_Son_HW1

Depth_6_Son_HW1:
    movq (%r13), %r14

    cmpq $0, %r14
    je Next_Neighbor_6_HW1

    cmpq (%rax), %r14
    je set_circle_HW1

    jmp Depth_7_Son_HW1

Next_Neighbor_6_HW1:
    addq $8, %r12
    jmp Depth_5_Son_HW1

Depth_7_Son_HW1:
    movq (%r14), %r15
    
    cmpq $0, %r15
    je Next_Neighbor_7_HW1

    cmpq (%rax), %r15
    je set_circle_HW1

    jmp set_circle_HW1

Next_Neighbor_7_HW1:
    addq $8, %r13
    jmp Depth_6_Son_HW1

set_circle_HW1:
    movb $1, (circle)
    jmp end_HW1

end_HW1:

