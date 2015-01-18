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

prefix :: String -> String -> String
prefix s x = s ++ x

addNewLine :: String -> String
addNewLine = suffix "\n"

--------------------------------------------------------------------------------
-- colours!

green :: String -> String
green s = setSGRCode [SetColor Foreground Vivid Green] ++ s ++ setSGRCode []

yellow :: String -> String
yellow s = setSGRCode [SetColor Foreground Vivid Yellow] ++ s ++ setSGRCode []

red :: String -> String
red s = setSGRCode [SetColor Foreground Vivid Red] ++ s ++ setSGRCode []


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

instance Serializable PipelineError where
    serialize InvalidArgument = "invalid argument"
    serialize (NoSuchFile path) = "no such path: " ++ yellow path
    serialize (NotEnoughInput path src) =
        path ++ ":\n"
        ++ "    Not enough input"
    serialize (LexError path src tok pos) =
        path ++ ":" ++ serialize pos ++ ":\n"
        ++ "    Unrecognizable token " ++ yellow tok ++ "\n"
    serialize (ParseError path src tok pos) =
        path ++ ":" ++ serialize pos ++ ":\n"
        ++ "    Unable to parse " ++ yellow (serialize tok) ++ "\n"
    serialize (DeclarationDuplicationError path src partition) =
        let Symbol _ i pos = head partition in
        path ++ ":" ++ serialize pos ++ ":\n"
        ++ "    Declaration Duplicated  " ++ yellow (serialize i) ++ "\n"
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
    serialize (ProgramNode sym syms decs subprogs stmts) =
        "\n" ++
        header ++ "\n" ++
        indent decs ++ "\n" ++
        indent subprogs ++ "\n" ++
        "    begin" ++ "\n" ++
        indentWith (prefix "    " . suffix ";\n") stmts ++
        "    end" ++
        ".\n"
        where
            header = "program " ++ fst sym ++ "(" ++ serializeIDs syms ++ ") ;" ++ "\n"
            serializeIDs [] = error "serialize empty ids"
            serializeIDs [x] = fst x
            serializeIDs (x:xs) = fst x ++ ", " ++ serializeIDs xs

instance Serializable VarDecNode where
    serialize (VarDecNode [] _) = []
    serialize (VarDecNode syms t) =
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

instance Serializable SubprogDecNode where
    serialize (FuncDecNode sym [] typ vars stmts) =
        "function " ++ fst sym ++ " : " ++ serialize typ ++ ";" ++ "\n" ++
        indent vars ++
        "    begin" ++ "\n" ++
        indentWith (prefix "    " . suffix ";\n") stmts ++
        "    end"

    serialize (FuncDecNode sym args typ vars stmts) =
        "function " ++ fst sym ++ "(" ++ intercalate ", " (map serialize args) ++ "): " ++ serialize typ ++ ";" ++ "\n" ++
        indent vars ++
        "    begin" ++ "\n" ++
        indentWith (prefix "    " . suffix ";\n") stmts ++
        "    end"

    serialize (ProcDecNode sym [] vars stmts) =
        "procedure " ++ fst sym ++ ";" ++ "\n" ++
        indent vars ++
        "    begin" ++ "\n" ++
        indentWith (prefix "    " . suffix ";\n") stmts ++
        "    end"

    serialize (ProcDecNode sym args vars stmts) =
        "procedure " ++ fst sym ++ "(" ++ intercalate ", " (map serialize args) ++ ");" ++ "\n" ++
        indent vars ++
        "    begin" ++ "\n" ++
        indentWith (prefix "    " . suffix ";\n") stmts ++
        "    end"


instance Serializable ParameterNode where
    serialize (ParameterNode syms t) = serializeIDs ++ ": " ++ serialize t
        where   serializeIDs = intercalate ", " (map fst syms)

instance Serializable StmtNode where
    serialize (AssignStmtNode v e) = serialize v ++ " := " ++ serialize e
    serialize (SubprogInvokeStmtNode sym []) = fst sym
    serialize (SubprogInvokeStmtNode sym exprs) = fst sym ++ "(" ++ serializeExprs ++ ")"
        where   serializeExprs = intercalate ", " (map serialize exprs)
    serialize (CompStmtNode stmts) =
        "    begin" ++ "\n" ++
        indentWith (prefix "    " . suffix ";\n") stmts ++
        "    end"
    serialize (BranchStmtNode e s t) =
        "if " ++ serialize e ++ "\n" ++
        "    then " ++ serialize s ++ "\n" ++
        "    else " ++ serialize t
    serialize (LoopStmtNode e s) = "while " ++ serialize e ++ " do\n" ++ serialize s

instance Serializable VariableNode where
    serialize (VariableNode sym es) = fst sym ++ concat (map showSBExpr es)
        where   showSBExpr e = "[" ++ serialize e ++ "]"

instance Serializable ExprNode where
    serialize (UnaryExprNode e) = serialize e
    serialize (BinaryExprNode a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

instance Serializable SimpleExprNode where
    serialize (SimpleExprTermNode t) = serialize t
    serialize (SimpleExprOpNode a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b

instance Serializable TermNode where
    serialize (FactorTermNode f) = serialize f
    serialize (OpTermNode a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
    serialize (NegTermNode f) = "-" ++ serialize f

instance Serializable FactorNode where
    serialize (ArrayAccessFactorNode sym es) = fst sym ++ concat (map serialize es)
        where   serializeSBExpr a = "[" ++ serialize a ++ "]"
    serialize (SubprogInvokeFactorNode sym es)  = fst sym ++ "(" ++ serializeExpr ++ ")"
        where   serializeExpr = intercalate ", " (map serialize es)
    serialize (NumFactorNode s) = s
    serialize (SubFactorNode e) = serialize e
    serialize (NotFactorNode f) = "not " ++ serialize f

instance Serializable AddOpNode where
    serialize Plus = "+"
    serialize Minus = "-"

instance Serializable MulOpNode where
    serialize Mul = "*"
    serialize Div = "/"

instance Serializable RelOpNode where
    serialize S = "<"
    serialize L = ">"
    serialize E = "="
    serialize NE = "!="
    serialize SE = "<="
    serialize LE = ">="
