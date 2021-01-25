        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L15:    push    12
        call    L_halloc
        add     %esp, 4
        mov     t1009, %eax
        push    10
        push    5
        push    t1009
        call    LA$run
        add     %esp, 12
        mov     t1010, %eax
        push    t1010
        call    L_println_int
        add     %esp, 4
L16:    leave
        ret
        .global LA$run
        .type LA$run, @function
LA$run:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
        jmp     L17
L7:     mov     t1026, DWORD PTR [%ebp+8]
        mov     t1006, DWORD PTR [t1026+8]
        cmp     t8, 0
        jl      L11
L9:     cmp     t8, DWORD PTR [t1006-4]
        jl      L10
        jmp     L11
L17:    mov     t1001, DWORD PTR [%ebp+16]
        mov     t1025, t1001
        add     t1025, 1
        mov     t1024, t1025
        sal     t1024, 2
        push    t1024
        call    L_halloc
        add     %esp, 4
        mov     t1002, %eax
        mov     DWORD PTR [t1002], t1001
        mov     t1023, t1002
        add     t1023, 4
        mov     t1022, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1022+4], t1023
        mov     t8, 0
L0:     mov     t1021, DWORD PTR [%ebp+16]
        inc     t1021
        cmp     t8, t1021
        jl      L1
L2:     mov     t1004, DWORD PTR [%ebp+16]
        mov     t1020, t1004
        add     t1020, 1
        mov     t1019, t1020
        sal     t1019, 2
        push    t1019
        call    L_halloc
        add     %esp, 4
        mov     t1005, %eax
        mov     DWORD PTR [t1005], t1004
        mov     t1018, t1005
        add     t1018, 4
        mov     t1017, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1017+8], t1018
        mov     t8, 0
L6:     mov     t1016, DWORD PTR [%ebp+16]
        inc     t1016
        cmp     t8, t1016
        jl      L7
L8:     mov     t1015, DWORD PTR [%ebp+8]
        mov     t1007, DWORD PTR [t1015+4]
        mov     t1008, DWORD PTR [%ebp+16]
        cmp     t1008, 0
        jl      L14
L12:    cmp     t1008, DWORD PTR [t1007-4]
        jl      L13
L14:    push    0
        call    L_raise
        add     %esp, 4
L13:    mov     %eax, DWORD PTR [t1008*4+t1007]
        jmp     L18
L11:    push    0
        call    L_raise
        add     %esp, 4
L10:    mov     t1014, t8
        sal     t1014, 1
        mov     t1013, t1014
        inc     t1013
        mov     DWORD PTR [t8*4+t1006], t1013
        inc     t8
        jmp     L6
L1:     mov     t1012, DWORD PTR [%ebp+8]
        mov     t1003, DWORD PTR [t1012+4]
        cmp     t8, 0
        jl      L5
L3:     cmp     t8, DWORD PTR [t1003-4]
        jl      L4
L5:     push    0
        call    L_raise
        add     %esp, 4
L4:     mov     t1011, t8
        sal     t1011, 1
        mov     DWORD PTR [t8*4+t1003], t1011
        inc     t8
        jmp     L0
L18:    leave
        ret
