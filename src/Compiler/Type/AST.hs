{-# LANGUAGE DeriveFunctor #-}

module Compiler.Type.AST
    (   module Compiler.Type.AST.Expression
    ,   module Compiler.Type.AST.Statement
    ,   module Compiler.Type.AST.Raw
    ,   toSym
    ,   Program(..)
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
-- Main structure

data Program dec stmt = Program
    [dec]               --  program parameters, variable and subprogram declarations
    [SubScope dec stmt] --  subprogram
    (SubScope dec stmt) --  compound statement

data SubScope dec stmt = SubScope
    [dec]             --  variable and subprogram declarations
    [stmt]             --  compound statement

instance (Serializable a, Serializable b) => Serializable (Program a b) where
    serialize (Program decs subScopes stmts) = paragraph $
            0 >>>> ["Program"]
        ++  1 >>>> decs
        ++  1 >>>> subScopes
        ++  1 >>>> [stmts]

instance (Serializable a, Serializable b) => Serializable (SubScope a b) where
    serialize (SubScope decs stmts) = paragraph $
            0 >>>> [" "]
        ++  1 >>>> decs
        ++  1 >>>> stmts

instance Bifunctor Program where
    bimap f g (Program as subprogs stmts) = Program (map f as) (map (bimap f g) subprogs) (bimap f g stmts)

instance Bifunctor SubScope where
    bimap f g (SubScope as bs) = SubScope (map f as) (map g bs)
