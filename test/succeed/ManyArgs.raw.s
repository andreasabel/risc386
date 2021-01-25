        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L31:    push    4
        call    L_halloc
        add     %esp, 4
        mov     t1008, %eax
        push    87
        push    10
        push    5
        push    4
        push    3
        push    2
        push    1
        push    t1008
        call    LPrime$test_it
        add     %esp, 32
        mov     t1009, %eax
        push    t1009
        call    L_println_int
        add     %esp, 4
L32:    leave
        ret
        .global LPrime$or
        .type LPrime$or, @function
LPrime$or:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L33:    mov     t1001, DWORD PTR [%ebp+12]
        xor     t1001, 1
        cmp     t1001, 0
        je      L0
L1:     mov     t1001, DWORD PTR [%ebp+16]
        xor     t1001, 1
L0:     mov     %eax, t1001
        xor     %eax, 1
L34:    leave
        ret
        .global LPrime$divides
        .type LPrime$divides, @function
LPrime$divides:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
        jmp     L35
L8:     inc     t9
        jmp     L10
L5:     mov     t9, DWORD PTR [%ebp+16]
        jmp     L7
L35:    mov     t9, 1
        mov     t8, 0
L2:     cmp     t8, 0
        je      L11
L4:     mov     %eax, t8
        jmp     L36
L11:    cmp     t9, DWORD PTR [%ebp+16]
        jge     L4
L3:     mov     %eax, t9
        imul    DWORD PTR [%ebp+12]
        mov     t1021, %eax
        cmp     t1021, DWORD PTR [%ebp+16]
        jl      L8
L9:     mov     %eax, t9
        imul    DWORD PTR [%ebp+12]
        mov     t1020, %eax
        cmp     DWORD PTR [%ebp+16], t1020
        jl      L5
L6:     mov     t8, 1
L7:
L10:    jmp     L2
L36:    leave
        ret
        .global LPrime$isprime
        .type LPrime$isprime, @function
LPrime$isprime:
        #args LOC 0, LOC 4
        enter   0, 0
L37:    mov     t1011, DWORD PTR [%ebp+8]
        mov     t1002, 1
        cmp     DWORD PTR [%ebp+12], 1
        jg      L12
L13:    mov     t1002, 0
L12:    mov     t1004, t1002
        cmp     t1004, 0
        je      L16
L17:    mov     t1003, 1
        cmp     DWORD PTR [%ebp+12], 3
        jl      L14
L15:    mov     t1003, 0
L14:    mov     t1004, t1003
L16:    mov     t1005, 1
        cmp     DWORD PTR [%ebp+12], 2
        jg      L18
L19:    mov     t1005, 0
L18:    mov     t1006, t1005
        cmp     t1006, 0
        je      L20
L21:    push    DWORD PTR [%ebp+12]
        push    2
        push    DWORD PTR [%ebp+8]
        call    LPrime$divides
        add     %esp, 12
        mov     t1010, %eax
        mov     t1006, t1010
        xor     t1006, 1
L20:    push    t1006
        push    t1004
        push    t1011
        call    LPrime$or
        add     %esp, 12
        mov     t9, %eax
        mov     t8, 3
L22:    cmp     t9, 0
        je      L24
L27:    cmp     t8, DWORD PTR [%ebp+12]
        jl      L23
L24:    mov     %eax, t9
        jmp     L38
L23:    mov     t1007, t9
        cmp     t1007, 0
        je      L25
L26:    push    DWORD PTR [%ebp+12]
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LPrime$divides
        add     %esp, 12
        mov     t1012, %eax
        mov     t1007, t1012
        xor     t1007, 1
L25:    mov     t9, t1007
        add     t8, 2
        jmp     L22
L38:    leave
        ret
        .global LPrime$b2i
        .type LPrime$b2i, @function
LPrime$b2i:
        #args LOC 0, LOC 4
        enter   0, 0
L39:    cmp     DWORD PTR [%ebp+12], 0
        je      L29
L28:    mov     t8, 1
L30:    mov     %eax, t8
        jmp     L40
L29:    mov     t8, 0
        jmp     L30
L40:    leave
        ret
        .global LPrime$test_it
        .type LPrime$test_it, @function
LPrime$test_it:
        #args LOC 0, LOC 4, LOC 8, LOC 12, LOC 16, LOC 20, LOC 24, LOC 28
        enter   0, 0
L41:    mov     t9, DWORD PTR [%ebp+12]
        push    t9
        call    L_println_int
        add     %esp, 4
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LPrime$isprime
        add     %esp, 8
        mov     t8, %eax
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LPrime$b2i
        add     %esp, 8
        mov     t1013, %eax
        push    t1013
        call    L_println_int
        add     %esp, 4
        mov     t9, DWORD PTR [%ebp+16]
        push    t9
        call    L_println_int
        add     %esp, 4
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LPrime$isprime
        add     %esp, 8
        mov     t8, %eax
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LPrime$b2i
        add     %esp, 8
        mov     t1014, %eax
        push    t1014
        call    L_println_int
        add     %esp, 4
        mov     t9, DWORD PTR [%ebp+20]
        push    t9
        call    L_println_int
        add     %esp, 4
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LPrime$isprime
        add     %esp, 8
        mov     t8, %eax
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LPrime$b2i
        add     %esp, 8
        mov     t1015, %eax
        push    t1015
        call    L_println_int
        add     %esp, 4
        mov     t9, DWORD PTR [%ebp+24]
        push    t9
        call    L_println_int
        add     %esp, 4
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LPrime$isprime
        add     %esp, 8
        mov     t8, %eax
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LPrime$b2i
        add     %esp, 8
        mov     t1016, %eax
        push    t1016
        call    L_println_int
        add     %esp, 4
        mov     t9, DWORD PTR [%ebp+28]
        push    t9
        call    L_println_int
        add     %esp, 4
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LPrime$isprime
        add     %esp, 8
        mov     t8, %eax
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LPrime$b2i
        add     %esp, 8
        mov     t1017, %eax
        push    t1017
        call    L_println_int
        add     %esp, 4
        mov     t9, DWORD PTR [%ebp+32]
        push    t9
        call    L_println_int
        add     %esp, 4
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LPrime$isprime
        add     %esp, 8
        mov     t8, %eax
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LPrime$b2i
        add     %esp, 8
        mov     t1018, %eax
        push    t1018
        call    L_println_int
        add     %esp, 4
        mov     t9, DWORD PTR [%ebp+36]
        push    t9
        call    L_println_int
        add     %esp, 4
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LPrime$isprime
        add     %esp, 8
        mov     t8, %eax
        push    t8
        push    DWORD PTR [%ebp+8]
        call    LPrime$b2i
        add     %esp, 8
        mov     t1019, %eax
        push    t1019
        call    L_println_int
        add     %esp, 4
        mov     %eax, 999
L42:    leave
        ret
