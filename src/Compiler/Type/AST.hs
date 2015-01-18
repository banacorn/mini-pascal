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

-- Program Declaration
data ProgramNode =
    ProgramNode
        SymbolNode          -- program name
        [SymbolNode]        -- program arguments
        [VarDecNode]        -- variable declarations
        [SubprogDecNode]    -- subprogram declarations
        [StmtNode]          -- compound statement
    deriving (Eq, Show)

-- Type
data TypeNode   = BaseTypeNode StandardTypeNode
                | ArrayTypeNode (NumberNode, NumberNode) TypeNode
                deriving (Eq, Show)
data StandardTypeNode = IntTypeNode | RealTypeNode | StringTypeNode deriving (Eq, Show)

-- Variable Declaration
data VarDecNode = VarDecNode [SymbolNode] TypeNode
    deriving (Eq, Show)

-- Subprogram Declaration
data SubprogDecNode = FuncDecNode
                        SymbolNode          -- function name
                        [ParameterNode]     -- function parameters
                        StandardTypeNode    -- function return type
                        [VarDecNode]        -- variable declarations
                        [StmtNode]          -- compound statement
                    | ProcDecNode
                        SymbolNode          -- procedure name
                        [ParameterNode]     -- function parameters
                        [VarDecNode]        -- variable declarations
                        [StmtNode]          -- compound statement
                    deriving (Eq, Show)

data ParameterNode = ParameterNode [SymbolNode] TypeNode
    deriving (Eq, Show)

-- Statement Declaration
data StmtNode   = AssignStmtNode VariableNode ExprNode
                | SubprogInvokeStmtNode SymbolNode [ExprNode]
                | CompStmtNode [StmtNode]
                | BranchStmtNode ExprNode StmtNode StmtNode
                | LoopStmtNode ExprNode StmtNode
                deriving (Eq, Show)

data VariableNode = VariableNode SymbolNode [ExprNode] -- e.g. a[1+2][3*4]
    deriving (Eq, Show)

data ExprNode   = UnaryExprNode SimpleExprNode
                | BinaryExprNode SimpleExprNode RelOpNode SimpleExprNode
                deriving (Eq, Show)

data SimpleExprNode = SimpleExprTermNode TermNode
                    | SimpleExprOpNode SimpleExprNode AddOpNode TermNode
                    deriving (Eq, Show)

data TermNode   = FactorTermNode FactorNode
                | OpTermNode TermNode MulOpNode FactorNode
                | NegTermNode FactorNode
                deriving (Eq, Show)

data FactorNode = ArrayAccessFactorNode     SymbolNode [ExprNode]   -- id[]
                | SubprogInvokeFactorNode   SymbolNode [ExprNode]   -- id()
                | NumFactorNode             NumberNode
                | SubFactorNode             ExprNode                -- ( ... )
                | NotFactorNode             FactorNode              -- -id
                deriving (Eq, Show)

data AddOpNode = Plus | Minus deriving (Eq, Show)
data MulOpNode = Mul | Div deriving (Eq, Show)
data RelOpNode = S | L | E | NE | SE | LE deriving (Eq, Show)
