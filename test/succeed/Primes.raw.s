        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L47:    push    12
        call    L_halloc
        add     %esp, 4
        mov     t1010, %eax
        push    22
        push    t1010
        call    LPrimesClass$test_it
        add     %esp, 8
        mov     t1011, %eax
        push    t1011
        call    L_println_int
        add     %esp, 4
L48:    leave
        ret
        .global LPrimesClass$eq
        .type LPrimesClass$eq, @function
LPrimesClass$eq:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L49:    mov     t1001, 1
        mov     t1025, DWORD PTR [%ebp+12]
        cmp     t1025, DWORD PTR [%ebp+16]
        jge     L0
L1:     mov     t1001, 0
L0:     mov     t1003, t1001
        cmp     t1003, 0
        je      L4
L5:     mov     t1002, 1
        mov     t1024, DWORD PTR [%ebp+16]
        cmp     t1024, DWORD PTR [%ebp+12]
        jge     L2
L3:     mov     t1002, 0
L2:     mov     t1003, t1002
L4:     mov     %eax, t1003
L50:    leave
        ret
        .global LPrimesClass$div
        .type LPrimesClass$div, @function
LPrimesClass$div:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
        jmp     L51
L9:     mov     t8, 0
        jmp     L11
L7:     mov     t1027, DWORD PTR [%ebp+12]
        sub     t1027, DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+16]
        push    t1027
        push    DWORD PTR [%ebp+8]
        call    LPrimesClass$div
        add     %esp, 12
        mov     t1013, %eax
        mov     t8, t1013
        inc     t8
        jmp     L8
L51:    mov     t1026, DWORD PTR [%ebp+12]
        cmp     t1026, DWORD PTR [%ebp+16]
        jl      L9
L10:    push    1
        push    DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+8]
        call    LPrimesClass$eq
        add     %esp, 12
        mov     t1012, %eax
        cmp     t1012, 0
        je      L7
L6:     mov     t8, DWORD PTR [%ebp+12]
L8:
L11:    mov     %eax, t8
L52:    leave
        ret
        .global LPrimesClass$rem
        .type LPrimesClass$rem, @function
LPrimesClass$rem:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L53:    mov     t1016, DWORD PTR [%ebp+16]
        mov     t1015, DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+8]
        call    LPrimesClass$div
        add     %esp, 12
        mov     t1014, %eax
        mov     %eax, t1015
        imul    t1014
        mov     t1028, %eax
        mov     %eax, t1016
        sub     %eax, t1028
L54:    leave
        ret
        .global LPrimesClass$dividess
        .type LPrimesClass$dividess, @function
LPrimesClass$dividess:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L55:    mov     t1020, DWORD PTR [%ebp+8]
        mov     t1019, DWORD PTR [%ebp+16]
        mov     t1018, DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+8]
        call    LPrimesClass$div
        add     %esp, 12
        mov     t1017, %eax
        mov     %eax, t1018
        imul    t1017
        mov     t1029, %eax
        push    t1029
        push    t1019
        push    t1020
        call    LPrimesClass$eq
        add     %esp, 12
        mov     %eax, %eax
L56:    leave
        ret
        .global LPrimesClass$divides
        .type LPrimesClass$divides, @function
LPrimesClass$divides:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L57:    mov     t9, 1
        mov     t8, 0
L12:    cmp     t8, 0
        je      L21
L14:    mov     %eax, t8
        jmp     L58
L21:    cmp     t9, DWORD PTR [%ebp+16]
        jl      L13
        jmp     L14
L18:    inc     t9
        jmp     L20
L15:    mov     t9, DWORD PTR [%ebp+16]
        jmp     L17
L13:    mov     %eax, t9
        imul    DWORD PTR [%ebp+12]
        mov     t1031, %eax
        cmp     t1031, DWORD PTR [%ebp+16]
        jl      L18
L19:    mov     %eax, t9
        imul    DWORD PTR [%ebp+12]
        mov     t1030, %eax
        cmp     DWORD PTR [%ebp+16], t1030
        jl      L15
L16:    mov     t8, 1
L17:
L20:    jmp     L12
L58:    leave
        ret
        .global LPrimesClass$hcf
        .type LPrimesClass$hcf, @function
LPrimesClass$hcf:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L59:    mov     t1033, DWORD PTR [%ebp+12]
        cmp     t1033, DWORD PTR [%ebp+16]
        jl      L25
