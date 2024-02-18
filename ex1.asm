.global _start

# we get a `character` label that has ASCII character in a 1 byte size

.section .text
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
_start:

    movb (character), %sil      # move the character to a register

    cmp $0x31, %sil            # 0x31 : 1
    je exclamation_HW1          
    cmp $0x21, %sil            # 0x21 : !
    je exclamation_HW1          

    cmp $0x32, %sil            # 0x32 : 2
    je at_sign_HW1              
    cmp $0x40, %sil            # 0x40 : @
    je at_sign_HW1              

    cmp $0x33, %sil             # 0x33 : 3
    je hash_HW1
    cmp $0x23, %sil             # 0x23 : #
    je hash_HW1

    cmp $0x34, %sil             # 0x34 : 4
    je dollar_HW1
    cmp $0x24, %sil             # 0x24 : $
    je dollar_HW1

    cmp $0x35, %sil             # 0x35 : 5
    je percent_HW1
    cmp $0x25, %sil             # 0x25 : %
    je percent_HW1

    cmp $0x36, %sil             # 0x36 : 6
    je caret_HW1
    cmp $0x5E, %sil             # 0x5E : ^
    je caret_HW1

    cmp $0x37, %sil             # 0x37 : 7
    je ampersand_HW1
    cmp $0x26, %sil             # 0x26 : &
    je ampersand_HW1

    cmp $0x38, %sil             # 0x38 : 8
    je asterisk_HW1
    cmp $0x2A, %sil             # 0x2A : *
    je asterisk_HW1

    cmp $0x39, %sil             # 0x39 : 9
    je left_parenthesis_HW1
    cmp $0x28, %sil             # 0x28 : (
    je left_parenthesis_HW1

    cmp $0x30, %sil             # 0x30 : 0
    je right_parenthesis_HW1
    cmp $0x29, %sil             # 0x29 : )
    je right_parenthesis_HW1

    cmp $0x60, %sil             # 0x60 : `
    je tilde_HW1
    cmp $0x7E, %sil             # 0x7E : ~
    je tilde_HW1

    cmp $0x2D, %sil             # 0x2D : -
    je underscore_HW1
    cmp $0x5F, %sil             # 0x5F : _
    je underscore_HW1

    cmp $0x3D, %sil             # 0x3D : =
    je plus_HW1
    cmp $0x2B, %sil             # 0x2B : +
    je plus_HW1

    cmp $0x5B, %sil             # 0x5B : [
    je left_brace_HW1
    cmp $0x7B, %sil             # 0x7B : {
    je left_brace_HW1

    cmp $0x5D, %sil             # 0x5D : ]
    je right_brace_HW1
    cmp $0x7D, %sil             # 0x7D : }
    je right_brace_HW1

    cmp $0x3B, %sil             # 0x3B : ;
    je colon_HW1
    cmp $0x3A, %sil             # 0x3A : :
    je colon_HW1

    cmp $0x27, %sil             # 0x27 : '
    je quote_HW1
    cmp $0x22, %sil             # 0x22 : "
    je quote_HW1

    cmp $0x5C, %sil             # 0x5C : \
    je pipe_HW1
    cmp $0x7C, %sil             # 0x7C : |
    je pipe_HW1

    cmp $0x2C, %sil             # 0x2C : ,
    je less_than_HW1
    cmp $0x3C, %sil             # 0x3C : <
    je less_than_HW1

    cmp $0x2E, %sil             # 0x2E : .
    je greater_than_HW1
    cmp $0x3E, %sil             # 0x3E : >
    je greater_than_HW1

    cmp $0x2F, %sil             # 0x2F : /
    je question_HW1
    cmp $0x3F, %sil             # 0x3F : ?
    je question_HW1
# Check a-z or A-Z or others
# Note we already checked [ \ ] ^ _ ` 
# they the only characters between Capitals and Lowers
    cmp $0x41, %sil             # $0x41 : A
    jl others_HW1               # jump to others if its less than A
    cmp $0x7A, %sil             # $0x7A : z
    jg others_HW1               # jump to others if its greater than z
    cmp $0x61, %sil             # $0x61 : a
    jge capitalize_HW1          # if a-z then capitlize them
# If we reached here then its an "other" character
    jmp capital_letters_HW1
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# -*- Returns -*- 
# Return !
exclamation_HW1:
    movb $0x21, %sil
    jmp return_value_HW1
# Return @
at_sign_HW1:
    movb $0x40, %sil
    jmp return_value_HW1
# Return #
hash_HW1:
    movb $0x23, %sil
    jmp return_value_HW1
# Return $
dollar_HW1:
    movb $0x24, %sil
    jmp return_value_HW1
# Return %
percent_HW1:
    movb $0x25, %sil
    jmp return_value_HW1
# Return ^
caret_HW1:
    movb $0x5E, %sil
    jmp return_value_HW1
# Return &
ampersand_HW1:
    movb $0x26, %sil
    jmp return_value_HW1
# Return *
asterisk_HW1:
    movb $0x2A, %sil
    jmp return_value_HW1
# Return (
left_parenthesis_HW1:
    movb $0x28, %sil
    jmp return_value_HW1
# Return )
right_parenthesis_HW1:
    movb $0x29, %sil
    jmp return_value_HW1
# Return ~
tilde_HW1:
    movb $0x7E, %sil
    jmp return_value_HW1
# Return _
underscore_HW1:
    movb $0x5F, %sil
    jmp return_value_HW1
# Return +
plus_HW1:
    movb $0x2B, %sil
    jmp return_value_HW1
# Return {
left_brace_HW1:
    movb $0x7B, %sil
    jmp return_value_HW1
# Return }
right_brace_HW1:
    movb $0x7D, %sil
    jmp return_value_HW1
# Return :
colon_HW1:
    movb $0x3A, %sil
    jmp return_value_HW1
# Return "
quote_HW1:
    movb $0x22, %sil
    jmp return_value_HW1
# Return |
pipe_HW1:
    movb $0x7C, %sil
    jmp return_value_HW1
# Return <
less_than_HW1:
    movb $0x3C, %sil
    jmp return_value_HW1
# Return >
greater_than_HW1:
    movb $0x3E, %sil
    jmp return_value_HW1
# Return ?
question_HW1:
    movb $0x3F, %sil
    jmp return_value_HW1
# Capitalize a-z
capitalize_HW1:
    subb $32, %sil              # subtract the diff between lowers and capitals
    jmp return_value_HW1
# Return A-Z from a-z
capital_letters_HW1:
    jmp return_value_HW1
# Return other charcters
others_HW1:
    movb $0xFF, %sil
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Return the value
return_value_HW1:
    movb %sil, (shifted)
