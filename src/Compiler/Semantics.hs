module Compiler.Semantics
    (   declarationDuplicated
    ,   variableUndeclared
    ) where

import Compiler.Type
import Compiler.Type.AST
import Data.Set (Set, size)
import Data.Maybe (isNothing)

--------------------------------------------------------------------------------
-- Declarations Duplicated

-- Duplicate if
--      1. both are variables OR both are functions/procedures
--      2. have the same name
--      3. at the same level of scope
declarationDuplicated :: Program (Set Declaration) b -> [Set Declaration]
declarationDuplicated =  filter ((> 1) . size) . extractFirst

--------------------------------------------------------------------------------
-- Symbols Undeclared

variableUndeclared :: Program a Binding -> [Symbol]
variableUndeclared = map fst . filter (isNothing . snd) . extractSecond
