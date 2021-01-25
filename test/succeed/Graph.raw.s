        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L27:    push    4
        call    L_halloc
        add     %esp, 4
        mov     t1007, %eax
        push    t1007
        call    LTest$test
        add     %esp, 4
        mov     t1008, %eax
        push    t1008
        call    L_println_int
        add     %esp, 4
L28:    leave
        ret
        .global LLabel$init
        .type LLabel$init, @function
LLabel$init:
        #args LOC 0, LOC 4
        enter   0, 0
L29:    mov     t1017, DWORD PTR [%ebp+8]
        mov     t1018, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1017+4], t1018
        mov     %eax, 0
L30:    leave
        ret
        .global LLabel$label
        .type LLabel$label, @function
LLabel$label:
        #args LOC 0
        enter   0, 0
L31:    mov     t1019, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1019+4]
L32:    leave
        ret
        .global LLabel$eq
        .type LLabel$eq, @function
LLabel$eq:
        #args LOC 0, LOC 4
        enter   0, 0
L33:    push    DWORD PTR [%ebp+12]
        call    LLabel$label
        add     %esp, 4
        mov     t8, %eax
        mov     t1001, 1
        mov     t1023, t8
        inc     t1023
        mov     t1022, DWORD PTR [%ebp+8]
        cmp     DWORD PTR [t1022+4], t1023
        jl      L0
L1:     mov     t1001, 0
L0:     mov     t1003, t1001
        cmp     t1003, 0
        je      L4
L5:     mov     t1002, 1
        mov     t1021, DWORD PTR [%ebp+8]
        mov     t1020, DWORD PTR [t1021+4]
        inc     t1020
        cmp     t8, t1020
        jl      L2
L3:     mov     t1002, 0
L2:     mov     t1003, t1002
L4:     mov     %eax, t1003
L34:    leave
        ret
        .global LLabel$print
        .type LLabel$print, @function
LLabel$print:
        #args LOC 0
        enter   0, 0
L35:    mov     t1024, DWORD PTR [%ebp+8]
        push    DWORD PTR [t1024+4]
        call    L_println_int
        add     %esp, 4
        mov     %eax, 0
L36:    leave
        ret
        .global LNode$init
        .type LNode$init, @function
LNode$init:
        #args LOC 0, LOC 4
        enter   0, 0
L37:    mov     t1031, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1031+16], 0
        mov     t1029, DWORD PTR [%ebp+8]
        mov     t1030, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1029+4], t1030
        mov     t1027, DWORD PTR [%ebp+8]
        mov     t1028, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1027+8], t1028
        mov     t1025, DWORD PTR [%ebp+8]
        mov     t1026, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1025+12], t1026
        mov     %eax, 0
L38:    leave
        ret
        .global LNode$label
        .type LNode$label, @function
LNode$label:
        #args LOC 0
        enter   0, 0
L39:    mov     t1032, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1032+4]
L40:    leave
        ret
        .global LNode$setLeft
        .type LNode$setLeft, @function
LNode$setLeft:
        #args LOC 0, LOC 4
        enter   0, 0
L41:    mov     t1033, DWORD PTR [%ebp+8]
        mov     t1034, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1033+8], t1034
        mov     %eax, 0
L42:    leave
        ret
        .global LNode$setRight
        .type LNode$setRight, @function
LNode$setRight:
        #args LOC 0, LOC 4
        enter   0, 0
L43:    mov     t1035, DWORD PTR [%ebp+8]
        mov     t1036, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1035+12], t1036
        mov     %eax, 0
L44:    leave
        ret
        .global LNode$print
        .type LNode$print, @function
LNode$print:
        #args LOC 0
        enter   0, 0
L45:    mov     t1037, DWORD PTR [%ebp+8]
        push    DWORD PTR [t1037+4]
        call    LLabel$print
        add     %esp, 4
        mov     t8, %eax
        mov     %eax, 0
L46:    leave
        ret
        .global LNode$beq
        .type LNode$beq, @function
