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
        push    10
        push    t1001
        call    LFac$ComputeFac
        add     %esp, 8
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L4:     leave
        ret
        .global LFac$ComputeFac
        .type LFac$ComputeFac, @function
LFac$ComputeFac:
        #args LOC 0, LOC 4
        enter   0, 0
L5:     cmp     DWORD PTR [%ebp+12], 1
        jl      L0
L1:     mov     t1004, DWORD PTR [%ebp+12]
        mov     t1005, DWORD PTR [%ebp+12]
        dec     t1005
        push    t1005
        push    DWORD PTR [%ebp+8]
        call    LFac$ComputeFac
        add     %esp, 8
        mov     t1003, %eax
        mov     %eax, t1004
        imul    t1003
        mov     t8, %eax
L2:     mov     %eax, t8
        jmp     L6
L0:     mov     t8, 1
        jmp     L2
L6:     leave
        ret
