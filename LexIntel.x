{
module LexIntel where

import Intel (Reg32(..),Register(..))
import TokenIntel as Token
}

%wrapper "posn"

$digit = 0-9        -- digits
$alpha = [a-zA-Z]   -- alphabetic characters
$letter = $alpha

tokens :-

  $white+;

   "#args" { \p s -> Args p } -- special comment for function args
   "# ".*  ;  -- one-line comments start with a hash and space
   ".".*  ;  -- ignore all pragmas, starting with a dot (simplified)

  "["{ \ p s -> LBrack p }
  "]"{ \ p s -> RBrack p }
  ":"{ \ p s -> Colon p }
  ","{ \ p s -> Comma p }
  "."{ \ p s -> Dot p }
  "+"{ \ p s -> Plus p }
  "-"{ \ p s -> Minus p }
  "*"{ \ p s -> Times p }

  MOV  { \ p s -> Mov p }
  ADD  { \ p s -> Add p }
  SUB  { \ p s -> Sub p }
  SHL  { \ p s -> Shl p }
  SHR  { \ p s -> Shr p }
  SAL  { \ p s -> Sal p }
  SAR  { \ p s -> Sar p }
  AND  { \ p s -> And p }
  OR   { \ p s -> Or p }
  XOR  { \ p s -> Xor p }
  NEG  { \ p s -> Neg p }
  NOT  { \ p s -> Not p }
  INC  { \ p s -> Inc p }
  DEC  { \ p s -> Dec p }
  POP  { \ p s -> Pop p }
  PUSH { \ p s -> Push p }
  IMUL { \ p s -> Imul p }
  IDIV { \ p s -> Idiv p }
  JMP  { \ p s -> Jmp p }
  LEA  { \ p s -> Lea p }
  CMP  { \ p s -> Cmp p }
  JE   { \ p s -> Je p }
  JNE  { \ p s -> Jne p }
  JL   { \ p s -> Jl p }
  JLE  { \ p s -> Jle p }
  JG   { \ p s -> Jg p }
  JGE  { \ p s -> Jge p }
  CALL { \ p s -> Call p }
  RET  { \ p s -> Ret p }
  ENTER{ \ p s -> Enter p }
  LEAVE{ \ p s -> Leave p }
  NOP  { \ p s -> Nop p }
  mov  { \ p s -> Mov p }
  add  { \ p s -> Add p }
  sub  { \ p s -> Sub p }
  shl  { \ p s -> Shl p }
  shr  { \ p s -> Shr p }
  sal  { \ p s -> Sal p }
  sar  { \ p s -> Sar p }
  and  { \ p s -> And p }
  or   { \ p s -> Or p }
  xor  { \ p s -> Xor p }
  neg  { \ p s -> Neg p }
  not  { \ p s -> Not p }
  inc  { \ p s -> Inc p }
  dec  { \ p s -> Dec p }
  pop  { \ p s -> Pop p }
  push { \ p s -> Push p }
  imul { \ p s -> Imul p }
  idiv { \ p s -> Idiv p }
  jmp  { \ p s -> Jmp p }
  lea  { \ p s -> Lea p }
  cmp  { \ p s -> Cmp p }
  je   { \ p s -> Je p }
  jne  { \ p s -> Jne p }
  jl   { \ p s -> Jl p }
  jle  { \ p s -> Jle p }
  jg   { \ p s -> Jg p }
  jge  { \ p s -> Jge p }
  call { \ p s -> Call p }
  ret  { \ p s -> Ret p }
  enter{ \ p s -> Enter p }
  leave{ \ p s -> Leave p }
  nop  { \ p s -> Nop p }

  DWORD{ \ p s -> Dword p }
  dword{ \ p s -> Dword p }
  PTR  { \ p s -> Token.Ptr p }
  ptr  { \ p s -> Token.Ptr p }

  LOC  { \ p s -> LOC p }
  REG  { \ p s -> REG p }

  $digit+{ \ p s -> Nat (read s) p }
--  "L" [$letter $digit \_ \' \$]*{ \ p s -> Label s p }
--  $letter [$letter $digit \_ \' \$]* ":" { \ p s -> Label s p }
  "t"[$digit]*    { \ p ('t':s) -> Temp (read s) p }
  "eax" { \ p s -> Reg eax p }
  "ebx" { \ p s -> Reg ebx p }
  "ecx" { \ p s -> Reg ecx p }
  "edx" { \ p s -> Reg edx p }
  "esi" { \ p s -> Reg esi p }
  "edi" { \ p s -> Reg edi p }
  "ebp" { \ p s -> Reg ebp p }
  "esp" { \ p s -> Reg esp p }
  "%eax" { \ p s -> Reg eax p }
  "%ebx" { \ p s -> Reg ebx p }
  "%ecx" { \ p s -> Reg ecx p }
  "%edx" { \ p s -> Reg edx p }
  "%esi" { \ p s -> Reg esi p }
  "%edi" { \ p s -> Reg edi p }
  "%ebp" { \ p s -> Reg ebp p }
  "%esp" { \ p s -> Reg esp p }
  $letter [$letter $digit \_ \' \$]*{ \ p s -> Id s p }

{
-- Each action has type :: String -> Token

-- The token type is in Token.hs
{-
main = do
  s <- getContents
  print (alexScanTokens s)
-}
}
