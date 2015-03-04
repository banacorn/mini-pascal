module Compiler.Type.Token where

import Compiler.Class.Serializable

import Data.Monoid
import Control.Applicative

data Tok    = TokID String         -- identifiers
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
            | TokInt String        -- integer literal
            | TokReal String       -- real literal
            | TokProgram           -- "program"
            | TokFunction          -- "function"
            | TokProc              -- "procedure"
            | TokBegin             -- "begin"
            | TokReturn            -- "return"
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
    serialize TokLSB = "["              -- [
    serialize TokRSB = "]"              -- ]
    serialize TokTypeInt = "integer"          -- "integer"
    serialize TokTypeReal = "real"         -- "real"
    serialize (TokInt s) = s        -- int numbers
    serialize (TokReal s) = s        -- real numbers
    serialize TokProgram = "program"          -- "program"
    serialize TokFunction = "function"         -- "function"
    serialize TokProc = "procedure"             -- "procedure"
    serialize TokBegin = "begin"            -- "begin"
    serialize TokReturn = "return"          -- "return"
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
-- Position

data Position = Position
    {   posOffset :: Int
    ,   posLength :: Int
    ,   posLine :: Int
    ,   posColumn :: Int
    } | Unknown
    deriving (Eq)

instance Show Position where
    show (Position offset len line column) = "Position " ++ show offset ++ " " ++ show len ++ " L"++ show line ++ " C" ++ show column
    show Unknown = "Unknown"

instance Serializable Position where
    serialize Unknown = "?"
    serialize (Position o n l c) = show l ++ ":" ++ show c

instance Monoid Position where
    mempty = Unknown
    Position o n l c `mappend` Position o' n' _ _ = Position o (o' - o + n') l n

-- imagine Unknown as infinitely big Position
instance Ord Position where
    Unknown `compare` Unknown = EQ
    Unknown `compare` _       = GT
    _       `compare` Unknown = LT
    Position o _ _ _ `compare` Position o' _ _ _ = o `compare` o'


--------------------------------------------------------------------------------
-- Token
data TokenF a = Token a Position
    deriving (Eq, Show)
type Token = TokenF Tok

getPosition :: TokenF a -> Position
getPosition (Token _ p) = p
