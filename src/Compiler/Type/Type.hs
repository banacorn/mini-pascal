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

data Type   = BasicType Domain
            | SubprogramType [Domain] deriving (Eq, Ord)

class HasType a where
    getType :: a -> Type

instance Serializable Domain where
    serialize IntType = "Int"
    serialize RealType = "Real"
    serialize ProgramParamType = "ProgArg"
    serialize UnitType = "()"

instance Serializable Type where
    serialize (BasicType domain) = serialize domain
    serialize (SubprogramType domains) = intercalate " → " (map serialize domains)

instance Monoid Type where
    mempty = SubprogramType []
    mappend (BasicType      a) (BasicType      b) = SubprogramType [a, b]
    mappend (SubprogramType a) (BasicType      b) = SubprogramType (a ++ [b])
    mappend (BasicType      a) (SubprogramType b) = SubprogramType (a : b)
    mappend (SubprogramType a) (SubprogramType b) = SubprogramType (a ++ b)

--------------------------------------------------------------------------------

order :: Type -> Int
order (BasicType _) = 1
order (SubprogramType domains) = length domains

firstOrder :: Type -> Bool
firstOrder = (== 1) . order

higherOrder :: Type -> Bool
higherOrder = (> 1) . order
