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

-- paragraph with top & bottom newline paddings
paragraphPadded :: [Line] -> String
paragraphPadded = serialize . Paragraph . addPadding
    where   addPadding xs = 0 >>>> [" "] ++ xs ++ 0 >>>> [" "]

indents :: Int -> String -> Line
indents 0 = Un
indents n = Indent . indents (n - 1)

-- indent list of Chunks
(>>>>) :: Serializable a => Int -> [a] -> [Line]
n >>>> xs = map (indents n) (map serialize xs >>= lines)

intercalate' :: Serializable a => String -> [a] -> String
intercalate' delimeter = intercalate delimeter . map serialize


--------------------------------------------------------------------------------
-- colours!

cyan :: String -> String
cyan s = setSGRCode [SetColor Foreground Vivid Cyan] ++ s ++ setSGRCode []

green :: String -> String
green s = setSGRCode [SetColor Foreground Vivid Green] ++ s ++ setSGRCode []

yellow :: String -> String
yellow s = setSGRCode [SetColor Foreground Vivid Yellow] ++ s ++ setSGRCode []

red :: String -> String
red s = setSGRCode [SetColor Foreground Vivid Red] ++ s ++ setSGRCode []

dull :: String -> String
dull s = setSGRCode [SetColor Foreground Dull White] ++ s ++ setSGRCode []

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
    serialize (Scope scopeType scopes stuffs) = paragraph $
            0 >>>> ["Scope: " ++ serialize scopeType]
        ++  1 >>>> stuffs
        ++  1 >>>> scopes
instance Serializable Symbol where
    serialize (Symbol t i p) = green i ++ " : " ++ show t ++ " " ++ serialize p

instance Serializable String where
    serialize = id

instance Serializable a => Serializable [a] where
    serialize xs = "[" ++ intercalate ", " (map serialize xs) ++ "]"

instance Serializable PipelineError where
    serialize InvalidArgument =  paragraphPadded $
            0 >>>> ["invalid argument"]
    serialize (NoSuchFile path) = paragraphPadded $
            0 >>>> ["no such path: " ++ yellow path]
    serialize (NotEnoughInput path src) = paragraphPadded $
            0 >>>> [path ++ ":"]
        ++  1 >>>> ["Not enough input"]
    serialize (LexError path src tok pos) = paragraphPadded $
            0 >>>> [red "Unrecognizable token: " ++ yellow tok]
        ++  1 >>>> toCodeBlocks path src [pos]
    serialize (ParseError path src tok pos) = paragraphPadded $
            0 >>>> [red "Unable to parse " ++ yellow (serialize tok)]
        ++  1 >>>> toCodeBlocks path src [pos]
    serialize (DeclarationDuplicationError path src partition) = paragraphPadded $
            0 >>>> [red "Declaration Duplicated: " ++ yellow (serialize i)]
        ++  1 >>>> codeBlocks
        where   partition' = sort partition         -- sort symbols base on their position
                Symbol t i pos = head partition'    -- get the foremost symbol
                markPosition symbol = path ++ ":" ++ serialize (symPos symbol)
                codeBlocks = toCodeBlocks path src (map symPos partition')

instance Serializable CodeBlock where
    serialize (CodeBlock path src positions (from, to)) = paragraphPadded $
            0 >>>> (map markPosition positions)
        ++  0 >>>> ["----------------------------------------------------------------"]
        ++  0 >>>> numberedLines
        where   markPosition pos = path ++ ":" ++ serialize pos
                colouredSource = colourSource 0 positions src
                markedLines = drop from (take to (lines colouredSource))


                numberedLines = zipWith (++) lineNumberStrs markedLines
                lineNumbers = [from + 1 .. to + 1]
                lineNumberStrs = map (dull . fillSpace . show) lineNumbers
                    where   widest = length (show (to + 1))     -- the longest line number
                            fillSpace s = replicate (widest - length s) ' ' ++ s ++ " "

                colourSource _ [] source = source
                colourSource i (Position o n _ _ : xs) source =
                    (pre ++ yellow mid) ++ colourSource (i + o + n) xs post
                    where   pre = take (o - i) source
                            mid = take n (drop (o - i) source)
                            post = drop n (drop (o - i) source)

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
        ++  1 >>>> subprogs
        ++  1 >>>> ["begin"]
        ++  2 >>>> stmts
        ++  1 >>>> ["end"]
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
        ++  1 >>>> ["begin"]
        ++  2 >>>> stmts
        ++  1 >>>> ["end"]

    -- function, with parameters
    serialize (FuncDecNode sym params typ vars stmts) = paragraph $
            0 >>>> ["function " ++ fst sym ++ "(" ++ paramList ++ "): " ++ serialize typ ++ ";"]
        ++  1 >>>> vars
        ++  1 >>>> ["begin"]
        ++  2 >>>> stmts
        ++  1 >>>> ["end"]
        where   paramList = intercalate' ", " params

    -- procedure, no paramter
    serialize (ProcDecNode sym [] vars stmts) = paragraph $
            0 >>>> ["procedure " ++ fst sym ++ ";"]
        ++  1 >>>> vars
        ++  1 >>>> ["begin"]
        ++  2 >>>> stmts
        ++  1 >>>> ["end"]

    -- procedure, with parameters
    serialize (ProcDecNode sym params vars stmts) = paragraph $
            0 >>>> ["function " ++ fst sym ++ "(" ++ paramList ++ ");"]
        ++  1 >>>> vars
        ++  1 >>>> ["begin"]
        ++  2 >>>> stmts
        ++  1 >>>> ["end"]
        where   paramList = intercalate' ", " params


instance Serializable ParameterNode where
    serialize (ParameterNode syms t) = ids ++ ": " ++ serialize t
        where   ids = intercalate' ", " (map fst syms)

instance Serializable StmtNode where
    serialize (AssignStmtNode v e) = serialize v ++ " := " ++ serialize e
    serialize (SubprogInvokeStmtNode sym []) = fst sym
    serialize (SubprogInvokeStmtNode sym exprs) = fst sym ++ "(" ++ exprs' ++ ")"
        where   exprs' = intercalate' ", " exprs
    serialize (CompStmtNode stmts) = paragraph $
            0 >>>> ["begin"]
        ++  1 >>>> stmts
        ++  0 >>>> ["end"]
    serialize (BranchStmtNode e s t) = paragraph $
            0 >>>> ["if " ++ serialize e]
        ++  1 >>>> ["then " ++ serialize s]
        ++  1 >>>> ["else " ++ serialize s]
    serialize (LoopStmtNode e s) = paragraph $
            0 >>>> ["while " ++ serialize e ++ " do"]
        ++  1 >>>> [s]

instance Serializable VariableNode where
    serialize (VariableNode sym es) = fst sym ++ (es >>= showArrayAccess)
        where   showArrayAccess e = "[" ++ serialize e ++ "]"

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
    serialize (ArrayAccessFactorNode sym exprs) = fst sym ++ (exprs >>= showArrayAccess)
        where   showArrayAccess a = "[" ++ serialize a ++ "]"
    serialize (SubprogInvokeFactorNode sym exprs)  = fst sym ++ "(" ++ exprs' ++ ")"
        where   exprs' = intercalate' ", " exprs
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
