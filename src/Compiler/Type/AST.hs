module Compiler.Type.AST where

import Compiler.Type.Token
import Compiler.Type.Symbol

import Data.Monoid ((<>))
import Control.Applicative


--------------------------------------------------------------------------------
-- Helper functions

toSym :: Token -> SymbolNode
toSym (Token (TokID i) p) = (i, p)

--------------------------------------------------------------------------------
-- Abstract Syntax Tree

-- synomyms for some values
type NumberNode = String
type SymbolNode = (String, Position)

data ProgramNode =
    ProgramNode
        SymbolNode                         -- program name
        [SymbolNode]                       -- program arguments
        [VarDecNode]           -- variable declarations
        [SubprogDec]        -- subprogram declarations
        [StmtNode]                -- compound statement
    deriving (Eq, Show)


data VarDecNode = VarDecNode [SymbolNode] TypeNode
    deriving (Eq, Show)


-- Type
data TypeNode   = BaseTypeNode StandardTypeNode
                | ArrayTypeNode (NumberNode, NumberNode) TypeNode
                deriving (Eq, Show)
data StandardTypeNode = IntTypeNode | RealTypeNode | StringTypeNode deriving (Eq, Show)

-- Subprogram
data SubprogDec = SubprogDec SubprogHead [VarDecNode] [StmtNode] deriving (Eq, Show)

data SubprogHead    = SubprogHeadFunc SymbolNode [ParameterNode] StandardTypeNode
                    | SubprogHeadProc SymbolNode [ParameterNode]
                    deriving (Eq, Show)

data ParameterNode = ParameterNode [SymbolNode] TypeNode
    deriving (Eq, Show)

data StmtNode   = VarStmtNode Variable Expr
                | ProcStmtNode ProcedureStmt
                | CompStmtNode [StmtNode]
                | BranchStmtNode Expr StmtNode StmtNode
                | LoopStmtNode Expr StmtNode
                deriving (Eq, Show)

data Variable = Variable SymbolNode [Expr] -- e.g. a[1+2][3*4]
    deriving (Eq, Show)

-- procedure invocation
data ProcedureStmt  = ProcedureStmtOnlyID SymbolNode
                    | ProcedureStmtWithExprs SymbolNode [Expr]
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

data Factor = IDSBFactor SymbolNode [Expr]  -- id[]
            | IDPFactor SymbolNode [Expr]   -- id()
            | NumFactor String
            | PFactor Expr
            | NotFactor Factor
            deriving (Eq, Show)

data AddOp = Plus | Minus deriving (Eq, Show)
data MulOp = Mul | Div deriving (Eq, Show)
data Relop = S | L | E | NE | SE | LE deriving (Eq, Show)
