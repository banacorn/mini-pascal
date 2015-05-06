module Compiler.AST.Convert where

import Compiler.AST.Type

import qualified    Compiler.PreAST.Type as P
import qualified    Compiler.PreAST.Type.DataType as DT


map2 :: (a -> b -> c) -> [a] -> [b] -> [c]
map2 f a b = map (uncurry f) (zip a b)

convertProgram :: P.ABT -> Program
convertProgram (P.Program decs funcs) =
    Program (map convertVarDec varDecs) (map2 convertFuncDec funcDecs funcs)
    where   varDecs = take varNo decs
            funcDecs = drop varNo decs
            funcNo = length funcs
            extern = 1
            varNo = length decs - funcNo - extern

convertVarDec :: P.Declaration -> Variable
convertVarDec (P.Declaration (P.Symbol label _) _ _) = Variable label Declaration

convertFuncDec :: P.Declaration -> P.Subprogram P.Declaration (P.Statement P.Value) -> Function
convertFuncDec (P.Declaration (P.Symbol label _) typ _) (P.Subprogram decs stmts) =
    Function label returnType [] []
    where   returnType = DT.getReturnType typ == DT.BasicType DT.VoidType

-- data Program dec stmt = Program
--     [dec]                   --  program parameters, variable and subprogram declarations
--     [Subprogram dec stmt]   --  subprograms
--
-- data Subprogram dec stmt = Subprogram
--     [dec]                   --  variable and subprogram declarations
--     [stmt]                  --  compound statement

-- data Function = Function String Bool [Variable] [Statement]
-- data Program = Program [Variable] [Function]