LNode$beq:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L47:    mov     t1004, DWORD PTR [%ebp+12]
        cmp     t1004, 0
        je      L6
L7:     mov     t1004, DWORD PTR [%ebp+16]
L6:     mov     t1006, t1004
        xor     t1006, 1
        cmp     t1006, 0
        je      L10
L11:    mov     t1005, DWORD PTR [%ebp+12]
        xor     t1005, 1
        cmp     t1005, 0
        je      L8
L9:     mov     t1005, DWORD PTR [%ebp+16]
        xor     t1005, 1
L8:     mov     t1006, t1005
        xor     t1006, 1
L10:    mov     %eax, t1006
        xor     %eax, 1
L48:    leave
        ret
        .global LNode$dfs
        .type LNode$dfs, @function
LNode$dfs:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L49:    mov     t1043, DWORD PTR [%ebp+8]
        push    DWORD PTR [%ebp+12]
        push    DWORD PTR [t1043+16]
        push    DWORD PTR [%ebp+8]
        call    LNode$beq
        add     %esp, 12
        mov     t1009, %eax
        cmp     t1009, 0
        je      L22
L21:    mov     t8, 0
L23:    mov     %eax, t8
        jmp     L50
L22:    mov     t1042, DWORD PTR [%ebp+8]
        push    DWORD PTR [%ebp+16]
        push    DWORD PTR [t1042+4]
        call    LLabel$eq
        add     %esp, 8
        mov     t1010, %eax
        cmp     t1010, 0
        je      L19
        jmp     L18
L19:    mov     t1040, DWORD PTR [%ebp+8]
        mov     t1041, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1040+16], t1041
        mov     t1039, DWORD PTR [%ebp+8]
        push    DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+12]
        push    DWORD PTR [t1039+8]
        call    LNode$dfs
        add     %esp, 12
        mov     t1011, %eax
        cmp     t1011, 0
        je      L16
        jmp     L15
L18:    mov     t8, 1
        jmp     L20
L16:    mov     t1038, DWORD PTR [%ebp+8]
        push    DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+12]
        push    DWORD PTR [t1038+12]
        call    LNode$dfs
        add     %esp, 12
        mov     t1012, %eax
        cmp     t1012, 0
        je      L13
        jmp     L12
L15:    mov     t8, 1
        jmp     L17
L13:    mov     t8, 0
        jmp     L14
L12:    mov     t8, 1
L14:
L17:
L20:    jmp     L23
L50:    leave
        ret
        .global LTest$newLabel
        .type LTest$newLabel, @function
LTest$newLabel:
        #args LOC 0, LOC 4
        enter   0, 0
L51:    push    8
        call    L_halloc
        add     %esp, 4
        mov     t9, %eax
        push    DWORD PTR [%ebp+12]
        push    t9
        call    LLabel$init
        add     %esp, 8
        mov     t8, %eax
        mov     %eax, t9
L52:    leave
        ret
        .global LTest$newNode
        .type LTest$newNode, @function
LTest$newNode:
        #args LOC 0, LOC 4
        enter   0, 0
L53:    push    20
        call    L_halloc
        add     %esp, 4
        mov     t9, %eax
        push    DWORD PTR [%ebp+12]
        push    t9
        call    LNode$init
        add     %esp, 8
        mov     t8, %eax
        mov     %eax, t9
L54:    leave
        ret
        .global LTest$findPath
        .type LTest$findPath, @function
LTest$findPath:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L55:    push    DWORD PTR [%ebp+12]
        call    LNode$print
        add     %esp, 4
        mov     t8, %eax
        push    DWORD PTR [%ebp+16]
        call    LNode$print
        add     %esp, 4
        mov     t8, %eax
        mov     t1014, DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+16]
        call    LNode$label
        add     %esp, 4
        mov     t1013, %eax
        push    t1013
        push    1
        push    t1014
        call    LNode$dfs
        add     %esp, 12
        mov     t9, %eax
        mov     t1016, DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+16]
        call    LNode$label
        add     %esp, 4
        mov     t1015, %eax
        push    t1015
        push    0
        push    t1016
        call    LNode$dfs
        add     %esp, 12
        mov     t10, %eax
        cmp     t9, 0
        je      L25
