        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L76:    push    4
        call    L_halloc
        add     %esp, 4
        mov     t1001, %eax
        push    t1001
        call    LBT$Start
        add     %esp, 4
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L77:    leave
        ret
        .global LBT$Start
        .type LBT$Start, @function
LBT$Start:
        #args LOC 0
        enter   0, 0
L78:    push    24
        call    L_halloc
        add     %esp, 4
        mov     t10, %eax
        push    16
        push    t10
        call    LTree$Init
        add     %esp, 8
        mov     t8, %eax
        push    t10
        call    LTree$Print
        add     %esp, 4
        mov     t8, %eax
        push    100000000
        call    L_println_int
        add     %esp, 4
        push    8
        push    t10
        call    LTree$Insert
        add     %esp, 8
        mov     t8, %eax
        push    t10
        call    LTree$Print
        add     %esp, 4
        mov     t8, %eax
        push    24
        push    t10
        call    LTree$Insert
        add     %esp, 8
        mov     t8, %eax
        push    4
        push    t10
        call    LTree$Insert
        add     %esp, 8
        mov     t8, %eax
        push    12
        push    t10
        call    LTree$Insert
        add     %esp, 8
        mov     t8, %eax
        push    20
        push    t10
        call    LTree$Insert
        add     %esp, 8
        mov     t8, %eax
        push    28
        push    t10
        call    LTree$Insert
        add     %esp, 8
        mov     t8, %eax
        push    14
        push    t10
        call    LTree$Insert
        add     %esp, 8
        mov     t8, %eax
        push    t10
        call    LTree$Print
        add     %esp, 4
        mov     t8, %eax
        push    24
        push    t10
        call    LTree$Search
        add     %esp, 8
        mov     t1003, %eax
        push    t1003
        call    L_println_int
        add     %esp, 4
        push    12
        push    t10
        call    LTree$Search
        add     %esp, 8
        mov     t1004, %eax
        push    t1004
        call    L_println_int
        add     %esp, 4
        push    16
        push    t10
        call    LTree$Search
        add     %esp, 8
        mov     t1005, %eax
        push    t1005
        call    L_println_int
        add     %esp, 4
        push    50
        push    t10
        call    LTree$Search
        add     %esp, 8
        mov     t1006, %eax
        push    t1006
        call    L_println_int
        add     %esp, 4
        push    12
        push    t10
        call    LTree$Search
        add     %esp, 8
        mov     t1007, %eax
        push    t1007
        call    L_println_int
        add     %esp, 4
        push    12
        push    t10
        call    LTree$Delete
        add     %esp, 8
        mov     t8, %eax
        push    t10
        call    LTree$Print
        add     %esp, 4
        mov     t8, %eax
        push    12
        push    t10
        call    LTree$Search
        add     %esp, 8
        mov     t1008, %eax
        push    t1008
        call    L_println_int
        add     %esp, 4
        mov     %eax, 0
L79:    leave
        ret
        .global LTree$Init
        .type LTree$Init, @function
LTree$Init:
        #args LOC 0, LOC 4
        enter   0, 0
L80:    mov     t1038, DWORD PTR [%ebp+8]
        mov     t1039, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1038+12], t1039
        mov     t1037, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1037+4], 0
        mov     t1036, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1036+8], 0
        mov     %eax, 1
L81:    leave
        ret
        .global LTree$SetRight
        .type LTree$SetRight, @function
LTree$SetRight:
        #args LOC 0, LOC 4
        enter   0, 0
L82:    mov     t1040, DWORD PTR [%ebp+8]
        mov     t1041, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1040+20], t1041
        mov     %eax, 1
L83:    leave
        ret
        .global LTree$SetLeft
        .type LTree$SetLeft, @function
LTree$SetLeft:
        #args LOC 0, LOC 4
        enter   0, 0
L84:    mov     t1042, DWORD PTR [%ebp+8]
        mov     t1043, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1042+16], t1043
        mov     %eax, 1
L85:    leave
        ret
        .global LTree$GetRight
        .type LTree$GetRight, @function
LTree$GetRight:
        #args LOC 0
        enter   0, 0
L86:    mov     t1044, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1044+20]
L87:    leave
        ret
        .global LTree$GetLeft
        .type LTree$GetLeft, @function
LTree$GetLeft:
        #args LOC 0
        enter   0, 0
L88:    mov     t1045, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1045+16]
L89:    leave
        ret
        .global LTree$GetKey
        .type LTree$GetKey, @function
LTree$GetKey:
        #args LOC 0
        enter   0, 0
L90:    mov     t1046, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1046+12]
L91:    leave
        ret
        .global LTree$SetKey
        .type LTree$SetKey, @function
