module Compiler.Scope.Binding where

import Compiler.Type

import              Data.List (find)
import              Data.Set (Set)
import qualified    Data.Set as Set

--------------------------------------------------------------------------------
-- Class & Instances of HasBinding

findBinding :: [Set Declaration] -> Occurrence -> Binding
findBinding decs o@(Occurrence name _) = case find match decs of
    Just dec -> BoundVar o dec
    Nothing  -> FreeVar o
    where   match set = decID (Set.findMin set) == name

zipMaybe :: [a] -> [b] -> [(Maybe a, b)]
zipMaybe (x:xs) (y:ys) = (Just x , y) : zipMaybe xs ys
zipMaybe (x:xs) []     = []
zipMaybe []     (y:ys) = (Nothing, y) : zipMaybe [] ys
zipMaybe []     []     = []

buildBindingTree :: [Set Declaration] -> Maybe (Scope (Set Declaration)) -> Scope Occurrence -> Scope Binding
buildBindingTree acc (Just (Scope _ s decs)) (Scope t s' occs) = Scope t subScopes bindings
    where   subScopes = map (uncurry (buildBindingTree (decs ++ acc))) (zipMaybe s s')
            bindings = map (findBinding acc) occs
buildBindingTree acc Nothing                 (Scope t s' occs) = Scope t subScopes bindings
    where   subScopes = map (uncurry (buildBindingTree acc)) (zipMaybe [] s')
            bindings = map (findBinding acc) occs
