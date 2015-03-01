module Compiler.Semantics
    (   declarationDuplicated
    ,   variableUndeclared
    ) where

import Compiler.Type

import              Data.Set (Set, size)
import              Data.Maybe (mapMaybe)

--------------------------------------------------------------------------------
-- Declarations Duplicated

-- Duplicate if
--      1. both are variables OR both are functions/procedures
--      2. have the same name
--      3. at the same level of scope
declarationDuplicated :: Scope (Set Declaration) -> [Set Declaration]
declarationDuplicated (Scope decs subScopes) =
    pickDuplicated decs ++ (subScopes >>= subScopeDeclarationDuplicated)
    where   pickDuplicated = filter ((> 1) . size)

subScopeDeclarationDuplicated :: SubScope (Set Declaration) -> [Set Declaration]
subScopeDeclarationDuplicated (SubScope decs _) = filter ((> 1) . size) decs

--------------------------------------------------------------------------------
-- Symbols Undeclared

variableUndeclared :: Scope Binding -> [Occurrence]
variableUndeclared (Scope _ subScopes) = subScopes >>= subScopeVariableUndeclared

subScopeVariableUndeclared :: SubScope Binding -> [Occurrence]
subScopeVariableUndeclared (SubScope _ occs) = mapMaybe free occs
    where   free (FreeVar occ) = Just occ
            free _ = Nothing