LTree$SetKey:
        #args LOC 0, LOC 4
        enter   0, 0
L92:    mov     t1047, DWORD PTR [%ebp+8]
        mov     t1048, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1047+12], t1048
        mov     %eax, 1
L93:    leave
        ret
        .global LTree$GetHas_Right
        .type LTree$GetHas_Right, @function
LTree$GetHas_Right:
        #args LOC 0
        enter   0, 0
L94:    mov     t1049, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1049+8]
L95:    leave
        ret
        .global LTree$GetHas_Left
        .type LTree$GetHas_Left, @function
LTree$GetHas_Left:
        #args LOC 0
        enter   0, 0
L96:    mov     t1050, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1050+4]
L97:    leave
        ret
        .global LTree$SetHas_Left
        .type LTree$SetHas_Left, @function
LTree$SetHas_Left:
        #args LOC 0, LOC 4
        enter   0, 0
L98:    mov     t1051, DWORD PTR [%ebp+8]
        mov     t1052, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1051+4], t1052
        mov     %eax, 1
L99:    leave
        ret
        .global LTree$SetHas_Right
        .type LTree$SetHas_Right, @function
LTree$SetHas_Right:
        #args LOC 0, LOC 4
        enter   0, 0
L100:   mov     t1053, DWORD PTR [%ebp+8]
        mov     t1054, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1053+8], t1054
        mov     %eax, 1
L101:   leave
        ret
        .global LTree$Compare
        .type LTree$Compare, @function
LTree$Compare:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
        jmp     L102
L3:     mov     t8, 0
        jmp     L5
L102:   mov     t8, 0
        mov     t9, DWORD PTR [%ebp+16]
        inc     t9
        mov     t1055, DWORD PTR [%ebp+12]
        cmp     t1055, DWORD PTR [%ebp+16]
        jl      L3
L4:     cmp     DWORD PTR [%ebp+12], t9
        jl      L0
L1:     mov     t8, 0
L2:
L5:     mov     %eax, t8
        jmp     L103
L0:     mov     t8, 1
        jmp     L2
L103:   leave
        ret
        .global LTree$Insert
        .type LTree$Insert, @function
LTree$Insert:
        #args LOC 0, LOC 4
        enter   0, 0
        jmp     L104
L8:     mov     %eax, 1
        jmp     L105
L15:    push    t9
        call    LTree$GetHas_Left
        add     %esp, 4
        mov     t1010, %eax
        cmp     t1010, 0
        je      L10
L9:     push    t9
        call    LTree$GetLeft
        add     %esp, 4
        mov     t9, %eax
        jmp     L11
L13:    mov     t8, 0
        push    1
        push    t9
        call    LTree$SetHas_Right
        add     %esp, 8
        mov     t12, %eax
        push    t11
        push    t9
        call    LTree$SetRight
        add     %esp, 8
        mov     t12, %eax
        jmp     L14
L104:   push    24
        call    L_halloc
        add     %esp, 4
        mov     t11, %eax
        push    DWORD PTR [%ebp+12]
        push    t11
        call    LTree$Init
        add     %esp, 8
        mov     t12, %eax
        mov     t9, DWORD PTR [%ebp+8]
        mov     t8, 1
L6:     cmp     t8, 0
        je      L8
L7:     push    t9
        call    LTree$GetKey
        add     %esp, 4
        mov     t10, %eax
        cmp     DWORD PTR [%ebp+12], t10
        jl      L15
L16:    push    t9
        call    LTree$GetHas_Right
        add     %esp, 4
        mov     t1009, %eax
        cmp     t1009, 0
        je      L13
L12:    push    t9
        call    LTree$GetRight
        add     %esp, 4
        mov     t9, %eax
L14:
L17:    jmp     L6
L10:    mov     t8, 0
        push    1
        push    t9
        call    LTree$SetHas_Left
        add     %esp, 8
        mov     t12, %eax
        push    t11
        push    t9
        call    LTree$SetLeft
        add     %esp, 8
        mov     t12, %eax
L11:    jmp     L17
L105:   leave
        ret
        .global LTree$Delete
        .type LTree$Delete, @function
LTree$Delete:
        #args LOC 0, LOC 4
        enter   0, 0
        jmp     L106
L37:    push    t9
        call    LTree$GetHas_Left
        add     %esp, 4
        mov     t1014, %eax
        cmp     t1014, 0
        je      L22
        jmp     L21
L34:    push    t9
        call    LTree$GetHas_Right
        add     %esp, 4
        mov     t1013, %eax
        cmp     t1013, 0
        je      L25
        jmp     L24
L32:    push    t9
        push    t14
        push    DWORD PTR [%ebp+8]
        call    LTree$Remove
        add     %esp, 12
        mov     t13, %eax
        jmp     L33
