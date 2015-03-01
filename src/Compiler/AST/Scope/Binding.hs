module Compiler.AST.Scope.Binding (collectBinding) where

import Compiler.Type

import              Data.List (find)
import              Data.Set (Set)
import qualified    Data.Set as Set


collectBinding :: Scope (Set Declaration) -> Scope Occurrence -> Scope (Binding)
collectBinding (Scope globalDecs subDecs) (Scope _ subOccs) = Scope [] subScopes
    where   subScopes = map (uncurry (bindSubScope globalDecs)) (zip subDecs subOccs)

findBinding :: [Set Declaration] -> Occurrence -> Binding
findBinding decs o@(Occurrence name _) = case find match decs of
    Just dec -> BoundVar o dec
    Nothing  -> FreeVar o
    where   match set = decID (Set.findMin set) == name

bindSubScope :: [Set Declaration] -> SubScope (Set Declaration) -> SubScope Occurrence -> SubScope Binding
bindSubScope globalDecs (SubScope localDecs _) (SubScope _ occurs) =
    SubScope [] (map (findBinding (localDecs ++ globalDecs)) occurs)
