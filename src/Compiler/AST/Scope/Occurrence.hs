 {-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies #-}

module Compiler.AST.Scope.Occurrence (collectOccurrence) where

import Compiler.Type
import Compiler.Type.AST

collectOccurrence :: Program -> Scope Occurrence
collectOccurrence (Program _ _ _ subprogs stmts) = Scope [] subScopes
        where
            subScopes = map subprogamOccurrence subprogs ++ [SubScope [] (stmts >>= getOccurrence)]

subprogamOccurrence :: SubprogDec -> SubScope Occurrence
subprogamOccurrence (FuncDec _ _ _ _ stmts) = SubScope [] (stmts >>= getOccurrence)
subprogamOccurrence (ProcDec _ _ _ stmts) = SubScope [] (stmts >>= getOccurrence)

--------------------------------------------------------------------------------
-- Class & Instances of HasDeclaration

class HasOccurrence n where
    getOccurrence :: n a -> [a]
    getOccurrence _ = []

instance HasOccurrence Statement where
    getOccurrence (Assignment var expr) = getOccurrence var ++ getOccurrence expr
    getOccurrence (Invocation sym exprs) = sym : (exprs >>= getOccurrence)
    getOccurrence (Compound stmts) = stmts >>= getOccurrence
    getOccurrence (Branch predExpr thenStmt elseStmt) =
            getOccurrence predExpr
        ++  getOccurrence thenStmt
        ++  getOccurrence elseStmt
    getOccurrence (Loop expr stmt) = getOccurrence expr ++ getOccurrence stmt

instance HasOccurrence Assignee where
    getOccurrence (Assignee sym exprs) = sym : (exprs >>= getOccurrence)

instance HasOccurrence Expression where
    getOccurrence (UnaryExpression expr) = getOccurrence expr
    getOccurrence (BinaryExpression expr0 _ expr1) = getOccurrence expr0 ++ getOccurrence expr1

instance HasOccurrence SimpleExpression where
    getOccurrence (TermSimpleExpression term) = getOccurrence term
    getOccurrence (OpSimpleExpression expr _ term) = getOccurrence expr ++ getOccurrence term

instance HasOccurrence Term where
    getOccurrence (FactorTerm factor) = getOccurrence factor
    getOccurrence (OpTerm term _ factor) = getOccurrence term ++ getOccurrence factor
    getOccurrence (NegTerm factor) = getOccurrence factor

instance HasOccurrence Factor where
    getOccurrence (ArrayAccessFactor sym exprs) = sym : (exprs >>= getOccurrence)
    getOccurrence (InvocationFactor  sym exprs) = sym : (exprs >>= getOccurrence)
    getOccurrence (NumberFactor num) = []
    getOccurrence (SubFactor expr) = getOccurrence expr
    getOccurrence (NotFactor factor) = getOccurrence factor
