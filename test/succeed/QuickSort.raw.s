        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L83:    push    12
        call    L_halloc
        add     %esp, 4
        mov     t1029, %eax
        push    10
        push    t1029
        call    LQS$Start
        add     %esp, 8
        mov     t1030, %eax
        push    t1030
        call    L_println_int
        add     %esp, 4
L84:    leave
        ret
        .global LQS$Start
        .type LQS$Start, @function
LQS$Start:
        #args LOC 0, LOC 4
        enter   0, 0
L85:    push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+8]
        call    LQS$Init
        add     %esp, 8
        mov     t8, %eax
        push    DWORD PTR [%ebp+8]
        call    LQS$Print
        add     %esp, 4
        mov     t8, %eax
        push    9999
        call    L_println_int
        add     %esp, 4
        mov     t1031, DWORD PTR [%ebp+8]
        mov     t8, DWORD PTR [t1031+8]
        dec     t8
        push    t8
        push    0
        push    DWORD PTR [%ebp+8]
        call    LQS$Sort
        add     %esp, 12
        mov     t8, %eax
        push    DWORD PTR [%ebp+8]
        call    LQS$Print
        add     %esp, 4
        mov     t8, %eax
        mov     %eax, 0
L86:    leave
        ret
        .global LQS$Sort
        .type LQS$Sort, @function
LQS$Sort:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L87:    mov     t14, 0
        mov     t1050, DWORD PTR [%ebp+12]
        cmp     t1050, DWORD PTR [%ebp+16]
        jl      L54
L55:    mov     t13, 0
L56:    mov     %eax, 0
        jmp     L88
L8:     mov     t10, 1
        jmp     L15
L54:    mov     t1049, DWORD PTR [%ebp+8]
        mov     t1001, DWORD PTR [t1049+4]
        mov     t1002, DWORD PTR [%ebp+16]
        cmp     t1002, 0
        jl      L2
        jmp     L0
L5:     mov     t1048, DWORD PTR [%ebp+8]
        mov     t1010, DWORD PTR [t1048+4]
        cmp     t12, 0
        jl      L44
L42:    cmp     t12, DWORD PTR [t1010-4]
        jl      L43
L44:    push    0
        call    L_raise
        add     %esp, 4
L43:    mov     t1047, DWORD PTR [%ebp+8]
        mov     t1009, DWORD PTR [t1047+4]
        cmp     t11, 0
        jl      L41
L39:    cmp     t11, DWORD PTR [t1009-4]
        jl      L40
L41:    push    0
        call    L_raise
        add     %esp, 4
L40:    mov     t1046, DWORD PTR [t11*4+t1009]
        mov     DWORD PTR [t12*4+t1010], t1046
        mov     t1045, DWORD PTR [%ebp+8]
        mov     t1013, DWORD PTR [t1045+4]
        cmp     t11, 0
        jl      L50
L48:    cmp     t11, DWORD PTR [t1013-4]
        jl      L49
L50:    push    0
        call    L_raise
        add     %esp, 4
L49:    mov     t1044, DWORD PTR [%ebp+8]
        mov     t1011, DWORD PTR [t1044+4]
        mov     t1012, DWORD PTR [%ebp+16]
        cmp     t1012, 0
        jl      L47
L45:    cmp     t1012, DWORD PTR [t1011-4]
        jl      L46
L47:    push    0
        call    L_raise
        add     %esp, 4
L46:    mov     t1043, DWORD PTR [t1012*4+t1011]
        mov     DWORD PTR [t11*4+t1013], t1043
        mov     t1042, DWORD PTR [%ebp+8]
        mov     t1014, DWORD PTR [t1042+4]
        mov     t1015, DWORD PTR [%ebp+16]
        cmp     t1015, 0
        jl      L53
L51:    cmp     t1015, DWORD PTR [t1014-4]
        jl      L52
L53:    push    0
        call    L_raise
        add     %esp, 4
L52:    mov     DWORD PTR [t1015*4+t1014], t14
        mov     t1041, t11
        dec     t1041
        push    t1041
        push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+8]
        call    LQS$Sort
        add     %esp, 12
        mov     t13, %eax
        mov     t1040, t11
        inc     t1040
        push    DWORD PTR [%ebp+16]
        push    t1040
        push    DWORD PTR [%ebp+8]
        call    LQS$Sort
        add     %esp, 12
        mov     t13, %eax
        jmp     L56
