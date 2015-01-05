module Compiler.Type.Scope where

type Depth = Int

data Symbol = Declared String
            | Used String
            deriving (Eq, Show)
type SymbolTable = [(Symbol, Depth)]

data Scope  = Scope String [Symbol] [Scope]
    deriving (Eq, Show)
