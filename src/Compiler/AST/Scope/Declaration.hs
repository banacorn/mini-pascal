module Compiler.AST.Scope.Declaration (collectDeclaration) where

import Compiler.Type
import Compiler.AST.Type
import Compiler.Type.Symbol

collectDeclaration :: ProgramNode -> Scope Declaration
collectDeclaration (ProgramNode _ params vars subprogs _) = Scope decs subDecs
        where
            decs =  (params   >>= fromParams)
                 ++ (vars     >>= fromVars)
                 ++ (subprogs >>= fromSubprogs)
            subDecs = map subprogamDeclaration subprogs
            fromParams n = [toDeclaration (FO ProgramParamType) n]
            fromVars (VarDecNode ids t) = map (toDeclaration (getType t)) ids
            fromSubprogs n@(FuncDecNode sym _ ret _ _) = [toDeclaration (getType n) sym]
            fromSubprogs n@(ProcDecNode sym _     _ _) = [toDeclaration (getType n) sym]

subprogamDeclaration :: SubprogDecNode -> SubScope Declaration
subprogamDeclaration (FuncDecNode sym params ret vars stmt) = SubScope decs []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (ParameterNode ids t) = map (toDeclaration (getType t)) ids
        fromVars   (VarDecNode    ids t) = map (toDeclaration (getType t)) ids

subprogamDeclaration (ProcDecNode sym params vars stmt) = SubScope decs []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (ParameterNode ids t) = map (toDeclaration (getType t)) ids
        fromVars   (VarDecNode    ids t) = map (toDeclaration (getType t)) ids
