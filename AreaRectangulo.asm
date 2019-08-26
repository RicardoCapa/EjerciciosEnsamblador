section .data
	
	
	basee db "Ingrese la basee",10
	bas equ $-basee

    alturaa db "Ingrese la altura",10
	alt equ $-alturaa

	resultado db 'el area delrectangulo es: ',10
	lenRes equ $-resultado

section .bss
      	base resb 2
        altura resb 2
	area resb 2

section .text
	global _start
		_start:


		mov eax, 4
		mov ebx, 1
		mov ecx, basee
	 	mov edx, bas	
		int 80H

		mov eax,3
		mov ebx,2
		mov ecx,base
		mov edx,2
		int 80h

		mov eax, 4

		mov ebx, 1
		mov ecx, alturaa
	 	mov edx, alt	
		int 80H

                mov eax,3
		mov ebx,2
		mov ecx,altura
		mov edx,2
		int 80h

		;Calculo del Area
		mov al,[base]
		mov bl,[altura]
		sub al,'0'
		sub bl,'0'
		mul bl
		add al,'0'
		mov [area],al

		mov eax, 4
		mov ebx, 2
		mov ecx, resultado
	 	mov edx, lenRes	
		int 80H

		mov eax, 4
		mov ebx, 1
		mov ecx, area
	 	mov edx, 10	
		int 80H
		

		jmp salir

salir: 
		mov eax,1
		mov ebx,0
		int 80h