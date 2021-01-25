        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L6:     push    4
        call    L_halloc
        add     %esp, 4
        mov     t1003, %eax
        push    t1003
        call    LAA$run
        add     %esp, 4
        mov     t1004, %eax
        push    t1004
        call    L_println_int
        add     %esp, 4
L7:     leave
        ret
        .global LAA$run
        .type LAA$run, @function
LAA$run:
        #args LOC 0
        enter   0, 0
L8:     mov     t1001, 2
        mov     t1006, t1001
        add     t1006, 1
        mov     t1005, t1006
        sal     t1005, 2
        push    t1005
        call    L_halloc
        add     %esp, 4
        mov     t1002, %eax
        mov     DWORD PTR [t1002], t1001
        mov     t8, t1002
        add     t8, 4
        cmp     DWORD PTR [t8-4], 0
        jg      L0
L1:     push    0
        call    L_raise
        add     %esp, 4
L0:     mov     DWORD PTR [t8], 5
        cmp     DWORD PTR [t8-4], 1
        jg      L2
L3:     push    0
        call    L_raise
        add     %esp, 4
L2:     mov     DWORD PTR [t8+4], 10
        cmp     DWORD PTR [t8-4], 0
        jg      L4
L5:     push    0
        call    L_raise
        add     %esp, 4
L4:     mov     %eax, DWORD PTR [t8]
L9:     leave
        ret
