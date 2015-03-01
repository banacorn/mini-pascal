module Compiler.AST.Scope.Occurrence (collectOccurrence) where

import Compiler.Type
import Compiler.AST.Type
import Compiler.Type.Symbol

import Data.Set (Set)

collectOccurrence :: ProgramNode -> Scope Occurrence
collectOccurrence (ProgramNode _ _ _ subprogs stmts) = Scope [] subScopes
        where
            subScopes = map subprogamOccurrence subprogs ++ [SubScope [] (getOccurrence stmts)]

subprogamOccurrence :: SubprogDecNode -> SubScope Occurrence
subprogamOccurrence (FuncDecNode _ _ _ _ stmts) = SubScope [] (getOccurrence stmts)
subprogamOccurrence (ProcDecNode _ _ _ stmts) = SubScope [] (getOccurrence stmts)

--------------------------------------------------------------------------------
-- Class & Instances of HasDeclaration

class HasOccurrence a where
    getOccurrence :: a -> [Occurrence]
    getOccurrence _ = []

instance HasOccurrence CompoundStmtNode where
    getOccurrence (CompoundStmtNode stmts) = stmts >>= getOccurrence

instance HasOccurrence StmtNode where
    getOccurrence (AssignStmtNode var expr) = getOccurrence var ++ getOccurrence expr
    getOccurrence (SubprogInvokeStmtNode sym exprs) = toOccurrence sym : (exprs >>= getOccurrence)
    getOccurrence (CompStmtNode stmts) = getOccurrence stmts
    getOccurrence (BranchStmtNode predExpr thenStmt elseStmt) =
            getOccurrence predExpr
        ++  getOccurrence thenStmt
        ++  getOccurrence elseStmt
    getOccurrence (LoopStmtNode expr stmt) = getOccurrence expr ++ getOccurrence stmt

instance HasOccurrence VariableNode where
    getOccurrence (VariableNode sym exprs) = toOccurrence sym : (exprs >>= getOccurrence)

instance HasOccurrence ExprNode where
    getOccurrence (UnaryExprNode expr) = getOccurrence expr
    getOccurrence (BinaryExprNode expr0 _ expr1) = getOccurrence expr0 ++ getOccurrence expr1

instance HasOccurrence SimpleExprNode where
    getOccurrence (SimpleExprTermNode term) = getOccurrence term
    getOccurrence (SimpleExprOpNode expr _ term) = getOccurrence expr ++ getOccurrence term

instance HasOccurrence TermNode where
    getOccurrence (FactorTermNode factor) = getOccurrence factor
    getOccurrence (OpTermNode term _ factor) = getOccurrence term ++ getOccurrence factor
    getOccurrence (NegTermNode factor) = getOccurrence factor

instance HasOccurrence FactorNode where
    getOccurrence (ArrayAccessFactorNode   sym exprs) = toOccurrence sym : (exprs >>= getOccurrence)
    getOccurrence (SubprogInvokeFactorNode sym exprs) = toOccurrence sym : (exprs >>= getOccurrence)
    getOccurrence (NumFactorNode num) = []
    getOccurrence (SubFactorNode expr) = getOccurrence expr
    getOccurrence (NotFactorNode factor) = getOccurrence factor
