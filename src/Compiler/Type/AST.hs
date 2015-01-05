module Compiler.Type.AST where

--------------------------------------------------------------------------------
-- Abstract Syntax Tree

data ParseTree = ParseTree Program
    deriving (Eq, Show)

data Program = Program ID [ID] [Declaration] SubprogSection CompoundStmt
    deriving (Eq, Show)

type ID = String

data Declaration = Declaration [ID] TypeN
    deriving (Eq, Show)

type Number = String

data TypeN  = StdTypeN StandardTypeN
            | ArrayTypeN (Number, Number) TypeN
            deriving (Eq, Show)

data StandardTypeN = IntTypeN | RealTypeN | StringTypeN deriving (Eq, Show)

data SubprogSection = SubprogSection [SubprogDec] deriving (Eq, Show)
data SubprogDec = SubprogDec SubprogHead [Declaration] CompoundStmt deriving (Eq, Show)

data SubprogHead    = SubprogHeadFunc ID Arguments StandardTypeN
                    | SubprogHeadProc ID Arguments
                    deriving (Eq, Show)

data Arguments  = EmptyArguments
                | Arguments [Param]
                deriving (Eq, Show)
data Param = Param [ID] TypeN
    deriving (Eq, Show)

data CompoundStmt = CompoundStmt [Stmt]
    deriving (Eq, Show)

data Stmt   = VarStmt Variable Expr
            | ProcStmt ProcedureStmt
            | CompStmt CompoundStmt
            | BranchStmt Expr Stmt Stmt
            | LoopStmt Expr Stmt
            deriving (Eq, Show)

data Variable = Variable ID [Expr] -- e.g. a[1+2][3*4]
    deriving (Eq, Show)

-- procedure invocation
data ProcedureStmt  = ProcedureStmtOnlyID ID
                    | ProcedureStmtWithExprs ID [Expr]
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

data Factor = IDSBFactor ID [Expr]  -- id[]
            | IDPFactor ID [Expr]   -- id()
            | NumFactor String
            | PFactor Expr
            | NotFactor Factor
            deriving (Eq, Show)

data AddOp = Plus | Minus deriving (Eq, Show)
data MulOp = Mul | Div deriving (Eq, Show)
data Relop = S | L | E | NE | SE | LE deriving (Eq, Show)
