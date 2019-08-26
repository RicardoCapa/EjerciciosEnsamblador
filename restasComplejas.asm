;487 + 276 = 763
;enpieza desde cero en cadena

%macro escribir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro
section .data
 	msj db "La resta es: "
 	len equ $- msj
 	n1 db '487'
 	n2 db '276'
 	suma db '   '

section .text
	global _start

_start :
	
	mov ecx, 3 ;numero de digitos de cada operando
	mov esi, 2 ;index source indice de fuente cadena se enpieza con cero
	clc    	   ;permite poner la bandera del carry en cero suponiendo que esxistio carry anteriormente

ciclo_suma:
	mov al, [n1 + esi] ; al ser cadenas se enpueza con cero parte baja
	sbb al, [n2 + esi] ;parte baja 7+6+carry al+n2+carry
	aas	 			   ;suma a AL 6 y AH suma el acarreo
					   ;se aplica despues de una suma con acarreo y suma
					   ;el contenido de la bandera de carry al primer operando
					   ;y despues al segundo vuelve al estado original aaa

    pushf			   ;push flag envia el estado de las banderas a la pila
    or al,30h 		   ;es similar a sub , '0'

	popf			   ;restaura el estado de las banderas almacenadas temporalmente en la pila hacia las 						   ;banderas

	mov[suma + esi],al
	dec esi
	loop ciclo_suma

	escribir msj, len
	escribir suma,3

	mov eax,1
	int 80h
