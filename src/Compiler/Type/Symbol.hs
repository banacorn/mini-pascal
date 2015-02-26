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
    Symbol _ _ _ == Symbol _ _ _ = False

instance Show Symbol where
    show (Symbol t i p) = " " ++ i ++ " : " ++ show t ++ show p

-- Order symbols base on their Position
instance Ord Symbol where
    a `compare` b = symPos a `compare` symPos b
