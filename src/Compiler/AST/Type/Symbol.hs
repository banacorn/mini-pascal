{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}

module Compiler.AST.Type.Symbol where

import Compiler.Syntax.Type.Position
import Compiler.AST.Type.DataType
import Compiler.Serializable

import           Data.Maybe (fromJust)
import           Data.Set (Set, findMin, insert, singleton)
import qualified Data.Set as Set

--------------------------------------------------------------------------------
-- Helper functions

getInt :: Value -> Int
getInt (IntLiteral i _) = i
getInt _ = error "not Int"


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
        | not (isFunction t) && not (isFunction t') = i == i'
        |      isFunction t  &&      isFunction t'  = i == i'
        | otherwise                       = False

-- Order Declaration base on their Position
instance Ord Declaration where
    a `compare` b = decSymbol a `compare` decSymbol b

--------------------------------------------------------------------------------
-- Binding

type Binding = (Symbol, Maybe (Set Declaration))

instance Serializable Binding where
    serialize (sym, Nothing) = serialize sym ++ yellow " ==> ?"
    serialize (sym, Just decs) = serialize sym ++ " ==> " ++ serialize decs


--------------------------------------------------------------------------------
-- Value, for ABT

data Value  = Variable Symbol Declaration
            | IntLiteral Int Position
            | RealLiteral Double Position
            deriving (Eq, Ord)

instance HasType Value where
    getType (Variable sym dec) = decType dec
    getType (IntLiteral i _) = BasicType IntType
    getType (RealLiteral i _) = BasicType RealType

instance Serializable Value where
    serialize (Variable sym dec) = "[ " ++ serialize sym ++ " (" ++ serialize dec ++ ")" ++ " ]"
    serialize (IntLiteral i _) = "[ " ++ green (show i) ++ ": Int" ++ " ]"
    serialize (RealLiteral i _) = "[ " ++ green (show i) ++ ": Real" ++ " ]"

instance Sym Value where
    getID (Variable sym dec) = symID sym
    getID (IntLiteral i _) = serialize i
    getID (RealLiteral i _) = serialize i
    getPos (Variable sym dec) = symPos sym
    getPos (IntLiteral _ p) = p
    getPos (RealLiteral _ p) = p

--------------------------------------------------------------------------------
-- helper functions

-- form a partition with the equiped equivalence relation
partite :: (Ord a, Eq a) => [a] -> [Set a]
partite = foldl addToPartition []
    where   addToPartition [] x     = [singleton x]
            addToPartition (c:cs) x | x == findMin c = (x `insert` c) : cs
                                    | otherwise      = c              : addToPartition cs x

toValue :: Binding -> Value
toValue (sym, dec) = Variable sym (findMin (fromJust dec))

isVariable :: Value -> Bool
isVariable (Variable _ _) = True
isVariable _ = False
