module Compiler.AST.Scope.Declaration (collectDeclaration) where

import Compiler.Type
import Compiler.AST.Type
import Compiler.Type.AST
import Compiler.Type.Symbol

import Data.Set (Set)

collectDeclaration :: ProgramNode -> Scope (Set Declaration)
collectDeclaration (ProgramNode _ params vars subprogs _) = Scope (partite decs) subScopes
        where
            decs =  (params   >>= fromParams)
                 ++ (vars     >>= fromVars)
                 ++ (subprogs >>= fromSubprogs)
            subScopes = map subprogamDeclaration subprogs ++ [SubScope [] []]
            fromParams n = [toDeclaration (Type [ProgramParamType]) n]
            fromVars (VarDecNode ids t) = map (toDeclaration (getType t)) ids
            fromSubprogs n@(FuncDecNode sym _ ret _ _) = [toDeclaration (getType n) sym]
            fromSubprogs n@(ProcDecNode sym _     _ _) = [toDeclaration (getType n) sym]

subprogamDeclaration :: SubprogDecNode -> SubScope (Set Declaration)
subprogamDeclaration (FuncDecNode sym params ret vars stmt) = SubScope (partite decs) []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (ParameterNode ids t) = map (toDeclaration (getType t)) ids
        fromVars   (VarDecNode    ids t) = map (toDeclaration (getType t)) ids

subprogamDeclaration (ProcDecNode sym params vars stmt) = SubScope (partite decs) []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (ParameterNode ids t) = map (toDeclaration (getType t)) ids
        fromVars   (VarDecNode    ids t) = map (toDeclaration (getType t)) ids