L36:    mov     t9, 0
        jmp     L38
L21:    mov     t10, 1
        jmp     L23
L17:    mov     t1039, DWORD PTR [%ebp+8]
        mov     t1005, DWORD PTR [t1039+4]
        cmp     t11, 0
        jl      L26
L24:    cmp     t11, DWORD PTR [t1005-4]
        jl      L25
L26:    push    0
        call    L_raise
        add     %esp, 4
L25:    mov     t14, DWORD PTR [t11*4+t1005]
        mov     t1038, DWORD PTR [%ebp+8]
        mov     t1007, DWORD PTR [t1038+4]
        cmp     t11, 0
        jl      L32
L30:    cmp     t11, DWORD PTR [t1007-4]
        jl      L31
L32:    push    0
        call    L_raise
        add     %esp, 4
L31:    mov     t1037, DWORD PTR [%ebp+8]
        mov     t1006, DWORD PTR [t1037+4]
        cmp     t12, 0
        jl      L29
L27:    cmp     t12, DWORD PTR [t1006-4]
        jl      L28
L29:    push    0
        call    L_raise
        add     %esp, 4
L28:    mov     t1036, DWORD PTR [t12*4+t1006]
        mov     DWORD PTR [t11*4+t1007], t1036
        mov     t1035, DWORD PTR [%ebp+8]
        mov     t1008, DWORD PTR [t1035+4]
        cmp     t12, 0
        jl      L35
L33:    cmp     t12, DWORD PTR [t1008-4]
        jl      L34
L35:    push    0
        call    L_raise
        add     %esp, 4
L34:    mov     DWORD PTR [t12*4+t1008], t14
        mov     t1034, t11
        inc     t1034
        cmp     t12, t1034
        jl      L36
L37:    mov     t9, 1
L38:    jmp     L3
L15:    cmp     t10, 0
        je      L17
L16:    dec     t12
        mov     t1033, DWORD PTR [%ebp+8]
        mov     t1004, DWORD PTR [t1033+4]
        cmp     t12, 0
        jl      L20
L18:    cmp     t12, DWORD PTR [t1004-4]
        jl      L19
L20:    push    0
        call    L_raise
        add     %esp, 4
L19:    mov     t8, DWORD PTR [t12*4+t1004]
        cmp     t15, t8
        jl      L21
L22:    mov     t10, 0
L23:    jmp     L15
L12:    mov     t10, 1
        jmp     L14
L0:     cmp     t1002, DWORD PTR [t1001-4]
        jl      L1
L2:     push    0
        call    L_raise
        add     %esp, 4
L1:     mov     t15, DWORD PTR [t1002*4+t1001]
        mov     t11, DWORD PTR [%ebp+12]
        dec     t11
        mov     t12, DWORD PTR [%ebp+16]
        mov     t9, 1
L3:     cmp     t9, 0
        je      L5
L4:     mov     t10, 1
L6:     cmp     t10, 0
        je      L8
L7:     inc     t11
        mov     t1032, DWORD PTR [%ebp+8]
        mov     t1003, DWORD PTR [t1032+4]
        cmp     t11, 0
        jl      L11
L9:     cmp     t11, DWORD PTR [t1003-4]
        jl      L10
L11:    push    0
        call    L_raise
        add     %esp, 4
L10:    mov     t8, DWORD PTR [t11*4+t1003]
        cmp     t8, t15
        jl      L12
L13:    mov     t10, 0
L14:    jmp     L6
L88:    leave
        ret
        .global LQS$Print
        .type LQS$Print, @function
LQS$Print:
        #args LOC 0
        enter   0, 0
L89:    mov     t8, 0
L57:    mov     t1052, DWORD PTR [%ebp+8]
        cmp     t8, DWORD PTR [t1052+8]
        jl      L58
L59:    mov     %eax, 0
        jmp     L90
L58:    mov     t1051, DWORD PTR [%ebp+8]
        mov     t1016, DWORD PTR [t1051+4]
        cmp     t8, 0
        jl      L62
