# N-C temp: t34 in OP(-, MEM(OP(+, TEMP(t11), OP(*, CONST(2), CONST(4)))), CONST(1))
# N-C temp: t44 in OP(*, OP(+, TEMP(t24), CONST(1)), CONST(4))
Lmain:

POP t45
L$$1:

MOV %eax, 3
MOV t47, 4
IMUL t47
MOV t46, %eax
PUSH t46
CALL L_halloc
MOV t28, %eax
MOV t48, t28
PUSH t48
MOV t49, 10
PUSH t49
CALL LBBS$Start
MOV t29, %eax
MOV t50, t29
PUSH t50
CALL L_println_int
MOV %eax, %eax
JMP L$$0
L$$0:

PUSH t45
RET

        
LBBS$Start:
        #args LOC 0, LOC 4

POP t51
POP t9
POP t8
L$$3:

MOV t52, t8
PUSH t52
MOV t53, t9
PUSH t53
CALL LBBS$Init
MOV t10, %eax
MOV t54, t8
PUSH t54
CALL LBBS$Print
MOV t10, %eax
MOV t55, 99999
PUSH t55
CALL L_println_int
MOV t56, t8
PUSH t56
CALL LBBS$Sort
MOV t10, %eax
MOV t57, t8
PUSH t57
CALL LBBS$Print
MOV t10, %eax
MOV %eax, 0
JMP L$$2
L$$2:

PUSH t51
RET


        
LBBS$Sort:
        #args LOC 0

POP t58
POP t11
L$$32:

MOV t60, t11
MOV %eax, 2
MOV t61, 4
IMUL t61
ADD t60, %eax
MOV t59, t60
MOV t34, DWORD PTR [t59+0]
MOV t62, t34
SUB t62, 1
MOV t13, t62
MOV t63, 0
SUB t63, 1
MOV t14, t63
L$$4:

MOV t31, 0
CMP t14, t13
JL L$$7
L$$8:

CMP t31, 0
JE L$$5
L$$6:

MOV t19, 1
L$$9:

MOV t32, 0
MOV t64, t13
ADD t64, 1
CMP t19, t64
JL L$$12
L$$13:

CMP t32, 0
JE L$$10
L$$11:

MOV t65, t19
SUB t65, 1
MOV t18, t65
MOV t66, 0
CMP t66, t18
JG L$$14
L$$16:

MOV t69, t11
MOV %eax, 1
MOV t70, 4
IMUL t70
ADD t69, %eax
MOV t68, t69
MOV t67, DWORD PTR [t68+0]
CMP DWORD PTR [t67+0], t18
JLE L$$14
L$$15:

MOV t72, t11
MOV %eax, 1
MOV t73, 4
IMUL t73
ADD t72, %eax
MOV %eax, 4
MOV t74, t18
ADD t74, 1
IMUL t74
ADD t72, %eax
MOV t71, t72
MOV t15, DWORD PTR [t71+0]
MOV t75, 0
CMP t75, t19
JG L$$17
L$$19:

MOV t78, t11
MOV %eax, 1
MOV t79, 4
IMUL t79
ADD t78, %eax
MOV t77, t78
MOV t76, DWORD PTR [t77+0]
CMP DWORD PTR [t76+0], t19
JLE L$$17
L$$18:

MOV t81, t11
MOV %eax, 1
MOV t82, 4
IMUL t82
ADD t81, %eax
MOV %eax, 4
MOV t83, t19
ADD t83, 1
IMUL t83
ADD t81, %eax
MOV t80, t81
MOV t16, DWORD PTR [t80+0]
MOV t33, 0
CMP t16, t15
JL L$$23
L$$24:

CMP t33, 0
JE L$$21
L$$20:

MOV t84, t19
SUB t84, 1
MOV t17, t84
MOV t85, 0
CMP t85, t17
JG L$$25
L$$27:

MOV t88, t11
MOV %eax, 1
MOV t89, 4
IMUL t89
ADD t88, %eax
MOV t87, t88
MOV t86, DWORD PTR [t87+0]
CMP DWORD PTR [t86+0], t17
JLE L$$25
L$$26:

