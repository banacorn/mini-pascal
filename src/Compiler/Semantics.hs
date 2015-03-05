module Compiler.Semantics where

import Compiler.Syntax.Type
import Compiler.DSL.Type
import Compiler.TypeCheck
import Data.Set (Set, size)
import Data.Maybe (isNothing)

--------------------------------------------------------------------------------
-- Declarations Duplicated

-- Duplicate if
--      1. both are variables OR both are functions/procedures
--      2. have the same name
--      3. at the same level of scope
declarationDuplicated :: AST -> [Set Declaration]
declarationDuplicated =  filter ((> 1) . size) . extractFirst

--------------------------------------------------------------------------------
-- Symbols Undeclared

variableUndeclared :: AST -> [Symbol]
variableUndeclared = map fst . filter (isNothing . snd) . extractSecond

--------------------------------------------------------------------------------
-- Type Checking

typeCheck :: ABT -> [TypeError]
typeCheck abt = extractSecond abt >>= typeCheckStatement
