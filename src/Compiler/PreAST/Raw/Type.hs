{-# LANGUAGE DeriveFunctor #-}

module Compiler.PreAST.Raw.Type where

import Compiler.Serializable
import Compiler.PreAST.Type.Expression
import Compiler.PreAST.Type.Statement
import Compiler.PreAST.Type.Symbol
import Compiler.PreAST.Type.DataType

import Data.Monoid
--------------------------------------------------------------------------------
--  Raw Abstract Syntax Tree
--------------------------------------------------------------------------------

-- Program Declaration
data RawProgram = RawProgram
    Symbol          -- program name
    [Symbol]        -- program arguments
    [VarDec]        -- variable declarations
    [RawSubprogram]    -- subprogram declarations

instance Serializable RawProgram where
    serialize (RawProgram sym params vars subprogs) = paragraph $
            0 >>>> [header]
        ++  1 >>>> vars
        ++  1 >>>> subprogs
        where
            header = "program " ++ getID sym ++ "(" ++ paramList ++ ") ;"
            paramList = intercalate' ", " (map getID params)

instance HPreASType RawSubprogram where
    getType (FuncDec _ params ret _ _) = mconcat (map getType params) <> getType ret





-- Type
data RawType = RawIntType | RawRealType | RawVoidType

instance Serializable RawType where
    serialize RawIntType = "int"
    serialize RawRealType = "real"
    serialize RawVoidType = "void"

instance HPreASType RawType where
    getType RawIntType    = BasicType IntType
    getType RawRealType   = BasicType RealType
    getType RawVoidType   = BasicType VoidType



-- Variable & Parameter Declaration
data VarDec = VarDec [Symbol] RawType
data Parameter = Parameter [Symbol] RawType

instance Serializable VarDec where
    serialize (VarDec [] _) = ""
    serialize (VarDec syms t) =
        "var " ++ ids ++ " : " ++ serialize t ++ ";"
        where
            ids = intercalate' ", " (map getID syms)

instance Serializable Parameter where
    serialize (Parameter syms t) = ids ++ ": " ++ serialize t
        where   ids = intercalate' ", " (map getID syms)

instance HPreASType Parameter where
    getType (Parameter _ t) = getType t


-- Subprogram Declaration
data RawSubprogram = FuncDec
    Symbol          -- function name
    [Parameter]     -- function parameters
    RawType    -- function return type
    [VarDec]        -- variable declarations
    [Statement Symbol]    -- compound statement

instance Serializable RawSubprogram where
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