MOV t91, t11
MOV %eax, 1
MOV t92, 4
IMUL t92
ADD t91, %eax
MOV %eax, 4
MOV t93, t17
ADD t93, 1
IMUL t93
ADD t91, %eax
MOV t90, t91
MOV t20, DWORD PTR [t90+0]
MOV t94, 0
CMP t94, t19
JG L$$28
L$$30:

MOV t97, t11
MOV %eax, 1
MOV t98, 4
IMUL t98
ADD t97, %eax
MOV t96, t97
MOV t95, DWORD PTR [t96+0]
CMP DWORD PTR [t95+0], t19
JLE L$$28
L$$29:

MOV t109, t11
MOV %eax, 1
MOV t110, 4
IMUL t110
ADD t109, %eax
MOV %eax, 4
MOV t111, t19
ADD t111, 1
IMUL t111
ADD t109, %eax
MOV t108, t109
MOV t107, DWORD PTR [t108+0]
MOV t113, t11
MOV %eax, 1
MOV t114, 4
IMUL t114
ADD t113, %eax
MOV %eax, 4
MOV t115, t17
ADD t115, 1
IMUL t115
ADD t113, %eax
MOV t112, t113
MOV DWORD PTR [t112+0], t107
MOV t117, t11
MOV %eax, 1
MOV t118, 4
IMUL t118
ADD t117, %eax
MOV %eax, 4
MOV t119, t19
ADD t119, 1
IMUL t119
ADD t117, %eax
MOV t116, t117
MOV DWORD PTR [t116+0], t20
L$$22:

MOV t120, t19
ADD t120, 1
MOV t19, t120
JMP L$$9
L$$7:

MOV t31, 1
JMP L$$8
L$$12:

MOV t32, 1
JMP L$$13
L$$14:

MOV t121, 9
PUSH t121
CALL L_raise
JMP L$$15
L$$17:

MOV t122, 9
PUSH t122
CALL L_raise
JMP L$$18
L$$23:

MOV t33, 1
JMP L$$24
L$$25:

MOV t123, 9
PUSH t123
CALL L_raise
JMP L$$26
L$$28:

MOV t124, 9
PUSH t124
CALL L_raise
JMP L$$29
L$$21:

MOV t12, 0
JMP L$$22
L$$10:

MOV t125, t13
SUB t125, 1
MOV t13, t125
JMP L$$4
L$$5:

MOV %eax, 0
JMP L$$31
L$$31:

PUSH t58
RET

        
LBBS$Print:
        #args LOC 0

POP t126   # return address
POP t21    # this

L$$42:
MOV t22, 0 # j := 0

L$$33:
MOV t39, 0                    # cond := false
MOV t128, t21
MOV %eax, 2
MOV t129, 4
IMUL t129
ADD t128, %eax
MOV t127, t128
CMP t22, DWORD PTR [t127+0]   # j < [this+8]
JL L$$36                      # 36: (sets cond := true)

L$$37:
CMP t39, 0                   # if cond still false goto 34  (return)
JE L$$34

L$$35:
MOV t130, 0                  # ensure j <= 0
CMP t130, t22
JG L$$38                     # 38: raise 9

L$$40:
MOV t133, t21
MOV %eax, 1
MOV t134, 4
IMUL t134
ADD t133, %eax
MOV t132, t133
MOV t131, DWORD PTR [t132+0]     # t131 = [this + 4] = number
CMP DWORD PTR [t131+0], t22      # ensure number.len > j
JLE L$$38

L$$39:
MOV t137, t21
MOV %eax, 1
MOV t138, 4
IMUL t138
ADD t137, %eax                # t137 := this + 4 = @number
MOV %eax, 4
MOV t139, t22                    
ADD t139, 1
IMUL t139
ADD t137, %eax                # t137 := t137 + 4 * (j + 1) = @number + 4 * (j + 2)
MOV t136, t137
MOV t135, DWORD PTR [t136+0]
PUSH t135
CALL L_println_int
MOV t140, t22
ADD t140, 1
MOV t22, t140
JMP L$$33
        
L$$36:         
MOV t39, 1       # cond := true
JMP L$$37

L$$38:
MOV t141, 9
PUSH t141
CALL L_raise
JMP L$$39

