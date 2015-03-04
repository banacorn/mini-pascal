{-# LANGUAGE DeriveFunctor #-}

module Compiler.Type.Type where

import Compiler.Type.Token
import Compiler.Class.Serializable

import Data.List (intercalate)
import Data.Monoid


--------------------------------------------------------------------------------
-- first order
data Domain = IntType
            | RealType
            | ProgramParamType
            | UnitType                          -- ()
            deriving (Eq, Ord)

data Type = Type [Domain] deriving (Eq, Ord)

class HasType a where
    getType :: a -> Type

instance Serializable Domain where
    serialize IntType = "Int"
    serialize RealType = "Real"
    serialize ProgramParamType = "ProgArg"
    serialize UnitType = "()"

instance Serializable Type where
    serialize (Type domains) = intercalate " → " (map serialize domains)

instance Monoid Type where
    mempty = Type []
    mappend (Type a) (Type b) = Type (a ++ b)

--------------------------------------------------------------------------------

order :: Type -> Int
order (Type domains) = length domains

firstOrder :: Type -> Bool
firstOrder = (== 1) . order

higherOrder :: Type -> Bool
higherOrder = (> 1) . order
