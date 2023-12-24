section .data
    SYS_EXIT    equ 1
    prompt_msg db "Enter a number: ", 0
    prompt_len equ $ - prompt_msg
    odd_msg db "-> This is an odd number!!", 0xa, 0xd, 0
    odd_len equ $ - odd_msg
    even_msg db "-> This is an even number!!", 0xa, 0xd, 0
    even_len equ $ - even_msg

section .bss
    user_input resb 1

section .text
    global _start
_start:
    ; Display prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_msg
    mov edx, prompt_len
    int 0x80

    ; Read user input
    mov eax, 3
    mov ebx, 0
    mov ecx, user_input
    mov edx, 1
    int 0x80

    ; Check if the number is odd or even
    test byte [user_input], 1
    jnz odd

    ; Display even message
    mov eax, 4
    mov ebx, 1
    mov ecx, even_msg
    mov edx, even_len
    int 0x80
    jmp exit

odd:
    ; Display odd message
    mov eax, 4
    mov ebx, 1
    mov ecx, odd_msg
    mov edx, odd_len
    int 0x80

exit:
    ; Exit the program
    mov eax, SYS_EXIT
    int 0x80


