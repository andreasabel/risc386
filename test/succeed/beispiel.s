	.intel_syntax
	.global Lmain
Lmain:
	push %ebp
	mov %ebp, %esp
	sub %esp, 4
L$$4:	mov t21,23
	mov t8,%ebx
	mov t9,%esi
	mov t10,%edi
	mov t22,23
	mov t23,4
	push t23
	call L_halloc
	mov t24,%eax
	add %esp,4
	mov t16,t24
	mov t25,5
	push t25
	push t16
	call LFibClass$nfib
	mov t26,%eax
	add %esp,8
	mov t17,t26
	push t17
	call L_println_int
	mov t27,%eax
	add %esp,4
	mov %eax,0
	mov t28,23
	mov %ebx,t8
	mov %esi,t9
	mov %edi,t10
	jmp L$$3
L$$3:	leave 
	ret 

# Der Simulator kann beim Funktionsaufruf den Stackinhalt und den
# Inhalt von Temporaries anzeigen. Dazu sagt man nach den Funktionenlabel
# welche Daten angezeigt werden sollen. Mit "#args LOC 4, REG t1" wird
# zum Beispiel das erste Element auf dem Stack und das Temp "t1"
# angezeigt. Vorsicht: Wenn man mit LOC auf eine ungültige Adresse
# zugreigt, dann bricht der Simulator ab.

LFibClass$nfib: #args LOC 4
	push %ebp
	mov %ebp, %esp
	sub %esp, 4
L$$6:	mov t29,23
	mov t13,%ebx
	mov t14,%esi
	mov t15,%edi
	mov t11,0
	mov t30, DWORD PTR [%ebp + 12]
	mov t31,2
	cmp t30,t31
	jl L$$0
L$$1:	mov t32, DWORD PTR [%ebp + 12]
	mov t33,1
	mov t34,t32
	sub t34,t33
	push t34
	mov t35, DWORD PTR [%ebp + 8]
	push t35
	call LFibClass$nfib
	mov t36,%eax
	add %esp,8
	mov t18,t36
	mov t20,t18
	mov t37, DWORD PTR [%ebp + 12]
	mov t38,2
	mov t39,t37
	sub t39,t38
	push t39
	mov t40, DWORD PTR [%ebp + 8]
	push t40
	call LFibClass$nfib
	mov t41,%eax
	add %esp,8
	mov t19,t41
	lea t42, DWORD PTR [t19 + t20 + 1]
	mov t11,t42
	jmp L$$2
L$$2:	mov %eax,t11
	mov t43,23
	mov %ebx,t13
	mov %esi,t14
	mov %edi,t15
	jmp L$$5
L$$0:	mov t11,1
	jmp L$$2
L$$5:	leave 
	ret 
