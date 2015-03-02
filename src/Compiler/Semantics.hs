module Compiler.Semantics
    (   declarationDuplicated
    ,   variableUndeclared
    ) where

import Compiler.Type
import Compiler.Type.AST (Program(..), SubScope(..))
import              Data.Set (Set, size)
import              Data.Maybe (mapMaybe, isNothing)

--------------------------------------------------------------------------------
-- Declarations Duplicated

-- Duplicate if
--      1. both are variables OR both are functions/procedures
--      2. have the same name
--      3. at the same level of scope
declarationDuplicated :: Program (Set Declaration) () -> [Set Declaration]
declarationDuplicated (Program decs subScopes stmts) =
    pickDuplicated decs ++ (subScopes >>= subScopeDeclarationDuplicated)
    where   pickDuplicated = filter ((> 1) . size)

subScopeDeclarationDuplicated :: SubScope (Set Declaration) () -> [Set Declaration]
subScopeDeclarationDuplicated (SubScope decs _) = filter ((> 1) . size) decs

--------------------------------------------------------------------------------
-- Symbols Undeclared

variableUndeclared :: Program () Binding -> [Occurrence]
variableUndeclared (Program _ subScopes stmts) = (subScopes ++ [stmts]) >>= subScopeVariableUndeclared

subScopeVariableUndeclared :: SubScope () Binding -> [Occurrence]
subScopeVariableUndeclared (SubScope _ occs) = mapMaybe free occs
    where   free (FreeVar occ) = Just occ
            free _             = Nothing
