%macro escribir 2 	;numero de parametros que va a recibir
	mov eax,4
	mov ebx,1
	mov ecx,%1      ; etiqueta de memoria donde se va imprimir 
	mov edx,%2      ; catidad de digitos a imprimir
	int 80h
%endmacro

%macro lectura 2 	;numero de parametros que va a recibir
	mov eax,3
	mov ebx,2
	mov ecx,%1      ; etiqueta de memoria donde se va imprimir 
	mov edx,%2      ; catidad de digitos a imprimir
	int 80h
%endmacro

section .data
	mensaje db "Leer un archivo en el disco duro y determinar si es par o impar",10
	len_mensaje equ $- mensaje

	mensaje2 db "Lo guardado en el archivo es: ",10
	len_msj2 equ $- mensaje2

	me db " ",10
	len_msj3 equ $- me

  
  	   par_msg  db  'Número par' 
   len1  equ  $ - par_msg 
   
   impar_msg db  'Número impar' 
   len2  equ  $ - impar_msg


	archivo db "/home/ricardo/Escritorio/ensamblador/archivo.txt",


section .bss
	texto resb 50  		; variable que almacena 
	 			  		; el contenido del archivo

	idarchivo resd 1	; el identificador que se obtiene	
				  		; del archivo, es el archivo fisico

   	res resb 2          ; para el mayor

section .text
	global _start

_start:

	;Abrir el archivo
	mov eax, 8   		;servicio para abrir un archivo
	mov ebx, archivo    ;direccion del archivo
	mov ecx, 2			;0 read only
	mov edx, 0	 		;permiso: permite leer si esta creada
	int 80h


	;Testeo para ver si existe el archivo
	test eax, eax

	jz salir

	mov dword[idarchivo], eax

	;Mesnaje que indica leer Archivo y sacar el mayor
	escribir mensaje,len_mensaje

 	mov ecx , 1
    


l1:
	push ecx

   	mov eax, 3
	mov ebx, 0
	mov ecx, texto
	mov edx, 10 ;20
	int 80h
  
	mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, texto
	mov edx, 1  ;20
	int 80h

	pop ecx
	loop l1


	;Mesnaje que indica leer Archivo y sacar el mayor

	mov eax, 5   		;servicio para abrir un archivo
	mov ebx, archivo    ;direccion del archivo
	mov ecx, 0			;0 read only
	mov edx, 0	 		;permiso: permite leer si esta creada
	int 80h


	;Testeo para ver si existe el archivo
	test eax, eax

	jz salir

	mov dword[idarchivo], eax

	mov eax, 3				;Lectura servicio 3
	mov ebx, [idarchivo]	;unidad de entrada
	mov ecx, texto
	mov edx, 20
	int 80h

	;Comparacion
	mov ecx, 1 ;numero de digitos de cada operando
	mov esi, 0 ;index source indice de fuente cadena se enpieza con cero

ciclo:
	mov al, [texto + esi] ; al ser cadenas se enpueza con cero parte baja
	and al, 1   
   	jz par
   	jmp impar

	dec esi
	loop ciclo

	par:   
   	mov   eax, 4             ;system call number (sys_write)
   	mov   ebx, 1             ;file descriptor (stdout)
   	mov   ecx, par_msg      ;message to write
   	mov   edx, len1          ;length of message
   	int   0x80               ;call kernel
   	jmp continuar

   	impar:
   	mov   eax, 4             ;system call number (sys_write)
   	mov   ebx, 1             ;file descriptor (stdout)
   	mov   ecx, impar_msg       ;message to write
   	mov   edx, len2          ;length of message
   	int   0x80               ;call kernel
   	jmp continuar

continuar:
   	escribir me,len_msj3

	escribir mensaje2,len_msj2
	
	;Presentar lo leido
	mov eax, 4
	mov ebx, 1
	mov ecx, texto
	mov edx, 20
	int 80h  

	;Cerrar el archivo
	mov eax, 6
	mov ebx, [idarchivo]
	mov ecx, 0
	mov edx, 0
	int 80h

salir:
	mov eax,1
	mov ebx,00
	int 80H