L24:    push    999
        call    L_println_int
        add     %esp, 4
L26:    mov     %eax, 0
        jmp     L56
L25:    push    -999
        call    L_println_int
        add     %esp, 4
        jmp     L26
L56:    leave
        ret
        .global LTest$test
        .type LTest$test, @function
LTest$test:
        #args LOC 0
        enter   0, 0
L57:    push    1
        push    DWORD PTR [%ebp+8]
        call    LTest$newLabel
        add     %esp, 8
        mov     t9, %eax
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LTest$newNode
        add     %esp, 8
        mov     t14, %eax
        push    2
        push    DWORD PTR [%ebp+8]
        call    LTest$newLabel
        add     %esp, 8
        mov     t10, %eax
        push    t10
        push    DWORD PTR [%ebp+8]
        call    LTest$newNode
        add     %esp, 8
        mov     t15, %eax
        push    3
        push    DWORD PTR [%ebp+8]
        call    LTest$newLabel
        add     %esp, 8
        mov     t11, %eax
        push    t11
        push    DWORD PTR [%ebp+8]
        call    LTest$newNode
        add     %esp, 8
        mov     t16, %eax
        push    4
        push    DWORD PTR [%ebp+8]
        call    LTest$newLabel
        add     %esp, 8
        mov     t12, %eax
        push    t12
        push    DWORD PTR [%ebp+8]
        call    LTest$newNode
        add     %esp, 8
        mov     t17, %eax
        push    5
        push    DWORD PTR [%ebp+8]
        call    LTest$newLabel
        add     %esp, 8
        mov     t13, %eax
        push    t13
        push    DWORD PTR [%ebp+8]
        call    LTest$newNode
        add     %esp, 8
        mov     t18, %eax
        push    t15
        push    t14
        call    LNode$setLeft
        add     %esp, 8
        mov     t8, %eax
        push    t17
        push    t14
        call    LNode$setRight
        add     %esp, 8
        mov     t8, %eax
        push    t16
        push    t15
        call    LNode$setLeft
        add     %esp, 8
        mov     t8, %eax
        push    t14
        push    t16
        call    LNode$setLeft
        add     %esp, 8
        mov     t8, %eax
        push    t17
        push    t16
        call    LNode$setRight
        add     %esp, 8
        mov     t8, %eax
        push    t17
        push    t14
        push    DWORD PTR [%ebp+8]
        call    LTest$findPath
        add     %esp, 12
        mov     t8, %eax
        push    t14
        push    t17
        push    DWORD PTR [%ebp+8]
        call    LTest$findPath
        add     %esp, 12
        mov     t8, %eax
        push    t15
        push    t16
        push    DWORD PTR [%ebp+8]
        call    LTest$findPath
        add     %esp, 12
        mov     t8, %eax
        push    t14
        push    t17
        push    DWORD PTR [%ebp+8]
        call    LTest$findPath
        add     %esp, 12
        mov     t8, %eax
        push    t15
        push    t16
        push    DWORD PTR [%ebp+8]
        call    LTest$findPath
        add     %esp, 12
        mov     t8, %eax
        push    t16
        push    t17
        push    DWORD PTR [%ebp+8]
        call    LTest$findPath
        add     %esp, 12
        mov     t8, %eax
        push    t18
        push    t18
        push    DWORD PTR [%ebp+8]
        call    LTest$findPath
        add     %esp, 12
        mov     t8, %eax
        push    t17
        push    t18
        push    DWORD PTR [%ebp+8]
        call    LTest$findPath
        add     %esp, 12
        mov     t8, %eax
        mov     %eax, 0
L58:    leave
        ret
