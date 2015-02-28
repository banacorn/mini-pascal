module Compiler.Interpret.Binding where

import Compiler.Type

import Data.List (find)
-- import Compiler.Interpret.Type

--------------------------------------------------------------------------------
-- Class & Instances of HasBinding

findBinding :: [EqClass Declaration] -> Occurrence -> Binding
findBinding decs (Occurrence name _) = find match decs
    where   match eqClass = let Symbol t i p = head eqClass in i == name

zipMaybe :: [a] -> [b] -> [(Maybe a, b)]
zipMaybe (x:xs) (y:ys) = (Just x , y) : zipMaybe xs ys
zipMaybe (x:xs) []     = []
zipMaybe []     (y:ys) = (Nothing, y) : zipMaybe [] ys
zipMaybe []     []     = []

buildBindingTree :: [EqClass Declaration] -> Maybe (Scope (EqClass Declaration)) -> Scope Occurrence -> Scope Binding
buildBindingTree acc (Just (Scope _ s decs)) (Scope t s' occs) = Scope t subScopes bindings
    where   subScopes = map (uncurry (buildBindingTree (decs ++ acc))) (zipMaybe s s')
            bindings = map (findBinding acc) occs
buildBindingTree acc Nothing                 (Scope t s' occs) = Scope t subScopes bindings
    where   subScopes = map (uncurry (buildBindingTree acc)) (zipMaybe [] s')
            bindings = map (findBinding acc) occs
