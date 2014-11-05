{

module Compiler.Lexer where

import Compiler.Types
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]

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

-- data Token  = ID                -- identifiers
--             | LParen            -- (
--             | RParen            -- )
--             | Semicolon         -- ;
--             | Colon             -- :
--             | Period            -- .
--             | Comma             -- ,
--             | LSB               -- [
--             | RSB               -- ]
--             | Z                 -- integer
--             | N                 -- num
--             | R                 -- real
--             | Program           -- "program"
--             | Function          -- "function"
--             | Proc              -- "procedure"
--             | Begin             -- "begin"
--             | End               -- "end"
--             | Var               -- "var"
--             | Arr               -- "array"
--             | Of                -- "of"
--             | If                -- "if"
--             | Then              -- "then"
--             | Else              -- "else"
--             | While             -- "while"
--             | Do                -- "do"
--             | Assign            -- :=
--             | S                 -- <
--             | L                 -- >
--             | SE                -- <=
--             | LE                -- >=
--             | EQ                -- =
--             | NEQ               -- !=
--             | Plus              -- +
--             | Minus             -- -
--             | Times             -- *
--             | Div               -- /
--             | Not               -- "not"
--             | To                -- ..
-- $($alpha|"_")($alpha|$digit)*   { ID }

tokens :-
    $white+                                 ;

    "//"[^\r\n]*(\r\n)                      ;
    ($alpha|"_")($alpha|$digit)*            { ID }

    $p$r$o$g$r$a$m                          { const Program }
    $f$u$n$c$t$i$o$n                        { const Function }
    $p$r$o$c$e$d$u$r$e                      { const Proc }
    $b$e$g$i$n                              { const Begin }
    $e$n$d                                  { const End }
    $v$a$r                                  { const Var }
    $a$r$r$a$y                              { const Arr }
    $o$f                                    { const Of }
    $i$f                                    { const If }
    $t$h$e$n                                { const Then }
    $e$l$s$e                                { const Else }
    $w$h$i$l$e                              { const While }
    $d$o                                    { const Do }
    $n$o$t                                  { const Not }
    "("                                     { const LParen }
    ")"                                     { const RParen }
    ":"                                     { const Colon }
    ";"                                     { const Semicolon }
    "."                                     { const Period }
    ","                                     { const Comma }
    "["                                     { const LSB }
    "]"                                     { const RSB }
    ":="                                    { const Assign }
    ">"                                     { const L }
    "<"                                     { const S }
    ">="                                    { const LE }
    "<="                                    { const SE }
    "="                                     { const E }
    "!="                                    { const NE }
    "+"                                     { const Plus }
    "-"                                     { const Minus }
    "*"                                     { const Times }
    "/"                                     { const Div }
    ".."                                    { const To }
    \0                                      ;
    .                                       { LexicalError }


{
scan :: String -> [Token]
scan = alexScanTokens
}