L30:    push    t9
        call    LTree$GetHas_Left
        add     %esp, 4
        mov     t1012, %eax
        cmp     t1012, 0
        je      L27
        jmp     L28
L27:    mov     t13, 1
        jmp     L29
L25:    mov     t8, 0
        jmp     L26
L24:    mov     t14, t9
        push    t9
        call    LTree$GetRight
        add     %esp, 4
        mov     t9, %eax
L26:    jmp     L36
L22:    mov     t8, 0
        jmp     L23
L21:    mov     t14, t9
        push    t9
        call    LTree$GetLeft
        add     %esp, 4
        mov     t9, %eax
L23:    jmp     L39
L20:    mov     %eax, t10
        jmp     L107
L106:   mov     t9, DWORD PTR [%ebp+8]
        mov     t14, DWORD PTR [%ebp+8]
        mov     t8, 1
        mov     t10, 0
        mov     t11, 1
L18:    cmp     t8, 0
        je      L20
L19:    push    t9
        call    LTree$GetKey
        add     %esp, 4
        mov     t12, %eax
        cmp     DWORD PTR [%ebp+12], t12
        jl      L37
L38:    cmp     t12, DWORD PTR [%ebp+12]
        jl      L34
L35:    cmp     t11, 0
        je      L32
L31:    push    t9
        call    LTree$GetHas_Right
        add     %esp, 4
        mov     t1011, %eax
        cmp     t1011, 0
        je      L30
L28:    push    t9
        push    t14
        push    DWORD PTR [%ebp+8]
        call    LTree$Remove
        add     %esp, 12
        mov     t13, %eax
L29:
L33:    mov     t10, 1
        mov     t8, 0
L36:
L39:    mov     t11, 0
        jmp     L18
L107:   leave
        ret
        .global LTree$Remove
        .type LTree$Remove, @function
LTree$Remove:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
        jmp     L108
L47:    push    DWORD PTR [%ebp+16]
        call    LTree$GetHas_Right
        add     %esp, 4
        mov     t1016, %eax
        cmp     t1016, 0
        je      L44
        jmp     L43
L44:    push    DWORD PTR [%ebp+16]
        call    LTree$GetKey
        add     %esp, 4
        mov     t8, %eax
        push    DWORD PTR [%ebp+12]
        call    LTree$GetLeft
        add     %esp, 4
        mov     t1017, %eax
        push    t1017
        call    LTree$GetKey
        add     %esp, 4
        mov     t9, %eax
        push    t9
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LTree$Compare
        add     %esp, 12
        mov     t1018, %eax
        cmp     t1018, 0
        je      L41
        jmp     L40
L43:    push    DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+8]
        call    LTree$RemoveRight
        add     %esp, 12
        mov     t10, %eax
        jmp     L45
L41:    push    0
        push    DWORD PTR [%ebp+12]
        call    LTree$SetHas_Right
        add     %esp, 8
        mov     t10, %eax
        jmp     L42
L40:    push    0
        push    DWORD PTR [%ebp+12]
        call    LTree$SetHas_Left
        add     %esp, 8
        mov     t10, %eax
L42:
L45:    jmp     L48
L108:   push    DWORD PTR [%ebp+16]
        call    LTree$GetHas_Left
        add     %esp, 4
        mov     t1015, %eax
        cmp     t1015, 0
        je      L47
L46:    push    DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+8]
        call    LTree$RemoveLeft
        add     %esp, 12
        mov     t10, %eax
L48:    mov     %eax, 1
L109:   leave
        ret
        .global LTree$RemoveRight
        .type LTree$RemoveRight, @function
LTree$RemoveRight:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
        jmp     L49
L51:    push    0
        push    DWORD PTR [%ebp+12]
        call    LTree$SetHas_Right
        add     %esp, 8
        mov     t8, %eax
        mov     %eax, 1
        jmp     L110
L49:    push    DWORD PTR [%ebp+16]
        call    LTree$GetHas_Right
        add     %esp, 4
        mov     t1019, %eax
        cmp     t1019, 0
        je      L51
L50:    mov     t1022, DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+16]
        call    LTree$GetRight
        add     %esp, 4
        mov     t1020, %eax
        push    t1020
        call    LTree$GetKey
        add     %esp, 4
        mov     t1021, %eax
        push    t1021
        push    t1022
        call    LTree$SetKey
        add     %esp, 8
        mov     t8, %eax
        mov     t1057, DWORD PTR [%ebp+16]
        mov     DWORD PTR [%ebp+12], t1057
        push    DWORD PTR [%ebp+16]
        call    LTree$GetRight
        add     %esp, 4
        mov     t1056, %eax
        mov     DWORD PTR [%ebp+16], t1056
        jmp     L49
