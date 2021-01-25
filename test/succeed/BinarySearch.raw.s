        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L63:    push    12
        call    L_halloc
        add     %esp, 4
        mov     t1006, %eax
        push    20
        push    t1006
        call    LBS$Start
        add     %esp, 8
        mov     t1007, %eax
        push    t1007
        call    L_println_int
        add     %esp, 4
L64:    leave
        ret
        .global LBS$Start
        .type LBS$Start, @function
LBS$Start:
        #args LOC 0, LOC 4
        enter   0, 0
        jmp     L65
L7:     push    0
        call    L_println_int
        add     %esp, 4
        jmp     L8
L65:    push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+8]
        call    LBS$Init
        add     %esp, 8
        mov     t8, %eax
        push    DWORD PTR [%ebp+8]
        call    LBS$Print
        add     %esp, 4
        mov     t9, %eax
        push    8
        push    DWORD PTR [%ebp+8]
        call    LBS$Search
        add     %esp, 8
        mov     t1008, %eax
        cmp     t1008, 0
        je      L1
L0:     push    1
        call    L_println_int
        add     %esp, 4
L2:     push    19
        push    DWORD PTR [%ebp+8]
        call    LBS$Search
        add     %esp, 8
        mov     t1009, %eax
        cmp     t1009, 0
        je      L4
L3:     push    1
        call    L_println_int
        add     %esp, 4
L5:     push    20
        push    DWORD PTR [%ebp+8]
        call    LBS$Search
        add     %esp, 8
        mov     t1010, %eax
        cmp     t1010, 0
        je      L7
L6:     push    1
        call    L_println_int
        add     %esp, 4
L8:     push    21
        push    DWORD PTR [%ebp+8]
        call    LBS$Search
        add     %esp, 8
        mov     t1011, %eax
        cmp     t1011, 0
        je      L10
L9:     push    1
        call    L_println_int
        add     %esp, 4
L11:    push    37
        push    DWORD PTR [%ebp+8]
        call    LBS$Search
        add     %esp, 8
        mov     t1012, %eax
        cmp     t1012, 0
        je      L13
L12:    push    1
        call    L_println_int
        add     %esp, 4
L14:    push    38
        push    DWORD PTR [%ebp+8]
        call    LBS$Search
        add     %esp, 8
        mov     t1013, %eax
        cmp     t1013, 0
        je      L16
L15:    push    1
        call    L_println_int
        add     %esp, 4
L17:    push    39
        push    DWORD PTR [%ebp+8]
        call    LBS$Search
        add     %esp, 8
        mov     t1014, %eax
        cmp     t1014, 0
        je      L19
L18:    push    1
        call    L_println_int
        add     %esp, 4
L20:    push    50
        push    DWORD PTR [%ebp+8]
        call    LBS$Search
        add     %esp, 8
        mov     t1015, %eax
        cmp     t1015, 0
        je      L22
L21:    push    1
        call    L_println_int
        add     %esp, 4
L23:    mov     %eax, 999
        jmp     L66
L4:     push    0
        call    L_println_int
        add     %esp, 4
        jmp     L5
L22:    push    0
        call    L_println_int
        add     %esp, 4
        jmp     L23
L19:    push    0
        call    L_println_int
        add     %esp, 4
        jmp     L20
L16:    push    0
        call    L_println_int
        add     %esp, 4
        jmp     L17
L13:    push    0
        call    L_println_int
        add     %esp, 4
        jmp     L14
L10:    push    0
        call    L_println_int
        add     %esp, 4
        jmp     L11
L1:     push    0
        call    L_println_int
        add     %esp, 4
        jmp     L2
L66:    leave
        ret
        .global LBS$Search
        .type LBS$Search, @function
LBS$Search:
        #args LOC 0, LOC 4
        enter   0, 0
L67:    mov     t8, 0
        mov     t9, 0
        mov     t1020, DWORD PTR [%ebp+8]
        mov     t1019, DWORD PTR [t1020+4]
        mov     t13, DWORD PTR [t1019-4]
        dec     t13
        mov     t10, 1
        mov     t14, 1
L24:    cmp     t14, 0
        je      L26
L25:    mov     t11, t10
        add     t11, t13
        push    t11
        push    DWORD PTR [%ebp+8]
        call    LBS$Div
        add     %esp, 8
        mov     t11, %eax
        mov     t1018, DWORD PTR [%ebp+8]
        mov     t1001, DWORD PTR [t1018+4]
        cmp     t11, 0
        jl      L29
L27:    cmp     t11, DWORD PTR [t1001-4]
        jl      L28
L29:    push    0
        call    L_raise
        add     %esp, 4
