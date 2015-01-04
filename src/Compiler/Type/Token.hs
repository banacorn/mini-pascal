module Compiler.Type.Token where

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
            | TokEq                -- =
            | TokNEq               -- !=
            | TokPlus              -- +
            | TokMinus             -- -
            | TokTimes             -- *
            | TokDiv               -- /
            | TokNot               -- "not"
            | TokTo                -- ..
            | TokError String      -- anything else
            deriving (Eq, Show)

data Position = Position
    {   posOffset :: Int
    ,   posLength :: Maybe Int
    ,   posLine :: Int
    ,   posColumn :: Int
    } | Unknown
    deriving (Eq)

instance Show Position where
    show (Position offset len line column) = "Position " ++ show offset ++ " " ++ show len ++ " L"++ show line ++ " C" ++ show column
    show Unknown = "Unknown"

data Token' a = Token a Position
    deriving (Eq, Show)

type Token = Token' Tok
