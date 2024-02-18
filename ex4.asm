.global _start

.section .text
_start:
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# We are given the following labels: 
#   head: pointer (8 bytes) to the first Node
#   result: 1 byte that holds the result = {0,1,2,3}
#       3 - strictly increasing
#       2 - increasing
#       1 - if we removed exactly one element it will become increasing
#       0 - otherwise
#       Note that in case of an empty list or a list of size 1 we must return 3
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# * %r8b holds the return value to put in result
    movb $0, %r8b          # initial value for result in %r8b (not legal)
    movq (head), %rax       # %rax holds the first pointer (value in head label)
#   check if list is empty 
    cmpq $0, %rax            
    je RETURN_strictly_increasing_HW1   # if %rax == NULL then its strictly increasing  
# * reg %r10 will alwyas hold the value 1
    movq $1, %r10     
#   check if the list has only 1 element
    movq (%rax, %r10, 8), %rbx  # %rbx holds the second pointer
    cmpq $0, %rbx   
    je RETURN_strictly_increasing_HW1  # %rbx == NULL
#   check if the list has only 2 elements
    movq (%rbx, %r10, 8), %rcx  # %rcx holds the third pointer
    cmpq $0, %rcx   
    jne handle_three_elements_first_time_HW1    # %rcx != NULL
    # handle the 2 elements case
    movq (%rax), %rdx   # %rdx temporaraly holds the value for the data in %rax 
    cmpq %rdx, (%rbx)
    je RETURN_increasing_HW1
    jg RETURN_strictly_increasing_HW1
    jmp RETURN_almost_increasing_HW1

handle_three_elements_first_time_HW1:
# here we have at least 3 (non empty) Nodes where:
#   - %rax is the first pointer 
#   - %rbx is the second pointer
#   - %rcx is the third pointer
#   - %r10 holds the value 1 (always)
    movq (%rax), %rdx   # %rdx temporaraly holds the value for the data in %rax 
    cmpq %rdx, (%rbx)
    jg array_is_strictly_increasing_at_the_beginning_HW1      # (%rax) < (%rbx)
    je check_if_array_inc_again_HW1     # (%rax) == (%rbx)
# here (%rax) > (%rbx) (for the first time)
handle_dip_after_first_node_HW1:
    movq %rbx, %rax             # move to the next pointer
    movq (%rax, %r10, 8), %rbx  # move to the next pointer
    cmp $0, %rbx
    je RETURN_almost_increasing_HW1 # %rbx == NULL
    movq (%rax), %rdx   # %rdx temporaraly holds the value for the data in %rax 
    cmpq %rdx, (%rbx)
    jl RETURN_otherwise_HW1     # (%rax) > (%rbx) (for the second time)
    jmp handle_dip_after_first_node_HW1

# check if array is increasing (use when not decreaced once)
check_if_array_inc_again_HW1:
    movq %rbx, %rax             # move to the next pointer
    movq (%rbx, %r10, 8), %rbx  # move to the next pointer
    cmpq $0, %rbx              
    je RETURN_increasing_HW1    # %rbx points to NULL now, we are done
    movq (%rax), %rdx           # RDX hold the data inside RAX
    cmpq %rdx, (%rbx)           # compare the (8-byte) data between the pointers
    jl check_if_almost_increasing_without_changing_pointers_HW1    # probably almost inceasing if (%rax) > (%rbx)
    jmp check_if_array_inc_again_HW1

# check if strictly increasing 
array_is_strictly_increasing_at_the_beginning_HW1:
#   here we have the case (%rax) < (%rbx) and (%rcx) not empty
    movq (%rbx), %rdx
    cmpq %rdx, (%rcx)     # compare the (8-byte) data between the pointers
    jg check_if_array_is_strictly_increasing_again_HW1
    jl array_starts_with_up_then_down_HW1       # (%rbx) > (%rcx)
    # here they are equal
    movq %rbx,%rax      # update registers to use the label correctly
    movq %rcx,%rbx      # update registers to use the label correctly
    jmp check_if_array_inc_again_HW1

# use only in array_is_strictly_increasing_at_the_beginning_HW1
check_if_array_is_strictly_increasing_again_HW1:
    # here we have (%rax) < (%rbx) < (%rcx) 
    movq %rbx, %rax             # move pointers to the next
    movq %rcx, %rbx             # move pointers to the next
    movq (%rcx, %r10, 8), %rcx  # move pointers to the next
    cmp $0, %rcx
    je RETURN_strictly_increasing_HW1
    movq (%rbx), %rdx   # %rdx temporaraly holds the value for the data in %rbx 
    cmpq %rdx, (%rcx)
    jg check_if_array_is_strictly_increasing_again_HW1
    jl check_if_almost_increasing_HW1
    # here the new (%rbx) and new (%rcx) are equal
    movq %rbx,%rax      # update registers to use the label correctly
    movq %rcx,%rbx      # update registers to use the label correctly
    jmp check_if_array_inc_again_HW1

