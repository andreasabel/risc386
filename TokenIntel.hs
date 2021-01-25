module TokenIntel where

import Prelude
  ( Int, String
  , Eq(..), Read(..), Show(..)
  , tail, dropWhile, ($),
  )

import Intel (Reg32(..))

data Token a =

-- punctuation
   LBrack a
 | RBrack a
 | Dot a
 | Comma a
 | Colon a
 | Plus a
 | Minus a
 | Times a

-- pragmas
 | Args a
 | LOC a
 | REG a

-- instructions
 | Mov a
 | Add a
 | Sub a
 | Shl a
 | Shr a
 | Sal a
 | Sar a
 | And a
 | Or a
 | Xor a
 | Neg a
 | Not a
 | Inc a
 | Dec a
 | Pop a
 | Push a
 | Imul a
 | Idiv a
 | Jmp a
 | Lea a
 | Cmp a
 | Je a
 | Jne a
 | Jl a
 | Jle a
 | Jg a
 | Jge a
 | Call a
 | Ret a
 | Enter a
 | Leave a
 | Nop a

-- addressing keywords
 | Dword a
 | Ptr a

-- identifiers and constants
 | Nat Int a       -- positive number or zero
 | Label String a
 | Reg Reg32 a
 | Temp Int a
 | Id String a

 deriving (Eq,Read,Show)

filterPn :: String -> String
filterPn [] = []
filterPn (' ':'(':'P':'n': s) = filterPn (tail $ dropWhile (/= ')') s)
filterPn (c:cs) = c:filterPn cs

token_pos :: Token t -> t
token_pos (LBrack p) = p
token_pos (RBrack p) = p
token_pos (Dot p) = p
token_pos (Comma p) = p
token_pos (Colon p) = p
token_pos (Plus p) = p
token_pos (Minus p) = p
token_pos (Times p) = p

token_pos (Args p) = p
token_pos (LOC p) = p
token_pos (REG p) = p

token_pos (Mov p) = p
token_pos (Add p) = p
token_pos (Sub p) = p
token_pos (Shr p) = p
token_pos (Shl p) = p
token_pos (Sar p) = p
token_pos (Sal p) = p
token_pos (And p) = p
token_pos (Or p) = p
token_pos (Xor p) = p
token_pos (Neg p) = p
token_pos (Not p) = p
token_pos (Inc p) = p
token_pos (Dec p) = p
token_pos (Pop p) = p
token_pos (Push p) = p
token_pos (Imul p) = p
token_pos (Idiv p) = p
token_pos (Jmp p) = p
token_pos (Lea p) = p
token_pos (Cmp p) = p
token_pos (Je p) = p
token_pos (Jne p) = p
token_pos (Jl p) = p
token_pos (Jle p) = p
token_pos (Jg p) = p
token_pos (Jge p) = p
token_pos (Call p) = p
token_pos (Ret p) = p
token_pos (Enter p) = p
token_pos (Leave p) = p
token_pos (Nop p) = p

token_pos (Dword p) = p
token_pos (Ptr p) = p

token_pos (Nat _ p) = p
token_pos (Label _ p) = p
token_pos (Temp _ p) = p
token_pos (Reg _ p) = p
token_pos (Id _ p) = p

