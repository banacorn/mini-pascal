module Compiler.AST.Raw.Declaration (collectDeclaration) where

import Compiler.Type
import Compiler.AST.Type
import Compiler.Type.AST
import Compiler.Type.Symbol

import Data.Set (Set)

collectDeclaration :: RawProgram -> Program (Set Declaration) ()
collectDeclaration (RawProgram _ params vars subprogs _) = Program
        (partite decs)
        (map collectSubprogramDeclaration subprogs)
        (Subprogram [] [])
        where
            decs =  (map (flip Declaration (Type [ProgramParamType])) params)
                 ++ (vars     >>= fromVars)
                 ++ (subprogs >>= fromSubprogs)
            fromVars (VarDec ids t) = map (flip Declaration (getType t)) ids
            fromSubprogs n@(FuncDec sym _ ret _ _) = [Declaration sym (getType n)]
            fromSubprogs n@(ProcDec sym _     _ _) = [Declaration sym (getType n)]

collectSubprogramDeclaration :: RawSubprogram -> Subprogram (Set Declaration) ()
collectSubprogramDeclaration (FuncDec sym params ret vars stmt) = Subprogram (partite decs) []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (Parameter ids t) = map (flip Declaration (getType t)) ids
        fromVars   (VarDec    ids t) = map (flip Declaration (getType t)) ids

collectSubprogramDeclaration (ProcDec sym params vars stmt) = Subprogram (partite decs) []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (Parameter ids t) = map (flip Declaration (getType t)) ids
        fromVars   (VarDec    ids t) = map (flip Declaration (getType t)) ids
