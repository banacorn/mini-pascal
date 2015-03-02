-- {-# LANGUAGE GADTs #-}

module Compiler.Type.Symbol where

import Compiler.Type.Token
import Compiler.Type.Type
import Compiler.Class.Serializable

import           Data.Set (Set, findMin, insert, singleton)
import qualified Data.Set as Set

--------------------------------------------------------------------------------
--  Symbol

class Sym s where
    getID :: s -> String
    getPos :: s -> Position

data Symbol = Symbol
    {   symID :: String
    ,   symPos :: Position
    } deriving Eq

instance Sym Symbol where
    getID = symID
    getPos = symPos

-- base on their Position
instance Ord Symbol where
    Symbol _ a `compare` Symbol _ b = a `compare` b


instance Serializable Symbol where
    serialize (Symbol name pos) = green name ++ " " ++ serialize pos

--------------------------------------------------------------------------------
--  Declaration

data Declaration = Declaration
    {   decSymbol :: Symbol
    ,   decType :: Type
    }

instance Sym Declaration where
    getID = symID . decSymbol
    getPos = symPos . decSymbol

instance Serializable Declaration where
    serialize (Declaration (Symbol name pos) typ) = green name ++ " : " ++ serialize typ ++ " " ++ serialize pos

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
             | FreeVar  Occurrence

instance Serializable Binding where
    serialize (BoundVar o d) = serialize o ++ " ==> " ++ serialize d
    serialize (FreeVar  o  ) = serialize o ++ yellow " ==> ?"


--------------------------------------------------------------------------------
-- Value, for ABT

data Variable = Variable Symbol Declaration

instance Sym Variable where
    getID (Variable s _) = getID s
    getPos (Variable _ p) = getPos p

data Literal = IntLiteral Int | RealLiteral Double

instance Serializable Literal where
    serialize (IntLiteral i) = show i
    serialize (RealLiteral i) = show i

--------------------------------------------------------------------------------
-- helper functions

-- form a partition with the equiped equivalence relation
partite :: (Ord a, Eq a) => [a] -> [Set a]
partite = foldl addToPartition []
    where   addToPartition [] x     = [singleton x]
            addToPartition (c:cs) x | x == findMin c = (x `insert` c) : cs
                                    | otherwise      = c              : addToPartition cs x
