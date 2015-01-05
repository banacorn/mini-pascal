module Compiler.Type.Scope where

import Data.List (intercalate)

type Depth = Int

data FOType = IntegerType
            | RealType
            | StringType
            | ArrayType (String, String) FOType
            | ProgramType       -- only for the top most program
            | ProgramParamType
            deriving (Eq)

instance Show FOType where
    show IntegerType = "Int"
    show RealType = "Real"
    show StringType = "String"
    show (ArrayType (from, to) t) = "Array [" ++ from ++ " .. " ++ to ++"] " ++ show t
    show ProgramType = "Prog"
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

data SymbolStatus = Declared | Used deriving (Eq, Show)

data Symbol = Symbol
    {   symStatus :: SymbolStatus
    ,   symType :: Type
    ,   symID :: String
    }   deriving (Eq)

instance Show Symbol where
    show (Symbol status t i) = show status ++ " " ++ i ++ " : " ++ show t

type SymbolTable = [(Symbol, Depth)]

data Scope  = Scope Symbol [Symbol] [Scope]
    deriving (Eq, Show)
