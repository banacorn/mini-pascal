{-# LANGUAGE DeriveFunctor #-}

module Compiler.Type.AST.Raw where

import Compiler.Class.Serializable
import Compiler.Type.Symbol
import Compiler.Type.AST.Expression
import Compiler.Type.AST.Statement

--------------------------------------------------------------------------------
-- Raw Abstract Syntax Tree

-- Program Declaration
data RawProgram = RawProgram
    Symbol          -- program name
    [Symbol]        -- program arguments
    [VarDec]        -- variable declarations
    [SubprogDec]    -- subprogram declarations
    [Statement Symbol] -- compound statement

instance Serializable RawProgram where
    serialize (RawProgram sym params vars subprogs stmts) = paragraph $
            0 >>>> [header]
        ++  1 >>>> vars
        ++  1 >>>> subprogs
        ++  1 >>>> compound stmts
        where
            header = "program " ++ getID sym ++ "(" ++ paramList ++ ") ;"
            paramList = intercalate' ", " (map getID params)

-- Type
type Number = String
data Type   = Basic BasicType
            | Array (Number, Number) Type
data BasicType = IntType | RealType | StringType

instance Serializable Type where
    serialize (Basic t) = serialize t
    serialize (Array (a, b) t) =
        "array [ " ++ a ++ " .. " ++ b ++ " ] of " ++ serialize t

instance Serializable BasicType where
    serialize IntType = "int"
    serialize RealType = "real"
    serialize StringType = "string"


-- Variable & Parameter Declaration
data VarDec = VarDec [Symbol] Type
data Parameter = Parameter [Symbol] Type

instance Serializable VarDec where
    serialize (VarDec [] _) = ""
    serialize (VarDec syms t) =
        "var " ++ ids ++ " : " ++ serialize t ++ ";"
        where
            ids = intercalate' ", " (map getID syms)

instance Serializable Parameter where
    serialize (Parameter syms t) = ids ++ ": " ++ serialize t
        where   ids = intercalate' ", " (map getID syms)


-- Subprogram Declaration
data SubprogDec = FuncDec
                    Symbol          -- function name
                    [Parameter]     -- function parameters
                    BasicType    -- function return type
                    [VarDec]        -- variable declarations
                    [Statement Symbol]    -- compound statement
                | ProcDec
                    Symbol          -- procedure name
                    [Parameter]     -- function parameters
                    [VarDec]        -- variable declarations
                    [Statement Symbol]    -- compound statement

instance Serializable SubprogDec where
    -- function, no parameter
    serialize (FuncDec sym [] typ vars stmts) = paragraph $
            0 >>>> ["function " ++ getID sym ++ " : " ++ serialize typ ++ ";"]
        ++  1 >>>> vars
        ++  1 >>>> compound stmts
    -- function, with parameters
    serialize (FuncDec sym params typ vars stmts) = paragraph $
            0 >>>> ["function " ++ getID sym ++ "(" ++ paramList ++ "): " ++ serialize typ ++ ";"]
        ++  1 >>>> vars
        ++  1 >>>> compound stmts
        where   paramList = intercalate' ", " params
    -- procedure, no paramter
    serialize (ProcDec sym [] vars stmts) = paragraph $
            0 >>>> ["procedure " ++ getID sym ++ ";"]
        ++  1 >>>> vars
        ++  1 >>>> compound stmts
    -- procedure, with parameters
    serialize (ProcDec sym params vars stmts) = paragraph $
            0 >>>> ["function " ++ getID sym ++ "(" ++ paramList ++ ");"]
        ++  1 >>>> vars
        ++  1 >>>> compound stmts
        where   paramList = intercalate' ", " params
