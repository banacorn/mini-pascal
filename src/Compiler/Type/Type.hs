module Compiler.Type.Type where

import Compiler.Type.Token

import Data.List (intercalate)
import Data.Monoid

-- first order
data Domain = IntegerType
            | RealType
            | StringType
            | ArrayType (String, String) Domain
            | ProgramParamType
            | UnitType                          -- ()
            deriving (Eq)

data Type = Type [Domain] deriving (Eq)

instance Monoid Type where
    mempty = Type []
    mappend (Type a) (Type b) = Type (a ++ b)

order :: Type -> Int
order (Type domains) = length domains

firstOrder :: Type -> Bool
firstOrder = (== 1) . order

higherOrder :: Type -> Bool
higherOrder = (> 1) . order
