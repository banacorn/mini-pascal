module Compiler.Codegen.Instruction where

import Compiler.Codegen.State

import LLVM.General.AST.Type hiding (void)
import LLVM.General.AST
import qualified LLVM.General.AST.Constant as C
import qualified LLVM.General.AST.CallingConvention as CC
import qualified LLVM.General.AST.IntegerPredicate as IP


terminateAnyway :: Bool -> Codegen ()
terminateAnyway isVoid = do
    current <- getCurrentBlock
    case term current of
        Just x -> return ()
        Nothing -> do
            if isVoid then retVoid else ret (literal 0)
            return ()

--------------------------------------------------------------------------------
--  Reference
--------------------------------------------------------------------------------

local ::  Name -> Operand
local = LocalReference i32

global ::  Name -> Operand
global = ConstantOperand . C.GlobalReference i32

--------------------------------------------------------------------------------
--  Arithmetic and Constants
--------------------------------------------------------------------------------

literal :: Int -> Operand
literal n = ConstantOperand $ C.Int 32 (toInteger n)

add :: Operand -> Operand -> Codegen Operand
add a b = instr $ Add True True a b []

sub :: Operand -> Operand -> Codegen Operand
sub a b = instr $ Sub True True a b []

mul :: Operand -> Operand -> Codegen Operand
mul a b = instr $ Mul True True a b []

sdiv :: Operand -> Operand -> Codegen Operand
sdiv a b = instr $ SDiv True a b []

cmp :: Operand -> Operand -> IP.IntegerPredicate -> Codegen Operand
cmp a b ip = do
    result <- instr $ ICmp ip a b []
    instr $ ZExt result i32 []

--------------------------------------------------------------------------------
--  Effects
--------------------------------------------------------------------------------

call :: Operand -> [Operand] -> Codegen Operand
call fn args = instr $ Call False CC.C [] (Right fn) (map toArg args) [] []
    where   toArg a = (a, [])

alloca :: Codegen Operand
alloca = instr $ Alloca i32 Nothing 0 []

store :: Operand -> Operand -> Codegen Operand
store ptr val = instr $ Store False ptr val Nothing 0 []

load :: Operand -> Codegen Operand
load ptr = instr $ Load False ptr Nothing 0 []

--------------------------------------------------------------------------------
--  Control Flow
--------------------------------------------------------------------------------

br :: Name -> Codegen (Named Terminator)
br val = terminator $ Do $ Br val []

cbr :: Operand -> Name -> Name -> Codegen (Named Terminator)
cbr cond tr fl = do
    cond' <- instr $ Trunc cond i1 []
    terminator $ Do $ CondBr cond' tr fl []

retVoid :: Codegen (Named Terminator)
retVoid = terminator $ Do $ Ret Nothing []

ret :: Operand -> Codegen (Named Terminator)
ret val = terminator $ Do $ Ret (Just val) []

ret' :: Operand -> Codegen Operand
ret' val = ret val >> return val
