.global _start

# in this question we get 3 labels:
#   command - null terminated string
#   legal - 1-byte for a result, {0,1}
#   integer - 4-bytes for a result, in case legal is 1,     
#       we put the result of the integer here
# 
#   Hexadecimal numbers will be followed by only Capital letters to make it easy
#   there can be many spaces between the command name and the first operand and 
#   if the first operand is a conasatnt operand then , theres alwauys a , after the opesand 
#   and theres atleast 2 operands
# 





# %rax holds the integer

.section .text
_start:
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# * %rax will hold the integer value if it exists
    movq $0, %rax
    movq $command, %rdi         # base pointer to command string
    cmpb $0, (%rdi)                
    je RETURN_not_legal_HW1     # base pointer == NULL

#   determine if command name started
find_command_operand_HW1:
    cmpb $36, (%rdi)
    je parse_operand_HW1
    inc %rdi
    cmpb $0, (%rdi)
    je RETURN_not_legal_HW1
    jmp find_command_operand_HW1

parse_operand_HW1:
#   here the register %rdi points to the first letter of the operand
#   check if the operand is a const op
    inc %rdi
    cmpb $0, (%rdi)                # %rdi == NULL
    je RETURN_not_legal_HW1     # no other characters after $
#   check the type of number base
    cmpb $'0', (%rdi)              
    je number_base_starts_with_zero_HW1 # $0
    cmpb $'1', (%rdi)              
    jl RETURN_not_legal_HW1             # $( < 1)
    cmpb $'9', (%rdi)              
    jg RETURN_not_legal_HW1             # $( > 9)
    # $(1...9)
    jmp number_base_ten_HW1

number_base_starts_with_zero_HW1:
    # here the register %rdi points to the 0 in the base
    inc %rdi
    cmpb $0, (%rdi)
    je RETURN_not_legal_HW1
#    jne determine_number_base_HW1   # %rdi != NULL
#    # %rdi == NULL --> return 0 in base 10
#    # check if we have , after
#    inc %rdi
#    cmpb $0, (%rdi)
#    je RETURN_not_legal_HW1
#    cmpb $',', (%rdi)
#    jne RETURN_not_legal_HW1
#    movq $0, %rax           # name $0
#    jmp RETURN_legal_HW1

    cmpb $',', (%rdi)
    jne determine_number_base_HW1
    movq $0, %rax           # name $0,
    jmp RETURN_legal_HW1
determine_number_base_HW1:    
    cmpb $'0', (%rdi)
    je handle_two_zeros_HW1   # $00
    cmpb $98, (%rdi)
    je binary_number_HW1
    cmpb $'x', (%rdi)
    je hexadecimal_number_HW1
    cmpb $'1', (%rdi)
    jl RETURN_not_legal_HW1
    cmpb $'7', (%rdi)
    jg RETURN_not_legal_HW1
    jmp octal_number_HW1

handle_two_zeros_HW1:
    # %rdi points to the second 0 in $00
    inc %rdi
    cmpb $0, (%rdi)
    je RETURN_not_legal_HW1 # %rdi == NULL, no , after number
    cmpb $',', (%rdi)
    jne handle_two_zeros_followed_by_something_HW1
    movq $0, %rax           # name $00,
    jmp RETURN_legal_HW1
    # we have an octal number here for sure

handle_two_zeros_followed_by_something_HW1:
    # the somethign is NOT `,` has to be valid octal
    cmpb $'0', (%rdi)
    je handle_three_zeros_HW1   # $000
    cmpb $'1', (%rdi)
    jl RETURN_not_legal_HW1     # $00( < 1)
    cmpb $'7', (%rdi)
    jg RETURN_not_legal_HW1     # $00( > 7)
    # here $00(1...7)
    inc %rdi
    cmpb $0, (%rdi)      # 
    je RETURN_not_legal_HW1
    cmpb $',', (%rdi)
    jne handle_two_digit_octal_number_HW1
    # name $00(1...7),
    dec %rdi
    movzbq (%rdi), %rax       # Load the current character into %rax
    sub $'0', %rax           
    jmp RETURN_legal_HW1

