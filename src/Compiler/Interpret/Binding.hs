module Compiler.Interpret.Binding where

import Compiler.Type

import Data.List (find)
-- import Compiler.Interpret.Type

--------------------------------------------------------------------------------
-- Class & Instances of HasBinding

findBinding :: [EqClass Declaration] -> Occurrence -> Binding
findBinding decs (Occurrence name _) = find match decs
    where   match eqClass = let Symbol t i p = head eqClass in i == name

buildBindingTree :: [EqClass Declaration] -> Scope (EqClass Declaration) -> Scope Occurrence -> Scope Binding
buildBindingTree acc (Scope t s decs) (Scope _ s' occs) = Scope t subScopes bindings
    where   subScopes = map buildSubTrees (zip s s')
            bindings = map (findBinding acc) occs
            buildSubTrees (decScope, occScope) = buildBindingTree (decs ++ acc) decScope occScope
