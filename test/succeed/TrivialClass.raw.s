        .intel_syntax
        .global Lmain
        .type Lmain, @function
Lmain:
        #args
        enter   0, 0
L0:     push    8
        call    L_halloc
        add     %esp, 4
        mov     t1001, %eax
        push    t1001
        call    LC$value
        add     %esp, 4
        mov     t1002, %eax
        push    t1002
        call    L_println_int
        add     %esp, 4
L1:     leave
        ret
        .global LC$value
        .type LC$value, @function
LC$value:
        #args LOC 0
        enter   0, 0
L2:     mov     t1004, DWORD PTR [%ebp+8]
        mov     DWORD PTR [t1004+4], 555
        mov     t1003, DWORD PTR [%ebp+8]
        mov     %eax, DWORD PTR [t1003+4]
L3:     leave
        ret
