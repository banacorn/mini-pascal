module Compiler.AST.Raw.Declaration (collectDeclaration) where

import Compiler.Syntax.Type
import Compiler.AST.Type
import Compiler.AST.Raw.DataType

import Data.Set (Set)

collectDeclaration :: RawProgram -> Program (Set Declaration) ()
collectDeclaration (RawProgram _ _ vars subprogs _) = Program
        (partite decs)
        (map collectSubprogramDeclaration subprogs)
        (Subprogram [] [])
        where
            decs =  (vars     >>= fromVars)
                 ++ (subprogs >>= fromSubprogs)
            fromVars (VarDec ids t) = map (flip Declaration (getType t)) ids
            fromSubprogs n@(FuncDec sym _ ret _ _) = [Declaration sym (getType n)]

collectSubprogramDeclaration :: RawSubprogram -> Subprogram (Set Declaration) ()
collectSubprogramDeclaration (FuncDec sym params ret vars stmt) = Subprogram (partite decs) []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (Parameter ids t) = map (flip Declaration (getType t)) ids
        fromVars   (VarDec    ids t) = map (flip Declaration (getType t)) ids
