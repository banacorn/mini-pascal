{-# LANGUAGE DeriveFunctor #-}

module Compiler.Type.Type where

import Compiler.Syntax.Type.Position
import Compiler.Class.Serializable

import Data.List (intercalate)
import Data.Monoid


--------------------------------------------------------------------------------
-- first order
data Domain = IntType
            | RealType
            | VoidType                          -- ()
            deriving (Eq, Ord)

data Type   = BasicType Domain
            | FunctionType [Domain] deriving (Eq, Ord)

class HasType a where
    getType :: a -> Type

instance Serializable Domain where
    serialize IntType = "Int"
    serialize RealType = "Real"
    serialize VoidType = "void"

instance Serializable Type where
    serialize (BasicType domain) = serialize domain
    serialize (FunctionType domains) = intercalate " → " (map serialize domains)

instance Monoid Type where
    mempty = FunctionType []
    mappend (BasicType    a) (BasicType    b) = FunctionType [a, b]
    mappend (FunctionType a) (BasicType    b) = FunctionType (a ++ [b])
    mappend (BasicType    a) (FunctionType b) = FunctionType (a : b)
    mappend (FunctionType a) (FunctionType b) = FunctionType (a ++ b)

--------------------------------------------------------------------------------

order :: Type -> Int
order (BasicType _) = 1
order (FunctionType domains) = length domains

firstOrder :: Type -> Bool
firstOrder = (== 1) . order

higherOrder :: Type -> Bool
higherOrder = (> 1) . order
