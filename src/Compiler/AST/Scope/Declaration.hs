module Compiler.AST.Scope.Declaration (collectDeclaration) where

import Compiler.Type
import Compiler.AST.Type
import Compiler.Type.AST
import Compiler.Type.Symbol

import Data.Set (Set)

collectDeclaration :: Program -> Scope (Set Declaration) ()
collectDeclaration (Program _ params vars subprogs _) = Scope (partite decs) subScopes (SubScope [] [])
        where
            decs =  (map (flip Declaration (Type [ProgramParamType])) params)
                 ++ (vars     >>= fromVars)
                 ++ (subprogs >>= fromSubprogs)
            subScopes = map subprogamDeclaration subprogs
            fromVars (VarDec ids t) = map (flip Declaration (getType t)) ids
            fromSubprogs n@(FuncDec sym _ ret _ _) = [Declaration sym (getType n)]
            fromSubprogs n@(ProcDec sym _     _ _) = [Declaration sym (getType n)]

subprogamDeclaration :: SubprogDec -> SubScope (Set Declaration) ()
subprogamDeclaration (FuncDec sym params ret vars stmt) = SubScope (partite decs) []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (Parameter ids t) = map (flip Declaration (getType t)) ids
        fromVars   (VarDec    ids t) = map (flip Declaration (getType t)) ids

subprogamDeclaration (ProcDec sym params vars stmt) = SubScope (partite decs) []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (Parameter ids t) = map (flip Declaration (getType t)) ids
        fromVars   (VarDec    ids t) = map (flip Declaration (getType t)) ids
