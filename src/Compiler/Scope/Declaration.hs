module Compiler.Scope.Declaration where

import Compiler.Type
import Compiler.Scope.Type

--------------------------------------------------------------------------------
-- Class & Instances of HasScope

class HasDeclarationScope a where
    getDeclarationScope :: a -> Scope (EqClass Declaration)

instance HasDeclarationScope ProgramNode where
    getDeclarationScope p@(ProgramNode sym _ _ subprogs stmts) = Scope scopeType scopes vars
        where
            scopeType = ProgramScope (fst sym)
            vars = partite (getDeclaration p)
            scopes = map getDeclarationScope subprogs ++ [getDeclarationScope stmts]

instance HasDeclarationScope SubprogDecNode where
    getDeclarationScope p@(FuncDecNode sym _ _ _ stmts) = Scope scopeType scopes vars
        where
            scopeType = RegularScope (toSymbol (getType p) sym)
            vars = partite (getDeclaration p)
            scopes = [getDeclarationScope stmts]
    getDeclarationScope p@(ProcDecNode sym _ _ stmts) = Scope scopeType scopes vars
        where
            scopeType = RegularScope (toSymbol (getType p) sym)
            vars = partite (getDeclaration p)
            scopes = [getDeclarationScope stmts]

instance HasDeclarationScope CompoundStmtNode where
    getDeclarationScope p@(CompoundStmtNode stmts) = Scope CompoundStmtScope [] []

--------------------------------------------------------------------------------
-- Class & Instances of HasDeclaration

class HasDeclaration a where
    getDeclaration :: a -> [Symbol]

instance HasDeclaration ProgramNode where
    getDeclaration (ProgramNode _ params vars subprogs _) =
        (params   >>= fromParams) ++
        (vars     >>= fromVars) ++
        (subprogs >>= fromSubprogs)
        where
            fromParams n = [toSymbol (FO ProgramParamType) n]
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
            fromSubprogs n@(FuncDecNode sym _ ret _ _) = [toSymbol (getType n) sym]
            fromSubprogs n@(ProcDecNode sym _     _ _) = [toSymbol (getType n) sym]

instance HasDeclaration SubprogDecNode where
    getDeclaration (FuncDecNode sym params ret vars stmt) =
        (params >>= fromParams) ++
        (vars >>= fromVars)
        where
            fromParams (ParameterNode ids t) = map (toSymbol (getType t)) ids
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
    getDeclaration (ProcDecNode sym params vars stmt) =
        (params >>= fromParams) ++
        (vars >>= fromVars)
        where
            fromParams (ParameterNode ids t) = map (toSymbol (getType t)) ids
            fromVars (VarDecNode ids t) = map (toSymbol (getType t)) ids
