module Compiler.Type.ABT where

import           Compiler.Type.Symbol
import qualified Compiler.Type.AST as AST
import           Compiler.AST.Scope.Declaration
-- import           Compiler.AST.Scope.Binding
import Compiler.Class.Serializable

import           Data.Set (Set)
import qualified Data.Set as Set

data Program = Program
    [Declaration]
    [Subprogram]
    [AST.Statement Variable]

data Subprogram = Subprogram
    [Declaration]
    [AST.Statement Variable]

instance Serializable Program where
    serialize (Program decs subprogs stmts) = paragraph $
            0 >>>> ["Program"]
        ++  1 >>>> decs
        ++  1 >>>> subprogs
        ++  2 >>>> stmts

instance Serializable Subprogram where
    serialize (Subprogram decs stmts) = paragraph $
            0 >>>> ["Subprogram"]
        ++  1 >>>> decs
        ++  2 >>>> stmts


fromAST :: AST.Program -> Program
fromAST p@(AST.Program _ _ _ subprogs _) = Program
    decs
    (map toSubprogram (init subScopes))
    []
    where
        AST.Scope decs subScopes = fmap Set.findMin (collectDeclaration p)
        -- AST.Scope decs subScopes = fmap Set.findMin (collectDeclaration p)
        toSubprogram :: AST.SubScope Declaration -> Subprogram
        toSubprogram (AST.SubScope decs _) = Subprogram decs []
--
-- fromASTSubprog :: AST.SubprogDec -> Subprogram
-- fromASTSubprog p@(AST.FuncDec _ _ _ _ _) = Subprogram
--     where
-- fromASTSubprog p@(AST.ProcDec _ _   _ _)
