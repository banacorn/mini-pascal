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

data CompoundStmt = CompoundStmt [Statement]

data Statement  = Assignment Assignee Expression
                | Invocation Symbol [Expression]
                | Compound CompoundStmt
                | Branch Expression Statement Statement
                | Loop Expression Statement

data Assignee = Assignee Symbol [Expression] -- e.g. a[1+2][3*4]

data Expression = UnaryExpression SimpleExpression
                | BinaryExpression SimpleExpression RelOp SimpleExpression

data SimpleExpression = TermSimpleExpression Term
                      | OpSimpleExpression SimpleExpression AddOp Term

data Term = FactorTerm Factor
          | OpTerm Term MulOp Factor
          | NegTerm Factor


data Factor = ArrayAccessFactor Symbol [Expression]     -- id[]
            | InvocationFactor  Symbol [Expression]     -- id()
            | NumberFactor      Literal
            | SubFactor         Expression              -- (...)
            | NotFactor         Factor                  -- -id

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
