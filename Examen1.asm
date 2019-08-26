section .data
	msj db "Ingrese el primer numero ", 0xa
	len equ $-msj
	msj2 db "Ingrese el segundo numero ", 0xa
	len_2 equ $-msj2
	msjMenor db "El numero es MENOR ", 0xa
	len_men equ $-msjMenor
	msjMayor db "El numero es MAYOR ", 0xa
	len_may equ $-msjMayor
	msjIgual db "El numero es IGUAL ", 0xa
	len_igu equ $-msjIgual

section .bss
	numero resb 1
	numero2 resb 1

section .text
	global _start
_start:
;-------PRIMER VALOR ----
	mov eax, 4
	mov ebx, 1
	mov ecx, msj
	mov edx, len
	int 80H

	mov eax, 3
	mov ebx, 2
	mov ecx, numero
	mov edx, 2
	int 80H	;

;-------SEGUNDO VALOR ----
	mov eax, 4
	mov ebx, 1
	mov ecx, msj2
	mov edx, len_2
	int 80H

	mov eax, 3
	mov ebx, 2
	mov ecx, numero2
	mov edx, 2
	int 80H

; --------------
	mov ax, [numero]	; para escritura  // 4 -> lectura
	mov bx, [numero2]
	sub ax, '0' 		; transforma de cadena a numero
	sub bx, '0'
	
	mov al, [numero]
	cmp al, [numero2]	;cmp op1-op2
	jz igual		; Compara numeros si.. 0 = 0 -> ZF=1
	
	mov al, [numero]	; 
	cmp al, [numero2]	; 
	jc menor		; CF=1 -->  jc se activa

	jmp mayor		; 


igual:
		; escribir msj IGUAL
		mov eax, 4
		mov ebx, 1
		mov ecx, msjIgual
	 	mov edx, len_igu	
		int 80H
		jmp salir

mayor:
		; escribir msj mayor
		mov eax, 4
		mov ebx, 1
		mov ecx, msjMayor
	 	mov edx, len_may
		int 80H
		jmp salir
menor:
		; escribir msj menor
		mov eax, 4
		mov ebx, 1
		mov ecx, msjMenor
	 	mov edx, len_men
		int 80H
		jmp salir

salir:
		mov eax, 1		;RETURN
		mov ebx, 0
		int 80H
