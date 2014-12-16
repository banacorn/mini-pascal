module Compiler.Class.Scope where

instance Serializable Scope where
    serialize (Scope name symbols scopes) =
        "Scope: " ++ name ++ "\n" ++
        indent ([show symbols] ++ map serialize scopes)

class HasScope a where
    getScope :: a -> [Scope]

class HasID a where
    getID :: a -> String

class HasSymbol a where
    getSymbol :: a -> [String]


withDepth :: Int -> [String] -> SymbolTable
withDepth n xs = zip xs (repeat n)

succDepth :: SymbolTable -> SymbolTable
succDepth = map (\ (a, i) -> (a, succ i))