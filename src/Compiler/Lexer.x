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

alexEOF :: Alex Token
alexEOF = return (Token TokEOF Unknown)

toPosition :: AlexPosn -> Position
toPosition (AlexPn o l c) = Position o Nothing l c



constant :: Tok -> AlexInput -> Int -> Alex Token
constant tok (pos, _, _, _) _ = return $ Token tok (toPosition pos)

unary :: (String -> Tok) -> AlexInput -> Int -> Alex Token
unary tok (pos, _, _, str) len = return $ Token (tok (take len str)) (toPosition pos)

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
{-
scan :: String -> Pipeline [Token]
scan str = go (alexStartPos, '\n', [], str)
    where
        go inp@(pos, _, _, str) = case alexScan inp 0 of
            AlexEOF -> return []
            AlexError (pos, _, _, _) -> error "lexer fucked up"
            AlexSkip  inp_ len     -> go inp_
            AlexToken inp_ len act -> do
                xs <- go inp_
                let Token tok pos_ = act pos (take len str)
                let tokLength = labelLength pos_ len
                let token = Token tok tokLength
                case tok of
                    TokError err -> throwError $ LexError token
                    _ -> return $ token : xs
        labelLength (Position o _ l n) len = Position o (Just len) l n
-}
}
