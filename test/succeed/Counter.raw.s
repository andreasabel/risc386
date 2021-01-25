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
        call    LCounterClass$f
        add     %esp, 12
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L4:     leave
        ret
        .global LCounterClass$getValue
        .type LCounterClass$getValue, @function
LCounterClass$getValue:
        #args LOC 0
        enter   0, 0
L5:     mov     t1003, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1003+4]
L6:     leave
        ret
        .global LCounterClass$f
        .type LCounterClass$f, @function
LCounterClass$f:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L7:     mov     t9, 0
        cmp     DWORD PTR [%ebp+16], 1
        jl      L0
L1:     mov     t1004, DWORD PTR [%ebp+12]
        add     t1004, DWORD PTR [%ebp+16]
        mov     t1005, DWORD PTR [%ebp+16]
        dec     t1005
        push    t1005
        push    t1004
        push    DWORD PTR [%ebp+8]
        call    LCounterClass$f
        add     %esp, 12
        mov     t8, %eax
L2:     mov     %eax, t8
        jmp     L8
L0:     mov     t8, t9
        jmp     L2
L8:     leave
        ret
