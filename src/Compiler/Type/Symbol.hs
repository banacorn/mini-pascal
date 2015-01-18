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

--------------------------------------------------------------------------------
--  Status
-- data SymbolStatus = Declared | Used deriving (Eq, Show)

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

--------------------------------------------------------------------------------
--  Scope

data ScopeType  = CompoundStatementScope
                | ProgramScope String
                | RegularScope Symbol -- functions, procedures ... usually with an associated symbol
                deriving (Eq, Show)
data Scope  = Scope ScopeType [Symbol] [Scope]
    deriving (Eq, Show)
