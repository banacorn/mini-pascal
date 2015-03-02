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

compound :: (Serializable a, Sym a) => [Statement a] -> [Line]
compound stmts  =   0 >>>> ["begin"]
                ++  1 >>>> map serialize stmts
                ++  0 >>>> ["end"]

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

instance Serializable Program where
    serialize (Program sym params vars subprogs stmts) = paragraph $
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


--------------------------------------------------------------------------------

-- Statement
data Statement a = Assignment (Assignee a) (Expression a)
                 | Invocation a [Expression a]
                 | Compound [Statement a]
                 | Branch (Expression a) (Statement a) (Statement a)
                 | Loop (Expression a) (Statement a)

data Assignee a = Assignee a [Expression a] -- e.g. a[1+2][3*4]



-- instance Serializable CompoundStmtNode where
--     serialize (CompoundStmtNode stmts) = paragraph $
--             0 >>>> ["begin"]
--         ++  1 >>>> stmts
--         ++  0 >>>> ["end"]
instance (Serializable a, Sym a) => Serializable (Statement a) where
    serialize (Assignment v e) = serialize v ++ " := " ++ serialize e
    serialize (Invocation sym []) = getID sym
    serialize (Invocation sym exprs) = getID sym ++ "(" ++ exprs' ++ ")"
        where   exprs' = intercalate' ", " exprs
    serialize (Compound stmts) = paragraph $ compound stmts
    serialize (Branch e s t) = paragraph $
            0 >>>> ["if " ++ serialize e]
        ++  1 >>>> ["then " ++ serialize s]
        ++  1 >>>> ["else " ++ serialize s]
    serialize (Loop e s) = paragraph $
            0 >>>> ["while " ++ serialize e ++ " do"]
        ++  1 >>>> [s]

instance (Serializable a, Sym a) => Serializable (Assignee a) where
    serialize (Assignee sym es) = getID sym ++ (es >>= showArrayAccess)
        where   showArrayAccess e = "[" ++ serialize e ++ "]"


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
