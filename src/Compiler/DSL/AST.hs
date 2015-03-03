module Compiler.DSL.AST (toABT) where

import Compiler.Type
import Compiler.Type.DSL

import qualified    Data.Set as Set
import              Data.Bifunctor


--------------------------------------------------------------------------------
toABT :: AST -> ABT
toABT = bimap Set.findMin toValue
