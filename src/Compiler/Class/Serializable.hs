{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}

module Compiler.Class.Serializable where

import Compiler.Type

import Data.List (intercalate)

class Serializable a where
    serialize :: a -> String

--------------------------------------------------------------------------------
-- helper functions

indentBlock :: String -> String
indentBlock str = map addNewLine (lines str) >>= (++) (replicate 4 ' ')

indentWith :: Serializable a => (String -> String) -> [a] -> String
indentWith f xs = indentBlock (xs >>= f . serialize)

indent :: Serializable a => [a] -> String
indent = indentWith addNewLine

suffix :: String -> String -> String
suffix s x = x ++ s

addNewLine :: String -> String
addNewLine = suffix "\n"

--------------------------------------------------------------------------------
-- other instances

instance Serializable Scope where
    serialize (Scope name symbols scopes) =
        "Scope: " ++ name ++ "\n" ++
        indent ([show symbols] ++ map serialize scopes)

instance Serializable String where
    serialize = id

--------------------------------------------------------------------------------
-- Tok instances

instance Serializable Tok where
    serialize (TokID s) = s        -- identifier
    serialize TokLParen = "("           -- (
    serialize TokRParen = ")"           -- )
    serialize TokSemicolon = ";"        -- ;
    serialize TokColon = ":"            -- :
    serialize TokPeriod = "."           -- .
    serialize TokComma = ","            -- ,
    serialize TokLSB = "["              -- [
    serialize TokRSB = "]"              -- ]
    serialize TokTypeInt = "integer"          -- "integer"
    serialize TokTypeReal = "real"         -- "real"
    serialize TokTypeStr = "string"          -- "string"
    serialize (TokNum s) = s        -- numbers
    serialize TokProgram = "program"          -- "program"
    serialize TokFunction = "function"         -- "function"
    serialize TokProc = "procedure"             -- "procedure"
    serialize TokBegin = "begin"            -- "begin"
    serialize TokEnd = "end"              -- "end"
    serialize TokVar = "var"              -- "var"
    serialize TokArr = "array"              -- "array"
    serialize TokOf = "of"               -- "of"
    serialize TokIf = "if"               -- "if"
    serialize TokThen = "then"             -- "then"
    serialize TokElse = "else"             -- "else"
    serialize TokWhile = "while"            -- "while"
    serialize TokDo = "do"               -- "do"
    serialize TokAssign = ":="           -- :=
    serialize TokS = "<"                -- <
    serialize TokL = ">"                -- >
    serialize TokSE = "<="               -- <=
    serialize TokLE = ">="               -- >=
    serialize TokEq = "="               -- =
    serialize TokNEq = "!="              -- !=
    serialize TokPlus = "+"             -- +
    serialize TokMinus = "-"            -- -
    serialize TokTimes = "*"            -- *
    serialize TokDiv = "/"              -- /
    serialize TokNot = "not"              -- "not"
    serialize TokTo = ".."               -- ..
    serialize (TokError s) = s

--------------------------------------------------------------------------------
-- AST instances

instance Serializable ParseTree where
    serialize (ParseTree program) = serialize program

instance Serializable Program where
    serialize (Program i is decs subprogdecs comp) =
        "\n" ++
        header ++ "\n" ++
        indent decs ++ "\n" ++
        indent subprogdecs ++
        indentBlock (serialize comp) ++
        ".\n"
        where
            header = "program " ++ i ++ "(" ++ serializeIDs is ++ ") ;" ++ "\n"
            serializeIDs [] = error "serialize empty ids"
            serializeIDs [x] = x
            serializeIDs (x:xs) = x ++ ", " ++ serializeIDs xs

instance Serializable Declaration where
    serialize (Declaration [] _) = []
    serialize (Declaration ids t) =
        "var " ++ serializeIDs ids ++ " : " ++ serialize t ++ ";"
        where
            serializeIDs = intercalate ", "

instance Serializable Type where
    serialize (StdType t) = serialize t
    serialize (ArrayType (a, b) t) = "array [ " ++ a ++ " .. " ++ b ++ " ] of " ++ serialize t

instance Serializable StandardType where
    serialize IntType = "int"
    serialize RealType = "real"
    serialize StringType = "string"

instance Serializable SubprogDec where
    serialize (SubprogDec header decs comp) =
        serialize header ++ "\n" ++
        indent decs ++
        indentBlock (serialize comp)

instance Serializable SubprogHead where
    serialize (SubprogHeadFunc i args typ) =
        "function " ++ i ++ serialize args ++ " : " ++ serialize typ ++ ";"
    serialize (SubprogHeadProc i args) =
        "procedure " ++ i ++ serialize args ++ ";"

instance Serializable Arguments where
    serialize EmptyArguments = ""
    serialize (Arguments xs) = "(" ++ serializeArgs ++ ")"
        where
            serializeArgs = intercalate "; " (map serialize xs)

instance Serializable Param where
    serialize (Param ids t) = serializeIDs ++ ": " ++ serialize t
        where   serializeIDs = intercalate ", " ids

instance Serializable CompoundStmt where
    serialize (CompoundStmt stmts) =
        "begin" ++ "\n" ++
        indentWith (suffix ";\n") stmts ++
        "end"

instance Serializable Stmt where
    serialize (VarStmt v e) = serialize v ++ " := " ++ serialize e
    serialize (ProcStmt p) = serialize p
    serialize (CompStmt c) = serialize c
    serialize (BranchStmt e s t) =
        "if " ++ serialize e ++ "\n" ++
        "    then " ++ serialize s ++ "\n" ++
        "    else " ++ serialize t
    serialize (LoopStmt e s) = "while " ++ serialize e ++ " do " ++ serialize s

instance Serializable Variable where
    serialize (Variable i es) = i ++ concat (map showSBExpr es)
        where   showSBExpr e = "[" ++ serialize e ++ "]"

instance Serializable ProcedureStmt where
    serialize (ProcedureStmtOnlyID i) = i
    serialize (ProcedureStmtWithExprs i es) = i ++ "(" ++ serializeExpr ++ ")"
        where   serializeExpr = intercalate ", " (map serialize es)

instance Serializable Expr where
    serialize (UnaryExpr e) = serialize e
    serialize (BinaryExpr a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

instance Serializable SimpleExpr where
    serialize (SimpleExprTerm t) = serialize t
    serialize (SimpleExprOp a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

instance Serializable Term where
    serialize (FactorTerm f) = serialize f
    serialize (OpTerm a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
    serialize (NegTerm f) = "-" ++ serialize f

instance Serializable Factor where
    serialize (IDSBFactor i es) = i ++ concat (map serialize es)
        where   serializeSBExpr a = "[" ++ serialize a ++ "]"
    serialize (IDPFactor i es)  = i ++ "(" ++ serializeExpr ++ ")"
        where   serializeExpr = intercalate ", " (map serialize es)
    serialize (NumFactor s) = s
    serialize (PFactor e) = serialize e
    serialize (NotFactor f) = "not " ++ serialize f

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
