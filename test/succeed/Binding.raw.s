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
        push    10
        push    5
        push    t1001
        call    LB$run
        add     %esp, 12
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L5:     leave
        ret
        .global LB$run
        .type LB$run, @function
LB$run:
        #args LOC 0, LOC 4, LOC 8
        enter   0, 0
L6:     mov     t1007, 0
        cmp     t1007, 1
        jl      L3
L1:     mov     t8, DWORD PTR [%ebp+16]
L2:     mov     %eax, t8
        jmp     L7
L3:     mov     t1006, DWORD PTR [%ebp+12]
        add     t1006, DWORD PTR [%ebp+16]
        mov     %eax, t1006
        imul    DWORD PTR [%ebp+16]
        mov     t1004, %eax
        mov     %eax, DWORD PTR [%ebp+16]
        imul    DWORD PTR [%ebp+16]
        mov     t1005, %eax
        mov     t1003, DWORD PTR [%ebp+12]
        add     t1003, t1005
        cmp     t1003, t1004
        jl      L0
        jmp     L1
L0:     mov     t8, DWORD PTR [%ebp+12]
        jmp     L2
L7:     leave
        ret
