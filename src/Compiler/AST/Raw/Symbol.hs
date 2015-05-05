module Compiler.AST.Raw.Symbol where

import Compiler.AST.Type
import Compiler.Syntax.Type

-- make the main compound statement a Subprogram
collectSymbol :: RawProgram -> Program () Symbol
collectSymbol (RawProgram _ _ _ subprogs) = Program
    []
    (map collectSubprogramSymbol subprogs)

collectSubprogramSymbol :: RawSubprogram -> Subprogram () Symbol
collectSubprogramSymbol (FuncDec _ _ _ _ stmts) = Subprogram [] (stmts >>= getSymbol)

--------------------------------------------------------------------------------
-- Class & Instances of HasSymbol

class HasSymbol n where
    getSymbol :: n a -> [a]
    getSymbol _ = []

instance HasSymbol Statement where
    getSymbol (Assignment sym expr) = sym : getSymbol expr
    getSymbol (Return expr) = getSymbol expr
    getSymbol (Invocation sym exprs) = sym : (exprs >>= getSymbol)
    getSymbol (Compound stmts) = stmts >>= getSymbol
    getSymbol (Branch predExpr thenStmt elseStmt) =
            getSymbol predExpr
        ++  getSymbol thenStmt
        ++  getSymbol elseStmt
    getSymbol (Loop expr stmt) = getSymbol expr ++ getSymbol stmt

instance HasSymbol Expression where
    getSymbol (UnaryExpression expr) = getSymbol expr
    getSymbol (BinaryExpression expr0 _ expr1) = getSymbol expr0 ++ getSymbol expr1

instance HasSymbol SimpleExpression where
    getSymbol (TermSimpleExpression term) = getSymbol term
    getSymbol (OpSimpleExpression expr _ term) = getSymbol expr ++ getSymbol term

instance HasSymbol Term where
    getSymbol (FactorTerm factor) = getSymbol factor
    getSymbol (OpTerm term _ factor) = getSymbol term ++ getSymbol factor
    getSymbol (NegTerm factor) = getSymbol factor

instance HasSymbol Factor where
    getSymbol (VariableFactor sym) = [sym]
    getSymbol (InvocationFactor  sym exprs) = sym : (exprs >>= getSymbol)
    getSymbol (NumberFactor num) = []
    getSymbol (SubFactor expr) = getSymbol expr
    getSymbol (NotFactor factor) = getSymbol factor
