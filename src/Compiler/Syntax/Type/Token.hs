module Compiler.Syntax.Type.Token where

import Compiler.Serializable
import Compiler.Syntax.Type.Position
import Compiler.AST.Type.Symbol

data Tok    = TokID String         -- identifiers
            | TokLParen            -- (
            | TokRParen            -- )
            | TokSemicolon         -- ;
            | TokColon             -- :
            | TokPeriod            -- .
            | TokComma             -- ,
            | TokTypeInt           -- "integer"
            | TokTypeReal          -- "real"
            | TokTypeVoid          -- "void"
            | TokInt String        -- integer literal
            | TokReal String       -- real literal
            | TokProgram           -- "program"
            | TokFunction          -- "function"
            | TokBegin             -- "begin"
            | TokReturn            -- "return"
            | TokEnd               -- "end"
            | TokVar               -- "var"
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
            | TokEq                -- =
            | TokNEq               -- !=
            | TokPlus              -- +
            | TokMinus             -- -
            | TokTimes             -- *
            | TokDiv               -- /
            | TokNot               -- "not"
            | TokTo                -- ..
            | TokError String      -- anything else
            | TokEOF               -- EOF
            deriving (Eq, Show)


instance Serializable Tok where
    serialize (TokID s) = s        -- identifier
    serialize TokLParen = "("           -- (
    serialize TokRParen = ")"           -- )
    serialize TokSemicolon = ";"        -- ;
    serialize TokColon = ":"            -- :
    serialize TokPeriod = "."           -- .
    serialize TokComma = ","            -- ,
    serialize TokTypeInt = "integer"          -- "integer"
    serialize TokTypeReal = "real"         -- "real"
    serialize TokTypeVoid = "void"              -- "void"
    serialize (TokInt s) = s        -- int numbers
    serialize (TokReal s) = s        -- real numbers
    serialize TokProgram = "program"          -- "program"
    serialize TokFunction = "function"         -- "function"
    serialize TokBegin = "begin"            -- "begin"
    serialize TokReturn = "return"          -- "return"
    serialize TokEnd = "end"              -- "end"
    serialize TokVar = "var"              -- "var"
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
-- Token

data TokenF a = Token a Position
    deriving (Eq, Show)

instance Serializable a => Serializable (TokenF a) where
    serialize (Token a pos) = green (serialize a) ++ " " ++ serialize pos

type Token = TokenF Tok

--------------------------------------------------------------------------------

getPosition :: TokenF a -> Position
getPosition (Token _ p) = p

toSym :: Token -> Symbol
toSym (Token (TokID i) p) = Symbol i p

toLiteral :: Token -> Value
toLiteral (Token (TokInt  i) p) = IntLiteral (read i) p
toLiteral (Token (TokReal i) p) = RealLiteral (read i) p
