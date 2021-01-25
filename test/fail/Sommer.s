
.intel_syntax
.globl Lmain


Lmain:
	PUSH %ebp
	MOV %ebp, %esp
	SUB %esp, 4
	# LABEL(L$$1)
L$$1:
	# MOVE(TEMP(t9), TEMP(%ebx))
	MOV %ecx, %ebx
	# MOVE(TEMP(t10), TEMP(%esi))
	MOV %esi, %esi
	# MOVE(TEMP(t11), TEMP(%edi))
	MOV %edx, %edi
	# MOVE(TEMP(t24), CONST(4))
	MOV %edi, 4
	# MOVE(TEMP(t23), CALL(NAME(L_halloc), TEMP(t24)))
	# push parameters on stack
	PUSH %edi
	CALL L_halloc
	# remove parameters from stack
	ADD %esp, 4
	# move return value from EAX into returnReg
	MOV %edi, %eax
	MOV %edi, %edi
	# MOVE(TEMP(t22), TEMP(t23))
	MOV %edi, %edi
	# MOVE(TEMP(t21), CALL(NAME(LC$value), TEMP(t22)))
	# push parameters on stack
	PUSH %edi
	CALL LC$value
	# remove parameters from stack
	ADD %esp, 4
	# move return value from EAX into returnReg
	MOV %edi, %eax
	MOV %edi, %edi
	# MOVE(TEMP(t20), TEMP(t21))
	MOV %edi, %edi
	# MOVE(TEMP(t19), CALL(NAME(L_println_int), TEMP(t20)))
	# push parameters on stack
	PUSH %edi
	CALL L_println_int
	# remove parameters from stack
	ADD %esp, 4
	# move return value from EAX into returnReg
	MOV %edi, %eax
	MOV %edi, %edi
	# EXP(TEMP(t19))
	# MOVE(TEMP(%ebx), TEMP(t9))
	MOV %ebx, %ecx
	# MOVE(TEMP(%esi), TEMP(t10))
	MOV %esi, %esi
	# MOVE(TEMP(%edi), TEMP(t11))
	MOV %edi, %edx
	# MOVE(TEMP(t25), CONST(1))
	MOV %edx, 1
	# MOVE(TEMP(%eax), TEMP(t25))
	MOV %eax, %edx
	# JUMP(NAME(L$$0), [L$$0])
	JMP L$$0
	# LABEL(L$$0)
L$$0:
	LEAVE
	RET

LC$value:
	PUSH %ebp
	MOV %ebp, %esp
	SUB %esp, 4
	# LABEL(L$$3)
L$$3:
	# MOVE(TEMP(t15), TEMP(%ebx))
	MOV %ecx, %ebx
	# MOVE(TEMP(t16), TEMP(%esi))
	MOV %esi, %esi
	# MOVE(TEMP(t17), TEMP(%edi))
	MOV %edx, %edi
	# MOVE(TEMP(t26), OP(+, TEMP(%esp), CONST(-4)))
	MOV %edi, %esp
	ADD %edi, -4
	MOV %edi, %edi
	# MOVE(TEMP(%esp), TEMP(t26))
	MOV %esp, %edi
	# MOVE(TEMP(t27), CONST(0))
	MOV %edi, 0
	# MOVE(MEM(TEMP(%esp)), TEMP(t27))
	MOV DWORD PTR [%esp], %edi
	# MOVE(TEMP(t28), MEM(TEMP(%esp)))
	MOV %edi, DWORD PTR [%esp]
	# MOVE(TEMP(t14), TEMP(t28))
	MOV %eax, %edi
	# MOVE(TEMP(t29), CONST(555))
	MOV %edi, 555
	# MOVE(TEMP(t14), TEMP(t29))
	MOV %eax, %edi
	# MOVE(TEMP(%ebx), TEMP(t15))
	MOV %ebx, %ecx
	# MOVE(TEMP(%esi), TEMP(t16))
	MOV %esi, %esi
	# MOVE(TEMP(%edi), TEMP(t17))
	MOV %edi, %edx
	# MOVE(TEMP(%eax), TEMP(t14))
	MOV %eax, %eax
	# JUMP(NAME(L$$2), [L$$2])
	JMP L$$2
	# LABEL(L$$2)
L$$2:
	LEAVE
	RET
