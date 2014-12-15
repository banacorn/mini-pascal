{
module Compiler.Lexer (TokenM(..), Token(..), AlexPosn(..), constant, unary, scan) where
import Compiler.Types
import Data.List (find)
import Control.Monad.Except (throwError)

}

%wrapper "posn"

$a = [aA]
$b = [bB]
$c = [cC]
$d = [dD]
$e = [eE]
$f = [fF]
$g = [gG]
$h = [hH]
$i = [iI]
$j = [jJ]
$k = [kK]
$l = [lL]
$m = [mM]
$n = [nN]
$o = [oO]
$p = [pP]
$q = [qQ]
$r = [rR]
$s = [sS]
$t = [tT]
$u = [uU]
$v = [vV]
$w = [wW]
$x = [xX]
$y = [yY]
$z = [zZ]

$digit = 0-9
$nzdigit = 1-9
$alpha = [a-zA-Z]
$newline = [\r\n]
@sign = "+"|"-"
@integer = "0"|$nzdigit$digit*
@real = @integer"."$digit+
@scinot = @integer"."?$digit+([eE]@sign?$digit+)?
@dqoute = "
@ndqoute = [^"]
@squote = '
@nsquote = [^']
@string = @dqoute(@ndqoute*)@dqoute|@squote(@nsquote*)@squote
@identifier = ($alpha)($alpha|$digit)*

tokens :-
    $white+                                 ;

    "//"[^$newline]*$newline                ;

    $p$r$o$g$r$a$m                          { constant TokProgram }
    $f$u$n$c$t$i$o$n                        { constant TokFunction }
    $p$r$o$c$e$d$u$r$e                      { constant TokProc }
    $b$e$g$i$n                              { constant TokBegin }
    $e$n$d                                  { constant TokEnd }
    $v$a$r                                  { constant TokVar }
    $a$r$r$a$y                              { constant TokArr }
    $o$f                                    { constant TokOf }
    $i$f                                    { constant TokIf }
    $t$h$e$n                                { constant TokThen }
    $e$l$s$e                                { constant TokElse }
    $w$h$i$l$e                              { constant TokWhile }
    $d$o                                    { constant TokDo }
    $n$o$t                                  { constant TokNot }
    $i$n$t$e$g$e$r                          { constant TokTypeInt }
    $r$e$a$l                                { constant TokTypeReal }
    $s$t$r$i$n$g                            { constant TokTypeStr }
    @string                                 { unary TokNum }
    @scinot|@real|@integer                  { unary TokNum }
    @identifier                             { unary TokID }
    [$digit]@identifier                     { unary TokError }
    "("                                     { constant TokLParen }
    ")"                                     { constant TokRParen }
    ":"                                     { constant TokColon }
    ";"                                     { constant TokSemicolon }
    "."                                     { constant TokPeriod }
    ","                                     { constant TokComma }
    "["                                     { constant TokLSB }
    "]"                                     { constant TokRSB }
    ":="                                    { constant TokAssign }
    ">"                                     { constant TokL }
    "<"                                     { constant TokS }
    ">="                                    { constant TokLE }
    "<="                                    { constant TokSE }
    "="                                     { constant TokEq }
    "!="                                    { constant TokNEq }
    "+"                                     { constant TokPlus }
    "-"                                     { constant TokMinus }
    "*"                                     { constant TokTimes }
    "/"                                     { constant TokDiv }
    ".."                                    { constant TokTo }
    \0                                      ;
    .                                       { unary TokError }

{

toPosition :: AlexPosn -> Position
toPosition (AlexPn o l c) = Position o l c

constant :: Token -> AlexPosn -> String -> TokenM
constant tok pos _ = (tok, toPosition pos)

unary :: (String -> Token) -> AlexPosn -> String -> TokenM
unary tok pos s = (tok s, toPosition pos)

data Token  = TokID String         -- identifiers
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

type TokenM = (Token, Position)

scan :: String -> Pipeline [TokenM]
scan source = do
    let tokens = alexScanTokens source
    case find isTokError tokens of
        Just (tok, pos) -> throwError $ LexError pos (show tok)
        Nothing         -> return tokens
    where   isTokError (TokError _, _) = True
            isTokError _               = False
}