handle_two_digit_octal_number_HW1:
    # %rdi points to the second of the two octals
    # second of the two is NOT `,`
    cmpb $'1', (%rdi)
    jl RETURN_not_legal_HW1     # $00( < 1)
    cmpb $'7', (%rdi)
    jg RETURN_not_legal_HW1     # $00( > 7)
    # here we have $00(1...7)(1...7)
    inc %rdi
    cmpb $0, (%rdi)
    je RETURN_not_legal_HW1
    cmpb $',', (%rdi)
    jne RETURN_not_legal_HW1
    dec %rdi
    movzbq (%rdi), %rax       # Load the current character into %rax
    sub $'0', %rax 
    dec %rdi
    movzbq (%rdi), %r12       # Load the current character into %r12
    sub $'0', %r12 
    shl $3, %r12
    add %r12, %rax
    jmp RETURN_legal_HW1

handle_three_zeros_HW1:
    inc %rdi
    cmpb $0, (%rdi)
    je RETURN_not_legal_HW1 # no , after the $000
    cmpb $',', (%rdi)
    jne handle_three_zeros_followed_by_something_HW1
    movq $0, %rax
    jmp RETURN_legal_HW1

handle_three_zeros_followed_by_something_HW1:
    # the somethign is NOT `,` has to be valid octal
    cmpb $'1', (%rdi)
    jl RETURN_not_legal_HW1     # $000( < 1)
    cmpb $'7', (%rdi)
    jg RETURN_not_legal_HW1     # $000( > 7)
    # here the number is $000(1...7)
    inc %rdi
    cmpb $0, (%rdi)
    je RETURN_not_legal_HW1 # no , after the $000(1...7)
    cmpb $',', (%rdi)
    jne RETURN_not_legal_HW1
    dec %rdi
    movzbq (%rdi), %rax       # Load the current character into %rax
    sub $'0', %rax           
    jmp RETURN_legal_HW1

# ########################################################################
binary_number_HW1:
# %rdi points to the 'b' in a string like "$0b..."
    xor %rcx, %rcx        # Counter for number of digits processed
    xor %rax, %rax        # Clear %rax for final binary number

check_next_digit_HW1:
    inc %rdi              # Move to the next character
    cmpb $0, (%rdi)
    je RETURN_not_legal_HW1

    cmpb $',', (%rdi)     # Check if current character is ','
    je found_comma_binary_HW1   # If found, end of binary number
    cmpq $3, %rcx          # Check if more than 3 digits have been processed
    jge RETURN_not_legal_HW1  # If more than 3, not legal

    movzbq (%rdi), %rdx   # Load the character into %rdx
    sub $'0', %rdx        # Convert ASCII to integer (0 or 1)
    cmpq $1, %rdx          # Check if %rdx is greater than 1
    jg RETURN_not_legal_HW1  # If greater, not a binary digit
    cmpq $0, %rdx          # Check if %rdx is greater than 1
    jl RETURN_not_legal_HW1  # If smaller, not a binary digit


    shl $1, %rax          # Shift left to make space for the new bit
    or %rdx, %rax         # Insert the new bit
    inc %rcx              # Increment digit counter
    jmp check_next_digit_HW1 

found_comma_binary_HW1:
    cmpq $0, %rcx          # Check if no digits were processed
    je RETURN_not_legal_HW1  # If no digits, not legal
    jmp RETURN_legal_HW1  # Conditions met, binary number is legal
# ########################################################################

octal_number_HW1:
#   here we know that we have $0(1...8)
#   %rdi points to the last digit
    xor %rax, %rax            # Clear %rax for final octal number
    xor %rcx, %rcx            # Counter for number of digits processed

process_octal_digit_HW1:
    cmpq $3, %rcx              # Check if more than 3 digits have been processed
    jge RETURN_not_legal_HW1  

    movzbq (%rdi), %rdx       # Load the current character into %rdx
    cmp $'0', %rdx            # Check if %rdx is below '0'
    jl RETURN_not_legal_HW1   # If less, not an octal digit
    cmp $'7', %rdx            # Check if %rdx is above '7'
    jg RETURN_not_legal_HW1   # If greater, not an octal digit

    sub $'0', %rdx            # Convert ASCII to integer (0 to 7)
    shl $3, %rax              # Multiply by 8
    add %rdx, %rax            # Add the new digit to %rax
    inc %rcx                  # Increment digit counter
    inc %rdi                  # Move to the next character
    cmpb $0, (%rdi)              # %rdi points to NULL
    je RETURN_not_legal_HW1

    cmpb $',', (%rdi)         # Check if the current character is a comma
    je RETURN_legal_HW1       # If it's a comma, the octal number is legal
    jmp process_octal_digit_HW1  # If not followed by a comma after 3 digits, not legal

