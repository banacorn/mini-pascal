module Compiler.AST.Raw.CollectDeclaration (collectDeclaration) where

import Compiler.Syntax.Type
import Compiler.AST.Type

import Data.Set (Set)

collectDeclaration :: RawProgram -> Program (Set Declaration) ()
collectDeclaration (RawProgram _ _ vars subprogs) = Program
        (partite decs)
        (map collectSubprogramDeclaration subprogs)
        where
            decs =  (vars     >>= fromVars)
                 ++ (subprogs >>= fromSubprogs)
                 ++ [putcharFunc]
            fromVars (VarDec ids t) = map (flip Declaration (getType t)) ids
            fromSubprogs n@(FuncDec sym _ ret _ _) = [Declaration sym (getType n)]
            -- printIntFunc = Declaration (Symbol "printInt" Unknown) (FunctionType [IntType])
            -- printRealFunc = Declaration (Symbol "printReal" Unknown) (FunctionType [RealType])
            putcharFunc = Declaration (Symbol "putchar" Unknown) (FunctionType [IntType, IntType])

collectSubprogramDeclaration :: RawSubprogram -> Subprogram (Set Declaration) ()
collectSubprogramDeclaration (FuncDec sym params ret vars stmt) = Subprogram (partite decs) []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (Parameter ids t) = map (flip Declaration (getType t)) ids
        fromVars   (VarDec    ids t) = map (flip Declaration (getType t)) ids