L28:    mov     t8, DWORD PTR [t11*4+t1001]
        cmp     DWORD PTR [%ebp+12], t8
        jl      L30
L31:    mov     t10, t11
        inc     t10
L32:    push    DWORD PTR [%ebp+12]
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LBS$Compare
        add     %esp, 12
        mov     t1016, %eax
        cmp     t1016, 0
        je      L34
L33:    mov     t14, 0
L35:    cmp     t13, t10
        jl      L36
L37:    mov     t12, 0
L38:    jmp     L24
L40:    mov     t9, 0
        jmp     L41
L36:    mov     t14, 0
        jmp     L38
L34:    mov     t14, 1
        jmp     L35
L30:    mov     t13, t11
        dec     t13
        jmp     L32
L26:    push    DWORD PTR [%ebp+12]
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LBS$Compare
        add     %esp, 12
        mov     t1017, %eax
        cmp     t1017, 0
        je      L40
L39:    mov     t9, 1
L41:    mov     %eax, t9
L68:    leave
        ret
        .global LBS$Div
        .type LBS$Div, @function
LBS$Div:
        #args LOC 0, LOC 4
        enter   0, 0
L69:    mov     t9, 0
        mov     t10, 0
        mov     t8, DWORD PTR [%ebp+12]
        dec     t8
L42:    cmp     t10, t8
        jl      L43
L44:    mov     %eax, t9
        jmp     L70
L43:    inc     t9
        add     t10, 2
        jmp     L42
L70:    leave
        ret
        .global LBS$Compare
        .type LBS$Compare, @function
LBS$Compare:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L71:    mov     t9, 0
        mov     t8, DWORD PTR [%ebp+16]
        inc     t8
        mov     t1021, DWORD PTR [%ebp+12]
        cmp     t1021, DWORD PTR [%ebp+16]
        jl      L48
L49:    cmp     DWORD PTR [%ebp+12], t8
        jl      L45
L46:    mov     t9, 0
L47:
L50:    mov     %eax, t9
        jmp     L72
L48:    mov     t9, 0
        jmp     L50
L45:    mov     t9, 1
        jmp     L47
L72:    leave
        ret
        .global LBS$Print
        .type LBS$Print, @function
LBS$Print:
        #args LOC 0
        enter   0, 0
L73:    mov     t8, 1
L51:    mov     t1023, DWORD PTR [%ebp+8]
        cmp     t8, DWORD PTR [t1023+8]
        jl      L52
L53:    push    99999
        call    L_println_int
        add     %esp, 4
        mov     %eax, 0
        jmp     L74
L52:    mov     t1022, DWORD PTR [%ebp+8]
        mov     t1002, DWORD PTR [t1022+4]
        cmp     t8, 0
        jl      L56
L54:    cmp     t8, DWORD PTR [t1002-4]
        jl      L55
L56:    push    0
        call    L_raise
        add     %esp, 4
L55:    push    DWORD PTR [t8*4+t1002]
        call    L_println_int
        add     %esp, 4
        inc     t8
        jmp     L51
L74:    leave
        ret
        .global LBS$Init
        .type LBS$Init, @function
LBS$Init:
        #args LOC 0, LOC 4
        enter   0, 0
L75:    mov     t1032, DWORD PTR [%ebp+8]
        mov     t1033, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1032+8], t1033
        mov     t1003, DWORD PTR [%ebp+12]
        mov     t1031, t1003
        add     t1031, 1
        mov     t1030, t1031
        sal     t1030, 2
        push    t1030
        call    L_halloc
        add     %esp, 4
        mov     t1004, %eax
        mov     DWORD PTR [t1004], t1003
        mov     t1029, t1004
        add     t1029, 4
        mov     t1028, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1028+4], t1029
        mov     t10, 1
        mov     t1027, DWORD PTR [%ebp+8]
        mov     t11, DWORD PTR [t1027+8]
        inc     t11
L57:    mov     t1026, DWORD PTR [%ebp+8]
        cmp     t10, DWORD PTR [t1026+8]
        jl      L58
L59:    mov     %eax, 0
        jmp     L76
L58:    mov     t8, t10
        sal     t8, 1
        mov     t9, -3
        add     t9, t11
        mov     t1025, DWORD PTR [%ebp+8]
        mov     t1005, DWORD PTR [t1025+4]
        cmp     t10, 0
        jl      L62
L60:    cmp     t10, DWORD PTR [t1005-4]
        jl      L61
L62:    push    0
        call    L_raise
        add     %esp, 4
L61:    mov     t1024, t8
        add     t1024, t9
        mov     DWORD PTR [t10*4+t1005], t1024
        inc     t10
        dec     t11
        jmp     L57
L76:    leave
        ret
