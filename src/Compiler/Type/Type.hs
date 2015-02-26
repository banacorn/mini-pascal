module Compiler.Type.Type where

import Compiler.Type.Token

import Data.List (intercalate)

data FOType = IntegerType
            | RealType
            | StringType
            | ArrayType (String, String) FOType
            | ProgramParamType
            deriving (Eq)

instance Show FOType where
    show IntegerType = "Int"
    show RealType = "Real"
    show StringType = "String"
    show (ArrayType (from, to) t) = "Array [" ++ from ++ " .. " ++ to ++"] " ++ show t
    show ProgramParamType = "ProgArg"

data HOType = FunctionType [FOType] FOType
            | ProcedureType [FOType]
            deriving (Eq)

instance Show HOType where
    show (FunctionType args ret) = intercalate " → " (map show args ++ [show ret])
    show (ProcedureType args) = intercalate " → " (map show args ++ ["()"])

data Type   = FO FOType
            | HO HOType
            | Uninferred
            deriving (Eq)

instance Show Type where
    show (FO t) = show t
    show (HO t) = show t
    show Uninferred = "?"
