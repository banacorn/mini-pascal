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

-- instance Show FOType where
--     show IntegerType = "Int"
--     show RealType = "Real"
--     show StringType = "String"
--     show (ArrayType (from, to) t) = "Array [" ++ from ++ " .. " ++ to ++"] " ++ show t
--     show ProgramParamType = "ProgArg"
--     show UnitType = "()"

-- instance Show HOType where
--     show (FunctionType args ret) = intercalate " → " (map show args ++ [show ret])
--     show (ProcedureType args) = intercalate " → " (map show args ++ ["()"])

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
