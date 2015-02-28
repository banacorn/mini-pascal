module Compiler.Scope.Occurrence where

import Compiler.Type
import Compiler.Scope.Type

--------------------------------------------------------------------------------
-- Class & Instances of HasScope

class HasOccurrenceScope a where
    getOccurrenceScope :: a -> Scope Occurrence

instance HasOccurrenceScope ProgramNode where
    getOccurrenceScope p@(ProgramNode sym _ _ subprogs stmts) = Scope scopeType scopes []
        where
            scopeType = ProgramScope (fst sym)
            scopes = map getOccurrenceScope subprogs ++ [getOccurrenceScope stmts]

instance HasOccurrenceScope SubprogDecNode where
    getOccurrenceScope p@(FuncDecNode sym _ _ _ stmts) = Scope scopeType scopes []
        where
            scopeType = RegularScope (toDeclaration (getType p) sym)
            scopes = [getOccurrenceScope stmts]
    getOccurrenceScope p@(ProcDecNode sym _ _ stmts) = Scope scopeType scopes []
        where
            scopeType = RegularScope (toDeclaration (getType p) sym)
            scopes = [getOccurrenceScope stmts]

instance HasOccurrenceScope CompoundStmtNode where
    getOccurrenceScope p@(CompoundStmtNode stmts) = Scope CompoundStmtScope (map getOccurrenceScope stmts) []

instance HasOccurrenceScope StmtNode where
    getOccurrenceScope p@(AssignStmtNode var expr) =
        Scope CompoundStmtScope [] (getOccurrence p)
    getOccurrenceScope p@(SubprogInvokeStmtNode sym exprs) =
        Scope CompoundStmtScope [] (getOccurrence p)
    getOccurrenceScope p@(CompStmtNode stmts) =
        Scope CompoundStmtScope [getOccurrenceScope stmts] []
    getOccurrenceScope p@(BranchStmtNode predExpr thenStmt elseStmt) =
        Scope CompoundStmtScope scopes (getOccurrence predExpr)
        where   scopes = [getOccurrenceScope thenStmt] ++ [getOccurrenceScope elseStmt]
    getOccurrenceScope p@(LoopStmtNode expr stmt) =
        Scope CompoundStmtScope [getOccurrenceScope stmt] (getOccurrence expr)


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