L$$34:           # returns
MOV %eax, 0
JMP L$$41

L$$41:
PUSH t126
RET


        
LBBS$Init:
        #args LOC 0, LOC 4        

POP t142
POP t24
POP t23
L$$44:

MOV t144, t23
MOV %eax, 2
MOV t145, 4
IMUL t145
ADD t144, %eax
MOV t143, t144
MOV DWORD PTR [t143+0], t24
MOV t146, t24
ADD t146, 1
MOV t44, t146
MOV %eax, t44
MOV t149, 4
IMUL t149
MOV t147, %eax
PUSH t147
CALL L_halloc
MOV t43, %eax
MOV t150, t43
MOV DWORD PTR [t150+0], t24
MOV t152, t23
MOV %eax, 1
MOV t153, 4
IMUL t153
ADD t152, %eax
MOV t151, t152
MOV DWORD PTR [t151+0], t43
MOV t158, 20
MOV t160, t23
MOV %eax, 1
MOV t161, 4
IMUL t161
ADD t160, %eax
MOV %eax, 4
MOV t162, 0
ADD t162, 1
IMUL t162
ADD t160, %eax
MOV t159, t160
MOV DWORD PTR [t159+0], t158
MOV t167, 7
MOV t169, t23
MOV %eax, 1
MOV t170, 4
IMUL t170
ADD t169, %eax
MOV %eax, 4
MOV t171, 1
ADD t171, 1
IMUL t171
ADD t169, %eax
MOV t168, t169
MOV DWORD PTR [t168+0], t167
MOV t176, 12
MOV t178, t23
MOV %eax, 1
MOV t179, 4
IMUL t179
ADD t178, %eax
MOV %eax, 4
MOV t180, 2
ADD t180, 1
IMUL t180
ADD t178, %eax
MOV t177, t178
MOV DWORD PTR [t177+0], t176
MOV t185, 18
MOV t187, t23
MOV %eax, 1
MOV t188, 4
IMUL t188
ADD t187, %eax
MOV %eax, 4
MOV t189, 3
ADD t189, 1
IMUL t189
ADD t187, %eax
MOV t186, t187
MOV DWORD PTR [t186+0], t185
MOV t194, 2
MOV t196, t23
MOV %eax, 1
MOV t197, 4
IMUL t197
ADD t196, %eax
MOV %eax, 4
MOV t198, 4
ADD t198, 1
IMUL t198
ADD t196, %eax
MOV t195, t196
MOV DWORD PTR [t195+0], t194
MOV t203, 11
MOV t205, t23
MOV %eax, 1
MOV t206, 4
IMUL t206
ADD t205, %eax
MOV %eax, 4
MOV t207, 5
ADD t207, 1
IMUL t207
ADD t205, %eax
MOV t204, t205
MOV DWORD PTR [t204+0], t203
MOV t212, 6
MOV t214, t23
MOV %eax, 1
MOV t215, 4
IMUL t215
ADD t214, %eax
MOV %eax, 4
MOV t216, 6
ADD t216, 1
IMUL t216
ADD t214, %eax
MOV t213, t214
MOV DWORD PTR [t213+0], t212
MOV t221, 9
MOV t223, t23
MOV %eax, 1
MOV t224, 4
IMUL t224
ADD t223, %eax
MOV %eax, 4
MOV t225, 7
ADD t225, 1
IMUL t225
ADD t223, %eax
MOV t222, t223
MOV DWORD PTR [t222+0], t221
MOV t230, 19
MOV t232, t23
MOV %eax, 1
MOV t233, 4
IMUL t233
ADD t232, %eax
MOV %eax, 4
MOV t234, 8
ADD t234, 1
IMUL t234
ADD t232, %eax
MOV t231, t232
MOV DWORD PTR [t231+0], t230
MOV t239, 5
MOV t241, t23
MOV %eax, 1
MOV t242, 4
IMUL t242
ADD t241, %eax
MOV %eax, 4
MOV t243, 9
ADD t243, 1
IMUL t243
ADD t241, %eax
MOV t240, t241
MOV DWORD PTR [t240+0], t239
MOV %eax, 0
JMP L$$43
L$$43:

PUSH t142
RET

