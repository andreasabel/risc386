        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L9:     push    4
        call    L_halloc
        add     %esp, 4
        mov     t1004, %eax
        push    t1004
        call    LTestEqMain$run
        add     %esp, 4
        mov     t1005, %eax
        push    t1005
        call    L_println_int
        add     %esp, 4
L10:    leave
        ret
        .global LTestEqMain$run
        .type LTestEqMain$run, @function
LTestEqMain$run:
        #args LOC 0
        enter   0, 0
        jmp     L11
L7:     push    0
        call    L_println_int
        add     %esp, 4
        jmp     L8
L11:    mov     t1001, 1
        mov     t1007, 4
        cmp     t1007, 5
        jl      L0
L1:     mov     t1001, 0
L0:     mov     t1003, t1001
        cmp     t1003, 0
        je      L4
L5:     mov     t1002, 1
        mov     t1006, 4
        cmp     t1006, 5
        jl      L2
L3:     mov     t1002, 0
L2:     mov     t1003, t1002
L4:     mov     t8, t1003
        cmp     t8, 0
        je      L7
L6:     push    1
        call    L_println_int
        add     %esp, 4
L8:     mov     %eax, 0
L12:    leave
        ret
