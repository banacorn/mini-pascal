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
convertFuncDec (P.Declaration (P.Symbol label _) typ _) (P.Subprogram decs statements) =
    Function label returnType parameters varDecs body
    where   returnType = DT.getReturnType typ == DT.BasicType DT.VoidType
            parameters = [ convertDeclaration dec | dec <- decs, P.decPlace dec == P.InParam ]
            varDecs    = [ convertDeclaration dec | dec <- decs, P.decPlace dec == P.InLocal ]
            body = map convertStatement statements

convertDeclaration :: P.Declaration -> Variable
convertDeclaration (P.Declaration (P.Symbol label _) _ _) = Variable label Declaration

-- convertValue :: P.Value -> Variable
-- convertValue (P.Variable label _) =


-- data Value  = Variable Symbol Declaration
--             | IntLiteral Int Position
--             | RealLiteral Double Position
-- convertStatement :: P.Statement P.Value -> Statement
-- convertStatement (P.Assignment var expr) = Assignment _ _
convertStatement _ = undefined
-- convertStatement (P.Return expr) = _
-- convertStatement (P.Invocation var expr) = _
-- convertStatement (P.Compound stmts) = _
-- convertStatement (P.Branch expr stmt0 stmt1) = _
-- convertStatement (P.Loop expr stmt) = _
--
-- data Statement  = Assignment Variable
--                 | Return Expression
--                 | Invocation Variable Expression
--                 | Compound [Statement]
--                 | Branch Expression Statement Statement
--                 | Loop Expression Statement
