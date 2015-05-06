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

convertStatement :: P.Statement P.Value -> Statement
convertStatement (P.Assignment var expr) = Assignment (convertVariable var) (convertExpression expr)
convertStatement (P.Return expr) = Return (convertExpression expr)
convertStatement (P.Invocation var exprs) = Invocation (convertVariable var) (map convertExpression exprs)
convertStatement (P.Compound stmts) = Compound (map convertStatement stmts)
convertStatement (P.Branch expr stmt0 stmt1) = Branch (convertExpression expr) (convertStatement stmt0) (convertStatement stmt1)
convertStatement (P.Loop expr stmt) = Loop (convertExpression expr) (convertStatement stmt)

convertExpression :: P.Expression P.Value -> Expression
convertExpression (P.UnaryExpression simpleExpr) = UnaryExpression (convertSimpleExpression simpleExpr)
convertExpression (P.BinaryExpression simpleExpr0 relOp simpleExpr1) = BinaryExpression (convertSimpleExpression simpleExpr0) (convertRelOp relOp) (convertSimpleExpression simpleExpr1)

convertSimpleExpression :: P.SimpleExpression P.Value -> SimpleExpression
convertSimpleExpression (P.TermSimpleExpression term) = TermSimpleExpression (convertTerm term)
convertSimpleExpression (P.OpSimpleExpression simpleExpr addOp term) = OpSimpleExpression (convertSimpleExpression simpleExpr) (convertAddOp addOp) (convertTerm term)

convertTerm :: P.Term P.Value -> Term
convertTerm (P.FactorTerm factor) = FactorTerm (convertFactor factor)
convertTerm (P.OpTerm term mulOp factor) = OpTerm (convertTerm term) (convertMulOp mulOp) (convertFactor factor)
convertTerm (P.NegTerm factor) = NegTerm (convertFactor factor)

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
