module Compiler.Type.ABT where

import Compiler.Type.Symbol
import qualified Compiler.Type.AST as AST
import Compiler.AST.Scope.Declaration

data Program = Program
    [Declaration]
    [Subprogram]
    [AST.Statement Variable]

data Subprogram = Subprogram
    [Declaration]
    [AST.Statement Variable]

-- fromAST :: AST.Program -> Program
-- fromAST p@(AST.Program _ _ _ _ _) = Program decs [] []
--     where
--         AST.Scope decs subScopes = collectDeclaration p
