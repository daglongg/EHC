section .data 

SYS_EXIT    equ 1

input db 'Input: '
lenInput equ $-input

output db 'Output:', 10
lenOutput equ $-output


hello db 'Hello '
lenHello equ $-hello

chamThan db ' !!', 10, 13
lenChamThan equ $-chamThan

welcome db 'Welcome, '
lenWelcomw equ $-welcome

toEHC db ' to EHC', 10,13,0
lenToEHC equ $-toEHC

section .bss 
name resb 100
section .text
global _start
_start:
mov eax, 4
mov ebx, 1
mov ecx, input
mov edx, lenInput
int 0x80

mov eax, 3
mov ebx,0
lea ecx, [name]
mov edx, 100
int 0x80

mov edx, name
sub eax, 1h
mov word [edx + eax], 0

mov eax, 4
mov ebx, 1
mov ecx, output
mov edx, lenOutput
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, hello
mov edx, lenHello
int 0x80

mov eax, 4
mov ebx, 1
lea ecx, [name]
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, chamThan
mov edx, lenChamThan
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, welcome
mov edx, lenWelcomw
int 0x80

mov eax, 4
mov ebx, 1
lea ecx, [name]

int 0x80

mov eax, 4
mov ebx, 1
mov ecx, toEHC
mov edx, lenToEHC
int 0x80

last:
mov eax, SYS_EXIT
int 0x80
