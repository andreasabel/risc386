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
        push    t1001
        call    LWhileClass$run
        add     %esp, 4
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L4:     leave
        ret
        .global LWhileClass$run
        .type LWhileClass$run, @function
LWhileClass$run:
        #args LOC 0
        enter   0, 0
L5:     mov     t9, 0
        mov     t8, 1
L0:     cmp     t8, 11
        jl      L1
L2:     mov     %eax, 0
        jmp     L6
L1:     add     t9, t8
        push    t9
        call    L_println_int
        add     %esp, 4
        inc     t8
        jmp     L0
L6:     leave
        ret
