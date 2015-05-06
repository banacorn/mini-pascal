{-# LANGUAGE DeriveFunctor #-}

module Compiler.PreAST.Type.DataType where

import Compiler.Syntax.Type.Position
import Compiler.Serializable

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

class HPreASType a where
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


isVariable :: Type -> Bool
isVariable (BasicType _) = True
isVariable (FunctionType _) = False

isFunction :: Type -> Bool
isFunction = not . isVariable

arity :: Type -> Int
arity (BasicType _) = 0
arity (FunctionType domains) = length domains

getDomains :: Type -> [Domain]
getDomains (BasicType _) = error "not a function"
getDomains (FunctionType domains) = domains

getParamType :: Type -> [Type]
getParamType = map BasicType . init . getDomains

getReturnType :: Type -> Type
getReturnType = BasicType . last . getDomains
