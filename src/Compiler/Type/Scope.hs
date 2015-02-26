-- {-# LANGUAGE GADTs #-}

module Compiler.Type.Scope where

import Compiler.Type.Token
import Compiler.Type.Symbol
import Compiler.Type.Type

type Declaration = Symbol

--------------------------------------------------------------------------------
--  Scope

data ScopeType a = CompoundStmtScope
                 | ProgramScope String
                 | RegularScope a -- functions, procedures ... usually with an associated symbol
                 deriving (Eq, Show)

data Scope a = Scope (ScopeType a) [Scope a] [a]
