        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L3:     push    4
        call    L_halloc
        add     %esp, 4
        mov     t1001, %eax
        push    55
        push    t1001
        call    LStckClass$stckme
        add     %esp, 8
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L4:     leave
        ret
        .global LStckClass$stckme
        .type LStckClass$stckme, @function
LStckClass$stckme:
        #args LOC 0, LOC 4
        enter   0, 0
L5:     mov     t9, DWORD PTR [%ebp+12]
        cmp     DWORD PTR [%ebp+12], 1
        jl      L0
L1:     mov     t1003, DWORD PTR [%ebp+12]
        dec     t1003
        push    t1003
        push    DWORD PTR [%ebp+8]
        call    LStckClass$stckme
        add     %esp, 8
        mov     t8, %eax
L2:     mov     %eax, t9
        jmp     L6
L0:     jmp     L2
L6:     leave
        ret
