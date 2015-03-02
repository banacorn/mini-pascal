{-# LANGUAGE DeriveFunctor #-}

module Compiler.Type.AST
    (   module Compiler.Type.AST.Expression
    ,   module Compiler.Type.AST.Statement
    ,   module Compiler.Type.AST.Raw
    ,   toSym
    ,   Scope(..)
    ,   SubScope(..)
    ) where

import Compiler.Type.Token
import Compiler.Type.Symbol

import Compiler.Type.AST.Expression
import Compiler.Type.AST.Statement
import Compiler.Type.AST.Raw


import Data.Monoid ((<>))
import Data.Bifunctor
import Control.Applicative
import Compiler.Class.Serializable

--------------------------------------------------------------------------------
-- Helper functions

toSym :: Token -> Symbol
toSym (Token (TokID i) p) = Symbol i p

--------------------------------------------------------------------------------
-- Scope structure for indicating variable declarations and occurrences

data Scope dec stmt = Scope
    [dec]               --  program parameters, variable and subprogram declarations
    [SubScope dec stmt] --  subprogram
    (SubScope dec stmt) --  compound statement

data SubScope dec stmt = SubScope
    [dec]             --  variable and subprogram declarations
    [stmt]             --  compound statement

instance (Serializable a, Serializable b) => Serializable (Scope a b) where
    serialize (Scope decs subScopes stmts) = paragraph $
            0 >>>> ["Program"]
        ++  1 >>>> decs
        ++  1 >>>> subScopes
        ++  1 >>>> [stmts]

instance (Serializable a, Serializable b) => Serializable (SubScope a b) where
    serialize (SubScope decs stmts) = paragraph $
            0 >>>> [" "]
        ++  1 >>>> decs
        ++  1 >>>> stmts

instance Bifunctor Scope where
    bimap f g (Scope as subprogs stmts) = Scope (map f as) (map (bimap f g) subprogs) (bimap f g stmts)

instance Bifunctor SubScope where
    bimap f g (SubScope as bs) = SubScope (map f as) (map g bs)
