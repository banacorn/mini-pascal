module Compiler.Types where

data Token  = ID String         -- identifiers
            | LParen            -- (
            | RParen            -- )
            | Semicolon         -- ;
            | Colon             -- :
            | Period            -- .
            | Comma             -- ,
            | LSB               -- [
            | RSB               -- ]
            | Z Int             -- integer
            | Str String        -- num, string
            | R Double          -- real
            | Program           -- "program"
            | Function          -- "function"
            | Proc              -- "procedure"
            | Begin             -- "begin"
            | End               -- "end"
            | Var               -- "var"
            | Arr               -- "array"
            | Of                -- "of"
            | If                -- "if"
            | Then              -- "then"
            | Else              -- "else"
            | While             -- "while"
            | Do                -- "do"
            | Assign            -- :=
            | S                 -- <
            | L                 -- >
            | SE                -- <=
            | LE                -- >=
            | E                 -- =
            | NE                -- !=
            | Plus              -- +
            | Minus             -- -
            | Times             -- *
            | Div               -- /
            | Not               -- "not"
            | To                -- ..
            | LexicalError String
    deriving (Eq, Show)