L110:   leave
        ret
        .global LTree$RemoveLeft
        .type LTree$RemoveLeft, @function
LTree$RemoveLeft:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
        jmp     L52
L54:    push    0
        push    DWORD PTR [%ebp+12]
        call    LTree$SetHas_Left
        add     %esp, 8
        mov     t8, %eax
        mov     %eax, 1
        jmp     L111
L52:    push    DWORD PTR [%ebp+16]
        call    LTree$GetHas_Left
        add     %esp, 4
        mov     t1023, %eax
        cmp     t1023, 0
        je      L54
L53:    mov     t1026, DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+16]
        call    LTree$GetLeft
        add     %esp, 4
        mov     t1024, %eax
        push    t1024
        call    LTree$GetKey
        add     %esp, 4
        mov     t1025, %eax
        push    t1025
        push    t1026
        call    LTree$SetKey
        add     %esp, 8
        mov     t8, %eax
        mov     t1059, DWORD PTR [%ebp+16]
        mov     DWORD PTR [%ebp+12], t1059
        push    DWORD PTR [%ebp+16]
        call    LTree$GetLeft
        add     %esp, 4
        mov     t1058, %eax
        mov     DWORD PTR [%ebp+16], t1058
        jmp     L52
L111:   leave
        ret
        .global LTree$Search
        .type LTree$Search, @function
LTree$Search:
        #args LOC 0, LOC 4
        enter   0, 0
        jmp     L112
L67:    push    t9
        call    LTree$GetHas_Left
        add     %esp, 4
        mov     t1028, %eax
        cmp     t1028, 0
        je      L59
        jmp     L58
L64:    push    t9
        call    LTree$GetHas_Right
        add     %esp, 4
        mov     t1027, %eax
        cmp     t1027, 0
        je      L62
        jmp     L61
L62:    mov     t8, 0
        jmp     L63
L61:    push    t9
        call    LTree$GetRight
        add     %esp, 4
        mov     t9, %eax
L63:    jmp     L66
L59:    mov     t8, 0
        jmp     L60
L58:    push    t9
        call    LTree$GetLeft
        add     %esp, 4
        mov     t9, %eax
L60:    jmp     L69
L57:    mov     %eax, t10
        jmp     L113
L112:   mov     t9, DWORD PTR [%ebp+8]
        mov     t8, 1
        mov     t10, 0
L55:    cmp     t8, 0
        je      L57
L56:    push    t9
        call    LTree$GetKey
        add     %esp, 4
        mov     t11, %eax
        cmp     DWORD PTR [%ebp+12], t11
        jl      L67
L68:    cmp     t11, DWORD PTR [%ebp+12]
        jl      L64
L65:    mov     t10, 1
        mov     t8, 0
L66:
L69:    jmp     L55
L113:   leave
        ret
        .global LTree$Print
        .type LTree$Print, @function
LTree$Print:
        #args LOC 0
        enter   0, 0
L114:   mov     t8, DWORD PTR [%ebp+8]
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LTree$RecPrint
        add     %esp, 8
        mov     t9, %eax
        mov     %eax, 1
L115:   leave
        ret
        .global LTree$RecPrint
        .type LTree$RecPrint, @function
LTree$RecPrint:
        #args LOC 0, LOC 4
        enter   0, 0
        jmp     L116
L74:    mov     t8, 1
        jmp     L75
L71:    mov     t8, 1
        jmp     L72
L116:   push    DWORD PTR [%ebp+12]
        call    LTree$GetHas_Left
        add     %esp, 4
        mov     t1029, %eax
        cmp     t1029, 0
        je      L71
L70:    mov     t1031, DWORD PTR [%ebp+8]
        push    DWORD PTR [%ebp+12]
        call    LTree$GetLeft
        add     %esp, 4
        mov     t1030, %eax
        push    t1030
        push    t1031
        call    LTree$RecPrint
        add     %esp, 8
        mov     t8, %eax
L72:    push    DWORD PTR [%ebp+12]
        call    LTree$GetKey
        add     %esp, 4
        mov     t1032, %eax
        push    t1032
        call    L_println_int
        add     %esp, 4
        push    DWORD PTR [%ebp+12]
        call    LTree$GetHas_Right
        add     %esp, 4
        mov     t1033, %eax
        cmp     t1033, 0
        je      L74
L73:    mov     t1035, DWORD PTR [%ebp+8]
        push    DWORD PTR [%ebp+12]
        call    LTree$GetRight
        add     %esp, 4
        mov     t1034, %eax
        push    t1034
        push    t1035
        call    LTree$RecPrint
        add     %esp, 8
        mov     t8, %eax
L75:    mov     %eax, 1
L117:   leave
        ret
