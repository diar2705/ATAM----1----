.global _start

# 64 bits registers
# %rsi = up_array
# %rdi = down_array
# %r14 = source_array
# %r12 = source_array helper

# 32 bits registers
# %r8d = size
# %ebx = counter
# %ecx = max
# %edx = min

.section .text
_start:

#your code here

# initializing
movq $source_array, %r12
movq $down_array, %rdi
movq $up_array, %rsi
movl (size), %r8d

movl %r8d, %r15d 
subl $1, %r15d # last element in source array

movb $1, (bool) # assumnig there is solution

cmpl $0, %r8d # if source array size is 0 -> end
je no_sol_HW1

movl $0, %ebx # initializing counter
movl (%r12), %ecx # initializing max
movl (%r12), %edx # initializing min


limits_loop_HW1: # stores the min in %edx and max in $ecx
    cmpl %ecx, (%r12) # if (max >= cur)
    jge check_min_HW1
    movl (%r12), %ecx # update max

check_min_HW1:    
    cmpl %edx, (%r12) # if(min <= cur)
    jle update_data_HW1
    movl (%r12), %edx # update min

update_data_HW1:
    addl $1, %ebx               # increasing counter
    cmpl %ebx, %r8d             # if(counter >= size)
    jge out_of_range_HW1
    
    addq $4, %r12 # increasing pointer
    jmp limits_loop_HW1
 
out_of_range_HW1:
    # reset data
    movq $source_array, %r14 
    movl $0, %ebx            # initializing counter
    addl $1, %ecx            # fixing max
    subl $1, %edx            # fixing min


split_HW1:
    cmpl %edx, (%r14)           # if(min >= cur)     
    jge not_both_HW1
    cmpl %ecx, (%r14)           # if(max <= cur)
    jle not_both_HW1

    # cur can be added to both arrays
    cmpl %ebx, %r15d
    je append_up_HW1 # we can add it to down array too

    movl 4(%r14), %r10d
    cmpl (%r14), %r10d # if(arr[cur] >= arr[cu + 1])
    jge append_down_HW1

append_up_HW1:
    movl (%r14), %edx
    movl %edx, (%rsi)
    
    addl $1, %ebx # increasing counter
    cmpl %ebx, %r8d # if(counter >= size)
    jge end_HW1
    
    addq $4, %r14 # increasing pointer
    jmp split_HW1
 

not_both_HW1:
    cmpl %edx, (%r14) # if(min < cur)
    jl append_up_HW1
    cmpl %ecx, (%r14) # if(max > cur) -> else -> append_down_HW1
    jle no_sol_HW1

append_down_HW1:
    movl (%r14), %ecx
    movl %ecx, (%rdi)
    
    addl $1, %ebx # increasing counter
    cmpl %ebx, %r8d # if(counter >= size)
    jge end_HW1
    
    addq $4, %r14 # increasing pointer
    jmp split_HW1

no_sol_HW1:
    movb $0, (bool)

end_HW1:

