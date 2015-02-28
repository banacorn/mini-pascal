module Compiler.Scope.Declaration where

import Compiler.Type
import Compiler.Scope.Type

import              Data.Set (Set)
import qualified    Data.Set as Set

--------------------------------------------------------------------------------
-- Class & Instances of HasScope

class HasDeclarationScope a where
    getDeclarationScope :: a -> Scope (Set Declaration)

instance HasDeclarationScope ProgramNode where
    getDeclarationScope p@(ProgramNode sym _ _ subprogs stmts) = Scope scopeType scopes vars
        where
            scopeType = ProgramScope (fst sym)
            vars = partite (getDeclaration p)
            scopes = map getDeclarationScope subprogs ++ [getDeclarationScope stmts]

instance HasDeclarationScope SubprogDecNode where
    getDeclarationScope p@(FuncDecNode sym _ _ _ stmts) = Scope scopeType scopes vars
        where
            scopeType = RegularScope (toDeclaration (getType p) sym)
            vars = partite (getDeclaration p)
            scopes = [getDeclarationScope stmts]
    getDeclarationScope p@(ProcDecNode sym _ _ stmts) = Scope scopeType scopes vars
        where
            scopeType = RegularScope (toDeclaration (getType p) sym)
            vars = partite (getDeclaration p)
            scopes = [getDeclarationScope stmts]

instance HasDeclarationScope CompoundStmtNode where
    getDeclarationScope p@(CompoundStmtNode stmts) = Scope CompoundStmtScope [] []

--------------------------------------------------------------------------------
-- Class & Instances of HasDeclaration

class HasDeclaration a where
    getDeclaration :: a -> [Declaration]

instance HasDeclaration ProgramNode where
    getDeclaration (ProgramNode _ params vars subprogs _) =
        (params   >>= fromParams) ++
        (vars     >>= fromVars) ++
        (subprogs >>= fromSubprogs)
        where
            fromParams n = [toDeclaration (FO ProgramParamType) n]
            fromVars (VarDecNode ids t) = map (toDeclaration (getType t)) ids
            fromSubprogs n@(FuncDecNode sym _ ret _ _) = [toDeclaration (getType n) sym]
            fromSubprogs n@(ProcDecNode sym _     _ _) = [toDeclaration (getType n) sym]

instance HasDeclaration SubprogDecNode where
    getDeclaration (FuncDecNode sym params ret vars stmt) =
        (params >>= fromParams) ++
        (vars >>= fromVars)
        where
            fromParams (ParameterNode ids t) = map (toDeclaration (getType t)) ids
            fromVars (VarDecNode ids t) = map (toDeclaration (getType t)) ids
    getDeclaration (ProcDecNode sym params vars stmt) =
        (params >>= fromParams) ++
        (vars >>= fromVars)
        where
            fromParams (ParameterNode ids t) = map (toDeclaration (getType t)) ids
            fromVars (VarDecNode ids t) = map (toDeclaration (getType t)) ids
