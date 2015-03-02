module Compiler.Type.AST where

import Compiler.Type.Token
import Compiler.Type.Symbol

import Data.Monoid ((<>))
import Control.Applicative

--------------------------------------------------------------------------------
-- Helper functions

toSym :: Token -> Symbol
toSym (Token (TokID i) p) = Symbol i p

--------------------------------------------------------------------------------
-- Abstract Syntax Tree

type Number = String

-- Program Declaration
data Program =
    Program
        Symbol          -- program name
        [Symbol]        -- program arguments
        [VarDec]        -- variable declarations
        [SubprogDec]    -- subprogram declarations
        CompoundStmt    -- compound statement

-- Type
data Type   = BaseType StandardType
            | ArrayType (Number, Number) Type

data StandardType = IntType | RealType | StringType

-- Variable Declaration
data VarDec = VarDec [Symbol] Type

-- Subprogram Declaration
data SubprogDec = FuncDec
                    Symbol          -- function name
                    [Parameter]     -- function parameters
                    StandardType    -- function return type
                    [VarDec]        -- variable declarations
                    CompoundStmt    -- compound statement
                | ProcDec
                    Symbol          -- procedure name
                    [Parameter]     -- function parameters
                    [VarDec]        -- variable declarations
                    CompoundStmt    -- compound statement

data Parameter = Parameter [Symbol] Type

data CompoundStmt = CompoundStmt [Statement Symbol]

-- Statement
data Statement a = Assignment (Assignee a) (Expression a)
                 | Invocation a [Expression a]
                 | Compound [Statement a]
                 | Branch (Expression a) (Statement a) (Statement a)
                 | Loop (Expression a) (Statement a)

data Assignee a = Assignee a [Expression a] -- e.g. a[1+2][3*4]


-- Expression
data Expression a = UnaryExpression (SimpleExpression a)
                  | BinaryExpression (SimpleExpression a) RelOp (SimpleExpression a)

data SimpleExpression a = TermSimpleExpression (Term a)
                        | OpSimpleExpression (SimpleExpression a) AddOp (Term a)

data Term a = FactorTerm (Factor a)
            | OpTerm (Term a) MulOp (Factor a)
            | NegTerm (Factor a)

data Factor a = ArrayAccessFactor a [Expression a]     -- id[]
              | InvocationFactor  a [Expression a]     -- id()
              | NumberFactor      Literal
              | SubFactor         (Expression a)       -- (...)
              | NotFactor         (Factor a)           -- -id

data AddOp = Plus | Minus
data MulOp = Mul | Div
data RelOp = S | L | E | NE | SE | LE


--------------------------------------------------------------------------------
-- Scope structure for indicating variable declarations and occurrences

data Scope a = Scope
    [a]             --  program parameters, variable and subprogram declarations
    [SubScope a]    --  subprogram and compound statement

data SubScope a = SubScope
    [a]             --  variable and subprogram declarations
    [a]             --  compound statement
