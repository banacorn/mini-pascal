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

convertVariable :: P.Value -> Variable
convertVariable (P.Variable (P.Symbol label _) (P.Declaration _ _ P.InGlobal)) = Variable label Global
convertVariable (P.Variable (P.Symbol label _) (P.Declaration _ _ P.InParam)) = Variable label Local
convertVariable (P.Variable (P.Symbol label _) (P.Declaration _ _ P.InLocal)) = Variable label Local
convertVariable _ = error "not variable"

convertLiteral :: P.Value -> Literal
convertLiteral (P.IntLiteral n _) = Literal n
convertLiteral _ = error "not int literal"

-- data Value  = Variable Symbol Declaration
--             | IntLiteral Int Position
--             | RealLiteral Double Position
convertStatement :: P.Statement P.Value -> Statement
convertStatement (P.Assignment var expr) = Assignment (convertVariable var) (convertExpression expr)
convertStatement _ = undefined
-- convertStatement (P.Return expr) = _
-- convertStatement (P.Invocation var expr) = _
-- convertStatement (P.Compound stmts) = _
-- convertStatement (P.Branch expr stmt0 stmt1) = _
-- convertStatement (P.Loop expr stmt) = _

convertExpression :: P.Expression P.Value -> Expression
convertExpression _ = undefined

-- data Statement  = Assignment Variable
--                 | Return Expression
--                 | Invocation Variable Expression
--                 | Compound [Statement]
--                 | Branch Expression Statement Statement
--                 | Loop Expression Statement

-- Convert

convertFactor :: P.Factor P.Value -> Factor
convertFactor (P.VariableFactor var) = VariableFactor (convertVariable var)
convertFactor (P.NumberFactor lit) = LiteralFactor (convertLiteral lit)
convertFactor (P.InvocationFactor var exprs) = InvocationFactor (convertVariable var) (map convertExpression exprs)
convertFactor (P.SubFactor expr) = SubFactor (convertExpression expr)
convertFactor (P.NotFactor factor) = NotFactor (convertFactor factor)


convertAddOp :: P.AddOp -> AddOp
convertAddOp P.Plus = Plus
convertAddOp P.Minus = Minus

convertMulOp :: P.MulOp -> MulOp
convertMulOp P.Mul = Mul
convertMulOp P.Div = Div

convertRelOp :: P.RelOp -> RelOp
convertRelOp P.S = S
convertRelOp P.L = L
convertRelOp P.E = E
convertRelOp P.NE = NE
convertRelOp P.SE = SE
convertRelOp P.LE = LE
--
--
-- data Expression = UnaryExpression SimpleExpression
--                 | BinaryExpression SimpleExpression RelOp SimpleExpression
--
-- data SimpleExpression = TermSimpleExpression Term
--                       | OpSimpleExpression SimpleExpression AddOp Term
--
-- data Term = FactorTerm Factor
--           | OpTerm Term MulOp Factor
--           | NegTerm Factor
--
-- data Factor = VariableFactor    Variable
--             | LiteralFactor     Literal
--             | InvocationFactor  Variable [Expression]   -- id()
--             | SubFactor         Expression              -- (...)
--             | NotFactor         Factor                  -- -id
