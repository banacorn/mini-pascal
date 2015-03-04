module Compiler.DSL.AST (toABT) where

import Compiler.Type
import Compiler.Type.DSL
import Compiler.DSL.RawAST.Statement

import qualified    Data.Set as Set
import              Data.Bifunctor


--------------------------------------------------------------------------------
toABT :: RawAST -> AST -> ABT
toABT raw ast = restoreStatement raw (bimap Set.findMin toValue ast)
