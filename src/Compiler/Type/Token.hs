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

data Position = Position {
        posOffset :: Int
    ,   posLength :: Int
    ,   posLine :: Int
    ,   posColumn :: Int
    }
    deriving (Eq)

instance Show Position where
    show (Position offset len line column) = "Position " ++ show offset ++ " " ++ show len ++ " "++ show line ++ " " ++ show column

data Token' a = Token a Position
    deriving (Eq, Show)

-- instance Functor Token' where
--     fmap f (Token x pos) = Token (f x) pos
--
-- instance Applicative Token' where
--     pure x = Token x (Position 0, 1, 1)
--     (Token f p) <*> (Token x q) = Token (f x)

type Token = Token' Tok
