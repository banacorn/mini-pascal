-- {-# LANGUAGE GADTs #-}

module Compiler.Type.Scope where

import Compiler.Type.Token
import Compiler.Type.Symbol
import Compiler.Type.Type

--------------------------------------------------------------------------------
--  Scope

data ScopeType   = CompoundStmtScope
                 | ProgramScope String
                 | RegularScope Declaration -- functions, procedures ... usually with an associated symbol
                 deriving (Eq, Show)

data Scope a = Scope ScopeType [Scope a] [a]