number_base_ten_HW1:
#   the number is NOT 0 here, this is taken care of in number_base_starts_with_zero_HW1
#   %rdi points to the number in $1...9
    xor %rax, %rax            # Clear %rax for final base 10 number
    xor %rcx, %rcx            # Counter for number of digits processed

process_base_ten_digit_HW1:
    cmp $3, %rcx              # Check if more than 3 digits have been processed
    jge RETURN_not_legal_HW1  # If more than 3, not legal

    movzbq (%rdi), %rdx       # Load the current character into %rdx
    cmpq $'0', %rdx            # Check if %rdx is below '0'
    jl RETURN_not_legal_HW1   # If less, not an base ten digit
    cmpq $'9', %rdx            # Check if %rdx is above '9'
    jg RETURN_not_legal_HW1   # If greater, not an base ten digit

    sub $'0', %rdx            # Convert ASCII to integer (0 to 9)
    imul $10, %rax            # Multiply current value of %rax by 10
    add %rdx, %rax            # Add the new digit to %rax
    inc %rcx                  # Increment digit counter
    inc %rdi                  # Move to the next character
    cmpb $0, (%rdi)              # %rdi points to NULL
    je RETURN_not_legal_HW1

    cmpb $',', (%rdi)         # Check if the current character is a comma
    je RETURN_legal_HW1       # If it's a comma, the number is legal
    cmpq $3, %rcx              # Check if 3 digits have been processed
    jl process_base_ten_digit_HW1 # If less than 3, continue processing
    jmp RETURN_not_legal_HW1  # If not followed by a comma after 3 digits, not legal

hexadecimal_number_HW1:
#   %rdi points to x in $0x
    xor %rax, %rax            # Clear %rax for final hexadecimal number
    xor %rcx, %rcx            # Counter for number of digits processed
    inc %rdi              # %rdi points to the first digit after "x"

process_hex_digit_HW1:
    cmpq $3, %rcx              # Check if more than 3 digits have been processed
    jge RETURN_not_legal_HW1  # If more than 3, not legal

    # Directly compare the character at %rdi
    cmpb $'0', (%rdi)         # Check if below '0'
    jl RETURN_not_legal_HW1   # If less, not a hexadecimal digit
    cmpb $'F', (%rdi)         # Check if above 'F'
    jg RETURN_not_legal_HW1   # If greater, not a hexadecimal digit

    cmpb $'9', (%rdi)         # Check if above '9'
    jle digit_is_valid_hexadecimal_HW1        # If less or equal, it's a valid digit (0-9)
    cmpb $'A', (%rdi)         # Check if below 'A'
    jl RETURN_not_legal_HW1   # If less, it's in the gap between '9' and 'A', not a valid digit

digit_is_valid_hexadecimal_HW1:
    movzbq (%rdi), %rdx       # Load the current character into %rdx for conversion
    sub $'0', %rdx            # Convert ASCII '0'-'9' to 0-9
    cmpq $9, %rdx              # Check if original character was between 'A'-'F'
    jle skip_adjustment_HW1       # If not, skip adjustment for 'A'-'F'
    add $'0', %rdx  
    sub $'A', %rdx
    add $10, %rdx              # Adjust for 'A'-'F', converting ASCII 'A'-'F' to 10-15

skip_adjustment_HW1:
    shl $4, %rax              # Shift existing number left by 4 bits (multiply by 16)
    or %rdx, %rax             # Combine new digit into %rax
    inc %rcx                  # Increment digit counter
    inc %rdi                  # Move to the next character

    # Directly compare the next character using %rdi
    cmpb $',', (%rdi)         # Check if the current character is a comma
    je RETURN_legal_HW1       # If it's a comma, the hexadecimal number is legal
    cmpq $3, %rcx              # Check if 3 digits have been processed
    jl process_hex_digit_HW1  # If less than 3, continue processing
    jmp RETURN_not_legal_HW1  # If not followed by a comma after 3 digits, not legal


RETURN_legal_HW1:
    movl %eax, (integer)
    movb $1, (legal)
    jmp RETURN_result_HW1

RETURN_not_legal_HW1:
    movb $0, (legal)
    jmp RETURN_result_HW1

RETURN_result_HW1:
