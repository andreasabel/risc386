        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L43:    push    4
        call    L_halloc
        add     %esp, 4
        mov     t1001, %eax
        push    t1001
        call    LLL$Start
        add     %esp, 4
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L44:    leave
        ret
        .global LElement$Init
        .type LElement$Init, @function
LElement$Init:
        #args LOC 0, LOC 4, LOC 8, LOC 12
        enter   0, 0
L45:    mov     t1017, DWORD PTR [%ebp+8]
        mov     t1018, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1017+4], t1018
        mov     t1015, DWORD PTR [%ebp+8]
        mov     t1016, DWORD PTR [%ebp+16]
        mov     DWORD PTR [t1015+12], t1016
        mov     t1013, DWORD PTR [%ebp+8]
        mov     t1014, DWORD PTR [%ebp+20]
        mov     DWORD PTR [t1013+8], t1014
        mov     %eax, 1
L46:    leave
        ret
        .global LElement$GetAge
        .type LElement$GetAge, @function
LElement$GetAge:
        #args LOC 0
        enter   0, 0
L47:    mov     t1019, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1019+4]
L48:    leave
        ret
        .global LElement$GetSalary
        .type LElement$GetSalary, @function
LElement$GetSalary:
        #args LOC 0
        enter   0, 0
L49:    mov     t1020, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1020+12]
L50:    leave
        ret
        .global LElement$GetMarried
        .type LElement$GetMarried, @function
LElement$GetMarried:
        #args LOC 0
        enter   0, 0
L51:    mov     t1021, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1021+8]
L52:    leave
        ret
        .global LElement$Equal
        .type LElement$Equal, @function
LElement$Equal:
        #args LOC 0, LOC 4
        enter   0, 0
        jmp     L53
L7:     push    DWORD PTR [%ebp+12]
        call    LElement$GetMarried
        add     %esp, 4
        mov     t1005, %eax
        cmp     t1005, 0
        je      L4
        jmp     L3
L53:    mov     t11, 1
        push    DWORD PTR [%ebp+12]
        call    LElement$GetAge
        add     %esp, 4
        mov     t8, %eax
        mov     t1024, DWORD PTR [%ebp+8]
        push    DWORD PTR [t1024+4]
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LElement$Compare
        add     %esp, 12
        mov     t1003, %eax
        cmp     t1003, 0
        je      L13
L12:    push    DWORD PTR [%ebp+12]
        call    LElement$GetSalary
        add     %esp, 4
        mov     t9, %eax
        mov     t1023, DWORD PTR [%ebp+8]
        push    DWORD PTR [t1023+12]
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LElement$Compare
        add     %esp, 12
        mov     t1004, %eax
        cmp     t1004, 0
        je      L10
L9:     mov     t1022, DWORD PTR [%ebp+8]
        cmp     DWORD PTR [t1022+8], 0
        je      L7
L6:     push    DWORD PTR [%ebp+12]
        call    LElement$GetMarried
        add     %esp, 4
        mov     t1006, %eax
        cmp     t1006, 0
        je      L1
L0:     mov     t10, 0
L2:
L8:
L11:
L14:    mov     %eax, t11
        jmp     L54
L4:     mov     t10, 0
        jmp     L5
L3:     mov     t11, 0
L5:     jmp     L8
L13:    mov     t11, 0
        jmp     L14
L10:    mov     t11, 0
        jmp     L11
L1:     mov     t11, 0
        jmp     L2
L54:    leave
        ret
        .global LElement$Compare
        .type LElement$Compare, @function
LElement$Compare:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L55:    mov     t9, 0
        mov     t8, DWORD PTR [%ebp+16]
        inc     t8
        mov     t1025, DWORD PTR [%ebp+12]
        cmp     t1025, DWORD PTR [%ebp+16]
        jl      L18
L19:    cmp     DWORD PTR [%ebp+12], t8
        jl      L15
L16:    mov     t9, 0
L17:
L20:    mov     %eax, t9
        jmp     L56
L18:    mov     t9, 0
        jmp     L20
L15:    mov     t9, 1
        jmp     L17
L56:    leave
        ret
        .global LList$Init
        .type LList$Init, @function
LList$Init:
        #args LOC 0
        enter   0, 0
L57:    mov     t1026, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1026+8], 1
        mov     %eax, 1
L58:    leave
        ret
        .global LList$InitNew
        .type LList$InitNew, @function
LList$InitNew:
        #args LOC 0, LOC 4, LOC 8, LOC 12
        enter   0, 0
L59:    mov     t1031, DWORD PTR [%ebp+8]
        mov     t1032, DWORD PTR [%ebp+20]
        mov     DWORD PTR [t1031+8], t1032
        mov     t1029, DWORD PTR [%ebp+8]
        mov     t1030, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1029+4], t1030
        mov     t1027, DWORD PTR [%ebp+8]
        mov     t1028, DWORD PTR [%ebp+16]
        mov     DWORD PTR [t1027+12], t1028
        mov     %eax, 1
L60:    leave
        ret
        .global LList$Insert
        .type LList$Insert, @function
LList$Insert:
        #args LOC 0, LOC 4
        enter   0, 0
L61:    mov     t9, DWORD PTR [%ebp+8]
        push    16
        call    L_halloc
        add     %esp, 4
        mov     t8, %eax
        push    0
        push    t9
        push    DWORD PTR [%ebp+12]
        push    t8
        call    LList$InitNew
        add     %esp, 16
        mov     t10, %eax
        mov     %eax, t8
L62:    leave
        ret
        .global LList$SetNext
        .type LList$SetNext, @function
LList$SetNext:
        #args LOC 0, LOC 4
        enter   0, 0
L63:    mov     t1033, DWORD PTR [%ebp+8]
        mov     t1034, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1033+12], t1034
        mov     %eax, 1
L64:    leave
        ret
        .global LList$Delete
        .type LList$Delete, @function
LList$Delete:
        #args LOC 0, LOC 4
        enter   0, 0
L65:    mov     t11, DWORD PTR [%ebp+8]
        mov     t14, 0
        mov     t9, -1
        mov     t8, DWORD PTR [%ebp+8]
        mov     t13, DWORD PTR [%ebp+8]
        mov     t1035, DWORD PTR [%ebp+8]
        mov     t16, DWORD PTR [t1035+8]
L21:    cmp     t16, 0
        je      L33
L23:    mov     %eax, t11
        jmp     L66
L33:    cmp     t14, 0
        je      L22
        jmp     L23
L31:    mov     t13, t8
        push    t8
        call    LList$GetNext
        add     %esp, 4
        mov     t8, %eax
        push    t8
        call    LList$GetEnd
        add     %esp, 4
        mov     t16, %eax
        mov     t9, 1
        jmp     L32
L28:    mov     t12, 0
        jmp     L29
L24:    push    t8
        call    LList$GetNext
        add     %esp, 4
        mov     t11, %eax
        jmp     L26
L22:    push    t8
        call    LList$GetElem
        add     %esp, 4
        mov     t15, %eax
        push    t15
        push    DWORD PTR [%ebp+12]
        call    LElement$Equal
        add     %esp, 8
        mov     t1007, %eax
        cmp     t1007, 0
        je      L28
L27:    mov     t14, 1
        cmp     t9, 0
        jl      L24
L25:    push    -555
        call    L_println_int
        add     %esp, 4
        push    t8
        call    LList$GetNext
        add     %esp, 4
        mov     t1008, %eax
        push    t1008
        push    t13
        call    LList$SetNext
        add     %esp, 8
        mov     t10, %eax
        push    -555
        call    L_println_int
        add     %esp, 4
L26:
L29:    cmp     t14, 0
        je      L31
L30:    mov     t12, 0
L32:    jmp     L21
L66:    leave
        ret
        .global LList$Search
        .type LList$Search, @function
LList$Search:
        #args LOC 0, LOC 4
        enter   0, 0
L67:    mov     t9, 0
        mov     t8, DWORD PTR [%ebp+8]
        mov     t1036, DWORD PTR [%ebp+8]
        mov     t12, DWORD PTR [t1036+8]
L34:    cmp     t12, 0
        je      L35
L36:    mov     %eax, t9
        jmp     L68
L38:    mov     t10, 0
        jmp     L39
L35:    push    t8
        call    LList$GetElem
        add     %esp, 4
        mov     t11, %eax
        push    t11
        push    DWORD PTR [%ebp+12]
        call    LElement$Equal
        add     %esp, 8
        mov     t1009, %eax
        cmp     t1009, 0
        je      L38
L37:    mov     t9, 1
L39:    push    t8
        call    LList$GetNext
        add     %esp, 4
        mov     t8, %eax
        push    t8
        call    LList$GetEnd
        add     %esp, 4
        mov     t12, %eax
        jmp     L34
L68:    leave
        ret
        .global LList$GetEnd
        .type LList$GetEnd, @function
LList$GetEnd:
        #args LOC 0
        enter   0, 0
L69:    mov     t1037, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1037+8]
L70:    leave
        ret
        .global LList$GetElem
        .type LList$GetElem, @function
LList$GetElem:
        #args LOC 0
        enter   0, 0
L71:    mov     t1038, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1038+4]
L72:    leave
        ret
        .global LList$GetNext
        .type LList$GetNext, @function
LList$GetNext:
        #args LOC 0
        enter   0, 0
L73:    mov     t1039, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1039+12]
L74:    leave
        ret
        .global LList$Print
        .type LList$Print, @function
LList$Print:
        #args LOC 0
        enter   0, 0
L75:    mov     t8, DWORD PTR [%ebp+8]
        mov     t1040, DWORD PTR [%ebp+8]
        mov     t10, DWORD PTR [t1040+8]
L40:    cmp     t10, 0
        je      L41
L42:    mov     %eax, 1
        jmp     L76
L41:    push    t8
        call    LList$GetElem
        add     %esp, 4
        mov     t9, %eax
        push    t9
        call    LElement$GetAge
        add     %esp, 4
        mov     t1010, %eax
        push    t1010
        call    L_println_int
        add     %esp, 4
        push    t8
        call    LList$GetNext
        add     %esp, 4
        mov     t8, %eax
        push    t8
        call    LList$GetEnd
        add     %esp, 4
        mov     t10, %eax
        jmp     L40
L76:    leave
        ret
        .global LLL$Start
        .type LLL$Start, @function
LLL$Start:
        #args LOC 0
        enter   0, 0
L77:    push    16
        call    L_halloc
        add     %esp, 4
        mov     t13, %eax
        push    t13
        call    LList$Init
        add     %esp, 4
        mov     t8, %eax
        mov     t12, t13
        push    t12
        call    LList$Init
        add     %esp, 4
        mov     t8, %eax
        push    t12
        call    LList$Print
        add     %esp, 4
        mov     t8, %eax
        push    16
        call    L_halloc
        add     %esp, 4
        mov     t9, %eax
        push    0
        push    37000
        push    25
        push    t9
        call    LElement$Init
        add     %esp, 16
        mov     t8, %eax
        push    t9
        push    t12
        call    LList$Insert
        add     %esp, 8
        mov     t12, %eax
        push    t12
        call    LList$Print
        add     %esp, 4
        mov     t8, %eax
        push    10000000
        call    L_println_int
        add     %esp, 4
        push    16
        call    L_halloc
        add     %esp, 4
        mov     t9, %eax
        push    1
        push    42000
        push    39
        push    t9
        call    LElement$Init
        add     %esp, 16
        mov     t8, %eax
        mov     t10, t9
        push    t9
        push    t12
        call    LList$Insert
        add     %esp, 8
        mov     t12, %eax
        push    t12
        call    LList$Print
        add     %esp, 4
        mov     t8, %eax
        push    10000000
        call    L_println_int
        add     %esp, 4
        push    16
        call    L_halloc
        add     %esp, 4
        mov     t9, %eax
        push    0
        push    34000
        push    22
        push    t9
        call    LElement$Init
        add     %esp, 16
        mov     t8, %eax
        push    t9
        push    t12
        call    LList$Insert
        add     %esp, 8
        mov     t12, %eax
        push    t12
        call    LList$Print
        add     %esp, 4
        mov     t8, %eax
        push    16
        call    L_halloc
        add     %esp, 4
        mov     t11, %eax
        push    0
        push    34000
        push    27
        push    t11
        call    LElement$Init
        add     %esp, 16
        mov     t8, %eax
        push    t10
        push    t12
        call    LList$Search
        add     %esp, 8
        mov     t1011, %eax
        push    t1011
        call    L_println_int
        add     %esp, 4
        push    t11
        push    t12
        call    LList$Search
        add     %esp, 8
        mov     t1012, %eax
        push    t1012
        call    L_println_int
        add     %esp, 4
        push    10000000
        call    L_println_int
        add     %esp, 4
        push    16
        call    L_halloc
        add     %esp, 4
        mov     t9, %eax
        push    0
        push    35000
        push    28
        push    t9
        call    LElement$Init
        add     %esp, 16
        mov     t8, %eax
        push    t9
        push    t12
        call    LList$Insert
        add     %esp, 8
        mov     t12, %eax
        push    t12
        call    LList$Print
        add     %esp, 4
        mov     t8, %eax
        push    2220000
        call    L_println_int
        add     %esp, 4
        push    t10
        push    t12
        call    LList$Delete
        add     %esp, 8
        mov     t12, %eax
        push    t12
        call    LList$Print
        add     %esp, 4
        mov     t8, %eax
        push    33300000
        call    L_println_int
        add     %esp, 4
        push    t9
        push    t12
        call    LList$Delete
        add     %esp, 8
        mov     t12, %eax
        push    t12
        call    LList$Print
        add     %esp, 4
        mov     t8, %eax
        push    44440000
        call    L_println_int
        add     %esp, 4
        mov     %eax, 0
L78:    leave
        ret
