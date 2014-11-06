module Compiler.Types where

data Token  = TokID String         -- identifiers
            | TokLParen            -- (
            | TokRParen            -- )
            | TokSemicolon         -- ;
            | TokColon             -- :
            | TokPeriod            -- .
            | TokComma             -- ,
            | TokLSB               -- [
            | TokRSB               -- ]
            | TokTypeInt           -- "integer"
            | TokTypeReal          -- "real"
            | TokStr String        -- string
            | TokNum String     -- numbers
            | TokProgram           -- "program"
            | TokFunction          -- "function"
            | TokProc              -- "procedure"
            | TokBegin             -- "begin"
            | TokEnd               -- "end"
            | TokVar               -- "var"
            | TokArr               -- "array"
            | TokOf                -- "of"
            | TokIf                -- "if"
            | TokThen              -- "then"
            | TokElse              -- "else"
            | TokWhile             -- "while"
            | TokDo                -- "do"
            | TokAssign            -- :=
            | TokS                 -- <
            | TokL                 -- >
            | TokSE                -- <=
            | TokLE                -- >=
            | TokEq                 -- =
            | TokNEq                -- !=
            | TokPlus              -- +
            | TokMinus             -- -
            | TokTimes             -- *
            | TokDiv               -- /
            | TokNot               -- "not"
            | TokTo                -- ..
            | TokError String
    deriving (Eq, Show)

data Program = Program ID [ID] [Declaration] [SubprogDec] CompoundStmt
    deriving (Eq, Show)

type ID = String
data Declaration = Declaration [ID] Type
    deriving (Eq, Show)
type Number = String
data Type   = StdType StandardType
            | ArrayType (Number, Number) Type
            deriving (Eq, Show)
data StandardType = IntType | RealType | StringType deriving (Eq, Show)

data SubprogDec = SubprogDec SubprogHead [Declaration] CompoundStmt deriving (Eq, Show)
data SubprogHead    = SubprogHeadFunc ID Arguments StandardType
                    | SubprogHeadProc ID Arguments
                    deriving (Eq, Show)
data Arguments  = EmptyArguments
                | Arguments [Param]
                deriving (Eq, Show)
data Param = Param [ID] Type
    deriving (Eq, Show)

type CompoundStmt = [OptionalStmt]
type OptionalStmt = [Stmt]
data Stmt   = VarStmt Variable Expr
            | ProcStmt ProcedureStmt
            | CompStmt CompoundStmt
            | BranchStmt Expr Stmt Stmt
            | LoopStmt Expr Stmt
            deriving (Eq, Show)

data Variable = Variable ID [Expr]
    deriving (Eq, Show)


data ProcedureStmt  = ProcedureStmtOnlyID ID
                    | ProcedureStmtWithExprs [Expr]
                    deriving (Eq, Show)

data Expr   = UnaryExpr SimpleExpr
            | BinaryExpr SimpleExpr Relop SimpleExpr
            deriving (Eq, Show)

data SimpleExpr = SimpleExprTerm Term
                | SimpleExprOp SimpleExpr AddOp Term
                deriving (Eq, Show)

data Term   = FactorTerm Factor
            | OpTerm Term MulOp Factor
            deriving (Eq, Show)

data Factor = IDSBFactor ID [Expr]
            | IDPFactor ID [Expr]
            | NumFactor String
            | PFactor Expr
            | NotFactor Factor
            deriving (Eq, Show)

data AddOp = Plus | Minus deriving (Eq, Show)
data MulOp = Mul | Div deriving (Eq, Show)
data Relop = S | L | E | NE | SE | LE deriving (Eq, Show)
