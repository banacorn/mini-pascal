{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}
module Compiler.Types where

import Compiler.Serialize
import Data.List (intercalate, elemIndices)

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
            | TokTypeStr           -- "string"
            | TokNum String        -- numbers
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

indent' :: Int -> [String] -> String
indent' n xs = xs >>= (++) (replicate n ' ')

indent :: Int -> String -> String
indent n str = map addNewLine (lines str) >>= (++) (replicate n ' ')

addNewLine :: String -> String
addNewLine s = s ++ "\n"

instance Serializable Program where
    serialize (Program i is decs subprogdecs stmt) =
        header ++
        indent' 4 declarations ++
        indent' 4 subProgDeclarations ++
        indent 4 (serialize stmt ++ ".\n")
        where
            header = "program " ++ i ++ "(" ++ serializeIDs is ++ ") ;" ++ "\n"
            serializeIDs [x] = x
            serializeIDs (x:xs) = x ++ ", " ++ serializeIDs xs

            declarations = map (addNewLine . serialize) decs

            subProgDeclarations = map (addNewLine . serialize) subprogdecs


type ID = String
data Declaration = Declaration [ID] Type
    deriving (Eq, Show)

instance Serializable Declaration where
    serialize (Declaration [] t) = []
    serialize (Declaration ids t) =
        "var " ++ serializeIDs ids ++ " : " ++ serialize t ++ ";"
        where
            serializeIDs [x] = x
            serializeIDs (x:xs) = x ++ ", " ++ serializeIDs xs

type Number = String
data Type   = StdType StandardType
            | ArrayType (Number, Number) Type
            deriving (Eq, Show)
data StandardType = IntType | RealType | StringType deriving (Eq, Show)

instance Serializable Type where
    serialize (StdType t) = serialize t
    serialize (ArrayType (a, b) t) = "array [ " ++ a ++ " .. " ++ b ++ " ] of " ++ serialize t

instance Serializable StandardType where
    serialize IntType = "int"
    serialize RealType = "real"
    serialize StringType = "string"

data SubprogDec = SubprogDec SubprogHead [Declaration] CompoundStmt deriving (Eq, Show)
data SubprogHead    = SubprogHeadFunc ID Arguments StandardType
                    | SubprogHeadProc ID Arguments
                    deriving (Eq, Show)

instance Serializable SubprogDec where
    serialize (SubprogDec h decs stmt) =
        serialize h ++ "\n" ++
        serializeDecs decs ++
        indent 4 (serialize stmt)
        where
            serializeDecs decs = indent' 4 (map (addNewLine . serialize) decs)

instance Serializable SubprogHead where
    serialize (SubprogHeadFunc i args typ) =
        "function " ++ i ++ serialize args ++ " : " ++ serialize typ ++ ";"
    serialize (SubprogHeadProc i args) =
        "procedure " ++ i ++ serialize args ++ ";"


data Arguments  = EmptyArguments
                | Arguments [Param]
                deriving (Eq, Show)
data Param = Param [ID] Type
    deriving (Eq, Show)

instance Serializable Arguments where
    serialize EmptyArguments = ""
    serialize (Arguments xs) = "(" ++ serializeArgs ++ ")"
        where
            serializeArgs = intercalate "; " (map serialize xs)

instance Serializable Param where
    serialize (Param ids t) = serializeIDs ++ ": " ++ serialize t
        where   serializeIDs = intercalate ", " ids

type CompoundStmt = [Stmt]
data Stmt   = VarStmt Variable Expr
            | ProcStmt ProcedureStmt
            | CompStmt CompoundStmt
            | BranchStmt Expr Stmt Stmt
            | LoopStmt Expr Stmt
            deriving (Eq, Show)

instance Serializable CompoundStmt where
    serialize s =
        "begin\n" ++
        indent' 4 (map (addNewLine . serialize) s) ++
        "end"

instance Serializable Stmt where
    serialize (VarStmt v e) = serialize v ++ " := " ++ serialize e
    serialize (ProcStmt p) = serialize p
    serialize (CompStmt c) = serialize c
    serialize (BranchStmt e s t) =
        "if " ++ serialize e ++ " then " ++ serialize s ++ " else " ++ serialize t
    serialize (LoopStmt e s) = "while " ++ serialize e ++ " do " ++ serialize s

data Variable = Variable ID [Expr]
    deriving (Eq, Show)

instance Serializable Variable where
    serialize (Variable i es) = i ++ concat (map showSBExpr es)
        where   showSBExpr e = "[" ++ serialize e ++ "]"

data ProcedureStmt  = ProcedureStmtOnlyID ID
                    | ProcedureStmtWithExprs ID [Expr]
                    deriving (Eq, Show)

instance Serializable ProcedureStmt where
    serialize (ProcedureStmtOnlyID i) = i
    serialize (ProcedureStmtWithExprs i es) = i ++ "(" ++ serializeExpr ++ ")"
        where   serializeExpr = intercalate ", " (map serialize es)

data Expr   = UnaryExpr SimpleExpr
            | BinaryExpr SimpleExpr Relop SimpleExpr
            deriving (Eq, Show)

instance Serializable Expr where
    serialize (UnaryExpr e) = serialize e
    serialize (BinaryExpr a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

data SimpleExpr = SimpleExprTerm Term
                | SimpleExprOp SimpleExpr AddOp Term
                deriving (Eq, Show)

instance Serializable SimpleExpr where
    serialize (SimpleExprTerm t) = serialize t
    serialize (SimpleExprOp a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

data Term   = FactorTerm Factor
            | OpTerm Term MulOp Factor
            | NegTerm Factor
            deriving (Eq, Show)

instance Serializable Term where
    serialize (FactorTerm f) = serialize f
    serialize (OpTerm a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
    serialize (NegTerm f) = "-" ++ serialize f

data Factor = IDSBFactor ID [Expr]  -- id[]
            | IDPFactor ID [Expr]   -- id()
            | NumFactor String
            | PFactor Expr
            | NotFactor Factor
            deriving (Eq, Show)

instance Serializable Factor where
    serialize (IDSBFactor i e) = i ++ concat (map serialize e)
        where   serializeSBExpr a = "[" ++ serialize a ++ "]"
    serialize (IDPFactor i es)  = i ++ "(" ++ serializeExpr ++ ")"
        where   serializeExpr = intercalate ", " (map serialize es)
    serialize (NumFactor s) = s
    serialize (PFactor e) = serialize e
    serialize (NotFactor f) = "not " ++ serialize f


data AddOp = Plus | Minus deriving (Eq, Show)
data MulOp = Mul | Div deriving (Eq, Show)
data Relop = S | L | E | NE | SE | LE deriving (Eq, Show)

instance Serializable AddOp where
    serialize Plus = "+"
    serialize Minus = "-"

instance Serializable MulOp where
    serialize Mul = "*"
    serialize Div = "/"

instance Serializable Relop where
    serialize S = "<"
    serialize L = ">"
    serialize E = "="
    serialize NE = "!="
    serialize SE = "<="
    serialize LE = ">="
