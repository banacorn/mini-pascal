module Compiler where

import Compiler.Lexer
import Compiler.Parser
import Data.List (intercalate)

main :: IO ()
main = do
    readFile "./test/parser/no-parsing-error/parser-test.p" >>= print . parse . scan
