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

    $p$r$o$g$r$a$m                          { const TokProgram }
    $f$u$n$c$t$i$o$n                        { const TokFunction }
    $p$r$o$c$e$d$u$r$e                      { const TokProc }
    $b$e$g$i$n                              { const TokBegin }
    $e$n$d                                  { const TokEnd }
    $v$a$r                                  { const TokVar }
    $a$r$r$a$y                              { const TokArr }
    $o$f                                    { const TokOf }
    $i$f                                    { const TokIf }
    $t$h$e$n                                { const TokThen }
    $e$l$s$e                                { const TokElse }
    $w$h$i$l$e                              { const TokWhile }
    $d$o                                    { const TokDo }
    $n$o$t                                  { const TokNot }
    @string                                 { TokNum }
    @scinot|@real|@integer                  { TokNum }
    ($alpha)($alpha|$digit)*                { TokID }
    "("                                     { const TokLParen }
    ")"                                     { const TokRParen }
    ":"                                     { const TokColon }
    ";"                                     { const TokSemicolon }
    "."                                     { const TokPeriod }
    ","                                     { const TokComma }
    "["                                     { const TokLSB }
    "]"                                     { const TokRSB }
    ":="                                    { const TokAssign }
    ">"                                     { const TokL }
    "<"                                     { const TokS }
    ">="                                    { const TokLE }
    "<="                                    { const TokSE }
    "="                                     { const TokE }
    "!="                                    { const TokNE }
    "+"                                     { const TokPlus }
    "-"                                     { const TokMinus }
    "*"                                     { const TokTimes }
    "/"                                     { const TokDiv }
    ".."                                    { const TokTo }
    \0                                      ;
    .                                       { TokError }


{
scan :: String -> [Token]
scan = alexScanTokens
}
