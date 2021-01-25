        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L3:     push    8
        call    L_halloc
        add     %esp, 4
        mov     t1001, %eax
        push    5
        push    0
        push    t1001
        call    LSumClass$f
        add     %esp, 12
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L4:     leave
        ret
        .global LSumClass$f
        .type LSumClass$f, @function
LSumClass$f:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L5:     mov     t9, DWORD PTR [%ebp+12]
        add     t9, DWORD PTR [%ebp+16]
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LSumClass$g
        add     %esp, 8
        mov     t1005, %eax
        mov     t1004, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1004+4], t1005
        cmp     DWORD PTR [%ebp+16], 1
        jl      L0
L1:     mov     t1003, DWORD PTR [%ebp+16]
        dec     t1003
        push    t1003
        push    t9
        push    DWORD PTR [%ebp+8]
        call    LSumClass$f
        add     %esp, 12
        mov     t8, %eax
L2:     mov     %eax, t8
        jmp     L6
L0:     mov     t8, t9
        jmp     L2
L6:     leave
        ret
        .global LSumClass$g
        .type LSumClass$g, @function
LSumClass$g:
        #args LOC 0, LOC 4
        enter   0, 0
L7:     mov     %eax, DWORD PTR [%ebp+12]
L8:     leave
        ret
