{
module Compiler.Lexer (Token(..), Tok(..), AlexPosn(..), constant, unary, scan) where
import Compiler.Type.Token
import Compiler.Type.Pipeline
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
@ndqoute = [^"]|$newline
@squote = '
@nsquote = [^']|$newline
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

constant :: Tok -> AlexPosn -> String -> Token
constant tok pos _ = Token tok (toPosition pos)

unary :: (String -> Tok) -> AlexPosn -> String -> Token
unary tok pos s = Token (tok s) (toPosition pos)


scan :: String -> Pipeline [Token]
scan source = do
    let tokens = alexScanTokens source
    case find isTokError tokens of
        Just (Token tok pos) -> throwError $ LexError pos (show tok)
        Nothing              -> return tokens
    where   isTokError (Token (TokError _) _) = True
            isTokError _               = False
            toTok (Token tok _) = tok
}
