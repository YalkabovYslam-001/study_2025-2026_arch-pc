section .data
    msg_x db "Введите x: ",0
    msg_x_len equ $-msg_x

    msg_a db "Введите a: ",0
    msg_a_len equ $-msg_a

    msg_res db "Результат: ",0
    msg_res_len equ $-msg_res

section .bss
    x resd 1
    a resd 1
    result resd 1
    inbuf resb 16
    outbuf resb 16

section .text
    global _start

_start:
    mov eax,4
    mov ebx,1
    mov ecx,msg_x
    mov edx,msg_x_len
    int 0x80

    mov eax,3
    mov ebx,0
    mov ecx,inbuf
    mov edx,16
    int 0x80

    mov esi,inbuf
    call atoi
    mov [x],eax

    mov eax,4
    mov ebx,1
    mov ecx,msg_a
    mov edx,msg_a_len
    int 0x80

    mov eax,3
    mov ebx,0
    mov ecx,inbuf
    mov edx,16
    int 0x80

    mov esi,inbuf
    call atoi
    mov [a],eax

    mov eax,[x]
    mov ebx,[a]
    cmp eax,ebx
    jge ge_case

    mov eax,[a]
    mov ebx,3
    mul ebx
    add eax,1
    mov [result],eax
    jmp print

ge_case:
    mov eax,[x]
    mov ebx,3
    mul ebx
    add eax,1
    mov [result],eax

print:
    mov eax,4
    mov ebx,1
    mov ecx,msg_res
    mov edx,msg_res_len
    int 0x80

    mov eax,[result]
    mov esi,eax
    mov edi,outbuf
    call itoa

    mov eax,4
    mov ebx,1
    mov ecx,outbuf
    mov edx,16
    int 0x80

    mov eax,1
    xor ebx,ebx
    int 0x80

atoi:
    xor eax,eax
atoi_loop:
    mov bl,[esi]
    cmp bl,10
    je atoi_end
    cmp bl,13
    je atoi_end
    cmp bl,0
    je atoi_end
    sub bl,'0'
    imul eax,eax,10
    add eax,ebx
    inc esi
    jmp atoi_loop
atoi_end:
    ret
itoa:
    mov ebx,10
    xor ecx,ecx
itoa_l1:
    xor edx,edx
    div ebx
    add edx,'0'
    push edx
    inc ecx
    test eax,eax
    jnz itoa_l1
itoa_l2:
    pop edx
    mov [edi],dl
    inc edi
    loop itoa_l2
    mov byte [edi],0
    ret
