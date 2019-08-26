section .data 
	nombre db  10, "Numero  " 
	len equ $ - nombre
	
section .text
	global _start
	
_start:
	mov ecx , 0
	mov esi , 9

comparar:
	push ecx 
	add ecx, '0'
	mov [nombre + 8], dword ecx

	mov eax,4
	mov ebx,1
	mov ecx,nombre
	mov edx,len
	int 80H

	pop ecx
	inc ecx
	cmp ecx,esi
	jz salir
	jmp comparar

salir:
	mov eax,1
	mov ebx,00
	int 80H