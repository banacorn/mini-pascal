{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, OverlappingInstances #-}
module Compiler.Class.Serializable where

import Compiler.Type

import System.Console.ANSI
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
-- colours!

green :: String -> String
green s = setSGRCode [SetColor Foreground Vivid Green] ++ s ++ setSGRCode []

yellow :: String -> String
yellow s = setSGRCode [SetColor Foreground Vivid Yellow] ++ s ++ setSGRCode []

--------------------------------------------------------------------------------
-- other instances

instance Serializable Position where
    serialize Unknown = "?"
    serialize (Position o n l c) = show l ++ ":" ++ show c

instance Serializable ScopeType where
    serialize CompoundStatementScope = ""
    serialize (ProgramScope name) = "Program " ++ green name
    serialize (RegularScope symbol) = serialize symbol

instance Serializable Scope where
    serialize (Scope scopeType symbols scopes) =
        "Scope: " ++ serialize scopeType ++ "\n" ++
        indent (map serialize symbols ++ map serialize scopes)

instance Serializable Symbol where
    serialize (Symbol t i p) = green i ++ " : " ++ show t ++ " " ++ serialize p
    -- serialize (Symbol Used t i p) = yellow i ++ " : " ++ show t ++ " " ++ serialize p

instance Serializable String where
    serialize = id

instance Serializable a => Serializable [a] where
    serialize xs = "[" ++ intercalate ", " (map serialize xs) ++ "]"

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

instance Serializable ProgramNode where
    serialize (ProgramNode sym syms decs subprogs comp) =
        "\n" ++
        header ++ "\n" ++
        indent decs ++ "\n" ++
        indentBlock (serialize subprogs) ++
        indentBlock (serialize comp) ++
        ".\n"
        where
            header = "program " ++ fst sym ++ "(" ++ serializeIDs syms ++ ") ;" ++ "\n"
            serializeIDs [] = error "serialize empty ids"
            serializeIDs [x] = fst x
            serializeIDs (x:xs) = fst x ++ ", " ++ serializeIDs xs

instance Serializable DeclarationNode where
    serialize (DeclarationNode [] _) = []
    serialize (DeclarationNode syms t) =
        "var " ++ serializeIDs syms ++ " : " ++ serialize t ++ ";"
        where
            serializeIDs = intercalate ", " . map fst

instance Serializable TypeNode where
    serialize (BaseTypeNode t) = serialize t
    serialize (ArrayTypeNode (a, b) t) = "array [ " ++ a ++ " .. " ++ b ++ " ] of " ++ serialize t

instance Serializable StandardTypeNode where
    serialize IntTypeNode = "int"
    serialize RealTypeNode = "real"
    serialize StringTypeNode = "string"

instance Serializable SubprogramSectionNode where
    serialize (SubprogramSectionNode decs) = intercalate "\n" (map serialize decs)

instance Serializable SubprogDec where
    serialize (SubprogDec header decs comp) =
        serialize header ++ "\n" ++
        indent decs ++
        indentBlock (serialize comp)

instance Serializable SubprogHead where
    serialize (SubprogHeadFunc sym args typ) =
        "function " ++ fst sym ++ serialize args ++ " : " ++ serialize typ ++ ";"
    serialize (SubprogHeadProc sym args) =
        "procedure " ++ fst sym ++ serialize args ++ ";"

instance Serializable Arguments where
    serialize EmptyArguments = ""
    serialize (Arguments xs) = "(" ++ serializeArgs ++ ")"
        where
            serializeArgs = intercalate "; " (map serialize xs)

instance Serializable Param where
    serialize (Param syms t) = serializeIDs ++ ": " ++ serialize t
        where   serializeIDs = intercalate ", " (map fst syms)

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
    serialize (Variable sym es) = fst sym ++ concat (map showSBExpr es)
        where   showSBExpr e = "[" ++ serialize e ++ "]"

instance Serializable ProcedureStmt where
    serialize (ProcedureStmtOnlyID sym) = fst sym
    serialize (ProcedureStmtWithExprs sym es) = fst sym ++ "(" ++ serializeExpr ++ ")"
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
    serialize (IDSBFactor sym es) = fst sym ++ concat (map serialize es)
        where   serializeSBExpr a = "[" ++ serialize a ++ "]"
    serialize (IDPFactor sym es)  = fst sym ++ "(" ++ serializeExpr ++ ")"
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
