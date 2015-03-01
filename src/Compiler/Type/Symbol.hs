-- {-# LANGUAGE GADTs #-}

module Compiler.Type.Symbol where

import Compiler.Type.Token
import Compiler.Type.Type

import           Data.Set (Set, findMin, insert, singleton)
import qualified Data.Set as Set

--------------------------------------------------------------------------------
--  Declaration

data Declaration = Declaration
    {   decType :: Type
    ,   decID :: String
    ,   decPos :: Position
    }

-- 2 Declaration are considered equal if
--      1. both are variables OR both are functions/procedures
--      2. have the same name
instance Eq Declaration where
    Declaration (FO _) i _ == Declaration (FO _) i' _ = i == i'
    Declaration (HO _) i _ == Declaration (HO _) i' _ = i == i'
    Declaration _      _ _ == Declaration _      _  _ = False

instance Show Declaration where
    show (Declaration t i p) = " " ++ i ++ " : " ++ show t ++ show p

-- Order Declaration base on their Position
instance Ord Declaration where
    a `compare` b = decPos a `compare` decPos b



--------------------------------------------------------------------------------
-- Occurrence

data Occurrence = Occurrence
    {   occID  :: String
    ,   occPos :: Position
    }   deriving Eq

-- Order Occurrence base on their Position
instance Ord Occurrence where
    a `compare` b = occPos a `compare` occPos b



--------------------------------------------------------------------------------
-- Binding

data Binding = BoundVar Occurrence (Set Declaration)
             | FreeVar Occurrence

--------------------------------------------------------------------------------
-- helper functions

toDeclaration :: Type -> (String, Position) -> Declaration
toDeclaration t (i, p) = Declaration t i p

toOccurrence :: (String, Position) -> Occurrence
toOccurrence = uncurry Occurrence

-- form a partition with the equiped equivalence relation
partite :: (Ord a, Eq a) => [a] -> [Set a]
partite = foldl addToPartition []
    where   addToPartition [] x     = [singleton x]
            addToPartition (c:cs) x | x == findMin c = (x `insert` c) : cs
                                    | otherwise      = c              : addToPartition cs x
