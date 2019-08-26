section .data
	msg1 db "Ingrese 5 números y presione enter:", 0xA
	len1 equ $-msg1	


   par_msg  db  'Número par' 
   len11  equ  $ - par_msg 
   
   impar_msg db  'Número impar' 
   len2  equ  $ - impar_msg


	arreglo db 0,0,0,0,0
	len_arreglo equ $-arreglo

	msj_resultado db "El menor número es:", 0xA
	len_resultado equ $-msj_resultado

section .bss
	dato resb 2

section .text
	global _start

_start:
	;se define el arreglo en los registros índices
	mov esi, arreglo
	mov edi, 0

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, len1
	int 0x80

leer:
	mov eax, 3
	mov ebx, 0
	mov ecx, dato
	mov edx, 2
	int 0x80

	mov al, [dato]
	sub al, '0'		;se convierte a decimal 
	
	mov [esi] , al
	
	add edi, 1     		; inc edi
	add esi, 1

	cmp edi, len_arreglo
	jb leer

	mov ecx, 0

comparacion:
	push ecx
	mov al,[arreglo + ecx] 
	and al, 1   
	
	jz par
   	jmp impar

	jmp contador

	par:   
   	mov   eax, 4             ;system call number (sys_write)
   	mov   ebx, 1             ;file descriptor (stdout)
   	mov   ecx, par_msg      ;message to write
   	mov   edx, len11          ;length of message
   	int   0x80               ;call kernel

   	jmp contador

   	impar:
   	mov   eax, 4             ;system call number (sys_write)
   	mov   ebx, 1             ;file descriptor (stdout)
   	mov   ecx, impar_msg       ;message to write
   	mov   edx, len2          ;length of message
   	int   0x80               ;call kernel
   	jmp contador

contador:
	pop ecx
	inc ecx
	cmp ecx, len_arreglo
	jb comparacion


salir:
	mov eax, 1
	int 0x80	
