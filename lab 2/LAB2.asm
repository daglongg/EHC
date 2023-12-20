section .data
SYS_EXIT    equ 1

input db 'Input: ', 10,13,0
lenInput equ $-input

thongBao db 'Nhap vao chieu dai va chieu rong: ', 10, 13, 0
lenThongBao equ $-thongBao

output db 'Output:', 10, 13, 0
lenOutput equ $-output

thongBao1 db 'Chu vi cua hinh chu nhat: '
lenThongBao1 equ $-thongBao1

thongBao2 db 13,10, 'Dien tich cua hinh chu nhat: '
lenThongBao2 equ $-thongBao2
section .bss


area resb 1
circuit resb 1
a resb 100
b resb 100

section .text
global _start
_start:
 mov eax, 4
 mov ebx, 1
 mov ecx, input
 mov edx, lenInput
 int 0x80

 mov eax, 4
 mov ebx, 1
 mov ecx, thongBao
 mov edx, lenThongBao
 int 0x80

 mov eax, 3
 mov ebx, 0
 lea ecx, [a]
 mov edx, 100
 int 0x80

 mov eax, 3
 mov ebx, 0
 lea ecx, [b]
 mov edx, 100
 int 0x80

mov eax, 4
mov ebx, 1
mov ecx, output
mov edx, lenOutput
int 0x80


mov al, [a]
sub al, '0'
mov bl, [b]
sub bl, '0'
mul bl
add al, '0'
mov [area], al

mov al, [a]
sub al, '0'
mov bl, [b]
sub bl, '0'
add al, bl
mov bl, 2
sub cl, '0'
mul bl
add al, '0'
mov [circuit], al

mov eax, 4
mov ebx, 1
mov ecx, thongBao1
mov edx, lenThongBao1
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, circuit
mov edx, 1
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, thongBao2
mov edx, lenThongBao2
int 0x80

mov eax, 4
mov ebx, 1
mov ecx, area
mov edx, 1
int 0x80

_last:
mov eax, SYS_EXIT
int 0x80
