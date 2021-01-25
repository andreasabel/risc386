        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L0:     push    4
        call    L_halloc
        add     %esp, 4
        mov     t1001, %eax
        push    t1001
        call    LEffectsClass$run
        add     %esp, 4
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L1:     leave
        ret
        .global LEffectsClass$run
        .type LEffectsClass$run, @function
LEffectsClass$run:
        #args LOC 0
        enter   0, 0
L2:     push    8
        call    L_halloc
        add     %esp, 4
        mov     t8, %eax
        push    1
        push    t8
        call    LBit$set
        add     %esp, 8
        mov     t1003, %eax
        push    0
        push    t8
        call    LBit$set
        add     %esp, 8
        mov     t1004, %eax
        push    t8
        call    LBit$value
        add     %esp, 4
        mov     t1005, %eax
        mov     t1008, t1005
        neg     t1008
        mov     t1007, t1004
        sub     t1007, t1008
        mov     t1006, t1003
        dec     t1006
        mov     %eax, t1006
        sub     %eax, t1007
L3:     leave
        ret
        .global LBit$set
        .type LBit$set, @function
LBit$set:
        #args LOC 0, LOC 4
        enter   0, 0
L4:     mov     t1009, DWORD PTR [%ebp+8]
        mov     t1010, DWORD PTR [%ebp+12]
        mov     DWORD PTR [t1009+4], t1010
        mov     %eax, DWORD PTR [%ebp+12]
L5:     leave
        ret
        .global LBit$value
        .type LBit$value, @function
LBit$value:
        #args LOC 0
        enter   0, 0
L6:     mov     t1011, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1011+4]
L7:     leave
        ret
