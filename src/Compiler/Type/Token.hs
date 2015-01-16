module Compiler.Type.Token where

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
            | TokEOF               -- EOF
            deriving (Eq, Show)

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

instance Monoid Position where
    mempty = Unknown
    Position o n l c `mappend` Position o' n' _ _ = Position o (o' - o + n') l n

data TokenF a = Token a Position
    deriving (Eq, Show)

instance Functor TokenF where
    fmap f (Token tok pos) = Token (f tok) pos

instance Applicative TokenF where
    pure tok = Token tok Unknown
    Token f a <*> Token tok b = Token (f tok) (a <> b)

type Token = TokenF Tok

getPosition :: TokenF a -> Position
getPosition (Token _ p) = p
