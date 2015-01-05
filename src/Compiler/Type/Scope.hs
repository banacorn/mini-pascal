module Compiler.Type.Scope where

type Depth = Int

data FOType = IntegerType
            | RealType
            | StringType
            | ArrayType (String, String) FOType
            | ProgramType       -- only for the top most program
            | ProgramParamType
            deriving (Eq, Show)

data HOType = FunctionType [FOType] FOType
            | ProcedureType [FOType]
            deriving (Eq, Show)

data Type   = FO FOType
            | HO HOType
            deriving (Eq, Show)

data Symbol = Declared String
            | Used String
            deriving (Eq, Show)

type SymbolTable = [(Symbol, Depth)]

data Scope  = Scope String [Symbol] [Scope]
    deriving (Eq, Show)
