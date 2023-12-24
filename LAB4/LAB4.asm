section .data
    prompt_msg db "Enter a number (n): ", 0
    prompt_len equ $ - prompt_msg
    result_msg db "Sum from 1 to n is: ", 0
    result_len equ $ - result_msg
    newline db 0xa, 0xd, 0
    newline_len equ $ - newline

section .bss
    n resb 5        ; Assuming n is a 32-bit integer, you may need to adjust this size
    sum resd 1

section .text
    global _start

_start:
    ; Display prompt for user input
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_msg
    mov edx, prompt_len
    int 0x80

    ; Read user input (integer n)
    mov eax, 3
    mov ebx, 0
    mov ecx, n
    mov edx, 5        ; Adjust size based on your needs
    int 0x80

    ; Convert ASCII to integer
    mov eax, 0
    mov ecx, n
    call ascii_to_int
    mov ebx, eax

    ; Calculate the sum
    mov eax, 0
    mov ecx, ebx
    add_sum:
        add eax, ecx
        loop add_sum

    ; Display the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, result_len
    int 0x80

    ; Display the sum
    mov eax, 4
    mov ebx, 1
    mov ecx, eax      ; Use eax register to display the sum
    mov edx, 1
    int 0x80

    ; Display newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 0x80

    ; Exit the program
    mov eax, 1
    int 0x80

; Function to convert ASCII to integer
ascii_to_int:
    xor eax, eax
    mov edi, 10      ; Base 10
convert_loop:
    movzx edx, byte [ecx]  ; Load the next ASCII character
    cmp edx, 0            ; Check for null terminator
    je  convert_done      ; If null terminator, conversion is done
    sub edx, '0'          ; Convert ASCII to integer ('0' -> 0, '1' -> 1, ..., '9' -> 9)
    imul eax, edi         ; Multiply the current result by 10
    add eax, edx          ; Add the new digit
    inc ecx               ; Move to the next character
    jmp convert_loop
convert_done:
    ret
