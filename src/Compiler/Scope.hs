module Compiler.Scope where

import Compiler.Types

type SymbolTable = [ID]

data Scope = Scope SymbolTable [Scope]
    deriving (Eq, Show)

class HasScope a where
    collectScope :: a -> Scope