L26:    cmp     DWORD PTR [%ebp+16], 1
        jl      L22
L23:    mov     t1032, DWORD PTR [%ebp+12]
        sub     t1032, DWORD PTR [%ebp+16]
        push    t1032
        push    DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+8]
        call    LPrimesClass$hcf
        add     %esp, 12
        mov     t8, %eax
L24:
L27:    mov     %eax, t8
        jmp     L60
L25:    push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+16]
        push    DWORD PTR [%ebp+8]
        call    LPrimesClass$hcf
        add     %esp, 12
        mov     t8, %eax
        jmp     L27
L22:    mov     t8, DWORD PTR [%ebp+12]
        jmp     L24
L60:    leave
        ret
        .global LPrimesClass$isprime
        .type LPrimesClass$isprime, @function
LPrimesClass$isprime:
        #args LOC 0, LOC 4
        enter   0, 0
L61:    mov     t9, 1
        mov     t8, 0
L28:    cmp     t9, 0
        je      L30
L37:    mov     t1035, DWORD PTR [%ebp+8]
        cmp     t8, DWORD PTR [t1035+4]
        jl      L36
L30:    mov     %eax, t9
        jmp     L62
L36:    cmp     t8, DWORD PTR [%ebp+12]
        jl      L29
        jmp     L30
L29:    mov     t1005, t9
        cmp     t1005, 0
        je      L34
L35:    mov     t1021, DWORD PTR [%ebp+8]
        mov     t1034, DWORD PTR [%ebp+8]
        mov     t1004, DWORD PTR [t1034+8]
        cmp     t8, 0
        jl      L33
L31:    cmp     t8, DWORD PTR [t1004-4]
        jl      L32
L33:    push    0
        call    L_raise
        add     %esp, 4
L32:    push    DWORD PTR [%ebp+12]
        push    DWORD PTR [t8*4+t1004]
        push    t1021
        call    LPrimesClass$divides
        add     %esp, 12
        mov     t1022, %eax
        mov     t1005, t1022
        xor     t1005, 1
L34:    mov     t9, t1005
        inc     t8
        jmp     L28
L62:    leave
        ret
        .global LPrimesClass$primes
        .type LPrimesClass$primes, @function
LPrimesClass$primes:
        #args LOC 0, LOC 4
        enter   0, 0
L63:    mov     t9, 0
        mov     t8, 2
L38:    cmp     t8, DWORD PTR [%ebp+12]
        jl      L39
L40:    mov     %eax, t9
        jmp     L64
L45:    inc     t8
        jmp     L46
L39:    push    t8
        push    DWORD PTR [%ebp+8]
        call    LPrimesClass$isprime
        add     %esp, 8
        mov     t1023, %eax
        cmp     t1023, 0
        je      L45
L44:    mov     t1040, DWORD PTR [%ebp+8]
        mov     t1006, DWORD PTR [t1040+8]
        mov     t1039, DWORD PTR [%ebp+8]
        mov     t1007, DWORD PTR [t1039+4]
        cmp     t1007, 0
        jl      L43
L41:    cmp     t1007, DWORD PTR [t1006-4]
        jl      L42
L43:    push    0
        call    L_raise
        add     %esp, 4
L42:    mov     DWORD PTR [t1007*4+t1006], t8
        mov     t1038, DWORD PTR [%ebp+8]
        mov     t1037, DWORD PTR [t1038+4]
        inc     t1037
        mov     t1036, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1036+4], t1037
        push    t8
        call    L_println_int
        add     %esp, 4
        inc     t8
        inc     t9
L46:    jmp     L38
L64:    leave
        ret
        .global LPrimesClass$test_it
        .type LPrimesClass$test_it, @function
LPrimesClass$test_it:
        #args LOC 0, LOC 4
        enter   0, 0
L65:    mov     t1008, DWORD PTR [%ebp+12]
        mov     t1045, t1008
        add     t1045, 1
        mov     t1044, t1045
        sal     t1044, 2
        push    t1044
        call    L_halloc
        add     %esp, 4
        mov     t1009, %eax
        mov     DWORD PTR [t1009], t1008
        mov     t1043, t1009
        add     t1043, 4
        mov     t1042, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1042+8], t1043
        mov     t1041, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1041+4], 0
        push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+8]
        call    LPrimesClass$primes
        add     %esp, 8
        mov     t8, %eax
        push    999
        call    L_println_int
        add     %esp, 4
        mov     %eax, t8
L66:    leave
        ret
