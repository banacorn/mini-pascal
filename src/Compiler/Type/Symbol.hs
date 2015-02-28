-- {-# LANGUAGE GADTs #-}

module Compiler.Type.Symbol where

import Compiler.Type.Token
import Compiler.Type.Type

--------------------------------------------------------------------------------
--  Symbol
data Symbol = Symbol
    {   symType :: Type
    ,   symID :: String
    ,   symPos :: Position
    }

-- 2 Symbols are considered equal if
--      1. both are variables OR both are functions/procedures
--      2. have the same name
instance Eq Symbol where
    Symbol (FO _) i _ == Symbol (FO _) i' _ = i == i'
    Symbol (HO _) i _ == Symbol (HO _) i' _ = i == i'
    Symbol _      _ _ == Symbol _      _  _ = False

instance Show Symbol where
    show (Symbol t i p) = " " ++ i ++ " : " ++ show t ++ show p

-- Order symbols base on their Position
instance Ord Symbol where
    a `compare` b = symPos a `compare` symPos b

--------------------------------------------------------------------------------

type EqClass a = [a]
type Declaration = Symbol
data Occurrence = Occurrence String Position
type Binding = Symbol

--------------------------------------------------------------------------------
-- helper functions

toSymbol :: Type -> (String, Position) -> Symbol
toSymbol t (i, p) = Symbol t i p

toOccurrence :: (String, Position) -> Occurrence
toOccurrence = uncurry Occurrence

-- form a partition with the equiped equivalence relation
partite :: Eq a => [a] -> [[a]]
partite = foldl addToPartition []
    where   addToPartition [] x     = [[x]]
            addToPartition (c:cs) x | x == head c = (x:c):cs
                                    | otherwise   = c : addToPartition cs x