L60:    cmp     t8, DWORD PTR [t1016-4]
        jl      L61
L62:    push    0
        call    L_raise
        add     %esp, 4
L61:    push    DWORD PTR [t8*4+t1016]
        call    L_println_int
        add     %esp, 4
        inc     t8
        jmp     L57
L90:    leave
        ret
        .global LQS$Init
        .type LQS$Init, @function
LQS$Init:
        #args LOC 0, LOC 4
        enter   0, 0
L91:    mov     t1067, DWORD PTR [%ebp+8]
        mov     t1068, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1067+8], t1068
        mov     t1017, DWORD PTR [%ebp+12]
        mov     t1066, t1017
        add     t1066, 1
        mov     t1065, t1066
        sal     t1065, 2
        push    t1065
        call    L_halloc
        add     %esp, 4
        mov     t1018, %eax
        mov     DWORD PTR [t1018], t1017
        mov     t1064, t1018
        add     t1064, 4
        mov     t1063, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1063+4], t1064
        mov     t1062, DWORD PTR [%ebp+8]
        mov     t1019, DWORD PTR [t1062+4]
        cmp     DWORD PTR [t1019-4], 0
        jg      L63
L64:    push    0
        call    L_raise
        add     %esp, 4
L63:    mov     DWORD PTR [t1019], 20
        mov     t1061, DWORD PTR [%ebp+8]
        mov     t1020, DWORD PTR [t1061+4]
        cmp     DWORD PTR [t1020-4], 1
        jg      L65
L66:    push    0
        call    L_raise
        add     %esp, 4
L65:    mov     DWORD PTR [t1020+4], 7
        mov     t1060, DWORD PTR [%ebp+8]
        mov     t1021, DWORD PTR [t1060+4]
        cmp     DWORD PTR [t1021-4], 2
        jg      L67
L68:    push    0
        call    L_raise
        add     %esp, 4
L67:    mov     DWORD PTR [t1021+8], 12
        mov     t1059, DWORD PTR [%ebp+8]
        mov     t1022, DWORD PTR [t1059+4]
        cmp     DWORD PTR [t1022-4], 3
        jg      L69
L70:    push    0
        call    L_raise
        add     %esp, 4
L69:    mov     DWORD PTR [t1022+12], 18
        mov     t1058, DWORD PTR [%ebp+8]
        mov     t1023, DWORD PTR [t1058+4]
        cmp     DWORD PTR [t1023-4], 4
        jg      L71
L72:    push    0
        call    L_raise
        add     %esp, 4
L71:    mov     DWORD PTR [t1023+16], 2
        mov     t1057, DWORD PTR [%ebp+8]
        mov     t1024, DWORD PTR [t1057+4]
        cmp     DWORD PTR [t1024-4], 5
        jg      L73
L74:    push    0
        call    L_raise
        add     %esp, 4
L73:    mov     DWORD PTR [t1024+20], 11
        mov     t1056, DWORD PTR [%ebp+8]
        mov     t1025, DWORD PTR [t1056+4]
        cmp     DWORD PTR [t1025-4], 6
        jg      L75
L76:    push    0
        call    L_raise
        add     %esp, 4
L75:    mov     DWORD PTR [t1025+24], 6
        mov     t1055, DWORD PTR [%ebp+8]
        mov     t1026, DWORD PTR [t1055+4]
        cmp     DWORD PTR [t1026-4], 7
        jg      L77
L78:    push    0
        call    L_raise
        add     %esp, 4
L77:    mov     DWORD PTR [t1026+28], 9
        mov     t1054, DWORD PTR [%ebp+8]
        mov     t1027, DWORD PTR [t1054+4]
        cmp     DWORD PTR [t1027-4], 8
        jg      L79
L80:    push    0
        call    L_raise
        add     %esp, 4
L79:    mov     DWORD PTR [t1027+32], 19
        mov     t1053, DWORD PTR [%ebp+8]
        mov     t1028, DWORD PTR [t1053+4]
        cmp     DWORD PTR [t1028-4], 9
        jg      L81
L82:    push    0
        call    L_raise
        add     %esp, 4
L81:    mov     DWORD PTR [t1028+36], 5
        mov     %eax, 0
L92:    leave
        ret
