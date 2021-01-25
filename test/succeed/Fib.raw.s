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
        push    5
        push    t1001
        call    LFibClass$nfib
        add     %esp, 8
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L4:     leave
        ret
        .global LFibClass$nfib
        .type LFibClass$nfib, @function
LFibClass$nfib:
        #args LOC 0, LOC 4
        enter   0, 0
L5:     cmp     DWORD PTR [%ebp+12], 2
        jl      L0
L1:     mov     t1007, DWORD PTR [%ebp+12]
        dec     t1007
        push    t1007
        push    DWORD PTR [%ebp+8]
        call    LFibClass$nfib
        add     %esp, 8
        mov     t1003, %eax
        mov     t1006, -2
        add     t1006, DWORD PTR [%ebp+12]
        push    t1006
        push    DWORD PTR [%ebp+8]
        call    LFibClass$nfib
        add     %esp, 8
        mov     t1004, %eax
        mov     t1005, t1003
        add     t1005, t1004
        mov     t8, t1005
        inc     t8
L2:     mov     %eax, t8
        jmp     L6
L0:     mov     t8, 1
        jmp     L2
L6:     leave
        ret
