module Compiler.Type.AST where

import Compiler.Type.Token
import Compiler.Type.Symbol

import Data.Monoid ((<>))
import Control.Applicative
import Compiler.Class.Serializable

--------------------------------------------------------------------------------
-- Helper functions

toSym :: Token -> Symbol
toSym (Token (TokID i) p) = Symbol i p

--------------------------------------------------------------------------------
-- Abstract Syntax Tree

-- Program Declaration
data Program =
    Program
        Symbol          -- program name
        [Symbol]        -- program arguments
        [VarDec]        -- variable declarations
        [SubprogDec]    -- subprogram declarations
        [Statement Symbol] -- compound statement

-- Type
type Number = String
data Type   = Basic BasicType
            | Array (Number, Number) Type
data BasicType = IntType | RealType | StringType


-- Variable & Parameter Declaration
data VarDec = VarDec [Symbol] Type
data Parameter = Parameter [Symbol] Type


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

--------------------------------------------------------------------------------

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


instance (Serializable a, Sym a) => Serializable (Expression a) where
    serialize (UnaryExpression e) = serialize e
    serialize (BinaryExpression a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

instance (Serializable a, Sym a) => Serializable (SimpleExpression a) where
    serialize (TermSimpleExpression t) = serialize t
    serialize (OpSimpleExpression a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

instance (Serializable a, Sym a) => Serializable (Term a) where
    serialize (FactorTerm f) = serialize f
    serialize (OpTerm a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
    serialize (NegTerm f) = "-" ++ serialize f

instance (Serializable a, Sym a) => Serializable (Factor a) where
    serialize (ArrayAccessFactor sym exprs) = getID sym ++ (exprs >>= showArrayAccess)
        where   showArrayAccess a = "[" ++ serialize a ++ "]"
    serialize (InvocationFactor sym exprs)  = getID sym ++ "(" ++ exprs' ++ ")"
        where   exprs' = intercalate' ", " exprs
    serialize (NumberFactor s) = serialize s
    serialize (SubFactor e) = serialize e
    serialize (NotFactor f) = "not " ++ serialize f


instance Serializable AddOp where
    serialize Plus = "+"
    serialize Minus = "-"

instance Serializable MulOp where
    serialize Mul = "*"
    serialize Div = "/"

instance Serializable RelOp where
    serialize S = "<"
    serialize L = ">"
    serialize E = "="
    serialize NE = "!="
    serialize SE = "<="
    serialize LE = ">="

--------------------------------------------------------------------------------
-- Scope structure for indicating variable declarations and occurrences

data Scope a = Scope
    [a]             --  program parameters, variable and subprogram declarations
    [SubScope a]    --  subprogram and compound statement

data SubScope a = SubScope
    [a]             --  variable and subprogram declarations
    [a]             --  compound statement

instance Serializable a => Serializable (Scope a) where
    serialize (Scope decs subScopes) = paragraph $
            0 >>>> ["Program"]
        ++  1 >>>> decs
        ++  1 >>>> subScopes

instance Serializable a => Serializable (SubScope a) where
    serialize (SubScope decs stmts) = paragraph $
            0 >>>> [" "]
        ++  1 >>>> decs
        ++  1 >>>> stmts
