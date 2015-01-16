module Compiler.Type.Symbol where

import Compiler.Type.Token

import Data.List (intercalate)

type Depth = Int

--------------------------------------------------------------------------------
--  Type

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

--------------------------------------------------------------------------------
--  Status
data SymbolStatus = Declared | Used deriving (Eq, Show)

--------------------------------------------------------------------------------
--  Symbol
data Symbol = Symbol
    {   symStatus :: SymbolStatus
    ,   symType :: Type
    ,   symID :: String
    ,   symPos :: Position
    }

instance Eq Symbol where
    Symbol s t i _ == Symbol s' t' i' _ = s == s' && t == t' && i == i'

instance Show Symbol where
    show (Symbol status t i p) = show status ++ " " ++ i ++ " : " ++ show t ++ show p

--------------------------------------------------------------------------------
--  Scope & Symbol Table
type SymbolTable = [(Symbol, Depth)]

data Scope  = Scope Symbol [Symbol] [Scope]
    deriving (Eq, Show)
