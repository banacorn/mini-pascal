module Compiler.AST.Convert where

import Compiler.AST.Type

import qualified    Compiler.PreAST.Type as P

convertProgram :: P.ABT -> Program
convertProgram (P.Program decs funcs) = Program (map convertVarDec varDecs) []
    where   varDecs = take varNo decs
            funcDecs = drop varNo decs
            funcNo = length funcs
            extern = 1
            varNo = length decs - funcNo - extern

convertVarDec :: P.Declaration -> Variable
convertVarDec (P.Declaration (P.Symbol label _) _) = Variable label Declaration
--
-- data Program dec stmt = Program
--     [dec]                   --  program parameters, variable and subprogram declarations
--     [Subprogram dec stmt]   --  subprograms
--
-- data Subprogram dec stmt = Subprogram
--     [dec]                   --  variable and subprogram declarations
--     [stmt]                  --  compound statement
