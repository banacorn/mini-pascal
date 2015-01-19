{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, OverlappingInstances #-}
module Compiler.Class.Serializable where

import Compiler.Type

import System.Console.ANSI
import Data.List (intercalate, sort)

infixr 6 >>>>

class Serializable a where
    serialize :: a -> String

--------------------------------------------------------------------------------
-- DSL for indentation, deep-embedding

data Line   = Indent Line
            | Un String
data Paragraph = Paragraph [Line]

indentSize :: Int
indentSize = 4

instance Serializable Line where
    serialize (Indent   p) = replicate indentSize ' ' ++ serialize p
    serialize (Un p) = p

instance Serializable Paragraph where
    serialize (Paragraph ls) = intercalate' "\n" ls

paragraph :: [Line] -> String
paragraph = serialize . Paragraph

intercalate' :: Serializable a => String -> [a] -> String
intercalate' delimeter = intercalate delimeter . map serialize

indents :: Int -> String -> Line
indents 0 = Un
indents n = Indent . indents (n - 1)

(>>>>) :: Serializable a => Int -> [a] -> [Line]
n >>>> xs = map (indents n . serialize) xs

(>>>|) :: Serializable a => Int -> [a] -> [Line]
n >>>| xs = map (indents n) (map serialize xs >>= lines)

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
    serialize (Scope scopeType symbols scopes) = paragraph $
        [   Un $ "Scope: " ++ serialize scopeType]
        ++  map (indents 1) (map serialize symbols)
        ++  map (indents 1) (map serialize scopes >>= lines)

instance Serializable Symbol where
    serialize (Symbol t i p) = green i ++ " : " ++ show t ++ " " ++ serialize p

instance Serializable String where
    serialize = id

instance Serializable a => Serializable [a] where
    serialize xs = "[" ++ intercalate ", " (map serialize xs) ++ "]"

instance Serializable PipelineError where
    serialize InvalidArgument = "invalid argument"
    serialize (NoSuchFile path) = "no such path: " ++ yellow path
    serialize (NotEnoughInput path src) = paragraph $
            0 >>>> [path ++ ":"]
        ++  1 >>>> ["Not enough input"]
    serialize (LexError path src tok pos) = paragraph $
            0 >>>> [path ++ ":" ++ serialize pos ++ ":"]
        ++  1 >>>> ["Unrecognizable token " ++ yellow tok]
    serialize (ParseError path src tok pos) = paragraph $
            0 >>>> [path ++ ":" ++ serialize pos ++ ":"]
        ++  1 >>>> ["Unable to parse " ++ yellow (serialize tok)]
    serialize (DeclarationDuplicationError path src partition) = paragraph $
            0 >>>> [path ++ ":" ++ serialize pos ++ ":"]
        ++  1 >>>> ["Declaration Duplicated " ++ yellow (serialize i)]
        ++  2 >>>> map markPosition partition'
        where   partition' = sort partition         -- sort symbols base on their position
                Symbol t i pos = head partition'    -- get the foremost symbol
                markPosition symbol = path ++ ":" ++ serialize (symPos symbol)
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
    serialize (ProgramNode sym params vars subprogs stmts) = paragraph $
            0 >>>> [header]
        ++  1 >>>> vars
        ++  1 >>>| subprogs
        where
            header = "program " ++ fst sym ++ "(" ++ paramList ++ ") ;"
            paramList = intercalate' ", " (map fst params)

instance Serializable VarDecNode where
    serialize (VarDecNode [] _) = ""
    serialize (VarDecNode syms t) =
        "var " ++ ids ++ " : " ++ serialize t ++ ";"
        where
            ids = intercalate' ", " (map fst syms)

instance Serializable TypeNode where
    serialize (BaseTypeNode t) = serialize t
    serialize (ArrayTypeNode (a, b) t) =
        "array [ " ++ a ++ " .. " ++ b ++ " ] of " ++ serialize t

instance Serializable StandardTypeNode where
    serialize IntTypeNode = "int"
    serialize RealTypeNode = "real"
    serialize StringTypeNode = "string"

instance Serializable SubprogDecNode where
    -- function, no parameter
    serialize (FuncDecNode sym [] typ vars stmts) = paragraph $
            0 >>>> ["function " ++ fst sym ++ " : " ++ serialize typ ++ ";"]
        ++  1 >>>> vars
        ++  2 >>>> ["begin"]
        -- ++  map Indent (map indent (map serialize stmts))
        ++  2 >>>> ["end"]

    -- function, with parameters
    serialize (FuncDecNode sym params typ vars stmts) = paragraph $
            0 >>>> ["function " ++ fst sym ++ "(" ++ paramList ++ "): " ++ serialize typ ++ ";"]
        ++  1 >>>> vars
        ++  2 >>>> ["begin"]
        -- ++  map Indent (map indent (map serialize stmts))
        ++  2 >>>> ["begin"]
        where   paramList = intercalate' ", " params

    -- procedure, no paramter
    serialize (ProcDecNode sym [] vars stmts) = paragraph $
            0 >>>> ["procedure " ++ fst sym ++ ";"]
        ++  1 >>>> vars
        ++  2 >>>> ["begin"]
        -- ++  map Indent (map indent (map serialize stmts))
        ++  2 >>>> ["begin"]

    -- procedure, with parameters
    serialize (ProcDecNode sym params vars stmts) = paragraph $
            0 >>>> ["function " ++ fst sym ++ "(" ++ paramList ++ ");"]
        ++  1 >>>> vars
        ++  2 >>>> ["begin"]
        -- ++  map Indent (map indent (map serialize stmts))
        ++  2 >>>> ["begin"]
        where   paramList = intercalate' ", " params


instance Serializable ParameterNode where
    serialize (ParameterNode syms t) = ids ++ ": " ++ serialize t
        where   ids = intercalate' ", " (map fst syms)

-- instance Serializable StmtNode where
--     serialize (AssignStmtNode v e) = serialize v ++ " := " ++ serialize e
--     serialize (SubprogInvokeStmtNode sym []) = fst sym
--     serialize (SubprogInvokeStmtNode sym exprs) = fst sym ++ "(" ++ serializeExprs ++ ")"
--         where   serializeExprs = intercalate ", " (map serialize exprs)
--     serialize (CompStmtNode stmts) =
--         "    begin" ++ "\n" ++
--         indentWith (prefix "    " . suffix ";\n") stmts ++
--         "    end"
--     serialize (BranchStmtNode e s t) =
--         "if " ++ serialize e ++ "\n" ++
--         "    then " ++ serialize s ++ "\n" ++
--         "    else " ++ serialize t
--     serialize (LoopStmtNode e s) = "while " ++ serialize e ++ " do\n" ++ serialize s
--
-- instance Serializable VariableNode where
--     serialize (VariableNode sym es) = fst sym ++ concat (map showSBExpr es)
--         where   showSBExpr e = "[" ++ serialize e ++ "]"
--
-- instance Serializable ExprNode where
--     serialize (UnaryExprNode e) = serialize e
--     serialize (BinaryExprNode a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
--
-- instance Serializable SimpleExprNode where
--     serialize (SimpleExprTermNode t) = serialize t
--     serialize (SimpleExprOpNode a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
--
-- instance Serializable TermNode where
--     serialize (FactorTermNode f) = serialize f
--     serialize (OpTermNode a o b) = serialize a ++ " " ++ serialize o ++ " " ++ serialize b
--     serialize (NegTermNode f) = "-" ++ serialize f
--
-- instance Serializable FactorNode where
--     serialize (ArrayAccessFactorNode sym es) = fst sym ++ concat (map serialize es)
--         where   serializeSBExpr a = "[" ++ serialize a ++ "]"
--     serialize (SubprogInvokeFactorNode sym es)  = fst sym ++ "(" ++ serializeExpr ++ ")"
--         where   serializeExpr = intercalate ", " (map serialize es)
--     serialize (NumFactorNode s) = s
--     serialize (SubFactorNode e) = serialize e
--     serialize (NotFactorNode f) = "not " ++ serialize f
--
-- instance Serializable AddOpNode where
--     serialize Plus = "+"
--     serialize Minus = "-"
--
-- instance Serializable MulOpNode where
--     serialize Mul = "*"
--     serialize Div = "/"
--
-- instance Serializable RelOpNode where
--     serialize S = "<"
--     serialize L = ">"
--     serialize E = "="
--     serialize NE = "!="
--     serialize SE = "<="
--     serialize LE = ">="
