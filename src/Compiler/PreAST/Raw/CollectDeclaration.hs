module Compiler.PreAST.Raw.CollectDeclaration (collectDeclaration) where

import Compiler.Syntax.Type
import Compiler.PreAST.Type

import Data.Set (Set)

collectDeclaration :: RawProgram -> Program (Set Declaration) ()
collectDeclaration (RawProgram _ _ vars subprogs) = Program
        (partite decs)
        (map collectSubprogramDeclaration subprogs)
        where
            decs =  (vars     >>= fromVars)
                 ++ (subprogs >>= fromSubprogs)
                 ++ [putcharFunc]
            fromVars (VarDec ids t) = map (\label -> Declaration label (getType t) False) ids
            fromSubprogs n@(FuncDec sym _ ret _ _) = [Declaration sym (getType n) False]
            -- printIntFunc = Declaration (Symbol "printInt" Unknown) (FunctionType [IntType])
            -- printRealFunc = Declaration (Symbol "printReal" Unknown) (FunctionType [RealType])
            putcharFunc = Declaration (Symbol "putchar" Unknown) (FunctionType [IntType, IntType]) False

collectSubprogramDeclaration :: RawSubprogram -> Subprogram (Set Declaration) ()
collectSubprogramDeclaration (FuncDec sym params ret vars stmt) = Subprogram (partite decs) []
    where
        decs = (params >>= fromParams) ++ (vars >>= fromVars)
        fromParams (Parameter ids t) = map (\label -> Declaration label (getType t) True) ids
        fromVars   (VarDec    ids t) = map (\label -> Declaration label (getType t) False) ids
