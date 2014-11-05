{

module Compiler.Lexer where

import Compiler.Types
}

%wrapper "basic"

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


tokens :-
    $white+                                 ;

    "//"[^$newline]*$newline                ;

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
    @string                                 { Str }
    @scinot                                 { Str }
    @real                                   { R . read }
    @integer                                { Z . read }
    ($alpha)($alpha|$digit)*                { ID }
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
