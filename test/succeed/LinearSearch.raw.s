        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L24:    push    12
        call    L_halloc
        add     %esp, 4
        mov     t1006, %eax
        push    10
        push    t1006
        call    LLS$Start
        add     %esp, 8
        mov     t1007, %eax
        push    t1007
        call    L_println_int
        add     %esp, 4
L25:    leave
        ret
        .global LLS$Start
        .type LLS$Start, @function
LLS$Start:
        #args LOC 0, LOC 4
        enter   0, 0
L26:    push    DWORD PTR [%ebp+12]
        push    DWORD PTR [%ebp+8]
        call    LLS$Init
        add     %esp, 8
        mov     t8, %eax
        push    DWORD PTR [%ebp+8]
        call    LLS$Print
        add     %esp, 4
        mov     t9, %eax
        push    9999
        call    L_println_int
        add     %esp, 4
        push    8
        push    DWORD PTR [%ebp+8]
        call    LLS$Search
        add     %esp, 8
        mov     t1008, %eax
        push    t1008
        call    L_println_int
        add     %esp, 4
        push    12
        push    DWORD PTR [%ebp+8]
        call    LLS$Search
        add     %esp, 8
        mov     t1009, %eax
        push    t1009
        call    L_println_int
        add     %esp, 4
        push    17
        push    DWORD PTR [%ebp+8]
        call    LLS$Search
        add     %esp, 8
        mov     t1010, %eax
        push    t1010
        call    L_println_int
        add     %esp, 4
        push    50
        push    DWORD PTR [%ebp+8]
        call    LLS$Search
        add     %esp, 8
        mov     t1011, %eax
        push    t1011
        call    L_println_int
        add     %esp, 4
        mov     %eax, 55
L27:    leave
        ret
        .global LLS$Print
        .type LLS$Print, @function
LLS$Print:
        #args LOC 0
        enter   0, 0
L28:    mov     t8, 1
L0:     mov     t1013, DWORD PTR [%ebp+8]
        cmp     t8, DWORD PTR [t1013+8]
        jl      L1
L2:     mov     %eax, 0
        jmp     L29
L1:     mov     t1012, DWORD PTR [%ebp+8]
        mov     t1001, DWORD PTR [t1012+4]
        cmp     t8, 0
        jl      L5
L3:     cmp     t8, DWORD PTR [t1001-4]
        jl      L4
L5:     push    0
        call    L_raise
        add     %esp, 4
L4:     push    DWORD PTR [t8*4+t1001]
        call    L_println_int
        add     %esp, 4
        inc     t8
        jmp     L0
L29:    leave
        ret
        .global LLS$Search
        .type LLS$Search, @function
LLS$Search:
        #args LOC 0, LOC 4
        enter   0, 0
        jmp     L30
L7:     mov     t1016, DWORD PTR [%ebp+8]
        mov     t1002, DWORD PTR [t1016+4]
        cmp     t11, 0
        jl      L11
L9:     cmp     t11, DWORD PTR [t1002-4]
        jl      L10
        jmp     L11
L30:    mov     t11, 1
        mov     t12, 0
        mov     t10, 0
L6:     mov     t1015, DWORD PTR [%ebp+8]
        cmp     t11, DWORD PTR [t1015+8]
        jl      L7
L8:     mov     %eax, t10
        jmp     L31
L15:    mov     t13, 0
        jmp     L17
L12:    mov     t12, 1
        mov     t10, 1
        mov     t1014, DWORD PTR [%ebp+8]
        mov     t11, DWORD PTR [t1014+8]
        jmp     L14
L11:    push    0
        call    L_raise
        add     %esp, 4
L10:    mov     t8, DWORD PTR [t11*4+t1002]
        mov     t9, DWORD PTR [%ebp+12]
        inc     t9
        cmp     t8, DWORD PTR [%ebp+12]
        jl      L15
L16:    cmp     t8, t9
        jl      L12
L13:    mov     t13, 0
L14:
L17:    inc     t11
        jmp     L6
L31:    leave
        ret
        .global LLS$Init
        .type LLS$Init, @function
LLS$Init:
        #args LOC 0, LOC 4
        enter   0, 0
L32:    mov     t1025, DWORD PTR [%ebp+8]
        mov     t1026, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1025+8], t1026
        mov     t1003, DWORD PTR [%ebp+12]
        mov     t1024, t1003
        add     t1024, 1
        mov     t1023, t1024
        sal     t1023, 2
        push    t1023
        call    L_halloc
        add     %esp, 4
        mov     t1004, %eax
        mov     DWORD PTR [t1004], t1003
        mov     t1022, t1004
        add     t1022, 4
        mov     t1021, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1021+4], t1022
        mov     t10, 1
        mov     t1020, DWORD PTR [%ebp+8]
        mov     t11, DWORD PTR [t1020+8]
        inc     t11
L18:    mov     t1019, DWORD PTR [%ebp+8]
        cmp     t10, DWORD PTR [t1019+8]
        jl      L19
L20:    mov     %eax, 0
        jmp     L33
L19:    mov     t8, t10
        sal     t8, 1
        mov     t9, -3
        add     t9, t11
        mov     t1018, DWORD PTR [%ebp+8]
        mov     t1005, DWORD PTR [t1018+4]
        cmp     t10, 0
        jl      L23
L21:    cmp     t10, DWORD PTR [t1005-4]
        jl      L22
L23:    push    0
        call    L_raise
        add     %esp, 4
L22:    mov     t1017, t8
        add     t1017, t9
        mov     DWORD PTR [t10*4+t1005], t1017
        inc     t10
        dec     t11
        jmp     L18
L33:    leave
        ret