array_starts_with_up_then_down_HW1:
    # here we have: first == (%rax) < (%rbx) > (%rcx) 
    # this is our first dip
    # in this label we must check if the array without the second element is increasing
    movq (%rax), %rdx   # %rdx temporaraly holds the value for the data in %rax 
    cmpq %rdx, (%rcx)
    jl array_starts_with_up_then_down_remove_third_HW1     # we dip too much we need to remove the third element
    # here (%rax) <= (%rcx) 
    movq %rcx,%rax              # update registers to use the next label correctly
    movq (%rax, %r10, 8),%rbx   # update registers to use the next label correctly
array_starts_with_up_then_down_second_removed_HW1:
    cmp $0, %rbx
    je RETURN_almost_increasing_HW1     # we are done and it can be fixed by removing the second element
    movq (%rax), %rdx   # %rdx temporaraly holds the value for the data in %rax 
    cmpq %rdx, (%rbx)
    jl RETURN_otherwise_HW1
    movq %rbx, %rax             # move pointers to the next
    movq (%rax, %r10, 8), %rbx             # move pointers to the next
    jmp array_starts_with_up_then_down_second_removed_HW1

array_starts_with_up_then_down_remove_third_HW1:
    # here we have: first == (%rax) < (%rbx) and (%rax) > (%rcx)
    movq (%rcx, %r10, 8),%rcx   # move pointer to the next
    cmp $0, %rcx
    jmp RETURN_almost_increasing_HW1        # %rcx = NULL
    movq (%rbx), %rdx   # %rdx temporaraly holds the value for the data in %rbx 
    cmpq %rdx, (%rcx)
    jl RETURN_otherwise_HW1     # the element after the dip is low
    movq %rcx,%rax              # update registers to use the next label correctly
    movq (%rcx, %r10, 8),%rbx   # update registers to use the next label correctly
array_starts_with_up_then_down_remove_third_check_if_inc_HW1:
    cmp $0, %rbx
    je RETURN_almost_increasing_HW1
    movq (%rax), %rdx   # %rdx temporaraly holds the value for the data in %rax 
    cmpq %rdx, (%rbx)
    jl RETURN_otherwise_HW1
    movq %rbx, %rax             # move pointers to the next
    movq (%rax, %r10, 8), %rbx  # move pointers to the next
    jmp array_starts_with_up_then_down_remove_third_check_if_inc_HW1

# check if almost increasing
check_if_almost_increasing_HW1:
#   here we have (%rax) <= (%rbx) > (%rcx) (three elements is guarnteed)
    movq %rbx, %rax             # move pointers to the next
    movq %rcx, %rbx             # move pointers to the next
check_if_almost_increasing_without_changing_pointers_HW1:
    movq (%rbx, %r10, 8), %rcx  # move pointers to the next
    cmpq $0, %rcx               # check the next pointer
    je RETURN_almost_increasing_HW1     # if next pointer is NULL we are done
# here we have more elements to check
# one time check to check if the one Node after the dip Node is also "high" 
    movq (%rax), %rdx
    cmpq %rdx, (%rcx)         # ompare *(pointer %rax) and *(pointer %rcx)
    jl RETURN_otherwise_HW1     # if we dip again then its otherwise 

# if we get here then we have almost increasing for now and we have:
# - RBX pointing to the "dip" Node 
# - RCX to the next Node (not empty)
# - RAX to the node precceding the "dip"

    # update the Nodes, RCX to the RAX and the next of it to RBX (later before first)
    movq %rcx, %rax             # we dont need %rcx anymore
    movq (%rax, %r10, 8), %rbx  # move RBX to the next of RAX
# check if we point to NULL
    cmpq $0, %rbx    
    je RETURN_almost_increasing_HW1 # if %rbx points to NULL, we are done

# otherwise we now need to check for an increasing list untill the end (after the dip Node)

almost_increasing_check_inc_again_HW1:
# ! %rbx here points to a non-empty Node
    movq (%rax), %rdx
    cmpq %rdx,(%rbx)
    jl RETURN_otherwise_HW1     # if we dip again its otherwise
    movq %rbx, %rax             # move RAX to point to the next Node (RBX)
    movq (%rax, %r10, 8), %rbx  # move RBX to point to the next Node
    cmpq $0, %rbx    
    je RETURN_almost_increasing_HW1 # if %rbx points to NULL, we are done
# otherwise loop again to check it its still increasing
    jmp almost_increasing_check_inc_again_HW1

RETURN_strictly_increasing_HW1:
    movb $3, %r8b               # 3 for strictly increasing
    jmp RETURN_value_HW1        

RETURN_increasing_HW1:
    movb $2, %r8b               # 2 for increasing
    jmp RETURN_value_HW1        

RETURN_almost_increasing_HW1:
    movb $1, %r8b               # 1 for almost increasing
    jmp RETURN_value_HW1        
    
RETURN_otherwise_HW1:
    movb $0, %r8b               # 0 for otherwise
    jmp RETURN_value_HW1        # no need to but imma keep it for symetry :)

RETURN_value_HW1:
    movb %r8b, (result)
