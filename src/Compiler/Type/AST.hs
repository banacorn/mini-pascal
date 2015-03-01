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
        CompoundStmtNode    -- compound statement

-- Type
data TypeNode   = BaseTypeNode StandardTypeNode
                | ArrayTypeNode (NumberNode, NumberNode) TypeNode

data StandardTypeNode = IntTypeNode | RealTypeNode | StringTypeNode

-- Variable Declaration
data VarDecNode = VarDecNode [SymbolNode] TypeNode

-- Subprogram Declaration
data SubprogDecNode = FuncDecNode
                        SymbolNode          -- function name
                        [ParameterNode]     -- function parameters
                        StandardTypeNode    -- function return type
                        [VarDecNode]        -- variable declarations
                        CompoundStmtNode    -- compound statement
                    | ProcDecNode
                        SymbolNode          -- procedure name
                        [ParameterNode]     -- function parameters
                        [VarDecNode]        -- variable declarations
                        CompoundStmtNode    -- compound statement

data ParameterNode = ParameterNode [SymbolNode] TypeNode

data CompoundStmtNode = CompoundStmtNode [StmtNode]

-- Statement Declaration
data StmtNode   = AssignStmtNode VariableNode ExprNode
                | SubprogInvokeStmtNode SymbolNode [ExprNode]
                | CompStmtNode CompoundStmtNode
                | BranchStmtNode ExprNode StmtNode StmtNode
                | LoopStmtNode ExprNode StmtNode

data VariableNode = VariableNode SymbolNode [ExprNode] -- e.g. a[1+2][3*4]

data ExprNode   = UnaryExprNode SimpleExprNode
                | BinaryExprNode SimpleExprNode RelOpNode SimpleExprNode

data SimpleExprNode = SimpleExprTermNode TermNode
                    | SimpleExprOpNode SimpleExprNode AddOpNode TermNode

data TermNode   = FactorTermNode FactorNode
                | OpTermNode TermNode MulOpNode FactorNode
                | NegTermNode FactorNode

data FactorNode = ArrayAccessFactorNode     SymbolNode [ExprNode]   -- id[]
                | SubprogInvokeFactorNode   SymbolNode [ExprNode]   -- id()
                | NumFactorNode             NumberNode
                | SubFactorNode             ExprNode                -- ( ... )
                | NotFactorNode             FactorNode              -- -id

data AddOpNode = Plus | Minus
data MulOpNode = Mul | Div
data RelOpNode = S | L | E | NE | SE | LE


--------------------------------------------------------------------------------
-- Scope structure for indicating variable declarations and occurrences

data Scope a = Scope
    [a]             --  program parameters, variable and subprogram declarations
    [SubScope a]    --  subprogram and compound statement

data SubScope a = SubScope
    [a]             --  variable and subprogram declarations
    [a]             --  compound statement
