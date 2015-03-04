{
module Compiler.Lexer (Token(..), Tok(..), AlexPosn(..), constant, unary, scan) where
import Compiler.Type.Token
import Compiler.Type.Pipeline
import Data.List (find)
import Control.Monad.Except (throwError)

}

%wrapper "monad"

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
    $r$e$t$u$r$n                            { constant TokReturn }
    $e$n$d                                  { constant TokEnd }
    $v$a$r                                  { constant TokVar }
    $o$f                                    { constant TokOf }
    $i$f                                    { constant TokIf }
    $t$h$e$n                                { constant TokThen }
    $e$l$s$e                                { constant TokElse }
    $w$h$i$l$e                              { constant TokWhile }
    $d$o                                    { constant TokDo }
    $n$o$t                                  { constant TokNot }
    $i$n$t$e$g$e$r                          { constant TokTypeInt }
    $r$e$a$l                                { constant TokTypeReal }
    @real                                   { unary    TokReal }
    @integer                                { unary    TokInt }
    @identifier                             { unary    TokID }
    [$digit]@identifier                     { unary    TokError }
    "("                                     { constant TokLParen }
    ")"                                     { constant TokRParen }
    ":"                                     { constant TokColon }
    ";"                                     { constant TokSemicolon }
    "."                                     { constant TokPeriod }
    ","                                     { constant TokComma }
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

alexEOF :: Alex Token
alexEOF = return (Token TokEOF Unknown)

toPosition :: AlexPosn -> Int -> Position
toPosition (AlexPn o l c) len = Position o len l c

constant :: Tok -> AlexInput -> Int -> Alex Token
constant tok (pos, _, _, _) len = return $ Token tok (toPosition pos len)

unary :: (String -> Tok) -> AlexInput -> Int -> Alex Token
unary tok (pos, _, _, str) len = return $ Token (tok (take len str)) (toPosition pos len)

scan :: String -> Pipeline [Token]
scan str = case runAlex str extractTokens of
    Left err     -> error err
    Right result -> return result

    where   extractTokens = do
                result <- alexMonadScan
                case result of
                    Token TokEOF _ -> return []
                    others         -> do
                        a <- extractTokens
                        return $ others : a
}
