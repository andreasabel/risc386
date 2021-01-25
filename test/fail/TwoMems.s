.intel_syntax
.globl main

main:
        push    %ebp
        mov     %ebp, %esp
        sub     %esp, 4
        mov     dword ptr [%ebp-4], 0
        mov     dword ptr [%ebp-4], dword ptr [%ebp-4]
        mov     %eax, 0
        leave
        ret

        