%include "in_out.asm"

SECTION .data
msg: DB 'Введите текст',0h

SECTION .bss
buf1: Resb 80

SECTION .text
GLOBAL _start
_start:
mov eax,msg
call sprint
mov ecx,buf1
mov edx,80
call sread
call quit

