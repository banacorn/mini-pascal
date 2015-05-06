module Compiler.AST (convert) where

import Compiler.AST.Type
import Compiler.AST.Convert

import qualified Compiler.PreAST.Type as P


convert :: P.ABT -> Program
convert = convertProgram
--
-- addExternFuncs :: Program -> Program
-- addExternFuncs (Program vars funcs) = Program vars (extern : funcs)
--     where   extern = Function "putchar" False [Variable "input" Local] [] []
