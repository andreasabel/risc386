        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L4:     push    4
        call    L_halloc
        add     %esp, 4
        mov     t1001, %eax
        push    0
        push    t1001
        call    LTestAnd$run
        add     %esp, 8
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L5:     leave
        ret
        .global LTestAnd$run
        .type LTestAnd$run, @function
LTestAnd$run:
        #args LOC 0, LOC 4
        enter   0, 0
L6:     cmp     DWORD PTR [%ebp+12], 0
        je      L1
L3:     push    DWORD PTR [%ebp+8]
        call    LTestAnd$sideEffect
        add     %esp, 4
        mov     t1003, %eax
        cmp     t1003, 0
        je      L1
L0:     mov     t8, 1
L2:     mov     %eax, t8
        jmp     L7
L1:     mov     t8, 0
        jmp     L2
L7:     leave
        ret
        .global LTestAnd$sideEffect
        .type LTestAnd$sideEffect, @function
LTestAnd$sideEffect:
        #args LOC 0
        enter   0, 0
L8:     push    -9999
        call    L_println_int
        add     %esp, 4
        push    -9999
        call    L_println_int
        add     %esp, 4
        push    -9999
        call    L_println_int
        add     %esp, 4
        push    -9999
        call    L_println_int
        add     %esp, 4
        push    -9999
        call    L_println_int
        add     %esp, 4
        mov     %eax, 1
L9:     leave
        ret
