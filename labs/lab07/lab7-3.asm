section .data
    a dd 81
    b dd 22
    c dd 72
    buf db "00", 0

section .text
    global _start

_start:
    mov eax, [a]

    mov ebx, [b]
    cmp eax, ebx
    jle check_c
    mov eax, ebx

check_c:
    mov ebx, [c]
    cmp eax, ebx
    jle convert
    mov eax, ebx

convert:
    mov ebx, buf
    mov ecx, 2
convert_loop:
    mov edx, 0
    mov esi, 10
    div esi
    add edx, '0'
    mov [ebx+ecx-1], dl
    loop convert_loop

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 2
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
