-- {-# LANGUAGE GADTs #-}

module Compiler.Type.Symbol where

import Compiler.Type.Token
import Compiler.Type.Type

import           Data.Set (Set, findMin, insert, singleton)
import qualified Data.Set as Set

--------------------------------------------------------------------------------
--  Symbol

data Symbol = Symbol
    {   symID :: String
    ,   symPos :: Position
    } deriving Eq

-- base on their Position
instance Ord Symbol where
    Symbol _ a `compare` Symbol _ b = a `compare` b


--------------------------------------------------------------------------------
--  Declaration

data Declaration = Declaration
    {   decSymbol :: Symbol
    ,   decType :: Type
    }

-- 2 Declaration are considered equal if
--      1. both are variables OR both are functions/procedures
--      2. have the same name
instance Eq Declaration where
    Declaration (Symbol i _) t == Declaration (Symbol i' _) t'
        | firstOrder  t && firstOrder  t' = i == i'
        | higherOrder t && higherOrder t' = i == i'
        | otherwise                       = False

-- Order Declaration base on their Position
instance Ord Declaration where
    a `compare` b = decSymbol a `compare` decSymbol b



--------------------------------------------------------------------------------
-- Occurrence

type Occurrence = Symbol

--------------------------------------------------------------------------------
-- Binding

data Binding = BoundVar Occurrence (Set Declaration)
             | FreeVar Occurrence

--------------------------------------------------------------------------------
-- helper functions

-- form a partition with the equiped equivalence relation
partite :: (Ord a, Eq a) => [a] -> [Set a]
partite = foldl addToPartition []
    where   addToPartition [] x     = [singleton x]
            addToPartition (c:cs) x | x == findMin c = (x `insert` c) : cs
                                    | otherwise      = c              : addToPartition cs x
