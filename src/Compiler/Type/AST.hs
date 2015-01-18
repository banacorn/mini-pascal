module Compiler.Type.AST where

import Compiler.Type.Token
import Compiler.Type.Symbol

import Data.Monoid ((<>))
import Control.Applicative


--------------------------------------------------------------------------------
-- Helper functions

toSym :: Token -> Sym
toSym (Token (TokID i) p) = (i, p)

--------------------------------------------------------------------------------
-- Abstract Syntax Tree

data ProgramNode =
    ProgramNode
        Sym                         -- program name
        [Sym]                       -- program arguments
        [VarDecNode]           -- variable declarations
        [SubprogDec]       -- subprogram declarations
        CompoundStmt                -- compound statement
    deriving (Eq, Show)

type ID = String
type Sym = (ID, Position)

data VarDecNode = VarDecNode [Sym] TypeNode
    deriving (Eq, Show)

type Number = String

-- Type
data TypeNode   = BaseTypeNode StandardTypeNode
                | ArrayTypeNode (Number, Number) TypeNode
                deriving (Eq, Show)
data StandardTypeNode = IntTypeNode | RealTypeNode | StringTypeNode deriving (Eq, Show)

-- Subprogram
data SubprogDec = SubprogDec SubprogHead [VarDecNode] CompoundStmt deriving (Eq, Show)

data SubprogHead    = SubprogHeadFunc Sym Arguments StandardTypeNode
                    | SubprogHeadProc Sym Arguments
                    deriving (Eq, Show)

data Arguments  = EmptyArguments
                | Arguments [Param]
                deriving (Eq, Show)
data Param = Param [Sym] TypeNode
    deriving (Eq, Show)

data CompoundStmt = CompoundStmt [Stmt]
    deriving (Eq, Show)

data Stmt   = VarStmt Variable Expr
            | ProcStmt ProcedureStmt
            | CompStmt CompoundStmt
            | BranchStmt Expr Stmt Stmt
            | LoopStmt Expr Stmt
            deriving (Eq, Show)

data Variable = Variable Sym [Expr] -- e.g. a[1+2][3*4]
    deriving (Eq, Show)

-- procedure invocation
data ProcedureStmt  = ProcedureStmtOnlyID Sym
                    | ProcedureStmtWithExprs Sym [Expr]
                    deriving (Eq, Show)

data Expr   = UnaryExpr SimpleExpr
            | BinaryExpr SimpleExpr Relop SimpleExpr
            deriving (Eq, Show)

data SimpleExpr = SimpleExprTerm Term
                | SimpleExprOp SimpleExpr AddOp Term
                deriving (Eq, Show)

data Term   = FactorTerm Factor
            | OpTerm Term MulOp Factor
            | NegTerm Factor
            deriving (Eq, Show)

data Factor = IDSBFactor Sym [Expr]  -- id[]
            | IDPFactor Sym [Expr]   -- id()
            | NumFactor String
            | PFactor Expr
            | NotFactor Factor
            deriving (Eq, Show)

data AddOp = Plus | Minus deriving (Eq, Show)
data MulOp = Mul | Div deriving (Eq, Show)
data Relop = S | L | E | NE | SE | LE deriving (Eq, Show)
