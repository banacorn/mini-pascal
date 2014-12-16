module Compiler.Type.Scope where

type Depth = Int
type Symbol = String
type SymbolTable = [(Symbol, Depth)]

data Scope  = Scope String [Symbol] [Scope]
    deriving (Eq, Show)
